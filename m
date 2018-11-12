Received: from eggs.gnu.org ([2001:4830:134:3::10]:42053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMANz-0001JA-Kr
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMANy-0006M9-Qk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:28:07 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMANy-0006LX-8l
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:28:06 -0500
Received: by mail-oi1-x244.google.com with SMTP id v198-v6so6877327oif.2
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:28:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181110121711.15257-1-richard.henderson@linaro.org>
References: <20181110121711.15257-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 11:27:44 +0000
Message-ID: <CAFEAcA-aXFgJiALAy0XqWOcJ6V1x0BBCJjMK_wjACsvMCnNwMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] target/arm: Fix typo in
 tlbi_aa64_vmalle1_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 10 November 2018 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This would cause an infinite recursion or loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 96301930cc..a327988c66 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3155,7 +3155,7 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = ENV_GET_CPU(env);
>
>      if (tlb_force_broadcast(env)) {
> -        tlbi_aa64_vmalle1_write(env, NULL, value);
> +        tlbi_aa64_vmalle1is_write(env, NULL, value);
>          return;
>      }
>



Applied to target-arm.next, thanks.

-- PMM
