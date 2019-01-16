Received: from eggs.gnu.org ([209.51.188.92]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhdo-0008Q5-RK
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjhdo-00019S-0k
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjhdn-00012w-LN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:37:43 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-13-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df45c647-5fe0-0f10-1c9a-8ce1437ddb82@redhat.com>
Date: Wed, 16 Jan 2019 10:37:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-13-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 12/37] hw/nios2/Makefile.objs:
 Conditionally build nios2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

On 2019-01-15 15:10, Yang Zhong wrote:
> CONFIG_NIOS2_10M50_BOARD added for 10m50 dev board.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/nios2-softmmu.mak | 1 +
>  hw/nios2/Makefile.objs            | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
> index 74dc70caae..f634c36d36 100644
> --- a/default-configs/nios2-softmmu.mak
> +++ b/default-configs/nios2-softmmu.mak
> @@ -4,3 +4,4 @@ CONFIG_NIOS2=y
>  CONFIG_SERIAL=y
>  CONFIG_PTIMER=y
>  CONFIG_ALTERA_TIMER=y
> +CONFIG_NIOS2_10M50_BOARD=y
> diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
> index 6b5c421760..12a2891395 100644
> --- a/hw/nios2/Makefile.objs
> +++ b/hw/nios2/Makefile.objs
> @@ -1 +1,2 @@
> -obj-y = boot.o cpu_pic.o 10m50_devboard.o
> +obj-y = boot.o cpu_pic.o
> +obj-$(CONFIG_NIOS2_10M50_BOARD) += 10m50_devboard.o
> 

I'd maybe rather only name it CONFIG_NIOS2_10M50 ... anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
