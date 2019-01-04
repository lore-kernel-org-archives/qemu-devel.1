Received: from eggs.gnu.org ([208.118.235.92]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSgb-0005Mr-AT
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSgZ-0002CS-6S
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:51:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfSgX-000277-AJ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:51:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so32551154ota.12
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 08:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-6-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 16:50:48 +0000
Message-ID: <CAFEAcA9ykqab2yKOk+m-cR8Hzt94UwnNxMADKvuqjQCbMa6VMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 05/27] target/arm: Decode PAuth within
 system hint space
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 81 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 7c1cc1ce8e..0df344f9e8 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1471,33 +1471,102 @@ static void handle_hint(DisasContext *s, uint32_t insn,
>      }
>
>      switch (selector) {
> -    case 0: /* NOP */
> -        return;
> -    case 3: /* WFI */
> +    case 000: /* NOP */
> +        break;
> +    case 003: /* WFI */

I can see why you wanted to use octal here, but I think it's
confusing (simply because octal constants are so rare and
so easy to misread). Maybe we could compromise on 0bnnnn ?
It looks like disas/riscv.c has implicitly proven that all
the compilers we care about support that...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
