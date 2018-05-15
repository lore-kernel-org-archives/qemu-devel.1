Received: from eggs.gnu.org ([2001:4830:134:3::10]:59470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIaAb-0004ni-NR
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIaAX-0001kk-P1
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:39:13 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIaAX-0001kQ-IQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:39:09 -0400
Received: by mail-wr0-x244.google.com with SMTP id q3-v6so184883wrj.6
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:39:09 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-16-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-16-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 14:39:06 +0100
Message-ID: <87fu2tf37p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 15/28] target/hppa: Remove
 floatX_maybe_silence_nan from conversions
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

> This is now handled properly by the generic softfloat code.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/hppa/op_helper.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index a3af62daf7..912e8d5be4 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -341,7 +341,6 @@ float64 HELPER(fdiv_d)(CPUHPPAState *env, float64 a, =
float64 b)
>  float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 arg)
>  {
>      float64 ret =3D float32_to_float64(arg, &env->fp_status);
> -    ret =3D float64_maybe_silence_nan(ret, &env->fp_status);
>      update_fr0_op(env, GETPC());
>      return ret;
>  }
> @@ -349,7 +348,6 @@ float64 HELPER(fcnv_s_d)(CPUHPPAState *env, float32 a=
rg)
>  float32 HELPER(fcnv_d_s)(CPUHPPAState *env, float64 arg)
>  {
>      float32 ret =3D float64_to_float32(arg, &env->fp_status);
> -    ret =3D float32_maybe_silence_nan(ret, &env->fp_status);
>      update_fr0_op(env, GETPC());
>      return ret;
>  }


--
Alex Benn=C3=A9e
