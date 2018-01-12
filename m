Received: from eggs.gnu.org ([2001:4830:134:3::10]:46561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4MK-0007VJ-Hu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4MF-0000r4-NB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:47:20 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:37643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea4MF-0000q9-HP
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:47:15 -0500
Received: by mail-pf0-x231.google.com with SMTP id p1so5022852pfh.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:47:15 -0800 (PST)
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-6-richard.henderson@linaro.org>
	<CAFEAcA-e0unT9rx9L0mqCbOwCREDg+-FifKL-mwusNZSRv_Vpg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7965ec06-120d-e872-3fd1-fd824bb4c862@linaro.org>
Date: Fri, 12 Jan 2018 10:47:11 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-e0unT9rx9L0mqCbOwCREDg+-FifKL-mwusNZSRv_Vpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Add
 aa32_vfp_dreg/aa64_vfp_qreg helpers
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

On 01/12/2018 10:44 AM, Peter Maydell wrote:
>>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>>          nregs += 16;
>>          if (reg < nregs) {
>> -            env->vfp.regs[(reg - 32) * 2] = ldfq_le_p(buf);
>> -            env->vfp.regs[(reg - 32) * 2 + 1] = ldfq_le_p(buf + 8);
>> +            uint64_t *q = aa32_vfp_dreg(env, (reg - 32) * 2);
>> +            q[0] = ldfq_le_p(buf);
>> +            q[1] = ldfq_le_p(buf + 8);
>>              return 16;
>>          }
>>      }
> 
> After reading patch 7 I came back to this one. I wonder if these two
> (which I think are the only ones) justify an aa32_vfp_qreg() ?

That does sound like a nice cleanup.  I'll include that next round.


r~
