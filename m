Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1darjw-0007Le-4D
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1darjt-0002C3-GD
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 18:58:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
	<1501153150-19984-4-git-send-email-peter.maydell@linaro.org>
	<5aff6da7-4ad1-64af-6445-98b8d7520b4c@amsat.org>
Message-ID: <122bfaa5-7192-056b-541c-b5f37f871bfc@amsat.org>
Date: Thu, 27 Jul 2017 19:58:36 -0300
MIME-Version: 1.0
In-Reply-To: <5aff6da7-4ad1-64af-6445-98b8d7520b4c@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.10 3/5] target/arm: Rename
 cp15.c6_rgnr to pmsav7.rnr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 07/27/2017 07:43 PM, Philippe Mathieu-Daudé wrote:
> On 07/27/2017 07:59 AM, Peter Maydell wrote:
[...]
>> -    u32p += env->cp15.c6_rgnr;
>> +    u32p += env->pmsav7.rnr;
>>       tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
>>       *u32p = value;
>>   }
>> @@ -2447,7 +2447,7 @@ static const ARMCPRegInfo pmsav7_cp_reginfo[] = {
>>         .readfn = pmsav7_read, .writefn = pmsav7_write, .resetfn = 
>> pmsav7_reset },
>>       { .name = "RGNR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 2, .opc2 
>> = 0,
> 
> "RGNR" -> "RNR"

Ah "RGNR" for -R and "RNR" for -M hmmm... still better keep the name 
matching the field, "rnr".

> 
>>         .access = PL1_RW,
>> -      .fieldoffset = offsetof(CPUARMState, cp15.c6_rgnr),
>> +      .fieldoffset = offsetof(CPUARMState, pmsav7.rnr),
>>         .writefn = pmsav7_rgnr_write },
> 
> pmsav7_rnr_write
> 
>>       REGINFO_SENTINEL
>>   };
>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 1a40469..93c1a78 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -151,7 +151,7 @@ static bool pmsav7_rgnr_vmstate_validate(void 
>> *opaque, int version_id)
> 
> pmsav7_rnr_vmstate_validate()
> 
>>   {
>>       ARMCPU *cpu = opaque;
>> -    return cpu->env.cp15.c6_rgnr < cpu->pmsav7_dregion;
>> +    return cpu->env.pmsav7.rnr < cpu->pmsav7_dregion;
>>   }
>>   static const VMStateDescription vmstate_pmsav7 = {
>>
> [...]
>          VMSTATE_VALIDATE("rgnr is valid", pmsav7_rgnr_vmstate_validate),
> 
> also this one "rnr is valid" ^^^
> 
> once fixed:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
