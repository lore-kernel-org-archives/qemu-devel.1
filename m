Received: from eggs.gnu.org ([2001:4830:134:3::10]:46131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVIv-0004b1-Fy
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVIu-0001lj-KF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:59:05 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVIu-0001lL-DL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:59:04 -0400
Received: by mail-ot1-x341.google.com with SMTP id o21so33239107otb.13
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:59:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539954845-26716-2-git-send-email-thuth@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-2-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 14:58:42 +0100
Message-ID: <CAFEAcA8EzuwgobawU3KhCcHRyMWG=5d2pZ5KSe0rHeRkUteU9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] configs: Add a CONFIG_OR_IRQ switch
 for the or-irq device
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
> "or-irq" device, we should also not compile or-irq.c. Add a proper
> CONFIG_OR_IRQ switch to be able to choose this more flexibly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  default-configs/ppc-softmmu.mak | 1 +
>  hw/core/Makefile.objs           | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 2420491..dc6a581 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -4,6 +4,7 @@ include pci.mak
>  include usb.mak
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> +CONFIG_OR_IRQ=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 3181bbf..83235af 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -68,3 +68,4 @@ CONFIG_PC87312=y
>  CONFIG_PCSPK=y
>  CONFIG_IDE_ISA=y
>  CONFIG_CS4231A=y
> +CONFIG_OR_IRQ=y

Again, this is generic. We shouldn't need to mess with default-configs
files if we use it in some other architecture.

thanks
-- PMM
