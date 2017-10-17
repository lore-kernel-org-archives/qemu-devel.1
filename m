Received: from eggs.gnu.org ([2001:4830:134:3::10]:42737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4Fuh-0002DL-Cl
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4Fud-0002S0-Fj
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:39:19 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:44610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4Fud-0002R1-AM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:39:15 -0400
Received: by mail-pg0-x22c.google.com with SMTP id j3so70435pga.1
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 17:39:15 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9106f459-c4fa-07f6-0709-b8e5aa23001f@linaro.org>
Date: Mon, 16 Oct 2017 17:39:11 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 22/30] target/arm/translate-a64.c: add
 FP16 FAGCT to AdvSIMD 3 Same
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
> -/* uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp) */
> -/* { */
> -/*     float_status *fpst = fpstp; */
> -/*     float16 f0 = float16_abs(a); */
> -/*     float16 f1 = float16_abs(b); */
> -/*     return -float16_lt(f1, f0, fpst); */
> -/* } */
> +uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp)
> +{
> +    float_status *fpst = fpstp;
> +    float16 f0 = float16_abs(a);
> +    float16 f1 = float16_abs(b);
> +    return -float16_lt(f1, f0, fpst);
> +}

Should be folded into previous.  But otherwise ok.


r~
