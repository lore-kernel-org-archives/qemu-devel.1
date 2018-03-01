Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOmd-0005pG-DI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOmX-00072z-I7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:02:07 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erOmX-00072M-CK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:02:01 -0500
Received: by mail-ot0-x241.google.com with SMTP id l5so5609208otf.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 06:02:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-14-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 14:01:39 +0000
Message-ID: <CAFEAcA8w=UJEzycn3Wc9b4GGZnP5YQm+Kb9__ikPg_+du4ERGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 13/16] target/arm: Decode aa32 armv8.3
 3-same
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
>  target/arm/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

> @@ -8424,6 +8486,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                      }
>                  }
>              }
> +        } else if ((insn & 0x0e000a00) == 0x0c000800
> +                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
> +            if (disas_neon_insn_3same_ext(s, insn)) {
> +                goto illegal_op;
> +            }
> +            return;
>          } else if ((insn & 0x0fe00000) == 0x0c400000) {
>              /* Coprocessor double register transfer.  */
>              ARCH(5TE);

Oh yes, shouldn't there be a similar fragment in disas_thumb2_insn()
to take care of the Thumb encodings of these insns ?

thanks
-- PMM
