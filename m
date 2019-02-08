Received: from eggs.gnu.org ([209.51.188.92]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gsA3m-00071t-VV
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gsA3m-0001C3-7I
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:35:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47444
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gsA3l-0001BR-Rz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:35:30 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-48-git-send-email-pbonzini@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ef86ffab-9dd7-869e-195f-2617ecb98b15@ilande.co.uk>
Date: Fri, 8 Feb 2019 17:35:21 +0000
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-48-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 47/51] sparc64-softmmu.mak: express
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

On 07/02/2019 17:57, Paolo Bonzini wrote:

> %-softmmu.mak only keep boards and optional device
> definitions in Kconfig mode.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/sparc64-softmmu.mak | 23 ++++++++---------------
>  hw/sparc64/Kconfig                  | 13 +++++++++++++
>  2 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
> index 528af8f..e50030a 100644
> --- a/default-configs/sparc64-softmmu.mak
> +++ b/default-configs/sparc64-softmmu.mak
> @@ -1,19 +1,12 @@
>  # Default configuration for sparc64-softmmu
>  
> -CONFIG_PCI=y
> -CONFIG_PCI_DEVICES=y
> -CONFIG_M48T59=y
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
> -CONFIG_PARALLEL=y
> -CONFIG_PCKBD=y
> -CONFIG_FDC=y
> -CONFIG_IDE_CMD646=y
> -CONFIG_PCI_SABRE=y
> -CONFIG_SIMBA=y
> -CONFIG_SUNHME=y
> -CONFIG_MC146818RTC=y
> -CONFIG_TEST_DEVICES=y
> -CONFIG_SUN4V_RTC=y
> +# Uncomment the following lines to disable these optional devices:
> +#
> +#CONFIG_PCI_DEVICES=n
> +#CONFIG_SUNHME=n

Again I'm not sure what you mean by optional? sunhme has been the default NIC for the
sun4u machine for several QEMU releases now.

> +#CONFIG_TEST_DEVICES=n
> +
> +# Boards:
> +#
>  CONFIG_SUN4U=y
>  CONFIG_NIAGARA=y
> diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
> index 41f7295..4a8166e 100644
> --- a/hw/sparc64/Kconfig
> +++ b/hw/sparc64/Kconfig
> @@ -1,6 +1,19 @@
>  config SUN4U
>      bool
> +    imply PCI_DEVICES
> +    imply SUNHME
> +    imply TEST_DEVICES
> +    select M48T59
>      select ISA_BUS
> +    select FDC
> +    select SERIAL_ISA
> +    select PCI_SABRE
> +    select IDE_CMD646
> +    select PARALLEL
> +    select PCKBD
> +    select SIMBA
>  
>  config NIAGARA
>      bool
> +    select EMPTY_SLOT
> +    select SUN4V_RTC
> 


ATB,

Mark.
