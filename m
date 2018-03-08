Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etmVK-0005uM-8x
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etmVJ-0000mI-Ky
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:46:06 -0500
Date: Thu, 8 Mar 2018 11:46:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180308034600.GN13844@lemon.usersys.redhat.com>
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 03/07 14:42, Stefan Hajnoczi wrote:
> v3:
>  * Rebase on qemu.git/master after AIO_WAIT_WHILE() was merged [Fam]
> v2:
>  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
>    from a BH in the IOThread [Fam]
> 
> There are several race conditions in virtio-blk/virtio-scsi dataplane code.
> This patch series addresses them, see the commit description for details on the
> individual cases.

Reviewed-by: Fam Zheng <famz@redhat.com>
