Received: from eggs.gnu.org ([2001:4830:134:3::10]:50710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLDwU-0002H3-S1
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLDwT-0001hx-MP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:31:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522191743.12872-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab0d563a-89f7-ffdb-7f43-956d7213b231@amsat.org>
Date: Tue, 22 May 2018 17:31:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180522191743.12872-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] ppc: move at24c to its own
 CONFIG_ symbol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

On 05/22/2018 04:17 PM, Paolo Bonzini wrote:
> AT24c EEPROM is currently gated by CONFIG_I2C, and as such it is
> being included in all emulators that use I2C, even if they do not
> really need it.  Separate it and, since it was added for the e500
> machines, add it to qemu-system-ppc and qemu-system-ppc64.

With your S-o-b:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
