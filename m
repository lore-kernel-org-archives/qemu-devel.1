Received: from eggs.gnu.org ([209.51.188.92]:42866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjT3S-0005uc-5d
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjT3Q-00045u-D7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjT3Q-00041G-2m
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:03:12 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-2-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6688ca8d-6aae-a40b-85fa-5910a6af4a53@redhat.com>
Date: Tue, 15 Jan 2019 19:02:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-2-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/37] build: actually use CONFIG_PAM
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
> Do not link it unconditionally into all binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I think you should put your Signed-off-by below Paolo's S-o-b into this
patch, too (since you've edited it).

> ---
>  default-configs/i386-softmmu.mak | 1 +
>  hw/pci-host/Makefile.objs        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 64c998c4c8..4711155a33 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -67,3 +67,4 @@ CONFIG_I2C=y
>  CONFIG_SEV=$(CONFIG_KVM)
>  CONFIG_VTD=y
>  CONFIG_AMD_IOMMU=y
> +CONFIG_PAM=y
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index 6d6597c065..9d7e7cd1b8 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y += pam.o
> +common-obj-$(CONFIG_PAM) += pam.o
>  
>  # PPC devices
>  common-obj-$(CONFIG_PREP_PCI) += prep.o
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
