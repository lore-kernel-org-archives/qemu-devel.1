Received: from eggs.gnu.org ([2001:4830:134:3::10]:53153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f6ToN-0002mp-T5
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 00:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f6ToM-00018e-D4
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 00:26:15 -0400
MIME-Version: 1.0
In-Reply-To: <CAHP4M8UESYxeJOd5Y+Hj1K26QUb2D1UJJoBTh9SYCsvuwBP95w@mail.gmail.com>
References: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
	<87efjov999.fsf@linaro.org>
	<CAHP4M8W-WuBmJUdb6LGR1t3tPayrnaS+b1ZZ1zew71aM==-imA@mail.gmail.com>
	<87d0z8v78e.fsf@linaro.org>
	<CAHP4M8VSzm4L6oS06J-e93FwjuHM=weJf2MegCaDNH8MPbsqgA@mail.gmail.com>
	<CAFEAcA91iNyUnahri9EdL7Th1Q9v44765z0OJexxMrNUD_DXEQ@mail.gmail.com>
	<CAHP4M8ViS=O4R+sMmR=CmkbgQtwd8RHGxLwNb5m_aMS_M++f6A@mail.gmail.com>
	<CAFEAcA8xG_GrVL5zgZqN26OQGj0UHWFNZ9xWEmHJyaiUFZLH8Q@mail.gmail.com>
	<CAHP4M8WEuR5JJTV_KggwJok0Pzbu8=4BifLuFOjhv3T9hfjUUg@mail.gmail.com>
	<CAHP4M8UESYxeJOd5Y+Hj1K26QUb2D1UJJoBTh9SYCsvuwBP95w@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Thu, 12 Apr 2018 09:56:08 +0530
Message-ID: <CAHP4M8V_NBFS9T_+TQzAPgw56n9THk-phqUiLuRw6DJRn+UQAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] Crash when running hello-world
 unikernel for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, rumpkernel-users@freelists.org, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Actually just realised that qemu does support integratorcp as one of
the supported-boards.

Unfortunately, when I use
          qemu-system-arm -machine integratorcp -nographic -kernel helloer.bin
the shell just hangs :(


Following are the details when run through gdb :

##########################################################################
GNU gdb (Debian 7.7.1+dfsg-5) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "arm-linux-gnueabihf".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from qemu-system-arm...(no debugging symbols found)...done.
(gdb) r
Starting program: /usr/bin/qemu-system-arm -machine integratorcp
-nographic -kernel helloer.bin
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/arm-linux-gnueabihf/libthread_db.so.1".
[New Thread 0xb388f290 (LWP 596)]

Program received signal SIGUSR1, User defined signal 1.
[Switching to Thread 0xb388f290 (LWP 596)]
memset () at ../ports/sysdeps/arm/memset.S:50
50    ../ports/sysdeps/arm/memset.S: No such file or directory.
(gdb) bt
#0  memset () at ../ports/sysdeps/arm/memset.S:50
#1  0xb65e1c6c in ?? () from /lib/arm-linux-gnueabihf/libglib-2.0.so.0
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb)
##########################################################################

On Wed, Apr 11, 2018 at 12:49 PM, Ajay Garg <ajaygargnsit@gmail.com> wrote:
> Hi All.
>
> Just wondering if there is something specific that needs to changed at
> https://github.com/rumpkernel/rumprun/tree/master/platform/hw/arch/arm/integrator
> in order to get a hello-world app run on "virt" machine?
>
> If so, I would request the rumprun-guys to kindly throw in some light,
> on what needs to be done in order to have something run on a "virt"
> machine in qemu-context.
>
>
> Thanks and Regards,
> Ajay
>
> On Tue, Apr 10, 2018 at 3:49 PM, Ajay Garg <ajaygargnsit@gmail.com> wrote:
>> Thanks Peter .. my sincere gratitude.
>> You pin-pointed the real issue ..
>>
>>
>>
>> On Tue, Apr 10, 2018 at 2:50 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 10 April 2018 at 09:16, Ajay Garg <ajaygargnsit@gmail.com> wrote:
>>>> On Tue, Apr 10, 2018 at 1:08 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>> What hardware (what CPU, board, etc) is this "rumprun" software
>>>>> expecting to run on?
>>>>
>>>> Yep, just to ensure that there are no cross-compiling issues, I am
>>>> building rumprun on the pseudo-real hardware itself.
>>>> In our case, the pseudo-real hardware are :
>>>>
>>>> a)
>>>> An ARM32 "virt" hardware/machine in a qemu environment
>>>> (https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemus-32-bit-arm-virt-board/)
>>>>
>>>> Once I start  this machine, all environment is arm32, and I compile
>>>> rumprun within this environemnt without any cross-compiling.
>>>>
>>>> b)
>>>> A beaglebone-green-wireless.
>>>> This is a arm32 machine bottoms-up, so no question of cross-compiling
>>>> whatsoever here :)
>>>>
>>>> In both cases, I then use qemu-system-arm (on the "virt" machine, and
>>>> beaglebone-green-wireless itself).
>>>
>>> That's telling me what setups you're trying to compile in,
>>> which doesn't correspond necessarily to what the guest
>>> OS is built to run on.
>>>
>>>> One query : It is apparent that there is nested qemu-virtualization in
>>>> step a), could that be an issue?
>>>
>>> Why are you running this in a nested setup? I don't understand
>>> the purpose of doing that. It would be simpler and faster to
>>> just run the guest on a QEMU running in your native host system.
>>>
>>> Assuming this is the source for the guest you're trying to run:
>>>
>>> https://github.com/rumpkernel/rumprun/tree/master/platform/hw/arch
>>>
>>> that suggests that the only Arm board it supports is "integrator"
>>> (which is an absolutely ancient devboard with very little memory,
>>> no PCI and no virtio support). You need to confirm what Arm hardware
>>> this 'rumpkernel' is actually intended to run on, and then give QEMU
>>> the right command line arguments to emulate that hardware. I can't
>>> really help any further, I'm afraid -- you need somebody who knows
>>> about this guest OS.
>>>
>>> thanks
>>> -- PMM
>>
>>
>>
>> --
>> Regards,
>> Ajay
>
>
>
> --
> Regards,
> Ajay



-- 
Regards,
Ajay
