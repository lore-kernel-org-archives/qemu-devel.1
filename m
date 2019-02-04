Received: from eggs.gnu.org ([209.51.188.92]:46434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqc4S-0008IU-2G
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqc4Q-0007Vo-40
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:05:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqc4E-00074U-4X
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:05:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so12602881wmc.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:05:24 -0800 (PST)
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-2-philmd@redhat.com>
	<162915fe-ef7f-c977-2fd2-985406b465d1@redhat.com>
	<54a0c271-c499-eeea-7344-68f68c010f7b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aaee9b37-72b7-7c9b-9b79-e1cc1590b07a@redhat.com>
Date: Mon, 4 Feb 2019 12:05:16 +0100
MIME-Version: 1.0
In-Reply-To: <54a0c271-c499-eeea-7344-68f68c010f7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] mips: Express dependencies of the
 MIPSsim machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Thomas,

On 2/4/19 9:36 AM, Thomas Huth wrote:
> On 2019-02-04 09:31, Thomas Huth wrote:
>> On 2019-02-03 23:07, Philippe Mathieu-Daudé wrote:
>>> The MIPSsim machine only emulates an 8250 UART and a simple network
>>> controller, connected via an ISA bus.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  default-configs/mips-softmmu-common.mak | 2 --
>>>  hw/mips/Kconfig                         | 3 +++
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>>> index 0795d522db..aa73a4a822 100644
>>> --- a/default-configs/mips-softmmu-common.mak
>>> +++ b/default-configs/mips-softmmu-common.mak
>>> @@ -26,7 +26,6 @@ CONFIG_PIIX4=y
>>>  CONFIG_IDE_ISA=y
>>>  CONFIG_IDE_PIIX=y
>>>  CONFIG_NE2000_ISA=y
>>> -CONFIG_MIPSNET=y
>>>  CONFIG_PFLASH_CFI01=y
>>>  CONFIG_I8259=y
>>>  CONFIG_MC146818RTC=y
>>> @@ -35,7 +34,6 @@ CONFIG_MIPS_CPS=y
>>>  CONFIG_MIPS_ITU=y
>>>  CONFIG_R4K=y
>>>  CONFIG_MALTA=y
>>> -CONFIG_MIPSSIM=y
>>>  CONFIG_ACPI_SMBUS=y
>>>  CONFIG_SMBUS_EEPROM=y
>>>  CONFIG_TEST_DEVICES=y
>>> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>>> index cdc07e59b6..3433e97e1a 100644
>>> --- a/hw/mips/Kconfig
>>> +++ b/hw/mips/Kconfig
>>> @@ -6,6 +6,9 @@ config MALTA
>>>  
>>>  config MIPSSIM
>>>      bool
>>> +    select ISA_BUS
>>> +    select SERIAL_ISA
>>> +    select MIPSNET
>>>  
>>>  config JAZZ
>>>      bool
>>>
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Scratch that. I think you have to keep CONFIG_MIPSSIM=y enabled in the
> default-configs, don't you?

I guess I misunderstood --without-default-devices with --no-defaults,
where you'd manually select the machines you want.

Thanks for the review!

Phil.
