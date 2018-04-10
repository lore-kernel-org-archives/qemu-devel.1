Received: from eggs.gnu.org ([2001:4830:134:3::10]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5sxi-0001QO-Vl
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5sxe-0000cr-Vz
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:05:26 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5sxe-0000bk-P4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:05:22 -0400
Received: by mail-wr0-x243.google.com with SMTP id d1so12720903wrj.13
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:05:22 -0700 (PDT)
References: <20180410055912.934-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180410055912.934-1-richard.henderson@linaro.org>
Date: Tue, 10 Apr 2018 14:05:20 +0100
Message-ID: <87604z5i0f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] fpu: Fix rounding mode for
 floatN_to_uintM_round_to_zero
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

> We incorrectly passed in the current rounding mode
> instead of float_round_to_zero.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Oops,

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>
> Found while runnning SVE RISU tests; it should be visible with the
> right set of inputs to AdvSIMD RISU tests.
>
>
> r~
>
> ---
>  fpu/softfloat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 6e16284e66..b46dccc63e 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1486,8 +1486,8 @@ uint ## isz ## _t float ## fsz ## _to_uint ## isz #=
# _round_to_zero     \
>   (float ## fsz a, float_status *s)                                      \
>  {                                                                       \
>      FloatParts p =3D float ## fsz ## _unpack_canonical(a, s);           =
  \
> -    return round_to_uint_and_pack(p, s->float_rounding_mode,            \
> -                                 UINT ## isz ## _MAX, s);               \
> +    return round_to_uint_and_pack(p, float_round_to_zero,               \
> +                                  UINT ## isz ## _MAX, s);              \
>  }
>
>  FLOAT_TO_UINT(16, 16)


--
Alex Benn=C3=A9e
