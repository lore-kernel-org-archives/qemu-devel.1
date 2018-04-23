Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fAb8a-0005aq-6n
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fAb8Z-00051E-Bl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:04:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fAb8Z-00050f-7n
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:04:07 -0400
Date: Mon, 23 Apr 2018 15:04:01 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180423130401.bmwm7hlbxnnmh4fu@sirius.home.kraxel.org>
References: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
	<1524471278-22546-2-git-send-email-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524471278-22546-2-git-send-email-tina.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] console: introduce
 dpy_gfx_switch_surface
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

 Hi,

>  void dpy_gfx_replace_surface(QemuConsole *con,
>                               DisplaySurface *surface);
> +void dpy_gfx_switch_surface(QemuConsole *con,
> +                             DisplaySurface *surface);

Why?  Any problems with dpy_gfx_replace_surface?

cheers,
  Gerd
