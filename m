Received: from eggs.gnu.org ([209.51.188.92]:46582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhw8-00080j-9S
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhw4-0005Ef-CN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjhvy-00056F-Ky
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:56:34 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-15-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0af3d575-88ae-4ca9-7288-64d878384a46@redhat.com>
Date: Wed, 16 Jan 2019 10:56:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-15-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/37] hw/sparc64/Makefile.objs:
 Create CONFIG_* for sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 2019-01-15 15:10, Yang Zhong wrote:
> Add the new configs to default-configs/sparc64-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/sparc64-softmmu.mak | 2 ++
>  hw/sparc64/Makefile.objs            | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
> index ce63d47046..1fae4888db 100644
> --- a/default-configs/sparc64-softmmu.mak
> +++ b/default-configs/sparc64-softmmu.mak
> @@ -17,3 +17,5 @@ CONFIG_SUNHME=y
>  CONFIG_MC146818RTC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_SUN4V_RTC=y
> +CONFIG_SUN4U=y
> +CONFIG_NIAGARA=y
> diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
> index 117e0ff27d..af0525c1a2 100644
> --- a/hw/sparc64/Makefile.objs
> +++ b/hw/sparc64/Makefile.objs
> @@ -1,4 +1,4 @@
>  obj-y += sparc64.o
> -obj-y += sun4u_iommu.o
> -obj-y += sun4u.o
> -obj-y += niagara.o
> \ No newline at end of file
> +obj-$(CONFIG_SUN4U) += sun4u_iommu.o
> +obj-$(CONFIG_SUN4U) += sun4u.o
> +obj-$(CONFIG_NIAGARA) += niagara.o
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
