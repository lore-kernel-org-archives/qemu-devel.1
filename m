Received: from eggs.gnu.org ([209.51.188.92]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1go9ZY-00011c-7I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1go9ZV-0000bd-2r
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:15:44 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190128160109.GF5756@localhost.localdomain>
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
	<735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
	<w518szbmmw9.fsf@maestria.local.igalia.com>
	<b3e3cb90-32a6-77b0-1c5b-8281181c8ae8@redhat.com>
	<w5136pjmjrp.fsf@maestria.local.igalia.com>
	<20190124091222.GB4601@localhost.localdomain>
	<w51d0ogsv1y.fsf@maestria.local.igalia.com>
	<20190128145743.GC5756@localhost.localdomain>
	<w517eeoss2l.fsf@maestria.local.igalia.com>
	<20190128160109.GF5756@localhost.localdomain>
Date: Mon, 28 Jan 2019 17:15:20 +0100
Message-ID: <w514l9ssqqv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio-scsi: Forbid devices with
 different iothreads sharing a blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon 28 Jan 2019 05:01:09 PM CET, Kevin Wolf wrote:

> And actually... if you move the first virtio-blk device to an
> iothread, then downgrading the others isn't going to save us, because
> that would still be using the backend from two threads (one
> successfully enabled iothread, and the main thread).

...which makes me think that, since patch 1 from this series moves the
BlockBackend back to the main AioContext on unplug, we could have a
similar problem if the BDS is being used by other devices. Or am I
missing something?

Berto
