Received: from eggs.gnu.org ([209.51.188.92]:60936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghyUb-0007Su-Hl
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghyUa-0008B0-Ks
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:13:05 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190111150917.GL5010@dhcp-200-186.str.redhat.com>
References: <cover.1547132561.git.berto@igalia.com>
	<20190111150917.GL5010@dhcp-200-186.str.redhat.com>
Date: Fri, 11 Jan 2019 16:13:02 +0100
Message-ID: <w51k1jbqlc1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri 11 Jan 2019 04:09:17 PM CET, Kevin Wolf wrote:
> Am 10.01.2019 um 16:03 hat Alberto Garcia geschrieben:
>> As discussed yesterday, this series acquires the AioContext in the
>> _realize() functions of several devices before making use of their
>> block backends. This fixes at least a couple of crashes (in virtio-blk
>> and scsi).
>
> Apart from the incomplete scsi-block fix, this looks good. Of course,
> I think patches 3-6 are completely optional because none of these
> devices actually support iothreads, so we can't hit a bug. But it
> might be nicer to add it there as well anyway.
>
> For patches 1 and 2, which actually fix bugs, it would be nice to have
> an accompanying test case.

Ok, I'll prepare v2 with your suggestions.

Berto
