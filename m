Received: from eggs.gnu.org ([2001:4830:134:3::10]:50882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyPqH-0000Yf-PU
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyPqH-0002Ov-3S
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:07:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180831103816.13479-1-clg@kaod.org>
	<20180831103816.13479-7-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9bc4c3d-c7cc-389c-12e7-3255383543c1@amsat.org>
Date: Fri, 7 Sep 2018 20:06:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180831103816.13479-7-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/11] aspeed/smc: fix default read value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>

Hi Cédric,

On 8/31/18 7:38 AM, Cédric Le Goater wrote:
> 0xFFFFFFFF should be returned for non implemented registers.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ssi/aspeed_smc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 1270842dcf0c..6045ca11b969 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -665,12 +665,12 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
>          addr == s->r_ce_ctrl ||
>          addr == R_INTR_CTRL ||
>          (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
> -        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs)) {
> +        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {

This change seems unrelated to this commit.

>          return s->regs[addr];
>      } else {
>          qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
>                        __func__, addr);
> -        return 0;
> +        return -1;
>      }
>  }
>  
> 
