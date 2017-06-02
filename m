Received: from eggs.gnu.org ([2001:4830:134:3::10]:35268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrRI-0003RN-Oq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrRH-0004qR-NW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:36:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170602162857.6065-1-krzk@kernel.org>
	<20170602163618.6369-1-krzk@kernel.org>
	<20170602163618.6369-3-krzk@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bda550c9-b9e1-83d0-9cdb-e198cb754a2f@amsat.org>
Date: Fri, 2 Jun 2017 15:36:44 -0300
MIME-Version: 1.0
In-Reply-To: <20170602163618.6369-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] hw/timer/exynos4210_mct: Cleanup
 indentation and empty new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/02/2017 01:36 PM, Krzysztof Kozlowski wrote:
> Statements under 'case' were in some places wrongly indented bringing
> confusion and making the code less readable.  Remove also few unneeded
> blank lines.  No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/timer/exynos4210_mct.c | 45 ++++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 2404fb737ac4..ea5f99d9a41b 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -1016,9 +1016,9 @@ static uint64_t exynos4210_mct_read(void *opaque, hwaddr offset,
>
>      case G_COMP_L(0): case G_COMP_L(1): case G_COMP_L(2): case G_COMP_L(3):
>      case G_COMP_U(0): case G_COMP_U(1): case G_COMP_U(2): case G_COMP_U(3):
> -    index = GET_G_COMP_IDX(offset);
> -    shift = 8 * (offset & 0x4);
> -    value = UINT32_MAX & (s->g_timer.reg.comp[index] >> shift);
> +        index = GET_G_COMP_IDX(offset);
> +        shift = 8 * (offset & 0x4);
> +        value = UINT32_MAX & (s->g_timer.reg.comp[index] >> shift);
>      break;
>
>      case G_TCON:
> @@ -1067,7 +1067,6 @@ static uint64_t exynos4210_mct_read(void *opaque, hwaddr offset,
>          lt_i = GET_L_TIMER_IDX(offset);
>
>          value = exynos4210_lfrc_get_count(&s->l_timer[lt_i]);
> -
>          break;
>
>      case L0_TCON: case L1_TCON:
> @@ -1153,23 +1152,23 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>
>      case G_COMP_L(0): case G_COMP_L(1): case G_COMP_L(2): case G_COMP_L(3):
>      case G_COMP_U(0): case G_COMP_U(1): case G_COMP_U(2): case G_COMP_U(3):
> -    index = GET_G_COMP_IDX(offset);
> -    shift = 8 * (offset & 0x4);
> -    s->g_timer.reg.comp[index] =
> -            (s->g_timer.reg.comp[index] &
> -            (((uint64_t)UINT32_MAX << 32) >> shift)) +
> -            (value << shift);
> +        index = GET_G_COMP_IDX(offset);
> +        shift = 8 * (offset & 0x4);
> +        s->g_timer.reg.comp[index] =
> +                (s->g_timer.reg.comp[index] &
> +                (((uint64_t)UINT32_MAX << 32) >> shift)) +
> +                (value << shift);
>
> -    DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
> +        DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
>
> -    if (offset & 0x4) {
> -        s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
> -    } else {
> -        s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
> -    }
> +        if (offset & 0x4) {
> +            s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
> +        } else {
> +            s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
> +        }
>
> -    exynos4210_gfrc_restart(s);
> -    break;
> +        exynos4210_gfrc_restart(s);
> +        break;
>
>      case G_TCON:
>          old_val = s->g_timer.reg.tcon;
> @@ -1207,7 +1206,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>          break;
>
>      case G_INT_ENB:
> -
>          /* Raise IRQ if transition from disabled to enabled and CSTAT pending */
>          for (i = 0; i < MCT_GT_CMP_NUM; i++) {
>              if ((value & G_INT_ENABLE(i)) > (s->g_timer.reg.tcon &
> @@ -1288,7 +1286,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>          break;
>
>      case L0_TCNTB: case L1_TCNTB:
> -
>          lt_i = GET_L_TIMER_IDX(offset);
>          index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>
> @@ -1316,7 +1313,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>          break;
>
>      case L0_ICNTB: case L1_ICNTB:
> -
>          lt_i = GET_L_TIMER_IDX(offset);
>          index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>
> @@ -1353,13 +1349,12 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>          if (icntb_max[lt_i] < value) {
>              icntb_max[lt_i] = value;
>          }
> -DPRINTF("local timer[%d] ICNTB write %llx; max=%x, min=%x\n\n",
> -        lt_i, value, icntb_max[lt_i], icntb_min[lt_i]);
> +        DPRINTF("local timer[%d] ICNTB write %llx; max=%x, min=%x\n\n",
> +                lt_i, value, icntb_max[lt_i], icntb_min[lt_i]);
>  #endif
> -break;
> +        break;
>
>      case L0_FRCNTB: case L1_FRCNTB:
> -
>          lt_i = GET_L_TIMER_IDX(offset);
>          index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>
>
