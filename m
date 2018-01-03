Received: from eggs.gnu.org ([2001:4830:134:3::10]:38263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWZO-0007As-TI
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWZN-0002C2-Os
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:06:10 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eWWZN-0002BW-Ho
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:06:09 -0500
Received: by mail-wr0-x243.google.com with SMTP id f8so69765wre.4
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:06:09 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171229174933.1781-3-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 2 Jan 2018 16:05:37 -0800
Message-ID: <CAKmqyKN60kE5eekuHOkBvEejKEb-BCBLxRz3xEUooDGH5+iVEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/42] sdhci: sort registers comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Dec 29, 2017 at 9:48 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sdhci.h | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 1335373d3c..749cc279ed 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -49,14 +49,20 @@ typedef struct SDHCIState {
>      qemu_irq irq;
>
>      /* Registers cleared on reset */
> +    /* 0x00 */
>      uint32_t sdmasysad;    /* SDMA System Address register */
>      uint16_t blksize;      /* Host DMA Buff Boundary and Transfer BlkSiz=
e Reg */
>      uint16_t blkcnt;       /* Blocks count for current transfer */
> +    /* 0x08 */
>      uint32_t argument;     /* Command Argument Register */
>      uint16_t trnmod;       /* Transfer Mode Setting Register */
>      uint16_t cmdreg;       /* Command Register */
> +    /* 0x10 */
>      uint32_t rspreg[4];    /* Response Registers 0-3 */
> +    /* 0x20 */
> +    /* Buffer Data Port Register - virtual access point to R and W buffe=
rs */
>      uint32_t prnsts;       /* Present State Register */
> +    /* 0x28 */
>      uint8_t  hostctl;      /* Host Control Register */
>      uint8_t  pwrcon;       /* Power control Register */
>      uint8_t  blkgap;       /* Block Gap Control Register */
> @@ -64,6 +70,7 @@ typedef struct SDHCIState {
>      uint16_t clkcon;       /* Clock control Register */
>      uint8_t  timeoutcon;   /* Timeout Control Register */
>      uint8_t  admaerr;      /* ADMA Error Status Register */
> +    /* 0x30 */
>      uint16_t norintsts;    /* Normal Interrupt Status Register */
>      uint16_t errintsts;    /* Error Interrupt Status Register */
>      uint16_t norintstsen;  /* Normal Interrupt Status Enable Register */
> @@ -71,23 +78,25 @@ typedef struct SDHCIState {
>      uint16_t norintsigen;  /* Normal Interrupt Signal Enable Register */
>      uint16_t errintsigen;  /* Error Interrupt Signal Enable Register */
>      uint16_t acmd12errsts; /* Auto CMD12 error status register */
> +    /* 0x50 */
> +    /* Force Event Auto CMD12 Error Interrupt Reg - write only */
> +    /* Force Event Error Interrupt Register- write only */
> +    /* 0x58 */
>      uint64_t admasysaddr;  /* ADMA System Address Register */
>
>      /* Read-only registers */
> +    /* 0x40 */
>      uint32_t capareg;      /* Capabilities Register */
> +    /* 0x48 */
>      uint32_t maxcurr;      /* Maximum Current Capabilities Register */
>
>      uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
>      uint32_t buf_maxsz;
>      uint16_t data_count;   /* current element in FIFO buffer */
>      uint8_t  stopped_state;/* Current SDHC state */
> -    bool     pending_insert_quirk;/* Quirk for Raspberry Pi card insert =
int */
>      bool     pending_insert_state;
> -    /* Buffer Data Port Register - virtual access point to R and W buffe=
rs */
> -    /* Software Reset Register - always reads as 0 */
> -    /* Force Event Auto CMD12 Error Interrupt Reg - write only */
> -    /* Force Event Error Interrupt Register- write only */
> -    /* RO Host Controller Version Register always reads as 0x2401 */
> +    /* Configurable properties */
> +    bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int=
 */
>  } SDHCIState;
>
>  #define TYPE_PCI_SDHCI "sdhci-pci"
> --
> 2.15.1
>
>
