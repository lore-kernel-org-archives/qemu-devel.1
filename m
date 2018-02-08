Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuqh-0000YL-2i
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuqe-0005dh-1g
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:39:23 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:38409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejuqd-0005cm-TJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:39:19 -0500
Received: by mail-it0-x22e.google.com with SMTP id k6so8380729ita.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:39:19 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d6f98bba-04ca-80f6-1fad-cfed416f4127@linaro.org>
Date: Thu, 8 Feb 2018 14:39:15 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 20/32] arm/translate-a64: add FP16 FCMxx
 (zero) to simd_two_reg_misc_fp16
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
> +            maxpasses = hp ? (is_q ? 8 : 4) : (is_q ? 4 : 2);

  (8 << is_q) >> size

?


> +            read_vec_element_i32(s, tcg_op, rn, pass, hp ? MO_16 : MO_32);

You already have size.

> +        return;
> +        break;

Unreachable break.


r~
