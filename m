Received: from eggs.gnu.org ([2001:4830:134:3::10]:47777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4PT-0001pe-BW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4PO-0004Zn-G0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:50:35 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:40691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea4PO-0004ZR-AS
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:50:30 -0500
Received: by mail-pg0-x233.google.com with SMTP id q12so5114618pgt.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:50:30 -0800 (PST)
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-8-richard.henderson@linaro.org>
	<CAFEAcA-kbZRaGoERUG7iZGsO3hswC=ityDWf4n2fwXsSwO7jCw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5dbbbf33-c60e-7e37-1335-86bfe0144947@linaro.org>
Date: Fri, 12 Jan 2018 10:50:26 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kbZRaGoERUG7iZGsO3hswC=ityDWf4n2fwXsSwO7jCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] target/arm: Expand vector registers
 for SVE
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

On 01/12/2018 10:38 AM, Peter Maydell wrote:
>> -        long ofs = offsetof(CPUARMState, vfp.regs[reg >> 1]);
>> +        long r = offsetof(CPUARMState, vfp.zregs[reg >> 2].d[(reg >> 1) & 1]);
>>          if (reg & 1) {
>> -            ofs += offsetof(CPU_DoubleU, l.upper);
>> +            return r + offsetof(CPU_DoubleU, l.upper);
>>          } else {
>> -            ofs += offsetof(CPU_DoubleU, l.lower);
>> +            return r + offsetof(CPU_DoubleU, l.lower);
>>          }
>> -        return ofs;
> ...I see we're tweaking the logic on this code again. I was
> expecting that the changes in the previous patch would have turned
> out to be in support of just having to do a one-line change in this
> one, but apparently not ?
> 

I don't know why I changed my mind about where the return would go.  It should
have just been the one line change...

r~
