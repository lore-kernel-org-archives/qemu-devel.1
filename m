Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjh6-0000Q5-8z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjh5-0003nn-BT
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:09:40 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjh5-0003m9-3H
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:09:39 -0500
Received: by mail-oi0-x241.google.com with SMTP id t185so13564534oif.6
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:09:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227143852.11175-3-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<20180227143852.11175-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 18:09:18 +0000
Message-ID: <CAFEAcA_uYRwKMz09B1E_TV3fb2xJd-D4UdF2kyDhNkwNLDiVnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/31] target/arm/cpu64: introduce
 ARM_V8_FP16 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 27 February 2018 at 14:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h   | 1 +
>  target/arm/cpu64.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8c839faa8f..267a9d7e2f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1408,6 +1408,7 @@ enum arm_features {
>      ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions=
 */
>      ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions *=
/
>      ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions *=
/
> +    ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 1c330adc28..9743bdc8c3 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -230,6 +230,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>      cpu->ctr =3D 0x80038003; /* 32 byte I and D cacheline size, VIPT ica=
che */
>      cpu->dcz_blocksize =3D 7; /*  512 bytes */
>  }

I'm just going to split out the second half of this patchset into its
own commit, because we shouldn't enable the feature until after we've
implemented it.

thanks
-- PMM
