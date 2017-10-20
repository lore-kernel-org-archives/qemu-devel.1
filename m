Received: from eggs.gnu.org ([2001:4830:134:3::10]:47258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e5Y7k-0001zW-Iz
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e5Y7g-00066L-AA
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:18:08 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:52730
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e5Y7f-00065h-RJ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:18:04 -0400
References: <1508417443-31849-1-git-send-email-gabriel291075@gmail.com>
	<CAFEAcA8dSSQgQAKN0GsOZPWDxhRL0zjDQ+QN=uSRh6hLB=1wCg@mail.gmail.com>
	<CAG+oHk_Zw0CdEphX0bVeyBbyWEBLqh8tBad6R-sP5gW11ni__w@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <8f0e9570-75d8-581c-3f3a-a584c6f6af2d@adacore.com>
Date: Fri, 20 Oct 2017 16:17:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAG+oHk_Zw0CdEphX0bVeyBbyWEBLqh8tBad6R-sP5gW11ni__w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] arm: Adding new arm machine,
 Kinetis K64 MK64FN1M0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gabriel Costa <gabriel291075@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



On 10/20/2017 04:01 PM, Gabriel Costa wrote:
> Thanks for your fast response and tips. This is my first time sending
> patchs!
> 
> Yes, I will follow the QEmu struct. I saw what other developers done
> (stm32f2xx) and I put the files in following folders:
> hw/arm/mk64fn1m0.c                 This file define the SoC
> hw/char/kinetis_k64_uart.c         UART peripheral
> hw/misc/kinetis_k64_flextimer.c  Timers peripherals

I'd say hw/timer/kinetis_k64_flextimer.c here.

Fred

> hw/misc/kinetis_k64_mcg.c        Clock Manager
> hw/misc/kinetis_k64_pmux.c      MUX selector
> hw/misc/kinetis_k64_sim.c         More Clock selection
> that is ok?
> 
> I will solve the code style issues and prepare a new patch series.
> Also, I received an error about a build fail (among others, of course), I
> believe that this happened because the first patch was not applied.
> 
> Regards to all,
> 
> Gabriel Costa
> 
> On Thu, Oct 19, 2017 at 1:02 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> 
>> On 19 October 2017 at 13:50,  <gabriel291075@gmail.com> wrote:
>>> From: Gabriel Augusto Costa <gabriel291075@gmail.com>
>>>
>>> I add a new arm machine with some peripherals. The machine is mk64fn1m0,
>> a
>>> cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
>>> simple arm binary file using UART0 in polling mode.
>>> I prepared two patchs to include this machine:
>>> PATCH v1: Include the machine and peripherals devices;
>>> PATCH v2: Change the make file to compile this machine.
>>
>> Thanks for these patches.
>>
>>> Also, I made a folder tree to accomodate this machine more or less like
>> u-boot.
>>> In my opinion put all files in the same folder "/hw/arm" is not a good
>> idea,
>>> or put all code in an unique file, because machines from the same family
>>> sharing the same peripherals.
>>> The folder tree struct is machine/family/peripheral, as an example:
>>> kinetis/k64/peripheral.
>>> So, in this way the code will be more maintainable.
>>
>> There's an inevitable conflict between:
>>   * these peripherals are all for this board so they should go
>>     in a subdirectory for these boards
>>   * these peripherals are all of the same type so they should
>>     go in a subdirectory for devices of that type
>> Whichever way you slice things it will split things that in
>> some sense should go together.
>>
>> However, QEMU has made a decision that we put devices of a
>> specific type in the same directory (roughly following what
>> the Linux kernel does). So can you please follow the structure
>> we have? Having a mix of the two schemes is much worse than
>> consistently following either.
>>
>>> Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
>>> ---
>>>   hw/arm/kinetis/k64/mk64fn1m0.c                    | 170 +++++++++
>>>   hw/arm/kinetis/k64/peripheral/flextimer.c         | 139 +++++++
>>>   hw/arm/kinetis/k64/peripheral/mcg.c               | 225 ++++++++++++
>>>   hw/arm/kinetis/k64/peripheral/pmux.c              | 423
>> ++++++++++++++++++++++
>>>   hw/arm/kinetis/k64/peripheral/sim.c               | 292 +++++++++++++++
>>>   hw/arm/kinetis/k64/peripheral/uart.c              | 369
>> +++++++++++++++++++
>>>   include/hw/arm/kinetis/k64/peripheral/flextimer.h |  62 ++++
>>>   include/hw/arm/kinetis/k64/peripheral/mcg.h       |  47 +++
>>>   include/hw/arm/kinetis/k64/peripheral/pmux.h      |  73 ++++
>>>   include/hw/arm/kinetis/k64/peripheral/sim.h       |  56 +++
>>>   include/hw/arm/kinetis/k64/peripheral/uart.h      |  85 +++++
>>>   11 files changed, 1941 insertions(+)
>>
>> This patch is much too large to review. Please can you split it up
>> into a number of smaller logical patchsets? (Usually for a new
>> board and SoC one patch per new device is what makes most sense.
>> If you get much over 250 lines in one patch you should consider
>> whether there's a logical split of it possible.)
>>
>> https://wiki.qemu.org/Contribute/SubmitAPatch has some other
>> helpful suggestions for patch submissions and is generally
>> worth reading I think.
>>
>> If you could structure your next revision of this series to
>> include a cover letter email that would also be helpful;
>> some of our automatic patch handling tools can't deal with
>> multi-patch series that don't have the cover letter.
>>
>> thanks
>> -- PMM
>>
