Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAJs-0003F9-Dh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnAJp-00023k-8q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:14:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-3-f4bug@amsat.org>
	<db19cb55-ab00-d889-521c-836d0f7e6464@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb46e788-e2e9-24b2-365e-b0f55fc5ff56@amsat.org>
Date: Wed, 30 Aug 2017 18:14:33 -0300
MIME-Version: 1.0
In-Reply-To: <db19cb55-ab00-d889-521c-836d0f7e6464@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/47] MAINTAINERS: add missing ARM entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 07/28/2017 03:55 AM, Thomas Huth wrote:
> On 28.07.2017 07:35, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   MAINTAINERS | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 972118e70b..795f89f709 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -120,6 +120,8 @@ F: include/hw/cpu/a*mpcore.h
>>   F: disas/arm.c
>>   F: disas/arm-a64.cc
>>   F: disas/libvixl/
>> +F: default-configs/arm-softmmu.mak
>> +F: default-configs/aarch64-softmmu.mak
> 
> You've added this to the TCG CPU core section, but strictly speaking
> these files are also used for the machine emulation in general (and also
> for KVM). So not sure whether this is a good fit here ... up to Peter to
> decide.

You are right.

> 
>>   CRIS
>>   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>> @@ -380,6 +382,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>>   L: qemu-arm@nongnu.org
>>   S: Maintained
>>   F: hw/char/pl011.c
>> +F: include/hw/char/pl011.h
>>   F: hw/display/pl110*
>>   F: hw/dma/pl080.c
>>   F: hw/dma/pl330.c
>> @@ -402,14 +405,19 @@ F: hw/intc/arm*
>>   F: hw/intc/gic_internal.h
>>   F: hw/misc/a9scu.c
>>   F: hw/misc/arm11scu.c
>> +F: hw/misc/arm_sysctl.c
> 
> According to a comment in that file, it is about RealView/Versatile
> boards instead, so this is the wrong section here?

Wrong section indeed.

> 
>>   F: hw/timer/a9gtimer*
>>   F: hw/timer/arm_*
>> +F: hw/timer/armv7m_systick.c
> 
> How about rather removing the underscore in the previous wildcard entry?

I also wondered, because I'm a slowly working branch where I try to boot 
some Marvell SoC, and I named the timer "armada_timer.c" following the 
Linux device-tree naming:

https://www.kernel.org/doc/Documentation/devicetree/bindings/timer/marvell%2Carmada-370-xp-timer.txt

But if I ever finish it I can add an exclude entry, so I'll follow your 
advice.

> 
>>   F: include/hw/arm/arm.h
>> +F: include/hw/arm/armv7m*.h
>>   F: include/hw/intc/arm*
>>   F: include/hw/misc/a9scu.h
>>   F: include/hw/misc/arm11scu.h
>>   F: include/hw/timer/a9gtimer.h
>>   F: include/hw/timer/arm_mptimer.h
>> +F: include/hw/timer/armv7m_systick.h
>> +F: tests/test-arm-mptimer.c
>>   
>>   Exynos
>>   M: Igor Mitsyanko <i.mitsyanko@gmail.com>
>>
> 
>   Thomas
> 
