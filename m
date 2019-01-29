Received: from eggs.gnu.org ([209.51.188.92]:40840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goU1I-0005TP-5F
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goU1H-0000lo-AP
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:05:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goU1H-0000hr-4C
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:05:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id v6so16218960oif.2
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:05:31 -0800 (PST)
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-7-richard.henderson@linaro.org>
	<CAFEAcA_cvfL2Sja4WawDAR++Ak85yKo7J=Xy4hzO_ChiFt7mZw@mail.gmail.com>
	<b4e20937-dbf0-1e26-8426-dcea14874833@linaro.org>
	<CAFEAcA9WGH8O1CQfe_HAQT3w3P7p_aRW=hE0b1TN-UNF011cWw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9717bb4f-e253-fe4e-ca72-7e59f162e844@linaro.org>
Date: Tue, 29 Jan 2019 06:05:27 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9WGH8O1CQfe_HAQT3w3P7p_aRW=hE0b1TN-UNF011cWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/11] target/arm: Reset btype for direct
 branches and syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/29/19 1:57 AM, Peter Maydell wrote:
>>> The advantage of picking the other choice (SPSR_ELx.BTYPE ==
>>> PSTATE.BTYPE) is that it means that the behaviour is identical
>>> for all exceptions (async or sync of any type) and we don't
>>> do the work of clearing the BTYPE field (which will happen
>>> potentially in "normal" guest code if we're not in a guarded page,
>>> I think).
>>
>> Well, BTYPE is in the TB flags, so we know it's already zero in that case, so
>> there's no extra work.
> 
> It's not zero if we just did a BR Xn to get to this SVC insn, is it?

I guess I misunderstood what you meant by "extra" work.
It's not "extra" if btype is known to not be zero...

Anyway, in v2 the clearing of btype happens in cpu_loop,
more like what the kernel would have to do.


r~
