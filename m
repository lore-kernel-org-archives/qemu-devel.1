Received: from eggs.gnu.org ([2001:4830:134:3::10]:39090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam@ravnborg.org>) id 1cFTC8-0007Rw-0G
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 16:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam@ravnborg.org>) id 1cFTC3-0000Pu-Co
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 16:59:08 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:46342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam@ravnborg.org>) id 1cFTC3-0000OF-6o
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 16:59:03 -0500
Date: Fri, 9 Dec 2016 22:58:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20161209215851.GA7717@ravnborg.org>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] sparc: fix a building error
 reported by kbuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org, luonengjun@huawei.com, mst@redhat.com, stefanha@redhat.com, weidong.huang@huawei.com, wu.wubin@huawei.com, xin.zeng@intel.com, claudio.fontana@huawei.com, herbert@gondor.apana.org.au, pasic@linux.vnet.ibm.com, davem@davemloft.net, jianjay.zhou@huawei.com, hanweidong@huawei.com, arei.gonglei@hotmail.com, cornelia.huck@de.ibm.com, xuquan8@huawei.com, longpeng2@huawei.com, wanzongshun@huawei.com, sparclinux@vger.kernel.org

Hi Gonglei.

On Thu, Dec 08, 2016 at 12:37:08PM +0800, Gonglei wrote:
> >> arch/sparc/include/asm/topology_64.h:44:44:
> error: implicit declaration of function 'cpu_data'
> [-Werror=implicit-function-declaration]
> 
>  #define topology_physical_package_id(cpu) (cpu_data(cpu).proc_id)
>                                                ^
> Let's include cpudata.h in topology_64.h.
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  arch/sparc/include/asm/topology_64.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
> index 7b4898a..2255430 100644
> --- a/arch/sparc/include/asm/topology_64.h
> +++ b/arch/sparc/include/asm/topology_64.h
> @@ -4,6 +4,7 @@
>  #ifdef CONFIG_NUMA
>  
>  #include <asm/mmzone.h>
> +#include <asm/cpudata.h>

Nitpick - if you are going to resend this patch, then please
order the two includes in alphabetic order.

For two includes this looks like bikeshedding, but when we add
more having them in a defined arder prevents merge conflicts.
And makes it readable too.

We also sometimes order the includes with the longest lines topmost,
and lines with the ame length are ordered alphabetically.
But this is not seen so often.

	Sam
