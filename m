Received: from eggs.gnu.org ([209.51.188.92]:56162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLbB-0000LK-Jf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmLb6-0000qJ-1Y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:41:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmLb3-0000YR-V8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:41:51 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-21-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43932ed0-eeac-2608-54a3-14c0a275cf7f@redhat.com>
Date: Wed, 23 Jan 2019 17:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-21-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 20/44] hw/openrisc/Makefile.objs:
 Create CONFIG_* for openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com, Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, Feng Gao <gf91597@gmail.com>

On 2019-01-23 07:55, Yang Zhong wrote:
> Add the new configs to default-configs/or1k-sofmmu.mak.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/or1k-softmmu.mak | 1 +
>  hw/openrisc/Makefile.objs        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
> index 6f5824fd48..85a7e696c7 100644
> --- a/default-configs/or1k-softmmu.mak
> +++ b/default-configs/or1k-softmmu.mak
> @@ -3,3 +3,4 @@
>  CONFIG_SERIAL=y
>  CONFIG_OPENCORES_ETH=y
>  CONFIG_OMPIC=y
> +CONFIG_OPENRISC=y
> diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
> index 61246b149b..8dc413c3b2 100644
> --- a/hw/openrisc/Makefile.objs
> +++ b/hw/openrisc/Makefile.objs
> @@ -1,2 +1,2 @@
>  obj-y = pic_cpu.o cputimer.o
> -obj-y += openrisc_sim.o 
> +obj-$(CONFIG_OPENRISC) += openrisc_sim.o

The machine is called "or1k-sim" in the "-machine help" output, so maybe
rather CONFIG_OR1K_SIM ?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
