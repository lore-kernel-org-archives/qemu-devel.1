Received: from eggs.gnu.org ([209.51.188.92]:53156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gsA2B-0005zt-LQ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gsA2A-0007sr-UP
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:33:51 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47436
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gsA2A-0007s9-Nw
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:33:50 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-47-git-send-email-pbonzini@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3a979817-5418-24b0-8568-fa6aa1de20e0@ilande.co.uk>
Date: Fri, 8 Feb 2019 17:33:39 +0000
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-47-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 46/51] sparc-softmmu.mak: express
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
>  default-configs/sparc-softmmu.mak | 22 ++++++----------------
>  hw/misc/Kconfig                   |  1 +
>  hw/net/Kconfig                    |  1 +
>  hw/sparc/Kconfig                  | 13 +++++++++++++
>  4 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/default-configs/sparc-softmmu.mak b/default-configs/sparc-softmmu.mak
> index b31a9f2..ee85218 100644
> --- a/default-configs/sparc-softmmu.mak
> +++ b/default-configs/sparc-softmmu.mak
> @@ -1,21 +1,11 @@
>  # Default configuration for sparc-softmmu
>  
> -CONFIG_ISA_BUS=y
> -CONFIG_ECC=y
> -CONFIG_ESP=y
> -CONFIG_ESCC=y
> -CONFIG_M48T59=y
> -CONFIG_FDC=y
> -CONFIG_EMPTY_SLOT=y
> -CONFIG_PCNET_COMMON=y
> -CONFIG_LANCE=y
> -CONFIG_TCX=y
> -CONFIG_CG3=y
> -CONFIG_SLAVIO=y
> -CONFIG_CS4231=y
> -CONFIG_GRLIB=y
> -CONFIG_STP2000=y
> -CONFIG_ECCMEMCTL=y
> +# Uncomment the following lines to disable these optional devices:
> +#
> +#CONFIG_TCX=n
> +#CONFIG_CG3=n

What do you mean by optional here? The video card that is selected is built-in to the
machine so is this comment eluding to a headless sun4m machine started with
-nodefaults or similar?

> +# Boards:
> +#
>  CONFIG_SUN4M=y
>  CONFIG_LEON3=y
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 728c561..11d4b30 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -71,6 +71,7 @@ config IVSHMEM_DEVICE
>  
>  config ECCMEMCTL
>      bool
> +    select ECC
>  
>  config IMX
>      bool
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 1aa1071..c132180 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -77,6 +77,7 @@ config STELLARIS_ENET
>  
>  config LANCE
>      bool
> +    select PCNET_COMMON
>  
>  config SUNHME
>      bool
> diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
> index c9c2142..2a83a80 100644
> --- a/hw/sparc/Kconfig
> +++ b/hw/sparc/Kconfig
> @@ -1,8 +1,21 @@
>  config SUN4M
>      bool
> +    imply TCX
> +    imply CG3
> +    select CS4231
> +    select ECCMEMCTL
> +    select EMPTY_SLOT
> +    select ESCC
> +    select ESP
> +    select FDC
> +    select SLAVIO
> +    select LANCE
> +    select M48T59
> +    select STP2000
>  
>  config LEON3
>      bool
> +    select GRLIB
>  
>  config GRLIB
>      bool


ATB,

Mark.
