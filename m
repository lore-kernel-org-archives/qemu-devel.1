Received: from eggs.gnu.org ([2001:4830:134:3::10]:42869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBgXn-0002Ol-HS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBgXk-0008Q3-Fe
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:02:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fBgXk-0008OI-B5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:02:36 -0400
Date: Thu, 26 Apr 2018 15:02:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180426130224.pvcs34fy66wqltbk@sirius.home.kraxel.org>
References: <1524730880-7154-1-git-send-email-tina.zhang@intel.com>
	<1524730880-7154-3-git-send-email-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524730880-7154-3-git-send-email-tina.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ui: introduce vfio_display_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tina Zhang <tina.zhang@intel.com>
Cc: alex.williamson@redhat.com, zhenyuw@linux.intel.com, hang.yuan@intel.com, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org

>  /* ---------------------------------------------------------------------- */
> +void vfio_display_reset(VFIOPCIDevice *vdev)
> +{
> +    if (!vdev || !vdev->dpy || !vdev->dpy->con) {
> +        return;
> +    }
> +
> +    dpy_gl_scanout_disable(vdev->dpy->con);
> +    vfio_display_dmabuf_exit(vdev->dpy);
> +    dpy_gfx_update_full(vdev->dpy->con);
> +}

> +    /* vfio_display_reset is needed by dma-buf based vfio display */
> +    if (vdev->display != ON_OFF_AUTO_OFF && dpy &&
> +        dpy->dmabuf.primary) {

Well, the check should be inside the vfio_display_reset() function, so
the display specific code is contained to display.c.

cheers,
  Gerd
