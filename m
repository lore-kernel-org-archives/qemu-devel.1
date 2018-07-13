Received: from eggs.gnu.org ([2001:4830:134:3::10]:36521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdxX4-0006Vq-E3
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdxX3-0004Sm-Ia
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:50:46 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdxX3-0004QW-DI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:50:45 -0400
Received: by mail-oi0-x244.google.com with SMTP id w126-v6so61970636oie.7
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:50:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8a05e6cb-dd76-58c4-8069-956b3e95161d@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
	<20180702160546.31969-5-richard.henderson@linaro.org>
	<CAFEAcA8qtHmWt9Zhnhqcc6J-hgbxucq-gU1V5=uZa727kqKSvg@mail.gmail.com>
	<8a05e6cb-dd76-58c4-8069-956b3e95161d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 13:50:23 +0100
Message-ID: <CAFEAcA_U9qhTZayGS9W56H+1MmM3wfVj4r1K1vSV11pLKFAp3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/6] accel/tcg: Don't treat invalid TLB
 entries as needing recheck
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 July 2018 at 13:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 07/13/2018 06:05 AM, Peter Maydell wrote:
>>> -    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
>>> +    if (unlikely((env->tlb_table[mmu_idx][index].addr_code &
>>> +                  (TLB_RECHECK | TLB_INVALID_MASK)) == TLB_RECHECK)) {
>>>          /*
>>>           * This is a TLB_RECHECK access, where the MMU protection
>>>           * covers a smaller range than a target page, and we must
>>
>> Looking again at this code, I think that now we have the code to
>> ensure that there's only ever one entry in the TLB/victim TLB for
>> a given guest address...
>
> Which probably wasn't the case the first time you wrote this, no?
> Fixing that single entry condition was just a few weeks ago.

Yes, exactly.

OTOH with Laurent's m68k test case I'm finding that the assert
is firing, and I'm not entirely sure why yet...

thanks
-- PMM
