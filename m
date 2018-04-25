Received: from eggs.gnu.org ([2001:4830:134:3::10]:38949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBIsf-00023i-Ja
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBIsc-0003ED-Il
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:46:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fBIsc-0003Cp-E3
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:46:34 -0400
Date: Wed, 25 Apr 2018 13:46:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180425114631.26k6c54oxrxu3hag@sirius.home.kraxel.org>
References: <1524643308-15560-1-git-send-email-tina.zhang@intel.com>
	<1524643308-15560-3-git-send-email-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524643308-15560-3-git-send-email-tina.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ui: introduce vfio_display_reset
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

This should not be called with a region-based vfio display.
Please add a check.

Otherwise looks fine to me.

cheers,
  Gerd
