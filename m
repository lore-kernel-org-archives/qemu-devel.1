Received: from eggs.gnu.org ([209.51.188.92]:35286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwsGR-0004xy-S5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwsGR-0002zC-1c
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:36:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gwsGQ-0002r7-Q2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:36:02 -0500
Date: Thu, 21 Feb 2019 10:35:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190221103536.2166450b@w520.home>
In-Reply-To: <20190221074643.cb6chu3tu7nkytpo@sirius.home.kraxel.org>
References: <20190220084753.9130-1-kraxel@redhat.com>
	<20190220084753.9130-3-kraxel@redhat.com>
	<20190220153602.57a11e97@w520.home>
	<20190221074643.cb6chu3tu7nkytpo@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] vfio/display: add xres + yres
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

On Thu, 21 Feb 2019 08:46:43 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > > +    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> > > +    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),  
> > 
> > This is actually quite fun, I started my VM with arbitrary numbers and
> > the Windows GUI honored it every time.  Probably very useful for
> > playing with odd screen sizes.  I also tried to break it using
> > 1000000x1000000, but the display came up as 1920x1200, the maximum
> > resolution GVT-g supports for this type.  I don't see that QEMU is
> > bounding this though, do we depend on the mdev device to ignore it if
> > we pass values it cannot support?  
> 
> There is a check in vfio_display_edid_update().

Ok, so we're bounded within QEMU, that seems good.  Thanks,

Alex
