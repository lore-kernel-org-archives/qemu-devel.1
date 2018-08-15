Received: from eggs.gnu.org ([2001:4830:134:3::10]:45818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpyYv-0005wC-6C
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 12:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpyYQ-00084R-SP
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 12:21:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpyYC-0007sL-D5
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 12:21:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8684E4023132
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 16:21:19 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-19-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <38c94dee-1b38-9af6-02bd-ed9d3d1d960c@redhat.com>
Date: Wed, 15 Aug 2018 18:21:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-19-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/22] virtio: split vhost-scsi bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |  1 +
>  hw/virtio/vhost-scsi-pci.c | 94 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c     | 59 ------------------------
>  3 files changed, 95 insertions(+), 59 deletions(-)
>  create mode 100644 hw/virtio/vhost-scsi-pci.c
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index a5d2e38d3a..6e6e001449 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -13,6 +13,7 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
>  obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
>  obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
> +obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-pci.o
>  obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
>  obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
> diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
> new file mode 100644
> index 0000000000..0ff9f10516
> --- /dev/null
> +++ b/hw/virtio/vhost-scsi-pci.c
> @@ -0,0 +1,94 @@
> +/*
> + * Virtio PCI Bindings
> + *
> + * Copyright IBM, Corp. 2007
> + * Copyright (c) 2009 CodeSourcery
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Paul Brook        <paul@codesourcery.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */

vhost-scsi has been added in 2013 by Nicholas Bellinger, so you can
simplify the above header comment, too.

 Thomas
