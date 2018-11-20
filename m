Received: from eggs.gnu.org ([2001:4830:134:3::10]:34276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP38o-000453-1p
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP38h-0005BI-2c
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:20:22 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP38g-0005Ay-Sv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:20:14 -0500
Received: by mail-oi1-x243.google.com with SMTP id t204so1054891oie.7
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 02:20:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542657473-9196-1-git-send-email-thuth@redhat.com>
References: <1542657473-9196-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 10:19:53 +0000
Message-ID: <CAFEAcA_xhYf0VNaq1gM1OWWCkms5sTpn3kdqSHN0AZ3cH1f8Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Assign some more files in the
 hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 November 2018 at 19:57, Thomas Huth <thuth@redhat.com> wrote:
> I apparently missed some more files and even a complete machine (the
> "imx25-pdk") in my previous patch... but now we should hopefully have
> a completely coverage for all available ARM boards.

Hi; looks like you forgot to cc qemu-devel.

> Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1032406..ac20dc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -533,6 +533,18 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/gumstix.c
>
> +i.MX25 PDK
> +M: Peter Maydell <peter.maydell@linaro.org>
> +R: Jean-Christophe Dubois <jcd@tribudubois.net>
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/fsl-imx25.c
> +F: hw/arm/imx25_pdk.c
> +F: hw/misc/imx25_ccm.c
> +F: include/hw/arm/fsl-imx25.h
> +F: include/hw/misc/imx25_ccm.h
> +F: tests/ds1338-test.c
> +
>  i.MX31 (kzm)
>  M: Peter Chubb <peter.chubb@nicta.com.au>
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -615,6 +627,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
> +F: hw/arm/raspi.c
>  F: hw/arm/raspi_platform.h
>  F: hw/*/bcm283*
>  F: include/hw/arm/raspi*
> @@ -641,6 +654,7 @@ F: hw/arm/z2.c
>  F: hw/*/pxa2xx*
>  F: hw/misc/mst_fpga.c
>  F: include/hw/arm/pxa.h
> +F: include/hw/arm/sharpsl.h
>
>  SABRELITE / i.MX6
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -686,7 +700,9 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/arm/virt*
> +F: hw/arm/smmu*
>  F: include/hw/arm/virt.h
> +F: include/hw/arm/smmu*

The SMMU files aren't part of the virt board, they're
the SMMUv3 device model. They should go in a section
that lets us mark Eric Auger as their maintainer.

>
>  Xilinx Zynq
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> --
> 1.8.3.1

thanks
-- PMM
