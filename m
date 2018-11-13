Received: from eggs.gnu.org ([2001:4830:134:3::10]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMf1Y-0004bo-CV
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMf1X-0000W1-4J
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:11:00 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gMf1W-0000Vf-TI
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:10:59 -0500
Received: by mail-lf1-x141.google.com with SMTP id u18so9796423lff.10
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 12:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20181108134139.31666-1-peter.maydell@linaro.org>
In-Reply-To: <20181108134139.31666-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Nov 2018 12:10:26 -0800
Message-ID: <CAKmqyKMaW0Ye5E_PMZXpnUpYZRGdwCBEOf9Qr_bzJpPR=-_p2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, Patch Tracking <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, philmd@redhat.com

On Thu, Nov 8, 2018 at 5:41 AM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> In practice for most of the more-or-less orphan Arm board models,
> I will review patches and put them in via the target-arm tree.
> So list myself as an "Odd Fixes" status maintainer for them.
>
> This commit downgrades these boards to "Odd Fixes":
>  * Allwinner-A10
>  * Exynos
>  * Calxeda Highbank
>  * Canon DIGIC
>  * Musicpal
>  * nSeries
>  * Palm
>  * PXA2xx
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Thomas Huth sent a patch which only addressed collie, but
> let's be consistent.
>
> The set of downgrades to odd-fixes is based mostly on my
> subjective impression of whether anybody has made any changes
> to the board models over the last year or so, so it's quite
> possible I've forgotten that one of them is in better shape
> maintainer-activity-wise. If the maintainers for those boards
> disagree (cc'd) I'm happy to re-upgrade them to Maintained.
>
> Arguably it would be nice to have a letter prefix for "this
> is the person who will deal with getting the patch into the
> tree, but somebody else will be the primary maintainer for
> patch review" -- that's the situation for the maintained/
> active boards like ASpeed.
> ---
>  MAINTAINERS | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d68e4bc5eb..4443105686d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -436,8 +436,9 @@ ARM Machines
>  ------------
>  Allwinner-a10
>  M: Beniamino Galvani <b.galvani@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/*/allwinner*
>  F: include/hw/*/allwinner*
>  F: hw/arm/cubieboard.c
> @@ -496,27 +497,31 @@ F: tests/test-arm-mptimer.c
>
>  Exynos
>  M: Igor Mitsyanko <i.mitsyanko@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/*/exynos*
>  F: include/hw/arm/exynos4210.h
>
>  Calxeda Highbank
>  M: Rob Herring <robh@kernel.org>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/arm/highbank.c
>  F: hw/net/xgmac.c
>
>  Canon DIGIC
>  M: Antony Pavlov <antonynpavlov@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: include/hw/arm/digic.h
>  F: hw/*/digic*
>
>  Gumstix
>  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-devel@nongnu.org
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
> @@ -524,8 +529,9 @@ F: hw/arm/gumstix.c
>
>  i.MX31
>  M: Peter Chubb <peter.chubb@nicta.com.au>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Odd fixes
> +S: Odd Fixes
>  F: hw/*/imx*
>  F: include/hw/*/imx*
>  F: hw/arm/kzm.c
> @@ -555,20 +561,23 @@ F: include/hw/misc/iotkit-sysinfo.h
>
>  Musicpal
>  M: Jan Kiszka <jan.kiszka@web.de>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/arm/musicpal.c
>
>  nSeries
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/arm/nseries.c
>
>  Palm
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/arm/palm.c
>
>  Real View
> @@ -582,8 +591,9 @@ F: include/hw/intc/realview_gic.h
>
>  PXA2XX
>  M: Andrzej Zaborowski <balrogg@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/arm/mainstone.c
>  F: hw/arm/spitz.c
>  F: hw/arm/tosa.c
> @@ -608,6 +618,7 @@ F: hw/misc/arm_sysctl.c
>  Xilinx Zynq
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  M: Alistair Francis <alistair@alistair23.me>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/xilinx_*
> @@ -619,6 +630,7 @@ X: hw/ssi/xilinx_*
>  Xilinx ZynqMP
>  M: Alistair Francis <alistair@alistair23.me>
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/xlnx*.c
> @@ -632,6 +644,7 @@ F: hw/arm/virt-acpi-build.c
>
>  STM32F205
>  M: Alistair Francis <alistair@alistair23.me>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: hw/arm/stm32f205_soc.c
>  F: hw/misc/stm32f2xx_syscfg.c
> @@ -643,11 +656,13 @@ F: include/hw/*/stm32*.h
>
>  Netduino 2
>  M: Alistair Francis <alistair@alistair23.me>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: hw/arm/netduino2.c

These two and the Xilinx boards seem a little out of place in this
patch. I agree they probably aren't maintained as well as they should
be, but the patch talks about orphaned boards and these four all have
active QEMU maintainers listed.

Alistair

>
>  SmartFusion2
>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: hw/arm/msf2-soc.c
>  F: hw/misc/msf2-sysreg.c
> @@ -660,11 +675,13 @@ F: include/hw/ssi/mss-spi.h
>
>  Emcraft M2S-FG484
>  M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: hw/arm/msf2-som.c
>
>  ASPEED BMCs
>  M: C=C3=A9dric Le Goater <clg@kaod.org>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  R: Andrew Jeffery <andrew@aj.id.au>
>  R: Joel Stanley <joel@jms.id.au>
>  L: qemu-arm@nongnu.org
> @@ -676,6 +693,7 @@ F: include/hw/net/ftgmac100.h
>
>  NRF51
>  M: Joel Stanley <joel@jms.id.au>
> +M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/nrf51_soc.c
> --
> 2.19.1
>
>
