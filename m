Received: from eggs.gnu.org ([209.51.188.92]:35710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggplv-0003dH-AS
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggplt-0007jv-9S
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggplr-0007bk-CW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:13 -0500
Date: Tue, 8 Jan 2019 12:42:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108114208.y3cdrwf7yrsfft5w@sirius.home.kraxel.org>
References: <1546077657-22637-1-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546077657-22637-1-git-send-email-hongbo.zhang@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] hw/usb: Add generic sys-bus EHCI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ard.biesheuvel@linaro.org, leif.lindholm@linaro.org, radoslaw.biernacki@linaro.org

On Sat, Dec 29, 2018 at 06:00:57PM +0800, Hongbo Zhang wrote:
> This patch introduces a new system bus generic EHCI controller.
> For the system bus EHCI controller, we've already had "xlnx",
> "exynos4210", "tegra2", "ppc4xx" and "fusbh200", they are specific and
> only suitable for their own platforms, platforms such as an Arm server,
> may need a generic system bus EHCI controller, this patch creates it,
> and the kernel driver ehci_platform.c works well on it.

Added to usb queue.

thanks,
  Gerd
