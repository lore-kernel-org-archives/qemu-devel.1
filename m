Received: from eggs.gnu.org ([209.51.188.92]:45695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjlYu-0003TJ-IW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjlYs-0004MQ-Qv
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjlYr-0004GW-ER
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:48:54 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-25-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4fe7900d-13c9-348e-3e14-89dc80251c3e@redhat.com>
Date: Wed, 16 Jan 2019 14:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-25-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 24/37] build: convert sound.mak to
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

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> There is really nothing special in these devices; they are just
> ISA devices.  Instead of including them for each target,
> set CONFIG_ISA to true, and make the devices default to present
> whenever ISA is available.  More conversion of ISA devices will
> follow.
[...]
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 301cc83279..c7003e4284 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -1,8 +1,8 @@
>  # Default configuration for ppc-softmmu
>  
> -include sound.mak
>  include usb.mak
>  CONFIG_PCI=y
> +ONFIG_ISA=y

Typo: CONFIG_ISA please

 Cheers,
  Thomas
