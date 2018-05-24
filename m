Received: from eggs.gnu.org ([2001:4830:134:3::10]:38466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLjLn-0008Lv-26
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLjLi-0007Jl-5h
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:03:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLjLh-0007J8-Vz
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:03:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id j20-v6so294948pff.10
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 23:03:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180522191743.12872-1-pbonzini@redhat.com>
Message-ID: <af5b29f1-b37f-e891-ceb3-9f5bb0762dd1@redhat.com>
Date: Thu, 24 May 2018 08:03:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180522191743.12872-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc: move at24c to its own CONFIG_ symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

On 22/05/2018 21:17, Paolo Bonzini wrote:
> AT24c EEPROM is currently gated by CONFIG_I2C, and as such it is
> being included in all emulators that use I2C, even if they do not
> really need it.  Separate it and, since it was added for the e500
> machines, add it to qemu-system-ppc and qemu-system-ppc64.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  default-configs/ppc-softmmu.mak | 1 +
>  hw/nvram/Makefile.objs          | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 4d7be45ac5..c57e568121 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=y
>  CONFIG_SM501=y
>  CONFIG_IDE_SII3112=y
>  CONFIG_I2C=y
> +CONFIG_AT24C=y
>  
>  # For Macs
>  CONFIG_MAC=y
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> index a912d25391..b318e53a43 100644
> --- a/hw/nvram/Makefile.objs
> +++ b/hw/nvram/Makefile.objs
> @@ -1,6 +1,6 @@
>  common-obj-$(CONFIG_DS1225Y) += ds1225y.o
>  common-obj-y += eeprom93xx.o
> -common-obj-$(CONFIG_I2C) += eeprom_at24c.o
> +common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
>  common-obj-y += fw_cfg.o
>  common-obj-y += chrp_nvram.o
>  common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
> 
