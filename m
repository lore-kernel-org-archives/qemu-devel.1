Received: from eggs.gnu.org ([209.51.188.92]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLB8-0002bg-Mk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLAz-0005z9-KS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:14:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmLAz-0005yP-6g
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:14:53 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-17-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b0128d00-6b1c-9aa8-f597-6b87b13bf414@redhat.com>
Date: Wed, 23 Jan 2019 17:14:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-17-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 16/44] hw/alpha/Makefile.objs:
 Create CONFIG_* for alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com, Richard Henderson <rth@twiddle.net>

On 2019-01-23 07:55, Yang Zhong wrote:
> Add the new configs to default-configs/alpha-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/alpha-softmmu.mak | 2 ++
>  hw/alpha/Makefile.objs            | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index 4d654eaa0b..c570caccd1 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -19,3 +19,5 @@ CONFIG_I8259=y
>  CONFIG_MC146818RTC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_SMC37C669=y
> +CONFIG_DP264=y
> +CONFIG_TYPHOON=y
> diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
> index 5c742756f0..61579207ee 100644
> --- a/hw/alpha/Makefile.objs
> +++ b/hw/alpha/Makefile.objs
> @@ -1 +1,3 @@
> -obj-y += dp264.o pci.o typhoon.o
> +obj-y += pci.o
> +obj-$(CONFIG_DP264) += dp264.o
> +obj-$(CONFIG_TYPHOON) += typhoon.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
