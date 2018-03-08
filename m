Received: from eggs.gnu.org ([2001:4830:134:3::10]:33752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ety02-0005yI-IY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1etxzx-0008IQ-Ng
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:02:34 -0500
Date: Thu, 8 Mar 2018 18:01:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180308180130-mutt-send-email-mst@kernel.org>
References: <20180307144205.20619-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307144205.20619-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Wed, Mar 07, 2018 at 02:42:01PM +0000, Stefan Hajnoczi wrote:
> v3:
>  * Rebase on qemu.git/master after AIO_WAIT_WHILE() was merged [Fam]
> v2:
>  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
>    from a BH in the IOThread [Fam]

Acked-by: Michael S. Tsirkin <mst@redhat.com>

who is merging this?

> There are several race conditions in virtio-blk/virtio-scsi dataplane code.
> This patch series addresses them, see the commit description for details on the
> individual cases.
> 
> Stefan Hajnoczi (4):
>   block: add aio_wait_bh_oneshot()
>   virtio-blk: fix race between .ioeventfd_stop() and vq handler
>   virtio-scsi: fix race between .ioeventfd_stop() and vq handler
>   vl: introduce vm_shutdown()
> 
>  include/block/aio-wait.h        | 13 +++++++++++++
>  include/sysemu/iothread.h       |  1 -
>  include/sysemu/sysemu.h         |  1 +
>  cpus.c                          | 16 +++++++++++++---
>  hw/block/dataplane/virtio-blk.c | 24 +++++++++++++++++-------
>  hw/scsi/virtio-scsi-dataplane.c |  9 +++++----
>  iothread.c                      | 31 -------------------------------
>  util/aio-wait.c                 | 31 +++++++++++++++++++++++++++++++
>  vl.c                            | 13 +++----------
>  9 files changed, 83 insertions(+), 56 deletions(-)
> 
> -- 
> 2.14.3
