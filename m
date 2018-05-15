Received: from eggs.gnu.org ([2001:4830:134:3::10]:38662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVRQ-0001Rx-UT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVRN-0003NP-18
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:36:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIVRM-0003N3-TF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:36:12 -0400
Date: Tue, 15 May 2018 10:36:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180515083611.p7lsstq5hliepqlt@sirius.home.kraxel.org>
References: <20180507134237.14996-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507134237.14996-1-tomeu.vizoso@collabora.com>
Subject: Re: [Qemu-devel] [PATCH] ui/gtk: Only try to initialize EGL/X11 if
 GtkGlArea failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: qemu-devel@nongnu.org

On Mon, May 07, 2018 at 03:42:37PM +0200, Tomeu Vizoso wrote:
> The commit referenced below changed the logic by causing the gtk-egl
> backend to be initialized regardless of whether GtkGlArea initialization
> succeeded. This causes eglInitialize to crash in Wayland systems without
> XWayland.
> 
> This patch restores the previous logic.

Added to ui patch queue.

thanks,
  Gerd
