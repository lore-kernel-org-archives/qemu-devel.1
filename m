Received: from eggs.gnu.org ([2001:4830:134:3::10]:42151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYkRq-0006I3-7s
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYkRn-0006wr-74
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:51:50 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYkRm-0006vv-VY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:51:47 -0400
Received: by mail-pf0-x244.google.com with SMTP id s21-v6so3568637pfm.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:51:46 -0700 (PDT)
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-6-richard.henderson@linaro.org>
	<fe8cd74b-e9b3-06cd-48c2-b3daeedcb869@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74f4cdb0-8cc0-2089-bbfa-bc2c1888d9c7@linaro.org>
Date: Thu, 28 Jun 2018 20:51:42 -0700
MIME-Version: 1.0
In-Reply-To: <fe8cd74b-e9b3-06cd-48c2-b3daeedcb869@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/arm: Add ID_ISAR6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 06/28/2018 05:57 PM, Philippe Mathieu-Daudé wrote:
>> @@ -4851,11 +4851,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
>>                .access = PL1_R, .type = ARM_CP_CONST,
>>                .resetvalue = cpu->id_mmfr4 },
>> -            /* 7 is as yet unallocated and must RAZ */
>> -            { .name = "ID_ISAR7_RESERVED", .state = ARM_CP_STATE_BOTH,
> 
> You added this in
> 
>     if (arm_feature(env, ARM_FEATURE_V6)) {
> 
> Shouldn't this stay same and a new entry added later in
> 
>     if (arm_feature(env, ARM_FEATURE_V8)) {
> 
> ?
> 
>> +            { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
> 
> If added under ARM_FEATURE_V8, shouldn't this be ARM_CP_STATE_AA32?

You'll notice that I'm replacing an entry that
was previously marked "reserved".

I'm not going to second-guess that.


r~
