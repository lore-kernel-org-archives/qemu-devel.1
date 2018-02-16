Received: from eggs.gnu.org ([2001:4830:134:3::10]:35379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emga2-0007iV-4S
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emgZz-0002AW-3u
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:01:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emgZy-0002AI-Vo
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:01:35 -0500
Date: Fri, 16 Feb 2018 15:01:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180216140118.evo6fcwvtb2biad5@sirius.home.kraxel.org>
References: <20180213161846.26914-1-kraxel@redhat.com>
	<20180213161846.26914-6-kraxel@redhat.com>
	<20180213134022.34438ef2@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213134022.34438ef2@w520.home>
Subject: Re: [Qemu-devel] [RfC PATCH v3 5/5] vfio/display: adding region
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

> > +static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
> > +{
> > +    vdev->dpy = g_new0(VFIODisplay, 1);
> > +    vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
> > +                                          &vfio_display_region_ops,
> > +                                          vdev);
> > +    /* TODO: disable hotplug (there is no graphic_console_close) */
> 
> via DeviceClass.hotpluggable?  I know that QE will immediately test
> this, so it needs to be sorted out sooner than later.

Hmm, I think setting DeviceClass.hotpluggable would tag all vfio devices
as not hotpluggable, not only the one we just created a display for.

cheers,
  Gerd
