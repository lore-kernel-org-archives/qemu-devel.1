Received: from eggs.gnu.org ([2001:4830:134:3::10]:41859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhEp-00024H-D8
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhEm-0004bU-CB
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:57:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-2-git-send-email-alindsay@codeaurora.org>
	<aeacd6da-0f45-f871-9a0a-2c8a524db510@amsat.org>
Message-ID: <d8f5d183-dfd4-c63a-999a-d336dcd352b6@amsat.org>
Date: Sun, 18 Mar 2018 23:57:09 +0100
MIME-Version: 1.0
In-Reply-To: <aeacd6da-0f45-f871-9a0a-2c8a524db510@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 01/22] target/arm: A53:
 Initialize PMCEID[01]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-arm@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 03/18/2018 11:35 PM, Philippe Mathieu-Daudé wrote:
> Hi Aaron,
> 
> On 03/16/2018 09:30 PM, Aaron Lindsay wrote:
>> A53 advertises ARM_FEATURE_PMU, but wasn't initializing pmceid[01].
>> pmceid[01] are already being initialized to zero for both A15 and A57.
>>
>> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
>> ---
>>  target/arm/cpu64.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 991d764..8c4db31 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -201,6 +201,8 @@ static void aarch64_a53_initfn(Object *obj)
>>      cpu->id_isar5 = 0x00011121;
>>      cpu->id_aa64pfr0 = 0x00002222;
>>      cpu->id_aa64dfr0 = 0x10305106;
>> +    cpu->pmceid0 = 0x00000000;
>> +    cpu->pmceid1 = 0x00000000;
>>      cpu->id_aa64isar0 = 0x00011120;
>>      cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
>>      cpu->dbgdidr = 0x3516d000;
>>
> 
> Maybe we can move this at a single place in arm_cpu_post_init():

Err, arm_cpu_reset() :)

> 
>     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>         cpu->pmceid0 = 0x00000000;
>         cpu->pmceid1 = 0x00000000;
>     }
> 
> Regards,
> 
> Phil.
> 
