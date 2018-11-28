Received: from eggs.gnu.org ([2001:4830:134:3::10]:58571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS2Ym-0005JO-6K
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS2Yi-0001PD-CH
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:19:32 -0500
Date: Wed, 28 Nov 2018 17:19:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181128161917.GE4222@dhcp-200-186.str.redhat.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-3-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/18] xen: introduce new
 'XenBus' and 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 21.11.2018 um 16:11 hat Paul Durrant geschrieben:
> This patch adds the basic boilerplate for a 'XenBus' object that will act
> as a parent to 'XenDevice' PV backends.
> A new 'XenBridge' object is also added to connect XenBus to the system bus.
> 
> The XenBus object is instantiated by a new xen_bus_init() function called
> from the same sites as the legacy xen_be_init() function.
> 
> Subsequent patches will flesh-out the functionality of these objects.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> new file mode 100644
> index 0000000000..dede2d914a
> --- /dev/null
> +++ b/hw/xen/xen-bus.c
> @@ -0,0 +1,125 @@
> +/*
> + * Copyright (c) Citrix Systems Inc.
> + * All rights reserved.
> + */

This doesn't look very compatible with the GPL. In fact it might even
make it illegal for the QEMU project to distribute this code. :-)

Other files you add throughout the series seem to have the same problem.

Kevin
