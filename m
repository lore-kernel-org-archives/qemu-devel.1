Received: from eggs.gnu.org ([2001:4830:134:3::10]:53600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1f7wE9-0006Sn-Ml
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1f7wE6-0003v3-M7
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:58:53 -0400
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-18-f4bug@amsat.org>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <16a3d8ff-2361-27c8-d93a-e210d7080063@tuxfamily.org>
Date: Mon, 16 Apr 2018 06:58:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180415234307.28132-18-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 17/41] hw/m68k: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>

On 16.04.2018 01:42, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/m68k/mcf5208.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index fac0d09cbc..673d65f8fd 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -6,6 +6,7 @@
>   * This code is licensed under the GPL
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> @@ -241,7 +242,7 @@ static void mcf5208evb_init(MachineState *machine)
>      memory_region_add_subregion(address_space_mem, 0x40000000, ram);
>  
>      /* Internal SRAM.  */
> -    memory_region_init_ram(sram, NULL, "mcf5208.sram", 16384, &error_fatal);
> +    memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * K_BYTE, &error_fatal);
>      memory_region_add_subregion(address_space_mem, 0x80000000, sram);
>  
>      /* Internal peripherals.  */
> 

Reviewed-by: Thomas Huth <thuth@tuxfamily.org>
