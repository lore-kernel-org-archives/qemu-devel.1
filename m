Received: from eggs.gnu.org ([2001:4830:134:3::10]:34839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eotjM-0000sc-51
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eotjH-0004BX-B3
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eotjH-0004Ag-4I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:28:19 -0500
Date: Thu, 22 Feb 2018 09:28:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180222092811.0a705b9e@w520.home>
In-Reply-To: <20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Tue, 20 Feb 2018 11:28:14 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Feb 19, 2018 at 03:16:49PM -0700, Alex Williamson wrote:
> > On Mon, 19 Feb 2018 12:14:51 +0100
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > This series adds support for a vgpu display to the qemu vfio code.
> > > For now only regions are supported, dmabufs will follow later.
> > > 
> > > This version adds a patch to allow devices disable hotplugging, which
> > > will be used by vfio display support.  Also fixed issues Alex found in
> > > review.  
> > 
> > Looks ok to me, if this is to go through my tree I'll need a qdev ack
> > for 4/7.  If you want to go a different route, for 5-7:
> > 
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > 
> > I'm still a bit confused though, what's preventing us from adding
> > dmabuf support now?  It's strange to provide the implementation for the
> > proprietary, unavailable vendor driver implementation first.  Is GVT-g
> > broken, lagging?  Thanks,  
> 
> A bit more complicated because it depends on user interface changes ...
> 
> Sneak preview at https://www.kraxel.org/cgit/qemu/log/?h=work/intel-vgpu
> Note: branch is a moving target ;)
> 
> State:
>   vfio:  Working, needs some cleanups though (drop debug logging, ...).
>   gtk:   Working, needs some minor cleanups too.
>   spice: Partly working (no mouse ptr yet).
>   sdl:   Not working.  Need to figure how I get a egl context (instead
>          of glx).  Possibly requires SDL 2.2.  Tina looked at this a
>          while back, need to look at some old mails ...
> 
> Current plan:
>   (1) fix/complete spice support.
>   (2) cleanup patches, send them out.
>   (3) look at the SDL issues.

Hi Gerd,

It's a little bit concerning that the only way we can test the
region-based display support is with proprietary drivers that nobody
but NVIDIA has at this point.  Have you considered adding region-based
display support to the mdev sample tty driver?  I know it sounds
ridiculous for a serial device to have a display, but the vfio display
region support isn't really tied to the functionality of the base mdev
device.  We could have it simply display a static test pattern, just so
we can test the end to end code path without a dependency on a closed
vendor driver.  Thanks,

Alex
