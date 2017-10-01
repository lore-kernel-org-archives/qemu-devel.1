Received: from eggs.gnu.org ([2001:4830:134:3::10]:43294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTMF-0000iX-0n
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTMC-0006iI-5V
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:47:51 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTMC-0006hu-0s
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:47:48 -0400
Received: by mail-qt0-x243.google.com with SMTP id i50so3741838qtf.0
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:47:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<f7aef8b84f0880faa0ec95abbb95910c166eb347.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c8bc3467-3d30-7943-e56e-0f61dfd38f7f@amsat.org>
Date: Sat, 30 Sep 2017 22:47:44 -0300
MIME-Version: 1.0
In-Reply-To: <f7aef8b84f0880faa0ec95abbb95910c166eb347.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 25/47] hw/misc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:16 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/misc/a9scu.c     |  3 ++-
>   hw/misc/omap_gpmc.c | 11 ++++++-----
>   hw/misc/omap_l4.c   |  5 +++--
>   hw/misc/omap_sdrc.c |  3 ++-
>   hw/misc/vmport.c    |  2 +-
>   5 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
> index 3e8ad8cd73..21b8e49b6c 100644
> --- a/hw/misc/a9scu.c
> +++ b/hw/misc/a9scu.c
> @@ -9,6 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/misc/a9scu.h"
>   
>   static uint64_t a9_scu_read(void *opaque, hwaddr offset,
> @@ -59,7 +60,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
>           mask = 0xffffffff;
>           break;
>       default:
> -        fprintf(stderr, "Invalid size %u in write to a9 scu register %x\n",
> +        error_report("Invalid size %u in write to a9 scu register %x",
>                   size, (unsigned)offset);
>           return;
>       }
> diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
> index 84f9e4c612..e3b30e90ea 100644
> --- a/hw/misc/omap_gpmc.c
> +++ b/hw/misc/omap_gpmc.c
> @@ -19,6 +19,7 @@
>    * with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/block/flash.h"
>   #include "hw/arm/omap.h"
> @@ -408,7 +409,7 @@ static void omap_gpmc_cs_map(struct omap_gpmc_s *s, int cs)
>       /* TODO: check for overlapping regions and report access errors */
>       if (mask != 0x8 && mask != 0xc && mask != 0xe && mask != 0xf
>            && !(s->accept_256 && !mask)) {
> -        fprintf(stderr, "%s: invalid chip-select mask address (0x%x)\n",
> +        error_report("%s: invalid chip-select mask address (0x%x)",
>                    __func__, mask);
>       }
>   
> @@ -642,7 +643,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
>   
>       case 0x010:	/* GPMC_SYSCONFIG */
>           if ((value >> 3) == 0x3)
> -            fprintf(stderr, "%s: bad SDRAM idle mode %"PRIi64"\n",
> +            error_report("%s: bad SDRAM idle mode %"PRIi64"",
>                               __func__, value >> 3);
>           if (value & 2)
>               omap_gpmc_reset(s);
> @@ -806,7 +807,7 @@ static void omap_gpmc_write(void *opaque, hwaddr addr,
>           break;
>       case 0x230:	/* GPMC_TESTMODE_CTRL */
>           if (value & 7)
> -            fprintf(stderr, "%s: test mode enable attempt\n", __func__);
> +            error_report("%s: test mode enable attempt", __func__);
>           break;
>   
>       default:
> @@ -864,7 +865,7 @@ void omap_gpmc_attach(struct omap_gpmc_s *s, int cs, MemoryRegion *iomem)
>       assert(iomem);
>   
>       if (cs < 0 || cs >= 8) {
> -        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
> +        error_report("%s: bad chip-select %i", __func__, cs);
>           exit(-1);
>       }
>       f = &s->cs_file[cs];
> @@ -881,7 +882,7 @@ void omap_gpmc_attach_nand(struct omap_gpmc_s *s, int cs, DeviceState *nand)
>       assert(nand);
>   
>       if (cs < 0 || cs >= 8) {
> -        fprintf(stderr, "%s: bad chip-select %i\n", __func__, cs);
> +        error_report("%s: bad chip-select %i", __func__, cs);
>           exit(-1);
>       }
>       f = &s->cs_file[cs];
> diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
> index 96fc057b4e..47d9c10aeb 100644
> --- a/hw/misc/omap_l4.c
> +++ b/hw/misc/omap_l4.c
> @@ -18,6 +18,7 @@
>    * with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/arm/omap.h"
>   
> @@ -126,7 +127,7 @@ struct omap_target_agent_s *omap_l4ta_get(struct omap_l4_s *bus,
>               break;
>           }
>       if (!ta) {
> -        fprintf(stderr, "%s: bad target agent (%i)\n", __func__, cs);
> +        error_report("%s: bad target agent (%i)", __func__, cs);
>           exit(-1);
>       }
>   
> @@ -151,7 +152,7 @@ hwaddr omap_l4_attach(struct omap_target_agent_s *ta,
>       hwaddr base;
>   
>       if (region < 0 || region >= ta->regions) {
> -        fprintf(stderr, "%s: bad io region (%i)\n", __func__, region);
> +        error_report("%s: bad io region (%i)", __func__, region);
>           exit(-1);
>       }
>   
> diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
> index 7b38c5568c..3dcabc1e00 100644
> --- a/hw/misc/omap_sdrc.c
> +++ b/hw/misc/omap_sdrc.c
> @@ -18,6 +18,7 @@
>    * with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/arm/omap.h"
>   
> @@ -108,7 +109,7 @@ static void omap_sdrc_write(void *opaque, hwaddr addr,
>   
>       case 0x10:	/* SDRC_SYSCONFIG */
>           if ((value >> 3) != 0x2)
> -            fprintf(stderr, "%s: bad SDRAM idle mode %i\n",
> +            error_report("%s: bad SDRAM idle mode %i",
>                       __func__, (unsigned)value >> 3);
>           if (value & 2)
>               omap_sdrc_reset(s);
> diff --git a/hw/misc/vmport.c b/hw/misc/vmport.c
> index 165500223f..55369bd180 100644
> --- a/hw/misc/vmport.c
> +++ b/hw/misc/vmport.c
> @@ -80,7 +80,7 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr addr,
>       if (!s->func[command])
>       {
>   #ifdef VMPORT_DEBUG
> -        fprintf(stderr, "vmport: unknown command %x\n", command);
> +        error_report("vmport: unknown command %x", command);
>   #endif
>           return eax;
>       }
> 
