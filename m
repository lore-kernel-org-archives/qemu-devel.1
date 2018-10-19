Received: from eggs.gnu.org ([2001:4830:134:3::10]:55257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDUTo-0005s7-1w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDUTh-0004wr-Ov
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:06:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDUTh-0004wL-Im
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:06:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id w67so33076089ota.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:06:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-6-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 14:05:48 +0100
Message-ID: <CAFEAcA-qBDchFPHH1sX1GrsPY2wXafyqHHOrm-8YyzCThWhVqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/20] target/arm: Mark some arrays const
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 October 2018 at 21:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 736880ee71..d59ffa1c67 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -72,7 +72,7 @@ static TCGv_i64 cpu_F0d, cpu_F1d;
>
>  #include "exec/gen-icount.h"
>
> -static const char *regnames[] =
> +static const char * const regnames[] =
>      { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
>        "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
>
> @@ -4907,7 +4907,7 @@ static struct {
>      int nregs;
>      int interleave;
>      int spacing;
> -} neon_ls_element_type[11] = {
> +} const neon_ls_element_type[11] = {
>      {4, 4, 1},
>      {4, 4, 2},
>      {4, 1, 1},
> @@ -13089,7 +13089,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>      translator_loop(ops, &dc.base, cpu, tb);
>  }
>
> -static const char *cpu_mode_names[16] = {
> +static const char * const cpu_mode_names[16] = {
>    "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
>    "???", "???", "hyp", "und", "???", "???", "???", "sys"
>  };

I dropped the last hunk here as one of my other patches
has moved this array (and fixed the constness in passing).

thanks
-- PMM
