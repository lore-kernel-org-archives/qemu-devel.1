Received: from eggs.gnu.org ([2001:4830:134:3::10]:38377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fjJ-0005Uq-E2
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fjG-0007qG-D2
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:41:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-8-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8211c8bc-4181-bbac-3688-d5ad2eb2dcf1@amsat.org>
Date: Sat, 13 May 2017 19:41:34 -0300
MIME-Version: 1.0
In-Reply-To: <1493122030-32191-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 07/13] arm: Remove unnecessary
 check on cpu->pmsav7_dregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, patches@linaro.org

On 04/25/2017 09:07 AM, Peter Maydell wrote:
> Now that we enforce both:
>  * pmsav7_dregion == 0 implies has_mpu == false
>  * PMSA with has_mpu == false means SCTLR.M cannot be set
> we can remove a check on pmsav7_dregion from get_phys_addr_pmsav7(),
> because we can only reach this code path if the MPU is enabled
> (and so region_translation_disabled() returned false).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f0f25c8..5c044d0 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8227,8 +8227,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>          }
>
>          if (n == -1) { /* no hits */
> -            if (cpu->pmsav7_dregion &&
> -                (is_user || !(regime_sctlr(env, mmu_idx) & SCTLR_BR))) {
> +            if (is_user || !(regime_sctlr(env, mmu_idx) & SCTLR_BR)) {
>                  /* background fault */
>                  *fsr = 0;
>                  return true;
>
