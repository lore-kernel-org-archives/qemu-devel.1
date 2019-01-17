Received: from eggs.gnu.org ([209.51.188.92]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk4lV-0002do-EY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk4lU-00062c-N5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:19:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk4lU-00061x-EZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:19:12 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-28-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8e67c71c-cf22-5158-ed44-a9de555c6af6@redhat.com>
Date: Thu, 17 Jan 2019 11:19:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-28-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 27/37] bluetooth: express
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
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

Note that bluetooth currently can not be disabled yet (code in vl.c
still calls some functions in hw/bt/), so we might need to keep the bt
folder always enabled here for now, to be able to compile boards that do
not include the bt-hci device.

 Thomas
