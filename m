Received: from eggs.gnu.org ([2001:4830:134:3::10]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8x7-00073s-Qy
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8x7-00058l-4s
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:53:45 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb8x6-00058L-VP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:53:45 -0500
Received: by mail-ot0-x241.google.com with SMTP id d10so11322034oti.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:53:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-8-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 17:53:23 +0000
Message-ID: <CAFEAcA-NAGcEba2ik__xirZxrtbNw4wsiWDtiqsLfLdG4jyKpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/11] target/arm: Add
 ARM_FEATURE_V8_FCMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Enable it for the "any" CPU used by *-linux-user.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     | 1 +
>  linux-user/elfload.c | 1 +
>  target/arm/cpu.c     | 1 +
>  target/arm/cpu64.c   | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e047756b80..7a705a09a1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1353,6 +1353,7 @@ enum arm_features {
>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
>      ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
>      ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
> +    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions. =
 */

This is a bit inconsistent. If we're going with the architectural
feature names this is "ARMv8.3-CompNum", so ARM_FEATURE_V8_3_COMPNUM.
If we're going with the ID_AA64ISARn_EL1 field names then
ARM_FEATURE_V8_1_SIMD should be ARM_FEATURE_V8_RDM...

>  };

thanks
-- PMM
