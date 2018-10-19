Received: from eggs.gnu.org ([2001:4830:134:3::10]:60194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDW0y-0006yU-00
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDW0x-0008Ry-69
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:44:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDW0w-0008RM-Vo
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:44:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id v2so26286451otk.1
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539954845-26716-3-git-send-email-thuth@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-3-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:44:14 +0100
Message-ID: <CAFEAcA-w9pwEXZfitppX=ybHfgnA4R2=z6UaHLqyLCk=ueN1zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] configs: Add a CONFIG_SPLIT_IRQ switch
 for the split-irq device
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
> "split-irq" device, we should also not compile split-irq.c. Add a proper
> CONFIG_SPLIT_IRQ switch to be able to choose this more flexibly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/core/Makefile.objs           | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index dc6a581..a3a3b66 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -5,6 +5,7 @@ include usb.mak
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_OR_IRQ=y
> +CONFIG_SPLIT_IRQ=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y

Generic device, not arm-specific.

thanks
-- PMM
