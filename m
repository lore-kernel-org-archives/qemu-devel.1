Received: from eggs.gnu.org ([2001:4830:134:3::10]:54062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIZrA-0002IM-BK
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIZr5-0007Zh-CT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:19:08 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIZr5-0007Yz-2o
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:19:03 -0400
Received: by mail-wr0-x242.google.com with SMTP id p4-v6so124259wrh.3
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:19:03 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-10-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 14:19:00 +0100
Message-ID: <87in7pf457.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 09/28] target/arm: Use
 floatX_silence_nan when we have already checked for SNaN
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

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper-a64.c |  6 +++---
>  target/arm/helper.c     | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 4f8034c513..6f0eb83661 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -376,7 +376,7 @@ float16 HELPER(frecpx_f16)(float16 a, void *fpstp)
>          float16 nan =3D a;
>          if (float16_is_signaling_nan(a, fpst)) {
>              float_raise(float_flag_invalid, fpst);
> -            nan =3D float16_maybe_silence_nan(a, fpst);
> +            nan =3D float16_silence_nan(a, fpst);
>          }
>          if (fpst->default_nan_mode) {
>              nan =3D float16_default_nan(fpst);
> @@ -405,7 +405,7 @@ float32 HELPER(frecpx_f32)(float32 a, void *fpstp)
>          float32 nan =3D a;
>          if (float32_is_signaling_nan(a, fpst)) {
>              float_raise(float_flag_invalid, fpst);
> -            nan =3D float32_maybe_silence_nan(a, fpst);
> +            nan =3D float32_silence_nan(a, fpst);
>          }
>          if (fpst->default_nan_mode) {
>              nan =3D float32_default_nan(fpst);
> @@ -434,7 +434,7 @@ float64 HELPER(frecpx_f64)(float64 a, void *fpstp)
>          float64 nan =3D a;
>          if (float64_is_signaling_nan(a, fpst)) {
>              float_raise(float_flag_invalid, fpst);
> -            nan =3D float64_maybe_silence_nan(a, fpst);
> +            nan =3D float64_silence_nan(a, fpst);
>          }
>          if (fpst->default_nan_mode) {
>              nan =3D float64_default_nan(fpst);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c6fd7f9479..3df5cf30e4 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11739,7 +11739,7 @@ float16 HELPER(recpe_f16)(float16 input, void *fp=
stp)
>          float16 nan =3D f16;
>          if (float16_is_signaling_nan(f16, fpst)) {
>              float_raise(float_flag_invalid, fpst);
> -            nan =3D float16_maybe_silence_nan(f16, fpst);
> +            nan =3D float16_silence_nan(f16, fpst);
>          }
>          if (fpst->default_nan_mode) {
>              nan =3D  float16_default_nan(fpst);
> @@ -11787,7 +11787,7 @@ float32 HELPER(recpe_f32)(float32 input, void *fp=
stp)
>          float32 nan =3D f32;
>          if (float32_is_signaling_nan(f32, fpst)) {
>              float_raise(float_flag_invalid, fpst);
> -            nan =3D float32_maybe_silence_nan(f32, fpst);
> +            nan =3D float32_silence_nan(f32, fpst);
>          }
>          if (fpst->default_nan_mode) {
>              nan =3D  float32_default_nan(fpst);
> @@ -11835,7 +11835,7 @@ float64 HELPER(recpe_f64)(float64 input, void *fp=
stp)
>          float64 nan =3D f64;
>          if (float64_is_signaling_nan(f64, fpst)) {
>              float_raise(float_flag_invalid, fpst);
> -            nan =3D float64_maybe_silence_nan(f64, fpst);
> +            nan =3D float64_silence_nan(f64, fpst);
>          }
>          if (fpst->default_nan_mode) {
>              nan =3D  float64_default_nan(fpst);
> @@ -11934,7 +11934,7 @@ float16 HELPER(rsqrte_f16)(float16 input, void *f=
pstp)
>          float16 nan =3D f16;
>          if (float16_is_signaling_nan(f16, s)) {
>              float_raise(float_flag_invalid, s);
> -            nan =3D float16_maybe_silence_nan(f16, s);
> +            nan =3D float16_silence_nan(f16, s);
>          }
>          if (s->default_nan_mode) {
>              nan =3D  float16_default_nan(s);
> @@ -11978,7 +11978,7 @@ float32 HELPER(rsqrte_f32)(float32 input, void *f=
pstp)
>          float32 nan =3D f32;
>          if (float32_is_signaling_nan(f32, s)) {
>              float_raise(float_flag_invalid, s);
> -            nan =3D float32_maybe_silence_nan(f32, s);
> +            nan =3D float32_silence_nan(f32, s);
>          }
>          if (s->default_nan_mode) {
>              nan =3D  float32_default_nan(s);
> @@ -12021,7 +12021,7 @@ float64 HELPER(rsqrte_f64)(float64 input, void *f=
pstp)
>          float64 nan =3D f64;
>          if (float64_is_signaling_nan(f64, s)) {
>              float_raise(float_flag_invalid, s);
> -            nan =3D float64_maybe_silence_nan(f64, s);
> +            nan =3D float64_silence_nan(f64, s);
>          }
>          if (s->default_nan_mode) {
>              nan =3D  float64_default_nan(s);


--
Alex Benn=C3=A9e
