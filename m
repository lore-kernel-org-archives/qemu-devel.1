Received: from eggs.gnu.org ([2001:4830:134:3::10]:48124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4RK7-0004Yn-Ul
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4RK6-0000CG-PJ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:50:19 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4RK6-0000BT-D7
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 08:50:18 -0400
Received: by mail-wm0-x230.google.com with SMTP id q124so3675273wmb.0
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 05:50:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506737310-21880-3-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-3-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 13:49:56 +0100
Message-ID: <CAFEAcA_zwAu4Zt0-2Qy9euBzYQgD19EnnoWwa+ZNzidWwkmEcA@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8be78ea..40c9273 100644
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
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I keep replying to your v1 patchset by mistake -- can you use
the git format-patch options to put make the subject prefix
be "[PATCH v3]" for the next round in all the patchmails to
help keep the versions distinct, please?

thanks
-- PMM
