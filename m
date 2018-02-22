Received: from eggs.gnu.org ([2001:4830:134:3::10]:38061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowj0-0002At-Sr
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowiw-0006kc-DA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:40:14 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:34907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eowiw-0006kO-84
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:40:10 -0500
Received: by mail-pf0-x22e.google.com with SMTP id y186so1811585pfb.2
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:40:10 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-21-alex.bennee@linaro.org>
	<d6f98bba-04ca-80f6-1fad-cfed416f4127@linaro.org>
	<87h8q99bv9.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <491cdad9-58a1-2f2d-a415-c2b6c1562eab@linaro.org>
Date: Thu, 22 Feb 2018 11:40:06 -0800
MIME-Version: 1.0
In-Reply-To: <87h8q99bv9.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/22/2018 09:23 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 02/08/2018 09:31 AM, Alex Bennée wrote:
>>> +            maxpasses = hp ? (is_q ? 8 : 4) : (is_q ? 4 : 2);
>>
>>   (8 << is_q) >> size
>>
>> ?
> 
> Hmm I'm not so sure about this. While mine is longer form at least the
> intent is clear. What about:
> 
>     maxpasses = (is_q ? 4 : 2) << hp
> 
> It's still a little magical IMHO though...

Two variables then?

  vector_size = 8 << is_q;
  maxpasses = vector_size >> size;

Why do you want the "hp" variable when you already have "size"?


r~
