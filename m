Received: from eggs.gnu.org ([209.51.188.92]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTxU-0003FA-Gi
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTxJ-000728-OE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:44 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTxH-0006ks-TB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:41 -0500
Received: by mail-ot1-x342.google.com with SMTP id n71so40785131ota.10
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:37:46 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Date: Wed, 20 Feb 2019 08:06:33 -0600
From: Corey Minyard <minyard@acm.org>
Message-ID: <20190220140633.GA22452@minyard.net>
Reply-To: minyard@acm.org
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-29-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549562254-41157-29-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 28/51] ipmi: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>, thuth@redhat.com, philmd@redhat.com

On Thu, Feb 07, 2019 at 06:57:11PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-36-yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/i386-softmmu.mak  | 3 ---
>  default-configs/ppc64-softmmu.mak | 3 ---
>  hw/ipmi/Kconfig                   | 6 ++++++
>  3 files changed, 6 insertions(+), 6 deletions(-)


This looks ok to me.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 53e9d5e..e779ee1 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,9 +1,6 @@
>  # Default configuration for i386-softmmu
>  
>  CONFIG_VMXNET3_PCI=y
> -CONFIG_IPMI=y
> -CONFIG_IPMI_LOCAL=y
> -CONFIG_IPMI_EXTERN=y
>  CONFIG_ISA_IPMI_KCS=y
>  CONFIG_ISA_IPMI_BT=y
>  
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
> index a0a9151..d642b67 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -5,9 +5,6 @@ include ppc-softmmu.mak
>  
>  # For PowerNV
>  CONFIG_POWERNV=y
> -CONFIG_IPMI=y
> -CONFIG_IPMI_LOCAL=y
> -CONFIG_IPMI_EXTERN=y
>  CONFIG_ISA_IPMI_BT=y
>  
>  # For pSeries
> diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
> index 6a4f08f..b944fae 100644
> --- a/hw/ipmi/Kconfig
> +++ b/hw/ipmi/Kconfig
> @@ -3,14 +3,20 @@ config IPMI
>  
>  config IPMI_LOCAL
>      bool
> +    default y
> +    depends on IPMI
>  
>  config IPMI_EXTERN
>      bool
> +    default y
> +    depends on IPMI
>  
>  config ISA_IPMI_KCS
>      bool
>      depends on ISA_BUS
> +    select IPMI
>  
>  config ISA_IPMI_BT
>      bool
>      depends on ISA_BUS
> +    select IPMI
> -- 
> 1.8.3.1
> 
> 
> 
