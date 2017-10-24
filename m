Received: from eggs.gnu.org ([2001:4830:134:3::10]:41454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71ZS-0003OT-J6
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e71ZP-0004GW-HE
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 11:56:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ce8c1a6e1ab21911798dba9915bab413dc9f3e38.1508390588.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e0a073e4-a976-360e-3c55-6e2a221af519@amsat.org>
Date: Tue, 24 Oct 2017 12:56:33 -0300
MIME-Version: 1.0
In-Reply-To: <ce8c1a6e1ab21911798dba9915bab413dc9f3e38.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/46] hw/ide: Replace fprintf(stderr,
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
Cc: alistair23@gmail.com, armbru@redhat.com, qemu-block@nongnu.org

Hi Alistair,

On 10/19/2017 01:16 PM, Alistair Francis wrote:
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
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: qemu-block@nongnu.org
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/ide/ahci.c | 6 +++---
>  hw/ide/core.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index c25e293d88..2ed015285a 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -410,8 +410,8 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
>  
>      /* Only aligned reads are allowed on AHCI */
>      if (addr & 3) {
> -        fprintf(stderr, "ahci: Mis-aligned write to addr 0x"
> -                TARGET_FMT_plx "\n", addr);
> +        error_report("ahci: Mis-aligned write to addr 0x"
> +                     TARGET_FMT_plx "", addr);

removing this trailing "":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          return;
>      }
>  
> @@ -1053,7 +1053,7 @@ static void process_ncq_command(AHCIState *s, int port, uint8_t *cmd_fis,
>      g_assert(is_ncq(ncq_fis->command));
>      if (ncq_tfs->used) {
>          /* error - already in use */
> -        fprintf(stderr, "%s: tag %d already used\n", __func__, tag);
> +        error_report("%s: tag %d already used", __func__, tag);
>          return;
>      }
>  
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 5f1cd3b91f..0ea34f62ba 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2762,7 +2762,7 @@ static int ide_drive_pio_pre_save(void *opaque)
>  
>      idx = transfer_end_table_idx(s->end_transfer_func);
>      if (idx == -1) {
> -        fprintf(stderr, "%s: invalid end_transfer_func for DRQ_STAT\n",
> +        error_report("%s: invalid end_transfer_func for DRQ_STAT",
>                          __func__);

eventually indent this line?

                        __func__);

>          s->end_transfer_fn_idx = 2;
>      } else {
