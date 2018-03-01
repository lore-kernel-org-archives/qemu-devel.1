Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOqX-00005g-1w
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOqR-0001xn-2A
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:06:08 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erOqQ-0001xV-So
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:06:02 -0500
Received: by mail-ot0-x244.google.com with SMTP id 95so5630393ote.5
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 06:06:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-15-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 14:05:41 +0000
Message-ID: <CAFEAcA9mVyHS2_2AoLztLFSFtZnQOMQBfsQkAs=zO6adeZBoZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 14/16] target/arm: Decode
 aa32 armv8.3 2-reg-index
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

On 28 February 2018 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>

> @@ -8492,6 +8547,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                  goto illegal_op;
>              }
>              return;
> +        } else if ((insn & 0x0f000a00) == 0x0e000800
> +                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
> +            if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
> +                goto illegal_op;
> +            }
> +            return;
>          } else if ((insn & 0x0fe00000) == 0x0c400000) {
>              /* Coprocessor double register transfer.  */
>              ARCH(5TE);

Missing the similar code for disas_thumb2_insn() again.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
