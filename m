Received: from eggs.gnu.org ([2001:4830:134:3::10]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG6Sy-000813-Nl
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG6Sv-0005Dq-IJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:31:56 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG6Sv-0005DH-CQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:31:53 -0400
Received: by mail-pf0-x229.google.com with SMTP id v63so24278770pfk.8
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:31:53 -0700 (PDT)
References: <20180508151437.4232-1-richard.henderson@linaro.org>
	<20180508151437.4232-8-richard.henderson@linaro.org>
	<CAFEAcA9YdzrU7gpu3XUmGJL+QXOk+R9PaYNOxuCQVyLjt7L=hQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61d9c194-4ee6-af9f-0fb4-55958058937e@linaro.org>
Date: Tue, 8 May 2018 10:31:48 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9YdzrU7gpu3XUmGJL+QXOk+R9PaYNOxuCQVyLjt7L=hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] target/arm: Introduce
 ARM_FEATURE_V8_ATOMICS and initial decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05/08/2018 09:48 AM, Peter Maydell wrote:
> (A v8.x implementation can include any arbitrary
> subset of the v8.(x+1) features, so this is a legal combination.)

I didn't realize this was a possibility.

> In fact we already have a mandatory-in-v8.1 feature:
> ARM_FEATURE_V8_RDM, which we've just given its own feature bit.

Yes, I'd been planning to send follow-up patches to "tidy" this.

> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1449,8 +1449,7 @@ enum arm_features {
>      ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
>      ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
>      ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
> -    ARM_FEATURE_V8_1,
> -    ARM_FEATURE_V8_ATOMICS = ARM_FEATURE_V8_1, /* mandatory extension */
> +    ARM_FEATURE_V8_ATOMICS, /* ARMv8.1-Atomics feature */
>      ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
>      ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>      ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
> 
> Is that OK?

Yes, that's fine.  Thanks.

> We can have a separate patch which adds ARM_FEATURE_V8_1 and the
> code in realizefn to do
>     if (arm_feature(env, ARM_FEATURE_V8_1)) {
>         set_feature(env, ARM_FEATURE_V8);
>         set_feature(env, ARM_FEATURE_V8_ATOMICS);
>         set_feature(env, ARM_FEATURE_V8_RDM);
>     }

Yep.


r~
