Received: from eggs.gnu.org ([2001:4830:134:3::10]:34293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ef9Hy-0001sv-KO
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ef9Hv-0002ax-IW
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:03:50 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:38362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ef9Hv-0002aV-AX
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:03:47 -0500
Received: by mail-pf0-x235.google.com with SMTP id k19so860105pfj.5
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 11:03:47 -0800 (PST)
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-10-richard.henderson@linaro.org>
	<CAFEAcA9Dmdh+u7AZHhjEkS3zc6i4yf+Eo1-NuksgVdo1cqmKFQ@mail.gmail.com>
	<707306d7-8ee4-ab6b-2154-290647a72779@linaro.org>
	<CAFEAcA9PGHMPeATRHESeUEWaU17OpVw99p-+U9KzOPaitSgEGQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <161aba52-a937-2481-23a5-0bd2d589e23e@linaro.org>
Date: Fri, 26 Jan 2018 11:03:43 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PGHMPeATRHESeUEWaU17OpVw99p-+U9KzOPaitSgEGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] target/arm: Decode aa64 armv8.3
 fcmla
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

On 01/26/2018 02:07 AM, Peter Maydell wrote:
>> The SVE pseudocode for the same operation is clearer than that in the main ARM
>> ARM, and is nearer to what I used:
>>
>>   for e = 0 to elements-1
>>     if ElemP[mask, e, esize] == '1' then
>>         pair = e - (e MOD 2);  // index of first element in pair
>>         addend = Elem[result, e, esize];
>>         if IsEven(e) then  // real part
>>             // realD = realA [+-] flip ? (imagN * imagM) : (realN * realM)
>>             element1 = Elem[operand1, pair + flip, esize];
>>             element2 = Elem[operand2, pair + flip, esize];
>>             if neg_real then element2 = FPNeg(element2);
>>         else  // imaginary part
>>             // imagD = imagA [+-] flip ? (imagN * realM) : (realN * imagM)
>>             element1 = Elem[operand1, pair + flip, esize];
>>             element2 = Elem[operand2, pair + (1 - flip), esize];
>>             if neg_imag then element2 = FPNeg(element2);
>>         Elem[result, e, esize] = FPMulAdd(addend, element1, element2, FPCR);
>>
>> In my version, e0/e1 are element1/element2 (real) and e2/e3 are
>> element1/element2 (imag).
> 
> Thanks. Could we use the same indexing (1/2/3/4) as the final Arm ARM
> pseudocode?

Done.


r~
