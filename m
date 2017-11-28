Received: from eggs.gnu.org ([2001:4830:134:3::10]:34214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eJp8p-00085H-Un
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eJp8m-0001f6-2Q
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:18:15 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:48984
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eJp8l-0001ei-Rl
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:18:11 -0500
References: <cover.1511908159.git.alistair.francis@xilinx.com>
	<ee595cb7408c5fce0f2ad6d33b721c7ae1fed283.1511908159.git.alistair.francis@xilinx.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <86f6cfaf-9686-d0ed-db2a-135c697e76ed@adacore.com>
Date: Wed, 29 Nov 2017 00:18:09 +0100
MIME-Version: 1.0
In-Reply-To: <ee595cb7408c5fce0f2ad6d33b721c7ae1fed283.1511908159.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH-2.12 v1 3/3] xilinx_spips: Use memset
 instead of a for loop to zero registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, alistair23@gmail.com



On 11/28/2017 11:31 PM, Alistair Francis wrote:
> Use memset() instead of a for loop to zero all of the registers.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>   hw/ssi/xilinx_spips.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 1a37f9c7f5..82436e2f69 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -330,10 +330,7 @@ static void xilinx_spips_reset(DeviceState *d)
>   {
>       XilinxSPIPS *s = XILINX_SPIPS(d);
>   
> -    int i;
> -    for (i = 0; i < XLNX_SPIPS_R_MAX; i++) {
> -        s->regs[i] = 0;
> -    }
> +    memset(s->regs, 0, sizeof(s->regs));
>   
>       fifo8_reset(&s->rx_fifo);
>       fifo8_reset(&s->rx_fifo);
> @@ -358,13 +355,11 @@ static void xilinx_spips_reset(DeviceState *d)
>   static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>   {
>       XlnxZynqMPQSPIPS *s = XLNX_ZYNQMP_QSPIPS(d);
> -    int i;
>   
>       xilinx_spips_reset(d);
>   
> -    for (i = 0; i < XLNX_ZYNQMP_SPIPS_R_MAX; i++) {
> -        s->regs[i] = 0;
> -    }
> +    memset(s->regs, 0, sizeof(s->regs));
> +
>       fifo8_reset(&s->rx_fifo_g);
>       fifo8_reset(&s->rx_fifo_g);
>       fifo32_reset(&s->fifo_g);
> 

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
