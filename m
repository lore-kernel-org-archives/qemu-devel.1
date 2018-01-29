Received: from eggs.gnu.org ([2001:4830:134:3::10]:36860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egBhx-0006ea-4z
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1egBhn-0003Wl-SL
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:50:57 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:36187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1egBhn-0003WH-L9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:50:47 -0500
Received: by mail-pf0-x22c.google.com with SMTP id 23so5616235pfp.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 07:50:47 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-20-alex.bennee@linaro.org>
	<57ab078a-049b-72e7-5bc5-f73a3c947b45@linaro.org>
	<87vafkyiyg.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85b5aa04-ec85-a2b6-3b79-2bb991824004@linaro.org>
Date: Mon, 29 Jan 2018 07:50:43 -0800
MIME-Version: 1.0
In-Reply-To: <87vafkyiyg.fsf@linaro.org>
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

On 01/29/2018 03:59 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 01/24/2018 05:13 AM, Alex Bennée wrote:
>>> +/* Multiply A by 2 raised to the power N.  */
>>> +static FloatParts scalbn_decomposed(FloatParts a, int n,
>>> +                                          float_status *s)
>>> +{
>>> +    if (a.cls == float_class_normal) {
>>> +        a.exp += n;
>>> +    }
>>> +    return a;
>>> +}
>>
>> ...
>>
>>> -    if ( aExp == 0x7FF ) {
>>> -        if ( aSig ) {
>>> -            return propagateFloat64NaN(a, a, status);
>>
>> This is where we used to raise inexact.
>> In the new function we need to handle this as in round_to_int.
> 
> Why is the handling in round_canonical not good enough for this?

This is scalbn -- you don't call round_canonical.


r~
