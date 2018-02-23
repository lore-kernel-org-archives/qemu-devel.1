Received: from eggs.gnu.org ([2001:4830:134:3::10]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epLY3-0007iF-Vn
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 17:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epLY1-00028U-44
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 17:10:35 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:40811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epLY0-00025z-Pi
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 17:10:32 -0500
Received: by mail-pg0-x22d.google.com with SMTP id g2so3862391pgn.7
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 14:10:32 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-12-alex.bennee@linaro.org>
	<da2bc012-1693-3335-eb5a-921d94e6015e@linaro.org>
	<87d10vapc1.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9fc0a96-ce22-47db-1c8d-05a2f05c6c32@linaro.org>
Date: Fri, 23 Feb 2018 14:10:28 -0800
MIME-Version: 1.0
In-Reply-To: <87d10vapc1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/32] arm/translate-a64: add FP16
 F[A]C[EQ/GE/GT] to simd_three_reg_same_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/23/2018 03:59 AM, Alex Bennée wrote:
>> Not using float16_eq etc?
> 
> These don't actually exist.

Ah.

> But I guess we could make stubs for them
> based on the generic float_compare support. But would it buy us much?
...
>>> +    return ADVSIMD_CMPRES(compare == float_relation_greater ||
>>> +                          compare == float_relation_equal);
>>
>> Especially float16_le(b, a, fpst).

It buys us knowledge of the float_relation_* values, such that instead of the
two comparisons above you can use <= 0 (note that this only works for le not
ge, because of float_relation_unordered == 2).

I'll grant you that two compares vs one isn't much, but it is simpler...


r~
