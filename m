Received: from eggs.gnu.org ([208.118.235.92]:41983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf5DE-00036E-Cq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf5D9-0002Pp-Dm
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:47:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf5D9-0002FK-69
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:47:07 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-10-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <026da2df-387b-d434-fcfd-0eec798e54c4@redhat.com>
Date: Thu, 3 Jan 2019 16:47:02 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-10-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 09/25] ide: express dependencies with
 Kconfig
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

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index 5ec449525f..091f3a81c9 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -3,33 +3,44 @@ config IDE_CORE
>  
>  config IDE_QDEV
>      bool
> +    select IDE_CORE
>  
>  config IDE_PCI
>      bool
> +    select IDE_CORE
>  
>  config IDE_ISA
>      bool
> +    select IDE_QDEV
>  
>  config IDE_PIIX
>      bool
> +    select IDE_QDEV
>  
>  config IDE_CMD646
>      bool
> +    select IDE_QDEV

PIIX and CMD646 seem to be derived from TYPE_PCI_IDE, so shouldn't these
switches rather select IDE_PCI instead? (Or depend on IDE_PCI?)

>  config IDE_MACIO
>      bool
> +    select IDE_QDEV
>  
>  config IDE_MMIO
>      bool
> +    select IDE_QDEV
>  
>  config IDE_VIA
>      bool
> +    select IDE_QDEV

dito, VIA is a PCI device, too.

>  config MICRODRIVE
>      bool
> +    select IDE_QDEV
>  
>  config AHCI
>      bool
> +    select IDE_QDEV
>  
>  config IDE_SII3112
>      bool
> +    select IDE_QDEV
> 

dito, SII3112 is a PCI device.

 Thomas
