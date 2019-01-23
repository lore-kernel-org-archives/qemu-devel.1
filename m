Received: from eggs.gnu.org ([209.51.188.92]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLDe-0004c5-I6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLDc-0007ra-DN
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:17:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmLDc-0007kq-07
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:17:36 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-18-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3cff3458-3d5a-443c-e972-cd379091c8b1@redhat.com>
Date: Wed, 23 Jan 2019 17:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-18-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 17/44] hw/cris/Makefile.objs: Create
 CONFIG_* for cris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 2019-01-23 07:55, Yang Zhong wrote:
> Add the new configs to default-configs/cris-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/cris-softmmu.mak | 1 +
>  hw/cris/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/cris-softmmu.mak b/default-configs/cris-softmmu.mak
> index d970d50158..a637c4b4bf 100644
> --- a/default-configs/cris-softmmu.mak
> +++ b/default-configs/cris-softmmu.mak
> @@ -4,3 +4,4 @@ CONFIG_ETRAXFS=y
>  CONFIG_NAND=y
>  CONFIG_PTIMER=y
>  CONFIG_PFLASH_CFI02=y
> +CONFIG_AXIS=y
> diff --git a/hw/cris/Makefile.objs b/hw/cris/Makefile.objs
> index 7624173f77..a4a27b3a13 100644
> --- a/hw/cris/Makefile.objs
> +++ b/hw/cris/Makefile.objs
> @@ -1,2 +1,2 @@
>  obj-y += boot.o
> -obj-y += axis_dev88.o
> +obj-$(CONFIG_AXIS) += axis_dev88.o

Reviewed-by: Thomas Huth <thuth@redhat.com>
