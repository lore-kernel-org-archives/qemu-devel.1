Received: from eggs.gnu.org ([2001:4830:134:3::10]:47177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMIQv-00086w-AW
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMIQo-0003mW-K5
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:59:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
	<1512153879-5291-4-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b802a13-3422-8e53-3b98-8f916af8505f@amsat.org>
Date: Tue, 5 Dec 2017 15:58:58 -0300
MIME-Version: 1.0
In-Reply-To: <1512153879-5291-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/7] target/arm: Add missing M
 profile case to regime_is_user()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 12/01/2017 03:44 PM, Peter Maydell wrote:
> When we added the ARMMMUIdx_MSUser MMU index we forgot to
> add it to the case statement in regime_is_user(), so we
> weren't treating it as unprivileged when doing MPU lookups.
> Correct the omission.

Eh commit e7b921c2d9e wasn't reviewed!

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f21c142..c4c8d5a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8016,6 +8016,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
>      case ARMMMUIdx_S1SE0:
>      case ARMMMUIdx_S1NSE0:
>      case ARMMMUIdx_MUser:
> +    case ARMMMUIdx_MSUser:
>          return true;
>      default:
>          return false;
> 
