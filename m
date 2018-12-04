Received: from eggs.gnu.org ([2001:4830:134:3::10]:41717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gTzAm-0006ZC-Dl
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gTzAg-0003CX-KS
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:06:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gTzAg-00037Q-82
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:06:42 -0500
Date: Mon, 3 Dec 2018 20:06:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181203200403-mutt-send-email-mst@kernel.org>
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 3/4] i386: import bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com

On Mon, Dec 03, 2018 at 10:48:51PM +0800, Li Zhijian wrote:
> It provides setup_data struct and header fields
> 
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>


Sorry I was unclear when I said "import it from Linux".

The way to import it is to copy the header
from the linux kernel by adding it to ./scripts/update-linux-headers.sh
and placing a copy into include/standard-headers/

Hope that helps.

> ---
> V3: new patch
> ---
>  hw/i386/pc.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 067d23a..8db7417 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,7 @@
>  #include "hw/nmi.h"
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/net/ne2000-isa.h"
> +#include <asm/bootparam.h>
>  
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -820,20 +821,6 @@ static long get_file_size(FILE *f)
>      return size;
>  }
>  
> -/* setup_data types */
> -#define SETUP_NONE     0
> -#define SETUP_E820_EXT 1
> -#define SETUP_DTB      2
> -#define SETUP_PCI      3
> -#define SETUP_EFI      4
> -
> -struct setup_data {
> -    uint64_t next;
> -    uint32_t type;
> -    uint32_t len;
> -    uint8_t data[0];
> -} __attribute__((packed));
> -
>  static void load_linux(PCMachineState *pcms,
>                         FWCfgState *fw_cfg)
>  {
> -- 
> 2.7.4
