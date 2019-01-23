Received: from eggs.gnu.org ([209.51.188.92]:49600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLJy-0000WI-Km
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLJw-0004U6-OM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:24:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmLJt-0004QT-GY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:24:06 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-19-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c74e04b6-21f8-a0eb-be92-c5c8c8ae226b@redhat.com>
Date: Wed, 23 Jan 2019 17:23:54 +0100
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>

On 2019-01-23 07:55, Yang Zhong wrote:
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
> diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
> index bef241ed25..6204b74e5e 100644
> --- a/hw/hppa/Makefile.objs
> +++ b/hw/hppa/Makefile.objs
> @@ -1 +1,3 @@
> -obj-y += machine.o pci.o dino.o
> +obj-y += pci.o
> +obj-$(CONFIG_HPPA) += machine.o
> +obj-$(CONFIG_DINO) += dino.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
