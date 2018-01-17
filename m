Received: from eggs.gnu.org ([2001:4830:134:3::10]:37276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebkhH-0006F9-6r
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ebkhD-000733-An
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:11:55 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180117090700.25811-1-stefanha@redhat.com>
References: <20180117090700.25811-1-stefanha@redhat.com>
Date: Wed, 17 Jan 2018 11:11:48 +0100
Message-ID: <w51vag023rv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: add
 block_set_io_throttle virtio-blk-pci QMP example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

On Wed 17 Jan 2018 10:07:00 AM CET, Stefan Hajnoczi wrote:
> The block_set_io_throttle command can look up BlockBackends by the
> attached qdev device ID.  virtio-blk-pci is a special case because the
> actual VirtIOBlock device is the "/virtio-backend" child of the PCI
> adapter device.
>
> Add a QMP schema example so clients will know how to use
> block_set_io_throttle on the virtio-blk-pci device.
>
> The alternative is to implement some sort of aliasing for qmp_get_blk()
> but that is likely to cause confusion and could break future use cases.
> Let's not go there.
>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
