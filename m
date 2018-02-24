Received: from eggs.gnu.org ([2001:4830:134:3::10]:58474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNJe-0007jK-Sf
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNJa-0004FQ-1n
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:03:50 -0500
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:46695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNJZ-0004EE-RU
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:03:45 -0500
Received: by mail-pl0-x22a.google.com with SMTP id x19so5792323plr.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:03:45 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0882ecdd-b31d-aa04-f80d-2404ead313be@linaro.org>
Date: Fri, 23 Feb 2018 16:03:41 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/31] arm/translate-a64: add FP16
 FMULX/MLS/FMLA to simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/23/2018 07:36 AM, Alex Bennée wrote:
>      case 0x9: /* FMUL, FMULX */
> -        if (!extract32(size, 1, 1)) {
> +        if (size == 1 ||
> +            (size < 2 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
>              unallocated_encoding(s);

You get to drop the check here...

> +        case 0: /* half precision */
> +            size = MO_16;
> +            index = h << 2 | l << 1 | m;
> +            is_fp16 = true;
> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                break;
> +            }

... because you added it here instead.


r~
