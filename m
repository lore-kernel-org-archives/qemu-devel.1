Received: from eggs.gnu.org ([209.51.188.92]:57236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm2EL-00072M-LP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm2EK-000831-Uu
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:01:05 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm2EK-000824-Ju
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:01:04 -0500
Received: by mail-oi1-x244.google.com with SMTP id c206so18542974oib.0
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-8-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:28:33 +0000
Message-ID: <CAFEAcA_nKMEgcJPfLTwm4NbCbNPxcRC1C=Z1FC-xY0vB8T3Csg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/11] target/arm: Set btype for indirect
 branches
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

On Thu, 10 Jan 2019 at 12:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>  {
> @@ -1985,6 +1998,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
>  static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
>  {
>      unsigned int opc, op2, op3, rn, op4;
> +    unsigned btype_mod = 2;

maybe add a comment /* 0: BR; 1: BLR; 2: other */
as otherwise you don't get to find out what the meaning of this
is until you get down to the end of the function.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
