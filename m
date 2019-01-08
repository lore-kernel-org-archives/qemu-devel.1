Received: from eggs.gnu.org ([209.51.188.92]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ggqER-0002vp-Kl
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ggqEP-0004RZ-R2
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:11:43 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:46919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ggqEO-00042W-MN
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:11:41 -0500
Date: Tue, 8 Jan 2019 13:11:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190108114208.y3cdrwf7yrsfft5w@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1901081302340.10380@zero.eik.bme.hu>
References: <1546077657-22637-1-git-send-email-hongbo.zhang@linaro.org>
	<20190108114208.y3cdrwf7yrsfft5w@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] hw/usb: Add generic sys-bus EHCI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, peter.maydell@linaro.org, radoslaw.biernacki@linaro.org, qemu-devel@nongnu.org, leif.lindholm@linaro.org, ard.biesheuvel@linaro.org

On Tue, 8 Jan 2019, Gerd Hoffmann wrote:
> On Sat, Dec 29, 2018 at 06:00:57PM +0800, Hongbo Zhang wrote:
>> This patch introduces a new system bus generic EHCI controller.
>> For the system bus EHCI controller, we've already had "xlnx",
>> "exynos4210", "tegra2", "ppc4xx" and "fusbh200", they are specific and
>> only suitable for their own platforms, platforms such as an Arm server,
>> may need a generic system bus EHCI controller, this patch creates it,
>> and the kernel driver ehci_platform.c works well on it.
>
> Added to usb queue.

Most of these only differ in capsbase and opregbase and we only need a 
separate subclass for them because ehci-sysbus is .abstract=true so cannot 
be instantiated. I wonder if it would be simpler to add properties to 
ehci-sysbus to allow setting these base values and allow it to be used 
directly, then most of these subclasses could be removed and only need 
subclass for those that are really do something more (maybe only fusbh200 
currently).

(Just asking, I'm not volunteering to make a patch.)

Regards,
BALATON Zoltan
