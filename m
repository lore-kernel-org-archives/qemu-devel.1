Received: from eggs.gnu.org ([209.51.188.92]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh0tM-00051P-MP
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh0tK-0001TK-O9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:34:40 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gh0tI-0001Nl-TC
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:34:38 -0500
Received: by mail-oi1-x244.google.com with SMTP id c206so4873476oib.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 15:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-15-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 23:34:16 +0000
Message-ID: <CAFEAcA9HxjHZgT9zAnHLZH+zSdM4q3LcTit=r5_=iRcQZ3f+4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 14/31] target/arm: Decode Load/store
 register (pac)
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

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Not that there are any stores involved, but why argue with ARM's
> naming convention.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Use do_gpr_ld; fix sextend typo; iss_valid only for !wback.

What was the sextend typo ?

> ---
>  target/arm/translate-a64.c | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index fa50003f0b..a4dfdf5836 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3146,6 +3146,63 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>         s->be_data | size | MO_ALIGN);
>  }
>
> +/* PAC memory operations
> + *
> + *  31  30      27  26    24    22  21       12  11  10    5     0
> + * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
> + * | size | 1 1 1 | V | 0 0 | M S | 1 |  imm9  | W | 1 | Rn |  Rt |
> + * +------+-------+---+-----+-----+------------+---+---+----+-----+

Utter nit: missing '+' between the '1' and 'imm9' boxes on
the bottom line. Not worth respinning unless you need to
for some other reason...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
