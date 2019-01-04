Received: from eggs.gnu.org ([208.118.235.92]:56803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPhh-00053L-73
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPha-0007zj-KE
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:40:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfPha-0007zL-9G
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:39:54 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-14-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fa9d19df-c373-f647-a732-9fc76d9b2f4b@redhat.com>
Date: Fri, 4 Jan 2019 14:39:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-14-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/25] scsi: express dependencies with
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
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> This lets you disable SCSI altogether with "CONFIG_SCSI=n".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/scsi/Kconfig       | 11 ++++++++++-
>  hw/scsi/Makefile.objs |  2 +-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index 6e7575397f..d669a4824e 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -5,24 +5,29 @@ config LSI_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config MPTSAS_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config MEGASAS_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config VMW_PVSCSI_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config ESP
>      bool
> +    select SCSI
>  
>  config ESP_PCI
>      bool
> @@ -30,11 +35,15 @@ config ESP_PCI
>      depends on PCI
>      select ESP
>  
> -config PSERIES
> +config SPAPR_VSCSI
>      bool
> +    select SCSI

I think this should get "default y" and "depends on PSERIES" now.

 Thomas
