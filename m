Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71fS-0006WY-6B
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71fP-00073C-24
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:03:02 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71fO-00072w-TC
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:02:59 -0400
Received: by mail-qk0-x241.google.com with SMTP id f199so26897924qke.2
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 09:02:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<e875fc6ca98b01cb94f175b60048fa863ec423ce.1508390588.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f056aaa-60f2-0dba-814f-515cea179ec5@amsat.org>
Date: Tue, 24 Oct 2017 13:02:55 -0300
MIME-Version: 1.0
In-Reply-To: <e875fc6ca98b01cb94f175b60048fa863ec423ce.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 34/46] hw/sd: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 10/19/2017 01:17 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Some of the prints in hw/sd/sd.c were manually converted to using
> DPRINTF() instead.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Fixup some DPRINTF() prints being wrong
> V2:
>  - Split hw patch into individual directories
> 
>  hw/sd/pl181.c |  5 +++--
>  hw/sd/sd.c    | 15 ++++++++-------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 55c8098ecd..2b878a0c5e 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/sysbus.h"
> @@ -146,7 +147,7 @@ static void pl181_fifo_push(PL181State *s, uint32_t value)
>      int n;
>  
>      if (s->fifo_len == PL181_FIFO_LEN) {
> -        fprintf(stderr, "pl181: FIFO overflow\n");
> +        error_report("pl181: FIFO overflow");
>          return;
>      }
>      n = (s->fifo_pos + s->fifo_len) & (PL181_FIFO_LEN - 1);
> @@ -160,7 +161,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
>      uint32_t value;
>  
>      if (s->fifo_len == 0) {
> -        fprintf(stderr, "pl181: FIFO underflow\n");
> +        error_report("pl181: FIFO underflow");
>          return 0;
>      }
>      value = s->fifo[s->fifo_pos];
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 35347a5bbc..5d7fa3e418 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -700,7 +700,7 @@ static void sd_lock_command(SDState *sd)
>          sd->card_status &= ~CARD_IS_LOCKED;
>          sd->pwd_len = 0;
>          /* Erasing the entire card here! */
> -        fprintf(stderr, "SD: Card force-erased by CMD42\n");
> +        error_report("SD: Card force-erased by CMD42");
>          return;
>      }
>  
> @@ -1282,7 +1282,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
>          return sd_r1;
>  
>      case 56:	/* CMD56:  GEN_CMD */
> -        fprintf(stderr, "SD: GEN_CMD 0x%08x\n", req.arg);
> +        error_report("SD: GEN_CMD 0x%08x", req.arg);
>  
>          switch (sd->state) {
>          case sd_transfer_state:
> @@ -1564,9 +1564,10 @@ send_response:
>      if (rsplen) {
>          int i;
>          DPRINTF("Response:");
> -        for (i = 0; i < rsplen; i++)
> -            fprintf(stderr, " %02x", response[i]);
> -        fprintf(stderr, " state %d\n", sd->state);
> +        for (i = 0; i < rsplen; i++) {
> +            DPRINTF(" %02x", response[i]);
> +        }
> +        DPRINTF(" state %d\n", sd->state);

We'll get ride of those later.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      } else {
>          DPRINTF("No response %d\n", sd->state);
>      }
> @@ -1580,14 +1581,14 @@ static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
>      DPRINTF("sd_blk_read: addr = 0x%08llx, len = %d\n",
>              (unsigned long long) addr, len);
>      if (!sd->blk || blk_pread(sd->blk, addr, sd->data, len) < 0) {
> -        fprintf(stderr, "sd_blk_read: read error on host side\n");
> +        error_report("sd_blk_read: read error on host side");
>      }
>  }
>  
>  static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
>  {
>      if (!sd->blk || blk_pwrite(sd->blk, addr, sd->data, len, 0) < 0) {
> -        fprintf(stderr, "sd_blk_write: write error on host side\n");
> +        error_report("sd_blk_write: write error on host side");
>      }
>  }
>  
> 
