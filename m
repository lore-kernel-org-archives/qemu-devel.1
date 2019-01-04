Received: from eggs.gnu.org ([208.118.235.92]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPir-00063R-EO
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPil-00009V-Um
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:41:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfPil-00006W-NA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:41:07 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-15-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f67fc73d-8bfa-245e-b63d-4b4888e50be1@redhat.com>
Date: Fri, 4 Jan 2019 14:41:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-15-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 14/25] bluetooth: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/Makefile.objs | 2 +-
>  hw/usb/Kconfig   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 39d882af6f..b95b0c74a1 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -3,7 +3,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += acpi/
>  devices-dirs-$(CONFIG_SOFTMMU) += adc/
>  devices-dirs-$(CONFIG_SOFTMMU) += audio/
>  devices-dirs-$(CONFIG_SOFTMMU) += block/
> -devices-dirs-$(CONFIG_SOFTMMU) += bt/
> +devices-dirs-$(CONFIG_BLUETOOTH) += bt/
>  devices-dirs-$(CONFIG_SOFTMMU) += char/
>  devices-dirs-$(CONFIG_SOFTMMU) += cpu/
>  devices-dirs-$(CONFIG_SOFTMMU) += display/
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 0b8f41040e..7b7ccfc039 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -77,6 +77,7 @@ config USB_BLUETOOTH
>      bool
>      default y
>      depends on USB
> +    select BLUETOOTH
>  
>  config USB_SMARTCARD
>      bool
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
