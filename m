Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuv9-0004EY-Oi
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuv6-0008Bi-UZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:43:59 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejuv6-0008BV-On
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:43:56 -0500
Received: by mail-pg0-x235.google.com with SMTP id j9so1772054pgp.11
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:43:56 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <23fab91d-1ca1-0c6c-800c-f7fe6a1c109e@linaro.org>
Date: Thu, 8 Feb 2018 14:43:51 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 22/32] arm/translate-a64: add FP16
 FNEG/FABS to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> +            case 0x2f: /* FABS */
> +                gen_helper_advsimd_absh(tcg_res, tcg_op);
> +                break;
> +            case 0x6f: /* FNEG */
> +                tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
> +                break;

Why is ABS a function call while NEG a bit operation?


r~
