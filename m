Received: from eggs.gnu.org ([2001:4830:134:3::10]:46270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTldX-0001KK-6J
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTldT-0002sU-2m
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:39:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTldQ-0002qp-NE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:39:29 -0500
Received: by mail-wr1-x441.google.com with SMTP id z5so11566692wrt.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:39:28 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-11-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-11-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:39:26 +0000
Message-ID: <8736re51y9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/16] tcg/mips: Remove retranslation
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> There is no longer a need for preserving branch offset operands,
> as we no longer re-translate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/mips/tcg-target.inc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index cff525373b..e21cb1ae28 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -483,12 +483,7 @@ static inline void tcg_out_opc_bf64(TCGContext *s, M=
IPSInsn opc, MIPSInsn opm,
>  static inline void tcg_out_opc_br(TCGContext *s, MIPSInsn opc,
>                                    TCGReg rt, TCGReg rs)
>  {
> -    /* We pay attention here to not modify the branch target by reading
> -       the existing value and using it again. This ensure that caches and
> -       memory are kept coherent during retranslation. */
> -    uint16_t offset =3D (uint16_t)*s->code_ptr;
> -
> -    tcg_out_opc_imm(s, opc, rt, rs, offset);
> +    tcg_out_opc_imm(s, opc, rt, rs, 0);
>  }
>
>  /*


--
Alex Benn=C3=A9e
