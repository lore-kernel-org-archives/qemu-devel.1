Received: from eggs.gnu.org ([2001:4830:134:3::10]:51864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyBJK-0002hd-2O
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyBJG-0006hN-UZ
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dyBJG-0006gx-MK
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:31:34 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<db884cd8f27fa0144630bdb07f6d00dbf57f38ac.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce526af7-2920-a832-0396-c0c5a72b1033@redhat.com>
Date: Sat, 30 Sep 2017 08:31:29 +0200
MIME-Version: 1.0
In-Reply-To: <db884cd8f27fa0144630bdb07f6d00dbf57f38ac.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/47] Fixes after renaming __FUNCTION__
 to __func__
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

On 30.09.2017 02:15, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Eric Blake <eblake@redhat.com>
> ---
> 
>  hw/arm/omap1.c     | 4 ++--
>  hw/arm/omap2.c     | 2 +-
>  hw/block/onenand.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 1388200191..64f2ee8356 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -1717,7 +1717,7 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
>          if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
>              s->clkm.clocking_scheme = (value >> 11) & 7;
>              printf("%s: clocking scheme set to %s\n", __func__,
> -                            clkschemename[s->clkm.clocking_scheme]);
> +                   clkschemename[s->clkm.clocking_scheme]);
>          }
>          s->clkm.cold_start &= value & 0x3f;
>          return;
> @@ -3336,7 +3336,7 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
>          s->mcr[0] = value & 0x03e1;
>          if (value & 1)					/* RMCM */
>              printf("%s: Rx channel selection mode enable attempt\n",
> -                            __func__);
> +                   __func__);

That would now also fit into one line.

>          return;
>      case 0x1c:	/* RCERA */
>          s->rcer[0] = value & 0xffff;
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index b53878b8b9..758a26f3d8 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -1312,7 +1312,7 @@ static void omap_prcm_apll_update(struct omap_prcm_s *s)
>  
>      if (mode[0] == 1 || mode[0] == 2 || mode[1] == 1 || mode[1] == 2)
>          fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
> -                        __func__);
> +                __func__);

You're changing the indentation here again in patch 5 when you replace
it with error_report ... so this hunk really seems like unnecessary code
churn - I'd suggest to drop it.

>  }
>  
>  static void omap_prcm_dpll_update(struct omap_prcm_s *s)
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index 7542ef9634..08c63adc9a 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -663,7 +663,7 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
>      case 0xff02:	/* ECC Result of spare area data */
>      case 0xff03:	/* ECC Result of main area data */
>      case 0xff04:	/* ECC Result of spare area data */
> -        hw_error("%s: imeplement ECC\n", __func__);
> +        hw_error("%s: implement ECC\n", __func__);
>          return 0x0000;
>      }
>  
> 

 Thomas
