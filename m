Received: from eggs.gnu.org ([2001:4830:134:3::10]:40098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTn74-0004X3-0K
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTn70-0006vl-7U
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:14:10 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTn6w-0006rH-Jy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:14:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id n190so3088324wmd.0
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 04:14:01 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-2-cota@braap.org>
Date: Mon, 03 Dec 2018 12:13:58 +0000
Message-ID: <87sgze3j09.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/13] fp-test: pick TARGET_ARM to get
 its specialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> This gets rid of the muladd errors due to not raising the invalid flag.
>
> - Before:
> Errors found in f64_mulAdd, rounding near_even, tininess before rounding:
> +000.0000000000000  +7FF.0000000000000  +7FF.FFFFFFFFFFFFF
>         =3D> +7FF.FFFFFFFFFFFFF .....  expected -7FF.FFFFFFFFFFFFF v....
> [...]
>
> - After:
> In 6133248 tests, no errors found in f64_mulAdd, rounding near_even, tini=
ness before rounding.
> [...]
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/fp/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/fp/Makefile b/tests/fp/Makefile
> index d649a5a1db..49cdcd1bd2 100644
> --- a/tests/fp/Makefile
> +++ b/tests/fp/Makefile
> @@ -29,6 +29,9 @@ QEMU_INCLUDES +=3D -I$(TF_SOURCE_DIR)
>
>  # work around TARGET_* poisoning
>  QEMU_CFLAGS +=3D -DHW_POISON_H
> +# define a target to match testfloat's implementation-defined choices, s=
uch as
> +# whether to raise the invalid flag when dealing with NaNs in muladd.
> +QEMU_CFLAGS +=3D -DTARGET_ARM
>
>  # capstone has a platform.h file that clashes with softfloat's
>  QEMU_CFLAGS :=3D $(filter-out %capstone, $(QEMU_CFLAGS))


--
Alex Benn=C3=A9e
