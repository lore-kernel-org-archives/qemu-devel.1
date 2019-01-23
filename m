Received: from eggs.gnu.org ([209.51.188.92]:51238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLLs-0002Wl-EP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLLr-0005zG-H3
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:26:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmLLr-0005yE-7l
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:26:07 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-20-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fb1309bf-ddc5-6060-d145-3c1c230c942d@redhat.com>
Date: Wed, 23 Jan 2019 17:26:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-20-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 19/44] hw/moxie/Makefile.objs:
 Conditionally build moxie
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com, Anthony Green <green@moxielogic.com>

On 2019-01-23 07:55, Yang Zhong wrote:
> CONFIG_MOXIE added for moxiesim board.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/moxie-softmmu.mak | 1 +
>  hw/moxie/Makefile.objs            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/moxie-softmmu.mak b/default-configs/moxie-softmmu.mak
> index e00d099994..b1765630f2 100644
> --- a/default-configs/moxie-softmmu.mak
> +++ b/default-configs/moxie-softmmu.mak
> @@ -5,3 +5,4 @@ CONFIG_MC146818RTC=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_VGA=y
> +CONFIG_MOXIE=y
> diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
> index bfc90012fd..cb575ef0ca 100644
> --- a/hw/moxie/Makefile.objs
> +++ b/hw/moxie/Makefile.objs
> @@ -1,2 +1,2 @@
>  # moxie boards
> -obj-y += moxiesim.o
> +obj-$(CONFIG_MOXIE) += moxiesim.o

Maybe it should rather be called CONFIG_MOXIESIM ?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
