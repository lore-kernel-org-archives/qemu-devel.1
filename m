Received: from eggs.gnu.org ([2001:4830:134:3::10]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evW0k-0002se-88
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evW0g-0003Hy-88
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evW0g-0003Hq-2W
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:33:38 -0400
Date: Mon, 12 Mar 2018 16:33:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180312163332.6a6b269d@w520.home>
In-Reply-To: <20180305085239.GR2872@erzo-ntb>
References: <20180228123110.6507-1-kraxel@redhat.com>
	<20180228123110.6507-8-kraxel@redhat.com>
	<20180305085239.GR2872@erzo-ntb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 7/9] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Tina Zhang <tina.zhang@intel.com>

On Mon, 5 Mar 2018 09:52:39 +0100
Erik Skultety <eskultet@redhat.com> wrote:

> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > new file mode 100644
> > index 0000000000..3e997f8a44
> > --- /dev/null
> > +++ b/hw/vfio/display.c
> > @@ -0,0 +1,56 @@
> > +/*
> > + * display support for mdev based vgpu devices
> > + *
> > + * Copyright Red Hat, Inc. 2017  
> 
> Just curious here since I don't really know close to nothing about the legal
> stuff, but isn't vGPU NVIDIA's trademark - [1,2,3] (especially [1]) would
> suggest so. Therefore, I'm just curious whether we can mention this as we
> please, especially when this should also work for Intel, which uses a different
> name for the technology. On the other hand, grepping through kernel modules,
> there's a lot of vGPU misuse in Intel's context, so I guess everything's fine.
> Again, I'm just curious since I have no clue about this stuff.
> 
> [1] https://www.geforce.com/en_GB/gfecnt/support/NVIDIA-Legal-Notices
> [2] https://trademarks.justia.com/859/42/vgpu-85942337.html
> [3] https://trademarks.justia.com/859/42/nvidia-grid-85942341.html

IANAL, but the official trademark trackers all seem to indicate "VGPU"
was filed for, but abandoned, so perhaps your link [1] above is stale
data (note that the copyright date on that is 2014 and the trademark
abandonment dates are late 2014/early 2015).  I'm not sure that it
matters either way though.  Thanks,

Alex
