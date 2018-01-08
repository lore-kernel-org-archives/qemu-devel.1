Received: from eggs.gnu.org ([2001:4830:134:3::10]:37351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYdzk-0002ms-Hf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYdzh-0001P1-5o
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:26:08 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYdzg-0001OP-L8
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 15:26:04 -0500
Received: by mail-pf0-x244.google.com with SMTP id e3so6782586pfi.10
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 12:26:04 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-5-alex.bennee@linaro.org>
	<c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
	<87d13b6uo4.fsf@linaro.org> <87fu7go6c9.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b19445c-91cd-32b6-488f-baf40cbe359a@linaro.org>
Date: Mon, 8 Jan 2018 12:25:59 -0800
MIME-Version: 1.0
In-Reply-To: <87fu7go6c9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/08/2018 04:58 AM, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 12/11/2017 04:56 AM, Alex Bennée wrote:
>>>> +static inline float16 float16_set_sign(float16 a, int sign)
>>>> +{
>>>> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>>>> +}
>>>> +
>>>
>>> 1) Do we use this anywhere?
>>
>> Yes in the target specific helpers
>>
>>>
>>> 2) While this is probably in line with the other implementations,
>>> but going to a more qemu-ish style this should use deposit32.
>>
>> OK, will do.
>>
> 
> It turns out doing this unleashes a weird circular dependency at we need
> qemu/bitops.h but that brings in host-utils.h and bswap.h which tries
> to include softfloat.h again.

Bah.

Just ignore this request for now then.

For future cleanup, I'm sure that bswap.h includes softfloat.h for the
float32/float64 typedefs.  We should move those out somewhere else -- probably
qemu/typedefs.h.  Which probably drops the number of objects that depend on
softfloat.h by a factor of 100.


r~
