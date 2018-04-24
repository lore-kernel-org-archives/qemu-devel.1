Received: from eggs.gnu.org ([2001:4830:134:3::10]:34385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fAt7n-0008R4-Ci
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fAt7h-0003o3-1x
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:16:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fAt7g-0003n9-Sd
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:16:24 -0400
Date: Tue, 24 Apr 2018 10:16:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180424081615.qx7d3ssemk3lothw@sirius.home.kraxel.org>
References: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
	<1524471278-22546-3-git-send-email-tina.zhang@intel.com>
	<20180423131202.zcyam25lkh7khbil@sirius.home.kraxel.org>
	<237F54289DF84E4997F34151298ABEBC7C7E5046@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <237F54289DF84E4997F34151298ABEBC7C7E5046@SHSMSX101.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] ui: introduce vfio_display_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Yuan, Hang" <hang.yuan@intel.com>

  Hi,

> After reviewing this patch-set again, I think we might not need the
> proposed dpy_gfx_switch_surface() any more.  The reason I proposed it
> was because I thought gfx.ds is changed to the surface related to
> guest dma-buf framebuffer and we need to switch it with QemuConsole's
> DisplaySurgface during reset.  But after reviewing the code,
> vc->gfx.ds is always pointing to the valid QemuConsoles'
> DisplaySurface. So we don=E2=80=99t need dpy_gfx_switch_surface() to ta=
ke care
> of it.

Good, this is what I expected.

> > Maybe you just need a full display update after disabling the gl
> > scanout?
> Do you still think updating full display is needed?

It certainly isn't required, gtk wouldn't access the dma-buf any more
after scanout_disable().

Without display update the last guest display may remain visible until
the guest reloads the driver though.  With display update the gtk ui
should show the (blank) DisplaySurface instead.  So it is more
cosmetical.

cheers,
  Gerd
