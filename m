Received: from eggs.gnu.org ([2001:4830:134:3::10]:38800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egBnd-0002F7-G4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egBna-0007aF-Ao
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:56:49 -0500
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:46662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1egBna-0007Zg-41
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:56:46 -0500
Received: by mail-pf0-x229.google.com with SMTP id y5so5620976pff.13
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 07:56:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-20-alex.bennee@linaro.org>
	<57ab078a-049b-72e7-5bc5-f73a3c947b45@linaro.org>
	<87vafkyiyg.fsf@linaro.org>
	<85b5aa04-ec85-a2b6-3b79-2bb991824004@linaro.org>
Message-ID: <841cd62e-1062-6997-10f6-272b55d1b612@linaro.org>
Date: Mon, 29 Jan 2018 07:56:42 -0800
MIME-Version: 1.0
In-Reply-To: <85b5aa04-ec85-a2b6-3b79-2bb991824004@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/22] fpu/softfloat: re-factor scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/29/2018 07:50 AM, Richard Henderson wrote:
> On 01/29/2018 03:59 AM, Alex Bennée wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 01/24/2018 05:13 AM, Alex Bennée wrote:
>>>> +/* Multiply A by 2 raised to the power N.  */
>>>> +static FloatParts scalbn_decomposed(FloatParts a, int n,
>>>> +                                          float_status *s)
>>>> +{
>>>> +    if (a.cls == float_class_normal) {
>>>> +        a.exp += n;
>>>> +    }
>>>> +    return a;
>>>> +}
>>>
>>> ...
>>>
>>>> -    if ( aExp == 0x7FF ) {
>>>> -        if ( aSig ) {
>>>> -            return propagateFloat64NaN(a, a, status);
>>>
>>> This is where we used to raise inexact.
>>> In the new function we need to handle this as in round_to_int.
>>
>> Why is the handling in round_canonical not good enough for this?
> 
> This is scalbn -- you don't call round_canonical.

Scratch that -- too early.  And I was trying to talk about invalid not inexact.
 What a cacophony of errors on my part.  No wonder we're not communicating.

But you'll notice that round_canonical does not raise invalid for nans.
Perhaps we could rearrange things so that it does, but at the moment it is the
responsibility of prior code to have set invalid and msnan/dnan.


r~
