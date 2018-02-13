Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eldXa-00083r-5r
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eldXZ-0002Va-FD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:34:46 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eldXZ-0002VK-BD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:34:45 -0500
Received: by mail-ot0-x242.google.com with SMTP id f18so17808542otf.6
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:34:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8c0097ba-fe66-5a28-17ed-7f22c486f034@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-23-alex.bennee@linaro.org>
	<CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
	<8c0097ba-fe66-5a28-17ed-7f22c486f034@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 16:34:24 +0000
Message-ID: <CAFEAcA9LbaZG0i87Y5X9Ws5D7UNODYBSUMedrim4-GOkGGjEnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 22/22] fpu/softfloat: re-factor sqrt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 13 February 2018 at 16:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/13/2018 07:50 AM, Peter Maydell wrote:
>>> +    /* We need two overflow bits at the top.  Adding room for that is
>>> +       a right shift.  If the exponent is odd, we can discard the low
>>> +       bit by multiplying the fraction by 2; that's a left shift.
>>> +       Combine those and we shift right if the exponent is even.  */
>>> +    a_frac = a.frac;
>>> +    if (!(a.exp & 1)) {
>>> +        a_frac >>= 1;
>>> +    }
>>> +    a.exp >>= 1;
>> Comment says "shift right if the exponent is even", but code
>> says "shift right by 1 if exponent is odd, by 2 if exponent is even".
>>
>
> The last line is dividing the exponent by 2, not shifting the fraction.

Doh, so it is.

-- PMM
