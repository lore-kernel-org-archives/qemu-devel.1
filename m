Received: from eggs.gnu.org ([209.51.188.92]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLd9-0001cu-BS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLd7-0002el-BG
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmLd5-0002cV-9s
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:43:55 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-22-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <430e347b-d020-9bd8-8253-4d45d09211c1@redhat.com>
Date: Wed, 23 Jan 2019 17:43:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-22-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 21/44] hw/tricore/Makefile.objs:
 Create CONFIG_* for tricore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 2019-01-23 07:55, Yang Zhong wrote:
> Add the new configs to default-configs/tricore-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/tricore-softmmu.mak | 1 +
>  hw/tricore/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/tricore-softmmu.mak b/default-configs/tricore-softmmu.mak
> index e69de29bb2..c397cff38a 100644
> --- a/default-configs/tricore-softmmu.mak
> +++ b/default-configs/tricore-softmmu.mak
> @@ -0,0 +1 @@
> +CONFIG_TRICORE=y
> diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
> index 435e095cff..5501f6c1a8 100644
> --- a/hw/tricore/Makefile.objs
> +++ b/hw/tricore/Makefile.objs
> @@ -1 +1 @@
> -obj-y += tricore_testboard.o
> +obj-$(CONFIG_TRICORE) += tricore_testboard.o
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
