Received: from eggs.gnu.org ([2001:4830:134:3::10]:52291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb96H-0001G4-0P
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb96D-0005xY-TR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:03:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb96D-0005x4-Nb
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:03:09 -0500
Received: by mail-pg0-x242.google.com with SMTP id i196so8315888pgd.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:03:09 -0800 (PST)
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-8-richard.henderson@linaro.org>
	<CAFEAcA-NAGcEba2ik__xirZxrtbNw4wsiWDtiqsLfLdG4jyKpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a0be836-f3f9-69dc-6b19-859317f869fc@linaro.org>
Date: Mon, 15 Jan 2018 10:03:05 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-NAGcEba2ik__xirZxrtbNw4wsiWDtiqsLfLdG4jyKpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/11] target/arm: Add
 ARM_FEATURE_V8_FCMA
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

On 01/15/2018 09:53 AM, Peter Maydell wrote:
> On 18 December 2017 at 17:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Enable it for the "any" CPU used by *-linux-user.
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h     | 1 +
>>  linux-user/elfload.c | 1 +
>>  target/arm/cpu.c     | 1 +
>>  target/arm/cpu64.c   | 1 +
>>  4 files changed, 4 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index e047756b80..7a705a09a1 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1353,6 +1353,7 @@ enum arm_features {
>>      ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
>>      ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
>>      ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>> +    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
> 
> This is a bit inconsistent. If we're going with the architectural
> feature names this is "ARMv8.3-CompNum", so ARM_FEATURE_V8_3_COMPNUM.
> If we're going with the ID_AA64ISARn_EL1 field names then
> ARM_FEATURE_V8_1_SIMD should be ARM_FEATURE_V8_RDM...

You preferred ASIMDRDM earlier.  Does this mean you prefer V8_RDM?

I hadn't noticed I was being inconsistent as to whence I drew my names.  Gimme
your preferred names and I'll use 'em.


r~
