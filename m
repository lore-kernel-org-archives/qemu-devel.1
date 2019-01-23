Received: from eggs.gnu.org ([209.51.188.92]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPy6-00051g-K5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPrx-00072E-VG
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:15:35 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmPrq-0006ts-2A
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:15:28 -0500
Received: by mail-pg1-x544.google.com with SMTP id v28so1625075pgk.10
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:15:22 -0800 (PST)
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-19-yang.zhong@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <80b01f75-d51e-3284-004c-b844dbf70ed0@linaro.org>
Date: Wed, 23 Jan 2019 13:15:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-19-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 18/44] hw/hppa/Makefile.objs: Create
 CONFIG_* for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com

On 1/22/19 10:55 PM, Yang Zhong wrote:
> Add the new configs to default-configs/hppa-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/hppa-softmmu.mak | 2 ++
>  hw/hppa/Makefile.objs            | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
> index 4badc0521e..846e9f0ba6 100644
> --- a/default-configs/hppa-softmmu.mak
> +++ b/default-configs/hppa-softmmu.mak
> @@ -10,3 +10,5 @@ CONFIG_IDE_CMD646=y
>  # CONFIG_IDE_MMIO=y
>  CONFIG_VIRTIO_VGA=y
>  CONFIG_MC146818RTC=y
> +CONFIG_HPPA=y
> +CONFIG_DINO=y

Why CONFIG_HPPA?
Isn't that implied by...

> diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
> index bef241ed25..6204b74e5e 100644
> --- a/hw/hppa/Makefile.objs
> +++ b/hw/hppa/Makefile.objs
> @@ -1 +1,3 @@
> -obj-y += machine.o pci.o dino.o
> +obj-y += pci.o
> +obj-$(CONFIG_HPPA) += machine.o

... arriving in the hw/hppa directory?
What makes pci.o different from machine.o?

> +obj-$(CONFIG_DINO) += dino.o

My question for Alpha about a single machine type applies here as well.


r~
