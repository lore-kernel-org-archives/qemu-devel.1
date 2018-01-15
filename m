Received: from eggs.gnu.org ([2001:4830:134:3::10]:41074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8SD-0006LU-0k
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8S8-0002Wp-S8
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:21:49 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb8S8-0002WP-OF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:21:44 -0500
Received: by mail-ot0-x242.google.com with SMTP id s3so11236313otc.9
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:21:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-2-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 17:21:23 +0000
Message-ID: <CAFEAcA_MEhgNCQf9MvfPxLdhpNUMYFB9-rKKy=X7_p-tXkCD1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/11] target/arm: Add
 ARM_FEATURE_V8_1_SIMD
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
>  linux-user/elfload.c | 9 +++++++++
>  target/arm/cpu.c     | 1 +
>  target/arm/cpu64.c   | 1 +
>  4 files changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 715ec6a476..e047756b80 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1351,6 +1351,7 @@ enum arm_features {
>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
> +    ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
>      ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>  };

I kind of prefer the kernel's choice of ASIMDRDM rather than
V8_1_SIMD, but the latter is the official architectural feature
name, so oh well.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
