Received: from eggs.gnu.org ([208.118.235.92]:33989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRVq-0008Vl-SN
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfRVj-0007SA-PN
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:35:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfRVg-0007Oj-0v
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:35:45 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-20-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f5fdb28-54da-c369-7433-53e89c243b21@redhat.com>
Date: Fri, 4 Jan 2019 16:35:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-20-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 19/25] edid: express dependencies with
 kconfig
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
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/display/Kconfig | 2 ++
>  hw/i2c/Kconfig     | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 8ddce09ead..8b8f1027b1 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -38,6 +38,7 @@ config VGA_PCI
>      default y
>      depends on PCI
>      select VGA
> +    select EDID
>  
>  config VGA_ISA
>      bool
> @@ -59,6 +60,7 @@ config BOCHS_DISPLAY
>      default y
>      depends on PCI
>      select VGA
> +    select EDID
>  
>  config BLIZZARD
>      bool
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index 74c9328729..ef1caa6d89 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -8,6 +8,7 @@ config SMBUS_EEPROM
>  config DDC
>      bool
>      depends on I2C
> +    select EDID
>  
>  config VERSATILE_I2C
>      bool
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
