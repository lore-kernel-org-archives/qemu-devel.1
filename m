Received: from eggs.gnu.org ([2001:4830:134:3::10]:40196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eldML-0006D0-2o
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eldMH-0008P7-V1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:23:09 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:41255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eldMH-0008Oi-OW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:23:05 -0500
Received: by mail-oi0-x22e.google.com with SMTP id t135so1615090oif.8
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 08:23:05 -0800 (PST)
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-23-alex.bennee@linaro.org>
	<CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c0097ba-fe66-5a28-17ed-7f22c486f034@linaro.org>
Date: Tue, 13 Feb 2018 08:23:01 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Tp9cH5CBi4C6CRHpZ4ozygGSFYhdLaURBQOVZ9zVxvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 22/22] fpu/softfloat: re-factor sqrt
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

On 02/13/2018 07:50 AM, Peter Maydell wrote:
>> +    /* We need two overflow bits at the top.  Adding room for that is
>> +       a right shift.  If the exponent is odd, we can discard the low
>> +       bit by multiplying the fraction by 2; that's a left shift.
>> +       Combine those and we shift right if the exponent is even.  */
>> +    a_frac = a.frac;
>> +    if (!(a.exp & 1)) {
>> +        a_frac >>= 1;
>> +    }
>> +    a.exp >>= 1;
> Comment says "shift right if the exponent is even", but code
> says "shift right by 1 if exponent is odd, by 2 if exponent is even".
> 

The last line is dividing the exponent by 2, not shifting the fraction.


r~
