Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1db8fR-0000it-De
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1db8fN-0002R0-DP
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:03:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
	<1501153150-19984-4-git-send-email-peter.maydell@linaro.org>
	<5aff6da7-4ad1-64af-6445-98b8d7520b4c@amsat.org>
	<122bfaa5-7192-056b-541c-b5f37f871bfc@amsat.org>
	<CAFEAcA-D4puOE5qPOGEd9mEdQFVqpA16997ZmHf4C5Nq_gEnAg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <22d5a43a-53fe-27df-656b-d17fc187e404@amsat.org>
Date: Fri, 28 Jul 2017 14:03:05 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-D4puOE5qPOGEd9mEdQFVqpA16997ZmHf4C5Nq_gEnAg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 07/28/2017 05:42 AM, Peter Maydell wrote:
> On 27 July 2017 at 23:58, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 07/27/2017 07:43 PM, Philippe Mathieu-Daudé wrote:
>>>
>>> On 07/27/2017 07:59 AM, Peter Maydell wrote:
>>
>> [...]
>>>>
>>>> -    u32p += env->cp15.c6_rgnr;
>>>> +    u32p += env->pmsav7.rnr;
>>>>        tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
>>>>        *u32p = value;
>>>>    }
>>>> @@ -2447,7 +2447,7 @@ static const ARMCPRegInfo pmsav7_cp_reginfo[] = {
>>>>          .readfn = pmsav7_read, .writefn = pmsav7_write, .resetfn =
>>>> pmsav7_reset },
>>>>        { .name = "RGNR", .cp = 15, .crn = 6, .opc1 = 0, .crm = 2, .opc2 =
>>>> 0,
>>>
>>>
>>> "RGNR" -> "RNR"
>>
>>
>> Ah "RGNR" for -R and "RNR" for -M hmmm... still better keep the name
>> matching the field, "rnr".
> 
> It's a bit awkward, yes -- we're going to get a mismatch one way
> or the other.
> 
> In this patch I wanted only to change the field name, not
> anything else (it's already a bit borderline for 2.10).

Fine by me for what's worth. So either ways:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> thanks
> -- PMM
> 
