Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqEGa-00018Z-47
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqEGW-0005km-VP
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:36:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqEGW-0005kV-Qc
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:36:08 -0500
Date: Mon, 26 Feb 2018 09:35:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180226083551.dingmvxfgqydw35a@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
	<20180222092811.0a705b9e@w520.home>
	<20180223090517.beti6t5grnxxhlwq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223090517.beti6t5grnxxhlwq@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>

On Fri, Feb 23, 2018 at 10:05:17AM +0100, Gerd Hoffmann wrote:
> > Hi Gerd,
> > 
> > It's a little bit concerning that the only way we can test the
> > region-based display support is with proprietary drivers that nobody
> > but NVIDIA has at this point.  Have you considered adding region-based
> > display support to the mdev sample tty driver?  I know it sounds
> > ridiculous for a serial device to have a display, but the vfio display
> > region support isn't really tied to the functionality of the base mdev
> > device.  We could have it simply display a static test pattern, just so
> > we can test the end to end code path without a dependency on a closed
> > vendor driver.
> 
> Hmm, have to think about that.  Some way to change the display content
> would be nice as you can see whenever display updates are working then.

https://www.kraxel.org/cgit/linux/log/?h=vfio-sample-display

Comes with host mdev driver and guest framebuffer driver.

enjoy,
  Gerd
