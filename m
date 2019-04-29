Received: from eggs.gnu.org ([209.51.188.92]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5C4-00057a-Nb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5Bt-0004jJ-5A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:15:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5Bq-0004hO-HD
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:15:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id u15so8343513otq.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190427133028.12874-1-philmd@redhat.com>
In-Reply-To: <20190427133028.12874-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:15:09 +0100
Message-ID: <CAFEAcA9ezbte4fq_Wyic3tv9+bnkQJGq9REuvxie+QCQpNL3bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/dma: Compile the bcm2835_dma device as
 common object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>

On Sat, 27 Apr 2019 at 14:30, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This device is used by both ARM (BCM2836, for raspi2) and AArch64
> (BCM2837, for raspi3) targets, and is not CPU-specific.
> Move it to common object, so we build it once for all targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/dma/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
> index 79affecc390..8b39f9c6004 100644
> --- a/hw/dma/Makefile.objs
> +++ b/hw/dma/Makefile.objs
> @@ -14,4 +14,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zdma.o
>
>  obj-$(CONFIG_OMAP) +=3D omap_dma.o soc_dma.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_dma.o
> -obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o




Applied to target-arm.next, thanks.

-- PMM
