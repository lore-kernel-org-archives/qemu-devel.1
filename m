Received: from eggs.gnu.org ([2001:4830:134:3::10]:53959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elcgN-0001Eh-Nc
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elcgJ-0003sP-Kd
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:39:47 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:35685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1elcgJ-0003sC-FP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:39:43 -0500
Received: by mail-it0-x22c.google.com with SMTP id e1so11285962ita.0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:39:43 -0800 (PST)
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-14-alex.bennee@linaro.org>
	<CAFEAcA_+hYx=-CPaLe3ZVGs8KF2zkb=dRta+A=C6jDteu--EcA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b4f4766-f35b-2caf-c086-03229b5b8ba7@linaro.org>
Date: Tue, 13 Feb 2018 07:39:39 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+hYx=-CPaLe3ZVGs8KF2zkb=dRta+A=C6jDteu--EcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 13/22] fpu/softfloat: re-factor mul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 02/13/2018 07:20 AM, Peter Maydell wrote:
>> +static FloatParts mul_floats(FloatParts a, FloatParts b, float_status *s)
>> +{
>> +    bool sign = a.sign ^ b.sign;
>> +
>> +    if (a.cls == float_class_normal && b.cls == float_class_normal) {
>> +        uint64_t hi, lo;
>> +        int exp = a.exp + b.exp;
>> +
>> +        mul64To128(a.frac, b.frac, &hi, &lo);
> 
> It seems a shame that we previously were able to use a
> 32x32->64 multiply for the float32 case, and now we have to
> do an expensive 64x64->128 multiply regardless...

To be fair, I've proposed two different solutions addressing that -- c++
templates and glibc macros -- and you like neither.  Is there a third
alternative that does not involve code duplication?


r~
