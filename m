Received: from eggs.gnu.org ([2001:4830:134:3::10]:44881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSLnp-0006nn-Av
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gSLnk-0005Fh-AI
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:52:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gSLnk-0005FK-2q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:52:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id j10so1784079wru.4
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 04:52:15 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123144558.5048-2-richard.henderson@linaro.org>
Date: Thu, 29 Nov 2018 12:52:13 +0000
Message-ID: <8736rk3v2a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 01/37] tcg/i386: Always use %ebp
 for TCG_AREG0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com


Richard Henderson <richard.henderson@linaro.org> writes:

> For x86_64, this can result in smaller code when manipulating
> TCG_TYPE_I32, as we can omit a REX prefix.

I take it you mean passing TCG_TYPE_I32 back and forth from the register
backing store in CPUEnv which TCG_AREG0 points at?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index 9fdf37f23c..7488c3d869 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -84,6 +84,8 @@ typedef enum {
>      TCG_REG_RBP =3D TCG_REG_EBP,
>      TCG_REG_RSI =3D TCG_REG_ESI,
>      TCG_REG_RDI =3D TCG_REG_EDI,
> +
> +    TCG_AREG0 =3D TCG_REG_EBP,
>  } TCGReg;
>
>  /* used for function call generation */
> @@ -194,12 +196,6 @@ extern bool have_avx2;
>  #define TCG_TARGET_extract_i64_valid(ofs, len) \
>      (((ofs) =3D=3D 8 && (len) =3D=3D 8) || ((ofs) + (len)) =3D=3D 32)
>
> -#if TCG_TARGET_REG_BITS =3D=3D 64
> -# define TCG_AREG0 TCG_REG_R14
> -#else
> -# define TCG_AREG0 TCG_REG_EBP
> -#endif
> -
>  static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>  {
>  }


--
Alex Benn=C3=A9e
