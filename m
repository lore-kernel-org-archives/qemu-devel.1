Received: from eggs.gnu.org ([2001:4830:134:3::10]:54157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ef6IJ-0003x5-5W
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ef6IF-00007v-1P
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:51:59 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ef6IE-00006H-3O
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:51:54 -0500
Received: by mail-wm0-x244.google.com with SMTP id 143so2150995wma.5
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 07:51:53 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180117161435.28981-5-richard.henderson@linaro.org>
Date: Fri, 26 Jan 2018 12:17:42 +0000
Message-ID: <87607o7r15.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10.5 04/20] tcg: Add generic vector
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I'm slightly confused by the fact some previously added functions in
this series are seeing changes. Is this just of an artefact of building
up the TCG API in stages or should the changes be rolled into the
original patches?

Also there are still some ??? comments which should probably be
solidified before merging. Other than that:


<snip>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index df2eabaa67..09fec5693f 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -914,6 +914,7 @@ void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
>  void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
>  void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
>  void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
> +void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);

Odd that we add this one at a different time to the others.

>  void tcg_gen_movi_v64(TCGv_vec, uint64_t);
>  void tcg_gen_movi_v128(TCGv_vec, uint64_t, uint64_t);
>  void tcg_gen_movi_v256(TCGv_vec, uint64_t, uint64_t, uint64_t, uint64_t);
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 4e62eda14b..b4e16cfbc3 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -229,6 +229,12 @@ DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS=
_andc_vec))
<snip>
> +
> +/* Expand the tuple (opc, type, vece) on the given arguments.  */
> +void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
> +
> +/* Replicate a constant C accoring to the log2 of the element size.
> */

nit: according

<snip>
--
Alex Benn=C3=A9e
