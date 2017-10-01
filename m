Received: from eggs.gnu.org ([2001:4830:134:3::10]:51989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTTL-0004Mh-J2
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTTI-0007hP-OK
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:55:11 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTTI-0007gB-IO
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:55:08 -0400
Received: by mail-qt0-x242.google.com with SMTP id t46so3740786qtj.2
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:55:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<85d53cce03d155ea59564a2743e8eb4637b422f0.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85f54f2e-89b5-bbc4-15d3-9d38849182a5@amsat.org>
Date: Sat, 30 Sep 2017 22:55:04 -0300
MIME-Version: 1.0
In-Reply-To: <85d53cce03d155ea59564a2743e8eb4637b422f0.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/47] hw/dma: Replace fprintf(stderr,
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

On 09/29/2017 09:15 PM, Alistair Francis wrote:
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
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/dma/omap_dma.c | 26 ++++++++++++++------------
>   hw/dma/soc_dma.c  | 37 +++++++++++++++++++------------------
>   2 files changed, 33 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
> index abd18c67ea..5d7fe06d98 100644
> --- a/hw/dma/omap_dma.c
> +++ b/hw/dma/omap_dma.c
> @@ -18,6 +18,7 @@
>    * with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qemu-common.h"
>   #include "qemu/timer.h"
>   #include "hw/arm/omap.h"
> @@ -1898,13 +1899,13 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
>               omap_dma_reset(s->dma);
>           s->ocp = value & 0x3321;
>           if (((s->ocp >> 12) & 3) == 3)				/* MIDLEMODE */
> -            fprintf(stderr, "%s: invalid DMA power mode\n", __func__);
> +            error_report("%s: invalid DMA power mode", __func__);
>           return;
>   
>       case 0x78:	/* DMA4_GCR */
>           s->gcr = value & 0x00ff00ff;
>   	if ((value & 0xff) == 0x00)		/* MAX_CHANNEL_FIFO_DEPTH */
> -            fprintf(stderr, "%s: wrong FIFO depth in GCR\n", __func__);
> +            error_report("%s: wrong FIFO depth in GCR", __func__);
>           return;
>   
>       case 0x80 ... 0xfff:
> @@ -1934,8 +1935,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
>           ch->buf_disable = (value >> 25) & 1;
>           ch->src_sync = (value >> 24) & 1;	/* XXX For CamDMA must be 1 */
>           if (ch->buf_disable && !ch->src_sync)
> -            fprintf(stderr, "%s: Buffering disable is not allowed in "
> -                            "destination synchronised mode\n", __func__);
> +            error_report("%s: Buffering disable is not allowed in "
> +                         "destination synchronised mode", __func__);
>           ch->prefetch = (value >> 23) & 1;
>           ch->bs = (value >> 18) & 1;
>           ch->transparent_copy = (value >> 17) & 1;
> @@ -1946,8 +1947,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
>           ch->priority = (value & 0x0040) >> 6;
>           ch->fs = (value & 0x0020) >> 5;
>           if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1])
> -            fprintf(stderr, "%s: For a packet transfer at least one port "
> -                            "must be constant-addressed\n", __func__);
> +            error_report("%s: For a packet transfer at least one port "
> +                         "must be constant-addressed", __func__);
>           ch->sync = (value & 0x001f) | ((value >> 14) & 0x0060);
>           /* XXX must be 0x01 for CamDMA */
>   
> @@ -1977,8 +1978,8 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
>           ch->endian[1] =(value >> 19) & 1;
>           ch->endian_lock[1] =(value >> 18) & 1;
>           if (ch->endian[0] != ch->endian[1])
> -            fprintf(stderr, "%s: DMA endianness conversion enable attempt\n",
> -                            __func__);
> +            error_report("%s: DMA endianness conversion enable attempt",
> +                          __func__);
>           ch->write_mode = (value >> 16) & 3;
>           ch->burst[1] = (value & 0xc000) >> 14;
>           ch->pack[1] = (value & 0x2000) >> 13;
> @@ -1986,12 +1987,13 @@ static void omap_dma4_write(void *opaque, hwaddr addr,
>           ch->burst[0] = (value & 0x0180) >> 7;
>           ch->pack[0] = (value & 0x0040) >> 6;
>           ch->translate[0] = (value & 0x003c) >> 2;
> -        if (ch->translate[0] | ch->translate[1])
> -            fprintf(stderr, "%s: bad MReqAddressTranslate sideband signal\n",
> -                            __func__);
> +        if (ch->translate[0] | ch->translate[1]) {
> +            error_report("%s: bad MReqAddressTranslate sideband signal",
> +                         __func__);
> +        }
>           ch->data_type = 1 << (value & 3);
>           if ((value & 3) == 3) {
> -            printf("%s: bad data_type for DMA channel\n", __func__);
> +            error_report("%s: bad data_type for DMA channel", __func__);
>               ch->data_type >>= 1;
>           }
>           break;
> diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
> index 9bb499bf9c..7339a3ec95 100644
> --- a/hw/dma/soc_dma.c
> +++ b/hw/dma/soc_dma.c
> @@ -18,6 +18,7 @@
>    * with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qemu-common.h"
>   #include "qemu/timer.h"
>   #include "hw/arm/soc_dma.h"
> @@ -270,11 +271,11 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwaddr virt_base,
>           if (entry->type == soc_dma_port_mem) {
>               if (entry->addr <= virt_base &&
>                               entry->addr + entry->u.mem.size > virt_base) {
> -                fprintf(stderr, "%s: FIFO at %"PRIx64
> -                                " collides with RAM region at %"PRIx64
> -                                "-%"PRIx64 "\n", __func__,
> -                                virt_base, entry->addr,
> -                                (entry->addr + entry->u.mem.size));
> +                error_report("%s: FIFO at %"PRIx64
> +                             " collides with RAM region at %"PRIx64
> +                             "-%"PRIx64 "", __func__,

Can you remove the ""?

> +                             virt_base, entry->addr,
> +                             (entry->addr + entry->u.mem.size));
>                   exit(-1);
>               }
>   
> @@ -284,9 +285,9 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwaddr virt_base,
>               while (entry < dma->memmap + dma->memmap_size &&
>                               entry->addr <= virt_base) {
>                   if (entry->addr == virt_base && entry->u.fifo.out == out) {
> -                    fprintf(stderr, "%s: FIFO at %"PRIx64
> -                                    " collides FIFO at %"PRIx64 "\n",
> -                                    __func__, virt_base, entry->addr);
> +                    error_report("%s: FIFO at %"PRIx64
> +                                 " collides FIFO at %"PRIx64 "",

Same here

> +                                 __func__, virt_base, entry->addr);
>                       exit(-1);
>                   }
>   
> @@ -321,11 +322,11 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
>               if ((entry->addr >= virt_base && entry->addr < virt_base + size) ||
>                               (entry->addr <= virt_base &&
>                                entry->addr + entry->u.mem.size > virt_base)) {
> -                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
> -                                " collides with RAM region at %"PRIx64
> -                                "-%"PRIx64 "\n", __func__,
> -                                virt_base, virt_base + size,
> -                                entry->addr, entry->addr + entry->u.mem.size);
> +                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
> +                             " collides with RAM region at %"PRIx64
> +                             "-%"PRIx64 "", __func__,

Again

> +                             virt_base, virt_base + size,
> +                             entry->addr, entry->addr + entry->u.mem.size);
>                   exit(-1);
>               }
>   
> @@ -334,11 +335,11 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
>           } else {
>               if (entry->addr >= virt_base &&
>                               entry->addr < virt_base + size) {
> -                fprintf(stderr, "%s: RAM at %"PRIx64 "-%"PRIx64
> -                                " collides with FIFO at %"PRIx64
> -                                "\n", __func__,
> -                                virt_base, virt_base + size,
> -                                entry->addr);
> +                error_report("%s: RAM at %"PRIx64 "-%"PRIx64
> +                             " collides with FIFO at %"PRIx64
> +                             "", __func__,

Again

> +                             virt_base, virt_base + size,
> +                             entry->addr);
>                   exit(-1);
>               }
>   
> 
