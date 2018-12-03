Received: from eggs.gnu.org ([2001:4830:134:3::10]:45716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTjqp-0007Pk-MZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTjqk-0007kn-02
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:45:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTjqj-0007jV-Dx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:45:05 -0500
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so4780632wmb.2
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 00:45:01 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-4-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 08:44:58 +0000
Message-ID: <87a7ln3sol.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/16] tcg/aarch64: Remove
 reloc_pc26_atomic
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

> It is unused since b68686bd4bfeb70040b4099df993dfa0b4f37b03.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 083592a4d7..a41b633960 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -87,18 +87,6 @@ static inline void reloc_pc26(tcg_insn_unit *code_ptr,=
 tcg_insn_unit *target)
>      *code_ptr =3D deposit32(*code_ptr, 0, 26, offset);
>  }
>
> -static inline void reloc_pc26_atomic(tcg_insn_unit *code_ptr,
> -                                     tcg_insn_unit *target)
> -{
> -    ptrdiff_t offset =3D target - code_ptr;
> -    tcg_insn_unit insn;
> -    tcg_debug_assert(offset =3D=3D sextract64(offset, 0, 26));
> -    /* read instruction, mask away previous PC_REL26 parameter contents,
> -       set the proper offset, then write back the instruction. */
> -    insn =3D atomic_read(code_ptr);
> -    atomic_set(code_ptr, deposit32(insn, 0, 26, offset));
> -}
> -
>  static inline void reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *ta=
rget)
>  {
>      ptrdiff_t offset =3D target - code_ptr;


--
Alex Benn=C3=A9e
