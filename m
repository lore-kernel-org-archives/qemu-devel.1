Received: from eggs.gnu.org ([2001:4830:134:3::10]:56795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTqU4-0008Up-6u
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTqU0-0003dq-7G
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:50:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTqTy-0003SV-EF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:50:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id y139so6356001wmc.5
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:50:00 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-6-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 15:49:57 +0000
Message-ID: <87k1kq390a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/16] tcg/arm: Remove reloc_pc24_atomic
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

> It is unused since 3fb53fb4d12f2e7833bd1659e6013237b130ef20.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/arm/tcg-target.inc.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index e1fbf465cb..1142eb13ad 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -193,14 +193,6 @@ static inline void reloc_pc24(tcg_insn_unit *code_pt=
r, tcg_insn_unit *target)
>      *code_ptr =3D (*code_ptr & ~0xffffff) | (offset & 0xffffff);
>  }
>
> -static inline void reloc_pc24_atomic(tcg_insn_unit *code_ptr, tcg_insn_u=
nit *target)
> -{
> -    ptrdiff_t offset =3D (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
> -    tcg_insn_unit insn =3D atomic_read(code_ptr);
> -    tcg_debug_assert(offset =3D=3D sextract32(offset, 0, 24));
> -    atomic_set(code_ptr, deposit32(insn, 0, 24, offset));
> -}
> -
>  static void patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {


--
Alex Benn=C3=A9e
