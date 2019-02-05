Received: from eggs.gnu.org ([209.51.188.92]:55933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gr3qx-0004iq-85
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gr3qv-0001GD-7c
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:45:43 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38416
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gr3qt-0001CG-4n
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:45:41 -0500
References: <20190103154810.GB32032@Red>
	<3a375dc6-f0ba-c3f0-6e86-2fd5cdf3ee35@ilande.co.uk>
	<8c302745-5097-afed-5c7e-9a992da03cf6@ilande.co.uk>
	<20190205091115.GA27918@Red>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <2a85b239-7117-71aa-b921-86c42a54aeba@ilande.co.uk>
Date: Tue, 5 Feb 2019 16:45:16 +0000
MIME-Version: 1.0
In-Reply-To: <20190205091115.GA27918@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sparc: crash when using initrd > 5M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: sparclinux@vger.kernel.org, qemu-devel@nongnu.org

On 05/02/2019 09:11, Corentin Labbe wrote:

> On Fri, Feb 01, 2019 at 02:15:15PM +0000, Mark Cave-Ayland wrote:
>> On 18/01/2019 13:33, Mark Cave-Ayland wrote:
>>
>>> On 03/01/2019 15:48, Corentin Labbe wrote:
>>>
>>>> Hello
>>>>
>>>> When using an initrd > 5M, I hit the following kernel crash:
>>>> qemu-system-sparc -kernel vmlinux -initrd rootfs.cpio.gz -nographic
>>>> Configuration device id QEMU version 1 machine id 32
>>>> Probing SBus slot 0 offset 0
>>>> Probing SBus slot 1 offset 0
>>>> Probing SBus slot 2 offset 0
>>>> Probing SBus slot 3 offset 0
>>>> Probing SBus slot 4 offset 0
>>>> Probing SBus slot 5 offset 0
>>>> Invalid FCode start byte
>>>> CPUs: 1 x FMI,MB86904
>>>> UUID: 00000000-0000-0000-0000-000000000000
>>>> Welcome to OpenBIOS v1.1 built on Oct 5 2018 08:20
>>>>   Type 'help' for detailed information
>>>> [sparc] Kernel already loaded
>>>> switching to new context:
>>>> PROMLIB: obio_ranges 1
>>>> [    0.000000] PROMLIB: Sun Boot Prom Version 3 Revision 2
>>>> [    0.000000] Linux version 4.20.0-next-20190102+ (compile@Red) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #148 Thu Jan 3 16:17:08 CET 2019
>>>> [    0.000000] printk: bootconsole [earlyprom0] enabled
>>>> [    0.000000] ARCH: SUN4M
>>>> [    0.000000] TYPE: SPARCstation 5
>>>> [    0.000000] Ethernet address: 52:54:00:12:34:56
>>>> [    0.000000] Unable to handle kernel NULL pointer dereference
>>>> [    0.000000] tsk->{mm,active_mm}->context = ffffffff
>>>> [    0.000000] tsk->{mm,active_mm}->pgd = 00000000
>>>> [    0.000000]               \|/ ____ \|/
>>>> [    0.000000]               "@'/ ,. \`@"
>>>> [    0.000000]               /_| \__/ |_\
>>>> [    0.000000]                  \__U_/
>>>> [    0.000000] swapper(0): Oops [#1]
>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.20.0-next-20190102+ #148
>>>> [    0.000000] PSR: 04001fc0 PC: f0010ef0 NPC: f0010ef4 Y: 00000000    Not tainted
>>>> [    0.000000] PC: <do_sparc_fault+0x158/0x404>
>>>> [    0.000000] %G: 0000000a 000003c4  f05ece08 f05ecc00  00000000 00e00000  f05d4000 00000001
>>>> [    0.000000] %O: 00000000 00e00000  00800000 00e00000  00000000 00000002  f05d5bb8 f00bba58
>>>> [    0.000000] RPC: <memblock_reserve+0x38/0x68>
>>>> [    0.000000] %L: 00000040 f05dfaf8  f05d5c68 00000001  0003ffff 006951e0  f05ed014 f0674ab4
>>>> [    0.000000] %I: f05d5c80 00000000  00000002 f1000000  ffffffff 00000000  f05d5c20 f0007fd8
>>>> [    0.000000] Disabling lock debugging due to kernel taint
>>>> [    0.000000] Caller[f0007fd8]: srmmu_fault+0x58/0x68
>>>> [    0.000000] Caller[f0618598]: memblock_alloc_try_nid+0xb8/0xc8
>>>> [    0.000000] Caller[f0611094]: srmmu_paging_init+0x174/0xaf8
>>>> [    0.000000] Caller[f06106a8]: paging_init+0x4/0x24
>>>> [    0.000000] Caller[f060e4f0]: setup_arch+0x3e8/0x480
>>>> [    0.000000] Caller[f060ab50]: start_kernel+0x48/0x460
>>>> [    0.000000] Caller[f060a43c]: continue_boot+0x324/0x334
>>>> [    0.000000] Caller[00000000]:   (null)
>>>> [    0.000000] Instruction DUMP:
>>>> [    0.000000]  c800a024 
>>>> [    0.000000]  83286002 
>>>> [    0.000000]  073c17b3 
>>>> [    0.000000] <c4010001>
>>>> [    0.000000]  c600e22c 
>>>> [    0.000000]  8a08a003 
>>>> [    0.000000]  80a16001 
>>>> [    0.000000]  0280003b 
>>>> [    0.000000]  c600c001 
>>>> [    0.000000] 
>>>> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
>>>> [    0.000000] Press Stop-A (L1-A) from sun keyboard or send break
>>>> [    0.000000] twice on console to return to the boot prom
>>>> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>>>> qemu-system-sparc: terminating on signal 15 from pid 13043 (killall)
>>>>
>>>> The NULL ptr dereference is done by memset() in srmmu_nocache_init() and memblock_alloc_try_nid().
>>>> If I comment both memset, the boot pass
>>>>
>>>> But since nothing explain the NULL ptr deref in memset(), I suspect something is overriden by the initrd
>>>
>>> Sorry about the delay in replying to this, I haven't been too well recently.
>>>
>>> Looking at the code I suspect the problem is that when loading a kernel directly,
>>> OpenBIOS isn't adding the kernel/initrd memory ranges to the DT properties, and so
>>> the kernel doesn't recreate its own mapping on boot.
>>>
>>> It shouldn't be too hard to make this happen, let me take and look and see how
>>> difficult this would be.
>>
>> I think I now have a fix for this, with changes needed in both QEMU and OpenBIOS.
>>
>> Firstly you'll need to apply the QEMU patch from
>> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06635.html and then you'll
>> need an updated OpenBIOS.
>>
>> I've uploaded a pre-compiled openbios-sparc32 with the patches from
>> https://mail.coreboot.org/hyperkitty/list/openbios@openbios.org/thread/E6IMJNUFRF7W6ALWSYBOOCEYLBFXXQEN/
>> to https://www.ilande.co.uk/tmp/qemu/openbios-sparc32-initrdfix for testing.
>>
>> Please can you test and let me know if this solves the issue? If so, I'll see if I
>> can get them merged in time for the upcoming QEMU 4.0 release.
>>
> 
> Hello
> 
> Sorry even with the patch I still hit the issue.
> 
> I have added some debug and at least qemu set initrd_size correctly now.
> 
> I have tried to compile openbios-sparc32 for debugging but fail with
> arch/sparc32/context.c:116:5: error: PIC register clobbered by 'l7' in 'asm'
>      asm __volatile__ ("\n\tcall __switch_context"
>      ^~~
> make[1]: *** [rules.mak:219: target/arch/sparc32/context.o] Error 1
> (gcc 7.2 and gc 6.4 with binutils 2.30)

Hmmm. One other thing I've noticed is that newer kernels tend need a minimum of 256M
RAM to start up - does it work if you add -m 256 to your command line?


ATB,

Mark.
