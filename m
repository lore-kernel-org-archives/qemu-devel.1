Received: from eggs.gnu.org ([209.51.188.92]:56325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8su-0005Ge-HY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8ss-0002xh-4h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:31:40 -0500
Date: Mon, 28 Jan 2019 16:31:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128153110.GD5756@localhost.localdomain>
References: <cover.1548171741.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548171741.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] iothread-related fixes for virtio-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 22.01.2019 um 16:53 hat Alberto Garcia geschrieben:
> Hi,
> 
> here are three patches with iothread-related fixes for virtio-scsi,
> with their test cases.
> 
> This series fixes the following bugs:
> 
>    https://bugzilla.redhat.com/show_bug.cgi?id=1656276
> 
>    https://bugzilla.redhat.com/show_bug.cgi?id=1662508
> 
> I also wanted to do prepare a similar one for virtio-blk but I'm
> unsure about how to proceed, because I'm unable to detect during
> realize() that the blockdev is using a different iothread. This
> crashes QEMU:
> 
> { "execute": "qmp_capabilities" }
> { "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
> { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
> { "execute": "device_add", "arguments": {"id": "virtio-blk0", "driver": "virtio-blk", "iothread": "iothread0", "drive": "hd0"}}
> { "execute": "system_reset"}
>   (wait for the events)
> { "execute": "device_add", "arguments": {"id": "virtio-blk1", "driver": "virtio-blk", "iothread": "iothread1", "drive": "hd0"}}

Thanks, applied to the block branch.

Kevin
