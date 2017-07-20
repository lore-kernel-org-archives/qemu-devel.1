Received: from eggs.gnu.org ([2001:4830:134:3::10]:53301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYBFc-0008G0-Ap
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYBFZ-0004lT-9O
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:12:19 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:58036)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYBFZ-0004k4-31
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:12:17 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<7caba6ac0e2f7dd2183f4febc529ceee55c699be.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <82394a73-fa6f-95eb-7807-93d5cf080389@imgtec.com>
Date: Thu, 20 Jul 2017 14:12:13 +0100
MIME-Version: 1.0
In-Reply-To: <7caba6ac0e2f7dd2183f4febc529ceee55c699be.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/14] target/mips: Enable CP0_EBase.WG on
 MIPS64 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 18/07/2017 12:55, James Hogan wrote:
> Enable the CP0_EBase.WG (write gate) on the I6400 and MIPS64R2-generic
> CPUs. This allows 64-bit guests to run KVM itself, which uses
> CP0_EBase.WG to point CP0_EBase at XKPhys.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - New patch.
> ---
>  target/mips/translate_init.c | 2 ++
>  1 file changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
> index 741b39023744..255d25bacd03 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -640,6 +640,7 @@ static const mips_def_t mips_defs[] =
>          .SYNCI_Step = 32,
>          .CCRes = 2,
>          .CP0_Status_rw_bitmask = 0x36FBFFFF,
> +        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
>          .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
>                      (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
>                      (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
> @@ -723,6 +724,7 @@ static const mips_def_t mips_defs[] =
>          .CP0_PageGrain = (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
>                           (1U << CP0PG_RIE),
>          .CP0_PageGrain_rw_bitmask = (1 << CP0PG_ELPA),
> +        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
>          .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR0_F64) |
>                      (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
>                      (1 << FCR0_S) | (0x03 << FCR0_PRID) | (0x0 << FCR0_REV),
> 

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
