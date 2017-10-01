Received: from eggs.gnu.org ([2001:4830:134:3::10]:52218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyewO-0000A4-A6
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyewL-0000yh-J6
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dyewL-0000xh-B0
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 10:09:53 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<f402d9e631e0f8fe04cdad03027c20cd27dc928e.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8dd7dd40-54ea-66d7-75a8-acbe1a2b1376@redhat.com>
Date: Sun, 1 Oct 2017 16:09:46 +0200
MIME-Version: 1.0
In-Reply-To: <f402d9e631e0f8fe04cdad03027c20cd27dc928e.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/47] hw/char: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 30.09.2017 02:15, Alistair Francis wrote:
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
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/char/exynos4210_uart.c | 6 +++---
>  hw/char/mcf_uart.c        | 5 +++--
>  hw/char/sh_serial.c       | 9 +++++----
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 3957e78abf..a388f01a23 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -296,7 +296,7 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
>          qemu_irq_raise(s->irq);
>  
>  #if DEBUG_IRQ
> -        fprintf(stderr, "UART%d: IRQ has been raised: %08x\n",
> +        error_report("UART%d: IRQ has been raised: %08x",
>                  s->channel, s->reg[I_(UINTP)]);
>  #endif
>  
> @@ -388,7 +388,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
>               * qemu_chr_fe_write and background I/O callbacks */
>              qemu_chr_fe_write_all(&s->chr, &ch, 1);
>  #if DEBUG_Tx_DATA
> -            fprintf(stderr, "%c", ch);
> +            error_report("%c", ch);
>  #endif
>              s->reg[I_(UTRSTAT)] |= UTRSTAT_TRANSMITTER_EMPTY |
>                      UTRSTAT_Tx_BUFFER_EMPTY;
> @@ -400,7 +400,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
>      case UINTP:
>          s->reg[I_(UINTP)] &= ~val;
>          s->reg[I_(UINTSP)] &= ~val;
> -        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x\n",
> +        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x",
>                      s->channel, offset, s->reg[I_(UINTP)]);
>          exynos4210_uart_update_irq(s);
>          break;

You didn't replace the PRINT_DEBUG macro, did you? So the last change
looks wrong. IMHO it's also sounds wrong to use error_report for all the
DEBUG sections in here, so I'd rather drop the changes to this file
completely.

 Thomas
