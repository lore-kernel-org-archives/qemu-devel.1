Received: from eggs.gnu.org ([2001:4830:134:3::10]:45585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiaM-00045X-IF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiaJ-0006wa-Dp
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:32:22 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZiaJ-0006wA-6b
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:32:19 -0500
Received: by mail-pg0-x241.google.com with SMTP id j2so2864922pgv.3
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:32:19 -0800 (PST)
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-10-richard.henderson@linaro.org>
	<CAFEAcA_DQwQzUS8Fce7zV=f+eo-MrFuh02fyT_OxKcPEVWh58g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8751b945-ad1b-b2a2-bb93-0769d6160aaf@linaro.org>
Date: Thu, 11 Jan 2018 11:32:15 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_DQwQzUS8Fce7zV=f+eo-MrFuh02fyT_OxKcPEVWh58g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 9/9] target/arm: Add ARM_FEATURE_SVE
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

On 01/11/2018 10:42 AM, Peter Maydell wrote:
> On 18 December 2017 at 17:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Enable it for the "any" CPU used by aarch64-linux-user.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h   | 1 +
>>  target/arm/cpu64.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 37b8cef2e2..652e00d957 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1386,6 +1386,7 @@ enum arm_features {
>>      ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
>>      ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>>      ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
>> +    ARM_FEATURE_SVE, /* has SVE extension */
>>  };
>>
>>  static inline int arm_feature(CPUARMState *env, int feature)
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 43b42f95fd..366ab2eeee 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -229,6 +229,7 @@ static void aarch64_any_initfn(Object *obj)
>>      set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
>>      set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>>      set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>> +    set_feature(&cpu->env, ARM_FEATURE_SVE);
>>      cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
>>      cpu->dcz_blocksize = 7; /*  512 bytes */
>>  }
> 
> We shouldn't turn this on until it actually works, I think.

Yes, probably.  One of those things where you need it on early for development
but for final commit you need to sort the fragment to the end.


r~
