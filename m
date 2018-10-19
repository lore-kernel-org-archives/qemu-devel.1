Received: from eggs.gnu.org ([2001:4830:134:3::10]:60302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDW1I-0007DB-TR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDW1I-0000ON-2P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:44:56 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDW1H-0000Nk-Ii
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:44:55 -0400
Received: by mail-oi1-x242.google.com with SMTP id w81-v6so26997503oiw.9
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:44:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539954845-26716-4-git-send-email-thuth@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-4-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:44:33 +0100
Message-ID: <CAFEAcA974ZrtCG7pPHXNq8EDsd5t0STJ6s9p-qGtGQf49Rk-bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/5] configs: Add a CONFIG_REGISTER switch
 for the "register" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 October 2018 at 14:14, Thomas Huth <thuth@redhat.com> wrote:
> If the user only wants to compile targets that do not require the
> "register" device, we should also not compile register.c. Add a proper
> CONFIG_REGISTER switch to be able to choose this more flexibly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak        | 1 +
>  default-configs/microblaze-softmmu.mak | 1 +
>  hw/core/Makefile.objs                  | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index a3a3b66..6f2ffc1 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -6,6 +6,7 @@ CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_OR_IRQ=y
>  CONFIG_SPLIT_IRQ=y
> +CONFIG_REGISTER=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
> diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/microblaze-softmmu.mak
> index 7fca8e4..b5c5659 100644
> --- a/default-configs/microblaze-softmmu.mak
> +++ b/default-configs/microblaze-softmmu.mak
> @@ -10,3 +10,4 @@ CONFIG_XILINX_ETHLITE=y
>  CONFIG_SSI=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_XLNX_ZYNQMP=y
> +CONFIG_REGISTER=y
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index cafbe01..cb7c149 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -16,7 +16,7 @@ common-obj-$(CONFIG_SOFTMMU) += machine.o
>  common-obj-$(CONFIG_SOFTMMU) += loader.o
>  common-obj-$(CONFIG_FITLOADER) += loader-fit.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
> -common-obj-$(CONFIG_SOFTMMU) += register.o
> +common-obj-$(CONFIG_REGISTER) += register.o
>  common-obj-$(CONFIG_OR_IRQ) += or-irq.o
>  common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o

Another generic facility.

thanks
-- PMM
