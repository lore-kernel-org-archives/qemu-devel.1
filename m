Received: from eggs.gnu.org ([2001:4830:134:3::10]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8631c8a8c=anthony.perard@citrix.com>)
	id 1gS3Lv-0007Il-6L
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8631c8a8c=anthony.perard@citrix.com>)
	id 1gS3Lq-0000oX-4r
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:10:19 -0500
Date: Wed, 28 Nov 2018 17:10:01 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181128171001.GC14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-3-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 02/18] xen: introduce new 'XenBus' and
 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 21, 2018 at 03:11:55PM +0000, Paul Durrant wrote:
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> new file mode 100644
> index 0000000000..dede2d914a
> --- /dev/null
> +++ b/hw/xen/xen-bus.c
> @@ -0,0 +1,125 @@
> +/*
> + * Copyright (c) Citrix Systems Inc.
> + * All rights reserved.

You probably should include:
  This work is licensed under the terms of the GNU GPL, version 2 or later.
  See the COPYING file in the top-level directory.

As this seems to be a boilerplate used in recent new files, there are
other similair boilerplates.

Also, I think the copyright line should include a year.

> +void xen_bus_init(void)
> +{
> +    DeviceState *dev = qdev_create(NULL, TYPE_XEN_BRIDGE);
> +
> +    qbus_create(TYPE_XEN_BUS, dev, NULL);
> +    qdev_init_nofail(dev);

Will we need a hotplug handler for this bus, like it is done with
TYPE_XENSYSBUS?


The rest looks good,
Thanks,

-- 
Anthony PERARD
