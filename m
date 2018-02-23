Received: from eggs.gnu.org ([2001:4830:134:3::10]:38107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epHC3-0004UX-TC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epHBz-0002RC-0b
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:35 -0500
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:34259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epHBy-0002QG-Qy
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:30 -0500
Received: by mail-pl0-x22d.google.com with SMTP id u13so5275475plq.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:31:30 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-26-richard.henderson@linaro.org>
	<CAFEAcA9=_kCGqv8Ck6Ttg=wEotYdTj7VYcs_w09+3D=7k5pARA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87933402-2722-157a-9509-523123f336c6@linaro.org>
Date: Fri, 23 Feb 2018 09:31:27 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=_kCGqv8Ck6Ttg=wEotYdTj7VYcs_w09+3D=7k5pARA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 25/67] target/arm: Implement SVE Integer
 Wide Immediate - Predicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 06:18 AM, Peter Maydell wrote:
>> +    mm = (mm & 0xff) * (-1ull / 0xff);
> 
> What is this expression doing? I guess from context that it's
> replicating the low 8 bits of mm across the 64-bit value,
> but this is too obscure to do without a comment or wrapping
> it in a helper function with a useful name, I think.

I do have a helper now -- dup_const.  I thought I'd converted all of the uses,
but clearly missed one/some.


r~
