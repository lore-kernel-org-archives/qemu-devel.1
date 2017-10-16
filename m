Received: from eggs.gnu.org ([2001:4830:134:3::10]:41614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4DYw-0007xI-02
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4DYs-0003Nj-Qd
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:08:41 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:57084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4DYs-0003NG-Kb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:08:38 -0400
Received: by mail-pg0-x234.google.com with SMTP id m18so7910707pgd.13
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 15:08:38 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbd163be-fd12-9b58-c8cc-34f94c742e25@linaro.org>
Date: Mon, 16 Oct 2017 15:08:34 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 16/30] target/arm/translate-a64.c: add
 FP16 FADD/FMUL/FDIV to AdvSIMD 3 Same (!sub)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> +DEF_HELPER_3(advsimd_addh, f16, f16, f16, ptr)
> +DEF_HELPER_3(advsimd_subh, f16, f16, f16, ptr)
> +DEF_HELPER_3(advsimd_mulh, f16, f16, f16, ptr)
> +DEF_HELPER_3(advsimd_divh, f16, f16, f16, ptr)
...
>          switch (fpopcode) {
> +        case 0x2: /* FADD */
> +            gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
> +            break;

Forgot FSUB with case 0x12?


r~
