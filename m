Received: from eggs.gnu.org ([2001:4830:134:3::10]:44348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e84M1-0001FE-2X
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e84M0-0006CR-1j
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:07:17 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:46996
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e84Lz-0006AF-Qf
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:07:15 -0400
References: <1509014053-28134-1-git-send-email-costa@advantech.ca>
	<1509014053-28134-7-git-send-email-costa@advantech.ca>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d48801c9-4801-d271-2d13-e08a518391fc@adacore.com>
Date: Fri, 27 Oct 2017 15:07:10 +0200
MIME-Version: 1.0
In-Reply-To: <1509014053-28134-7-git-send-email-costa@advantech.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6]arm: Makefiles to kinetis k64 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Costa <gabriel291075@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, f4bug@amsat.org

Hi,

Why does this patch has a v6 prefix? And it seems some patches
are missing.
To send your patches I suggest you use git send-email.

About this patch:
Each Makefile modification should go in the patch which
introduces the new model.
eg:
hw/char/Makefile.objs must be modified in 4/5 kinetis_k64_uart.

Fred

On 10/26/2017 12:34 PM, Gabriel Costa wrote:
> From: Gabriel Augusto Costa <gabriel291075@gmail.com>
> 
> This file change the Makefiles to compile the mk64fn1m0 machine.
> 
> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
> ---
>   default-configs/arm-softmmu.mak | 1 +
>   hw/arm/Makefile.objs            | 1 +
>   hw/char/Makefile.objs           | 1 +
>   hw/misc/Makefile.objs           | 3 +++
>   4 files changed, 6 insertions(+)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 5059d13..a835d4f
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -130,3 +130,4 @@ CONFIG_SMBIOS=y
>   CONFIG_ASPEED_SOC=y
>   CONFIG_GPIO_KEY=y
>   CONFIG_MSF2=y
> +CONFIG_KINETIS_K64=y
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 2794e08..874a38a
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -20,3 +20,4 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>   obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>   obj-$(CONFIG_MPS2) += mps2.o
>   obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
> +obj-$(CONFIG_KINETIS_K64) += mk64fn1m0.o
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 1bcd37e..75b194c
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -31,3 +31,4 @@ common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
>   
>   obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
>   obj-$(CONFIG_TERMINAL3270) += terminal3270.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_uart.o
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 19202d9..c5c8589
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -61,3 +61,6 @@ obj-$(CONFIG_AUX) += auxbus.o
>   obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
>   obj-y += mmio_interface.o
>   obj-$(CONFIG_MSF2) += msf2-sysreg.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_mcg.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_pmux.o
> +obj-$(CONFIG_KINETIS_K64) += kinetis_k64_system.o
> 
