Received: from eggs.gnu.org ([2001:4830:134:3::10]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4RIp-0003j8-Bz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4RIo-0007nd-IB
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:48:59 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:57123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4RIo-0007nB-Bp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:48:58 -0400
Received: by mail-wm0-x229.google.com with SMTP id l68so3703105wmd.5
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 05:48:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492623684-25799-3-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
	<1492623684-25799-3-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 13:48:36 +0100
Message-ID: <CAFEAcA8jQCtXtgYhR0W_rmyLSNmFHqgc-WEy-Anbcj_PF5-4WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/13] target/arm: Check PMCNTEN for
 whether PMCCNTR is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>

On 19 April 2017 at 18:41, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8cb7a94..8888391 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -964,7 +964,7 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
>  {
>      /* This does not support checking PMCCFILTR_EL0 register */
>
> -    if (!(env->cp15.c9_pmcr & PMCRE)) {
> +    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
>          return false;
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
