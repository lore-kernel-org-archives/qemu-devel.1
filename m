Received: from eggs.gnu.org ([2001:4830:134:3::10]:60210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eJp41-0005pJ-0R
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eJp3x-0007VK-QI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:13:16 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:48856
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eJp3x-0007Tv-Jg
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:13:13 -0500
References: <cover.1511908159.git.alistair.francis@xilinx.com>
	<30f5bb618b6b5dad168658fa78387ee641370bc8.1511908159.git.alistair.francis@xilinx.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <f75a7d45-aeb7-bc2c-c125-53dba27e94cd@adacore.com>
Date: Wed, 29 Nov 2017 00:13:10 +0100
MIME-Version: 1.0
In-Reply-To: <30f5bb618b6b5dad168658fa78387ee641370bc8.1511908159.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH-2.12 v1 1/3] xilinx_spips: Update the QSPI
 Mod ID reset value
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
> Update the reset value to match the latest ZynqMP register spec.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>   hw/ssi/xilinx_spips.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index ad1b2ba79f..899db814ee 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -355,6 +355,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>       s->regs[R_GQSPI_RX_THRESH] = 1;
>       s->regs[R_GQSPI_GFIFO_THRESH] = 1;
>       s->regs[R_GQSPI_IMR] = GQSPI_IXR_MASK;
> +    s->regs[R_MOD_ID] = 0x01090101;

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

>       s->man_start_com_g = false;
>       s->gqspi_irqline = 0;
>       xlnx_zynqmp_qspips_update_ixr(s);
> 
