Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eKpwO-0000x3-Vy
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eKpwM-0005mp-Uw
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:21:36 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eKpwM-0005m3-Js
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:21:34 -0500
Received: by mail-wr0-x243.google.com with SMTP id z18so11063407wrb.8
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 10:21:34 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAAYMZQtOBdq=z98Neu7Lh=GU3Gqoqukc-YLCEtv-wv8hPwgOVQ@mail.gmail.com>
References: <cover.1511908159.git.alistair.francis@xilinx.com>
	<058b3888cf0d40a3f29a156e1ed9cc27fd579548.1511908159.git.alistair.francis@xilinx.com>
	<CAAYMZQtOBdq=z98Neu7Lh=GU3Gqoqukc-YLCEtv-wv8hPwgOVQ@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Dec 2017 10:21:02 -0800
Message-ID: <CAKmqyKNkv=OhQfyzPZ68qxDn5j3Yj7nx5TPNFFFXr4wAAXh6dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH-2.12 v1 2/3] xilinx_spis: Set all of the
 reset values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: francisco iglesias <frasse.iglesias@gmail.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edde <edgar.iglesias@gmail.com>

On Wed, Nov 29, 2017 at 2:03 PM, francisco iglesias
<frasse.iglesias@gmail.com> wrote:
>
>
> On 28 November 2017 at 23:31, Alistair Francis <alistair.francis@xilinx.com>
> wrote:
>
> Dear Alistair,
>
> There is a typo in the commit message:
> s/xilinx_spis/xilinx_spips/
>
>> Following the ZynqMP register spec let's ensure that all reset values
>> are set.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/ssi/xilinx_spips.c         | 38 +++++++++++++++++++++++++++++++++-----
>>  include/hw/ssi/xilinx_spips.h |  2 +-
>>  2 files changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
>> index 899db814ee..1a37f9c7f5 100644
>> --- a/hw/ssi/xilinx_spips.c
>> +++ b/hw/ssi/xilinx_spips.c
>> @@ -66,6 +66,7 @@
>>
>>  /* interrupt mechanism */
>>  #define R_INTR_STATUS       (0x04 / 4)
>> +#define R_INTR_STATUS_RESET (0x104)
>>  #define R_INTR_EN           (0x08 / 4)
>>  #define R_INTR_DIS          (0x0C / 4)
>>  #define R_INTR_MASK         (0x10 / 4)
>> @@ -102,6 +103,9 @@
>>  #define R_SLAVE_IDLE_COUNT  (0x24 / 4)
>>  #define R_TX_THRES          (0x28 / 4)
>>  #define R_RX_THRES          (0x2C / 4)
>> +#define R_GPIO              (0x30 / 4)
>> +#define R_LPBK_DLY_ADJ      (0x38 / 4)
>> +#define R_LPBK_DLY_ADJ_RESET (0x33)
>>  #define R_TXD1              (0x80 / 4)
>>  #define R_TXD2              (0x84 / 4)
>>  #define R_TXD3              (0x88 / 4)
>> @@ -137,11 +141,16 @@
>>  #define R_GQSPI_SELECT          (0x144 / 4)
>>      FIELD(GQSPI_SELECT, GENERIC_QSPI_EN, 0, 1)
>>  #define R_GQSPI_ISR         (0x104 / 4)
>> +#define R_GQSPI_ISR_RESET   (0xb84)
>>  #define R_GQSPI_IER         (0x108 / 4)
>>  #define R_GQSPI_IDR         (0x10c / 4)
>>  #define R_GQSPI_IMR         (0x110 / 4)
>> +#define R_GQSPI_IMR_RESET   (0xfbe)
>>  #define R_GQSPI_TX_THRESH   (0x128 / 4)
>>  #define R_GQSPI_RX_THRESH   (0x12c / 4)
>> +#define R_GQSPI_GPIO_THRESH (0x130 / 4)
>> +#define R_GQSPI_LPBK_DLY_ADJ (0x138 / 4)
>> +#define R_GQSPI_LPBK_DLY_ADJ_RESET (0x33)
>>  #define R_GQSPI_CNFG        (0x100 / 4)
>>      FIELD(GQSPI_CNFG, MODE_EN, 30, 2)
>>      FIELD(GQSPI_CNFG, GEN_FIFO_START_MODE, 29, 1)
>> @@ -177,8 +186,16 @@
>>      FIELD(GQSPI_GF_SNAPSHOT, EXPONENT, 9, 1)
>>      FIELD(GQSPI_GF_SNAPSHOT, DATA_XFER, 8, 1)
>>      FIELD(GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA, 0, 8)
>> -#define R_GQSPI_MOD_ID        (0x168 / 4)
>> -#define R_GQSPI_MOD_ID_VALUE  0x010A0000
>> +#define R_GQSPI_MOD_ID        (0x1fc / 4)
>> +#define R_GQSPI_MOD_ID_RESET  (0x10a0000)
>>
>> +
>> +#define R_QSPIDMA_DST_CTRL         (0x80c / 4)
>> +#define R_QSPIDMA_DST_CTRL_RESET   (0x803ffa00)
>> +#define R_QSPIDMA_DST_I_MASK       (0x820 / 4)
>> +#define R_QSPIDMA_DST_I_MASK_RESET (0xfe)
>> +#define R_QSPIDMA_DST_CTRL2        (0x824 / 4)
>> +#define R_QSPIDMA_DST_CTRL2_RESET  (0x081bfff8)
>> +
>>  /* size of TXRX FIFOs */
>>  #define RXFF_A          (128)
>>  #define TXFF_A          (128)
>> @@ -351,11 +368,22 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>>      fifo8_reset(&s->rx_fifo_g);
>>      fifo8_reset(&s->rx_fifo_g);
>>      fifo32_reset(&s->fifo_g);
>> -    s->regs[R_GQSPI_TX_THRESH] = 1;
>> -    s->regs[R_GQSPI_RX_THRESH] = 1;
>> -    s->regs[R_GQSPI_GFIFO_THRESH] = 1;
>> +    s->regs[R_INTR_STATUS] = R_INTR_STATUS_RESET;
>> +    s->regs[R_GPIO] = 1;
>>
>> +    s->regs[R_LPBK_DLY_ADJ] = R_LPBK_DLY_ADJ_RESET;
>> +    s->regs[R_GQSPI_GFIFO_THRESH] = 0x10;
>>      s->regs[R_GQSPI_IMR] = GQSPI_IXR_MASK;
>
>
> Also, above row will be overriden below so maybe we should remove it?

Yes, we should. I'll remove it.

>
>>
>>      s->regs[R_MOD_ID] = 0x01090101;
>> +    s->regs[R_GQSPI_ISR] = R_GQSPI_ISR_RESET;
>
>
> To be noted, above row will also be overriden by
> xlnx_zynqmp_qspips_update_ixr below but maybe it is good to have for
> consistency (you can decide).

Ah, good point. I'll remove this one as well.

Alistair

>
> Best regards,
> Francisco Iglesias
>
>
>>
>> +    s->regs[R_GQSPI_IMR] = R_GQSPI_IMR_RESET;
>> +    s->regs[R_GQSPI_TX_THRESH] = 1;
>> +    s->regs[R_GQSPI_RX_THRESH] = 1;
>> +    s->regs[R_GQSPI_GPIO_THRESH] = 1;
>>
>> +    s->regs[R_GQSPI_LPBK_DLY_ADJ] = R_GQSPI_LPBK_DLY_ADJ_RESET;
>> +    s->regs[R_GQSPI_MOD_ID] = R_GQSPI_MOD_ID_RESET;
>> +    s->regs[R_QSPIDMA_DST_CTRL] = R_QSPIDMA_DST_CTRL_RESET;
>> +    s->regs[R_QSPIDMA_DST_I_MASK] = R_QSPIDMA_DST_I_MASK_RESET;
>> +    s->regs[R_QSPIDMA_DST_CTRL2] = R_QSPIDMA_DST_CTRL2_RESET;
>>      s->man_start_com_g = false;
>>      s->gqspi_irqline = 0;
>>      xlnx_zynqmp_qspips_update_ixr(s);
>> diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
>> index 75fc94ce5d..d398a4e81c 100644
>> --- a/include/hw/ssi/xilinx_spips.h
>> +++ b/include/hw/ssi/xilinx_spips.h
>> @@ -32,7 +32,7 @@
>>  typedef struct XilinxSPIPS XilinxSPIPS;
>>
>>  #define XLNX_SPIPS_R_MAX        (0x100 / 4)
>> -#define XLNX_ZYNQMP_SPIPS_R_MAX (0x200 / 4)
>> +#define XLNX_ZYNQMP_SPIPS_R_MAX (0x830 / 4)
>>
>>  /* Bite off 4k chunks at a time */
>>  #define LQSPI_CACHE_SIZE 1024
>> --
>> 2.14.1
>>
>>
>
