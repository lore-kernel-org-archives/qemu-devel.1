Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31AC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B0A2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4H/UtY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B0A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKAk-0004Ud-IF
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaJwr-0006Rs-Bs
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaJsy-0003ch-E5
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:31:17 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaJsy-0003SB-0R
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:31:08 -0500
Received: by mail-oi1-x243.google.com with SMTP id n14so23264486oie.13
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=q+hAXUdOIpiBPCYWpvaUzuVJN6iRjk+ciEc4wmsPAxY=;
 b=N4H/UtY9qH/HXLXXUrOgkGTwHyyMHRdz8UNFK2c/Fw38klO4Y+4MloJ9YwIuHW4jfp
 VfWnpW5fT+lm5SaE/fQib9yen0yxBu0VzJDodbO6Tv/2+KYIygAd6XeayYnaDM9uXB5B
 7rQiL7nE0lfAJNH3YUtZF31nweUy+JeO8BHgC/j8XavYR3ORoAgD/DAe+NeRqOZywY42
 yrC3qOsnjFlOZUooDoKFBDEpatNIXtYhm7ddt+VyHs72j5oChg5PEAB5xq7y9RACdXKA
 EGvAuWf0BCEnCMr8B08/wCkCeVFeeKJcc+aEt9s8W+vooF6vngmp3UmpcoS0wURJpV2a
 OiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=q+hAXUdOIpiBPCYWpvaUzuVJN6iRjk+ciEc4wmsPAxY=;
 b=T7LXfnz2X9HJBVVPyOWRjXxOXHrWo348LzkeU2IP0IY0cdoznL5vlxJYphAis4mtQm
 wai0MSnD9dRPf+ZjoOELadMACYTy/6QDB8YNJyJg/lCJdi1OucvoBOuPrHDh6m86xJoX
 yU3G2eM5hu4szw5ZvfznsvcqHSijGbwoEIHrvVMlAz0e1eOFkNXteEuScg5JTCjntrNf
 4Woxa+qHkwWn4PssV2Tp8Bc3lYIeskWvKUMAmRXuZ5OuT0n+Ob8e03mw69c+BEw/gYIV
 7/0a/4QptqVVm84vzS7kPtSTykheJ3WY3cV0GTSWU9NUxFIYPyq9QVztVblZGfGKJd0A
 eT+A==
X-Gm-Message-State: APjAAAVGUCajzXh703CcvEnHwTcfyAwJItgBWxP4PimUAzdvt38r2t3g
 n/eO2LekNsQaoVMl3td26TFJnVKu1eJNw5lgBrc=
X-Google-Smtp-Source: APXvYqzgEbwKGsjdHXil2rgT1Rs4K/9GNlhMvjadfJV+7Cowll538KKhz11gpXqIwxAsEMlRV+/neaW5PIVE76SIwpY=
X-Received: by 2002:aca:d17:: with SMTP id 23mr8584279oin.136.1574947865840;
 Thu, 28 Nov 2019 05:31:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 05:31:05
 -0800 (PST)
In-Reply-To: <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 14:31:05 +0100
Message-ID: <CAL1e-=ge=VyeQQRFVoZQPix0vSiWapt0+iByMmG6MmKc7KUCGg@mail.gmail.com>
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001551cb05986820fd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001551cb05986820fd
Content-Type: text/plain; charset="UTF-8"

On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> I don't see why you say that the peripherals are inside the chip, there is
> CPU within target/avr directory and then there are some peripherals in hw
> directory, CPU does not depend on them. what am I missing?
>
>>
>>
I meant these peripherals are physically inside the chip together with the
core.

And USART in a micricontroler from 2010 is different than USART from one
from 2018.


> On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>>
>>>
>>> On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic <
>>> aleksandar.m.mail@gmail.com> wrote:
>>>
>>>> On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik <mrolnik@gmail.com>
>>>> wrote:
>>>> >
>>>> > This series of patches adds 8bit AVR cores to QEMU.
>>>> > All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not
>>>> fully tested yet.
>>>> > However I was able to execute simple code with functions. e.g
>>>> fibonacci calculation.
>>>> > This series of patches include a non real, sample board.
>>>> > No fuses support yet. PC is set to 0 at reset.
>>>> >
>>>>
>>>> I have a couple of general remarks, so I am responding to the cover
>>>> letter, not individual patches.
>>>>
>>>> 1) The licenses for Sarah devices differ than the rest - shouldn't all
>>>> licenses be harmonized?
>>>
>>> Sarah,
>>> do you mind if use the same license I use for my code?
>>>
>>>
>>>>
>>>
>>>
>>>> 2) There is an architectural problem with peripherals. It is possible
>>>> that they evolve over time, so, for example, USART could not be the
>>>> same for older and newer CPUs (in principle, newer peripheral is
>>>> expected to be o sort of "superset" of the older). How do you solve
>>>> that problem? Right now, it may not looks serious to you, but if you
>>>> don;t think about that right now, from the outset, soon the code will
>>>> become so entangled, ti woudl be almost very difficult to fix it.
>>>> Please think about that, how would you solve it, is there a way to
>>>> pass the information on the currently emulated CPU to the code
>>>> covering a peripheral, and provide a different behaviour?
>>>>
>>> Hi Aleksandar,
>>>
>>> Please explain.
>>>
>>>
>> My concern is about peripherals inside the chip, together with the core.
>>
>> If one models, let's say an external (in the sense, it is a separate
>> chip) ADC (analog-to-digital converter), one looks at specs, implement what
>> is resonable possible in QEMU, plug it in in one of machines thst contains
>> it, and that's it. That ADC remains the same, of course, whatever the
>> surrounding system is.
>>
>> In AVR case, I think we have a phenomenon likes of which we didn't see
>> before (at least I don't know about). Number of AVR microcontrollers is
>> very large, and both cores and peripherals evolved.
>>
>> For cores, you handle differences with all these AVR_FEATURE macros, and
>> this seems to be working, no significant objection from my side, and btw
>> that was not an easy task to execute, all admiration from me.
>>
>> But what about peripherals inside the chip? A peripheral with the same
>> name and the same general area of functionality may be differently
>> specified for microcontrollers from 2010 and 2018. By the difference I
>> don't mean starting address, but the difference in behavior. I don't have
>> time right now to spell many examples, but I read three different specs,
>> and there are differences in USART specifications.
>>
>> I am not clear what is your envisioned solution for these cases. Would
>> you such close, but not the same, flabors of a peripheral treat as if they
>> are two completely separate cases of a peripheral? Or would you have a
>> single peripheral that would somehow configure itself depending on the core
>> it is attached to?
>>
>> I hope I was clearer this time.
>>
>> Aleksandar
>>
>>
>>
>>>
>>>
>>>
>>> I don't see any problem from CPU's perspective.
>>> as for the sample board is just a sample, I hope other people will
>>> create real models or real hw.
>>> there was no way I could provide a CPU alone, that's why there is sample.
>>>
>>>
>>>
>>>>
>>>> > Following are examples of possible usages, assuming program.elf is
>>>> compiled for AVR cpu
>>>> > 1.  Continious non interrupted execution
>>>> >     run `qemu-system-avr -kernel program.elf`
>>>> > 2.  Continious non interrupted execution with serial output into
>>>> telnet window
>>>> >     run `qemu-system-avr -kernel program.elf -serial
>>>> tcp::5678,server,nowait -nographic `
>>>> >     run `telent localhost 5678`
>>>> > 3.  Continious non interrupted execution with serial output into
>>>> stdout
>>>> >     run `qemu-system-avr -kernel program.elf -serial stdio`
>>>> > 4.  Debugging wit GDB debugger
>>>> >     run `qemu-system-avr -kernel program.elf -s -S`
>>>> >     run `avr-gdb program.elf` and then within GDB shell `target
>>>> remote :1234`
>>>> > 5.  Print out executed instructions
>>>> >     run `qemu-system-avr -kernel program.elf -d in_asm`
>>>> >
>>>>
>>>> Thank you so much for these examples!
>>>>
>>>> Aleksandar
>>>>
>>>>
>>>> >
>>>> > the patches include the following
>>>> > 1. just a basic 8bit AVR CPU, without instruction decoding or
>>>> translation
>>>> > 2. CPU features which allow define the following 8bit AVR cores
>>>> >      avr1
>>>> >      avr2 avr25
>>>> >      avr3 avr31 avr35
>>>> >      avr4
>>>> >      avr5 avr51
>>>> >      avr6
>>>> >      xmega2 xmega4 xmega5 xmega6 xmega7
>>>> > 3. a definition of sample machine with SRAM, FLASH and CPU which
>>>> allows to execute simple code
>>>> > 4. encoding for all AVR instructions
>>>> > 5. interrupt handling
>>>> > 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>>>> > 7. a decoder which given an opcode decides what istruction it is
>>>> > 8. translation of AVR instruction into TCG
>>>> > 9. all features together
>>>> >
>>>> > changes since v3
>>>> > 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of
>>>> 0x000000ff) for faster address manipulaton
>>>> > 2. ffs changed to ctz32
>>>> > 3. duplicate code removed at avr_cpu_do_interrupt
>>>> > 4. using andc instead of not + and
>>>> > 5. fixing V flag calculation in varios instructions
>>>> > 6. freeing local variables in PUSH
>>>> > 7. tcg_const_local_i32 -> tcg_const_i32
>>>> > 8. using sextract32 instead of my implementation
>>>> > 9. fixing BLD instruction
>>>> > 10.xor(r) instead of 0xff - r at COM
>>>> > 11.fixing MULS/MULSU not to modify inputs' content
>>>> > 12.using SUB for NEG
>>>> > 13.fixing tcg_gen_qemu_ld/st call in XCH
>>>> >
>>>> > changes since v4
>>>> > 1. target is now defined as big endian in order to optimize
>>>> push_ret/pop_ret
>>>> > 2. all style warnings are fixed
>>>> > 3. adding cpu_set/get_sreg functions
>>>> > 4. simplifying gen_goto_tb as there is no real paging
>>>> > 5. env->pc -> env->pc_w
>>>> > 6. making flag dump more compact
>>>> > 7. more spacing
>>>> > 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
>>>> > 9. removing avr_set_feature
>>>> > 10. SPL/SPH set bug fix
>>>> > 11. switching stb_phys to cpu_stb_data
>>>> > 12. cleaning up avr_decode
>>>> > 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
>>>> > 14. saving CPU features (savevm)
>>>> >
>>>> > changes since v5
>>>> > 1. BLD bug fix
>>>> > 2. decoder generator is added
>>>> >
>>>> > chages since v6
>>>> > 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_
>>>> cpu_gdb_write_register
>>>> > 2. configure the target as little endian because otherwise GDB does
>>>> not work
>>>> > 3. fixing and testing gen_push_ret/gen_pop_ret
>>>> >
>>>> > changes since v7
>>>> > 1. folding back v6
>>>> > 2. logging at helper_outb and helper_inb are done for non supported
>>>> yet registers only
>>>> > 3. MAINTAINERS updated
>>>> >
>>>> > changes since v8
>>>> > 1. removing hw/avr from hw/Makefile.obj as it should not be built for
>>>> all
>>>> > 2. making linux compilable
>>>> > 3. testing on
>>>> >     a. Mac, Apple LLVM version 7.0.0
>>>> >     b. Ubuntu 12.04, gcc 4.9.2
>>>> >     c. Fedora 23, gcc 5.3.1
>>>> > 4. folding back some patches
>>>> > 5. translation bug fixes for ORI, CPI, XOR instructions
>>>> > 6. propper handling of cpu register writes though memory
>>>> >
>>>> > changes since v9
>>>> > 1. removing forward declarations of static functions
>>>> > 2. disabling debug prints
>>>> > 3. switching to case range instead of if else if ...
>>>> > 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to
>>>> any device
>>>> > 5. commenst about sample board and sample IO device added
>>>> > 6. sample board description is more descriptive now
>>>> > 7. memory_region_allocate_system_memory is used to create RAM
>>>> > 8. now there are helper_fullrd & helper_fullwr when LD/ST try to
>>>> access registers
>>>> >
>>>> > changes since v10
>>>> > 1. movig back fullwr & fullrd into the commit where outb and inb were
>>>> introduced
>>>> > 2. changing tlb_fill function signature
>>>> > 3. adding empty line between functions
>>>> > 4. adding newline on the last line of the file
>>>> > 5. using tb->flags to generae full access ST/LD instructions
>>>> > 6. fixing SBRC bug
>>>> > 7. folding back 10th commit
>>>> > 8. whenever a new file is introduced it's added to Makefile.objs
>>>> >
>>>> > changes since v11
>>>> > 1. updating to v2.7.0-rc
>>>> > 2. removing assignment to env->fullacc from gen_intermediate_code
>>>> >
>>>> > changes since v12
>>>> > 1. fixing spacing
>>>> > 2. fixing get/put_segment functions
>>>> > 3. removing target-avr/machine.h file
>>>> > 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
>>>> > 5. comment spelling
>>>> > 6. removing hw/avr/sample_io.c
>>>> > 7. char const* -> const char*
>>>> > 8. proper ram allocation
>>>> > 9. fixing breakpoint functionality.
>>>> > 10.env1 -> env
>>>> > 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register
>>>> functions
>>>> > 12.any cpu is removed
>>>> > 12.feature bits are not saved into vm state
>>>> >
>>>> > changes since v13
>>>> > 1. rebasing to v2.7.0-rc1
>>>> >
>>>> > changes since v14
>>>> > 1. I made self review with git gui tool. (I did not know such a thing
>>>> exists)
>>>> > 2. removing all double/tripple spaces
>>>> > 3. removing comment reference to SampleIO
>>>> > 4. folding back some changes, so there is not deleted lines in my code
>>>> > 5. moving avr configuration, within configure file, before chris
>>>> >
>>>> > changes since v15
>>>> > 1. removing IO registers cache from CPU
>>>> > 2. implementing CBI/SBI as read(helper_inb), modify,
>>>> write(helper_outb)
>>>> > 3. implementing CBIC/SBIC as read(helper_inb), check, branch
>>>> > 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>>>> >
>>>> > changes since v16
>>>> > 1. removing EXT IO registers knoledge from CPU. These registers are
>>>> accessible
>>>> >    by LD/ST only. CPU has no interest in them
>>>> >
>>>> > changes since v17 (by Richard Henderson)
>>>> > This is Michael's v17, with some adjustments of my own:
>>>> >
>>>> > 1. Fix the whitespace errors reported by "git am",
>>>> > 2. Replace the utf-8 characters with normal ascii,
>>>> > 3. Ditch the separate compilation of translate.c.
>>>> >
>>>> > I retained the two separate files that could be regenerated
>>>> > from the included cpugen program, but merged in translate-insn.c.
>>>> > Not that it matters, but the code generated is about 3k smaller.
>>>> >
>>>> > changes since v18
>>>> > 1.  moving target-avr into target/avr
>>>> > 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
>>>> > 3.  call cpu_exec_realizefn avr_cpu_realizefn
>>>> > 4.  do not fail sample machine creation if no rom is suplied
>>>> > 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
>>>> > 6.  fix a register getters/setters in machine.c
>>>> > 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>>>> >
>>>> > changes since v19
>>>> > 1.  use decodetree.py tool to decode instructions
>>>> > 2.  adding USART
>>>> > 3.  adding 16 bit timer peripherals
>>>> > 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
>>>> > 5.  renaming tlb_fill to avr_cpu_tlb_fill
>>>> >
>>>> > changes since v20
>>>> > 1.  use one CPU naming convention
>>>> > 2.  merging insn16.decode & insn32.decode files
>>>> > 3.  modifying skip next instruction mechanizm
>>>> > 4.  translate BREAK as NOP for now
>>>> >
>>>> > changes since v21
>>>> > 1.  Reorganize bstate.
>>>> >     This will make transition to <exec/translator.h> easier, and
>>>> fixes a couple of bugs wrt single stepping
>>>> >     by richard.henderson@linaro.org
>>>> > 2.  Drop cpc and fix page cross condition.
>>>> >     by richard.henderson@linaro.org
>>>> > 3.  Refactor checking supported/unsupported instructions
>>>> > 4.  Add gdb-xml/avr-cpu.xml
>>>> >
>>>> > changes since v22
>>>> > 1.  Rebase
>>>> > 2.  Split long comment
>>>> >
>>>> > changes since v23
>>>> > 1.  remove avr_cpu_list_compare function
>>>> > 2.  modify avr_cpu_class_by_name function
>>>> > 3.  modify avr_cpu_list_entry function
>>>> > 4.  modify avr_cpu_list function
>>>> >
>>>> > changes since v24
>>>> > 1.  remove AVR_CPU_TYPE_NAME macro
>>>> >
>>>> > changes since v25
>>>> > 1.  fix patches. every file belong to one patch only
>>>> > 2.  change copyright year from 2016 to 2019
>>>> > 3.  create mask device to emulate prr0/prr1
>>>> >
>>>> > changes since v26
>>>> > 1.  add avocado acceptence test
>>>> > 2.  add boot serial test
>>>> >
>>>> > changes since v27
>>>> > 1.  list atmel2560 devices as unimplemented
>>>> > 2.  fix sram base/size
>>>> >
>>>> > changes since v28
>>>> > 1.  rebase
>>>> > 2.  fix includes & build
>>>> >
>>>> > changes since v29
>>>> > 1.  fixing ownership
>>>> > 2.  using 'since' instread of 'added in'
>>>> >
>>>> > changes since v30
>>>> > 1.  rebase
>>>> >
>>>> > changes since v31
>>>> > 1.  splitting 'Add instruction translation' commit
>>>> > 2.  fixing typo in qapi/machine.json sicne -> since
>>>> > 3.  removing unintended changes in configure file
>>>> > 4.  adding Richard Henderson as a co developer to 'Add instruction
>>>> translation - CPU main translation funcions' commit
>>>> >
>>>> > changes since v32
>>>> > 1.  modify cpu_get_sreg to treat sreg C as other flags, except sreg Z
>>>> >
>>>> > changes since v33
>>>> > 1.  ensure flag C is always calculated as one bit
>>>> > 2.  calculate flag Z as one bit, without using inverse logic
>>>> >
>>>> > changes since v34
>>>> > 1.  rebase
>>>> >
>>>> > changes since v35
>>>> > 1.  rebase
>>>> > 2.  use NANOSECONDS_PER_SECOND instead of 1000000000 in avr_timer16.c
>>>> > 3.  split "target/avr: Register AVR support with the rest of QEMU"
>>>> into three patches
>>>> >     1.  "target/avr: Register AVR support with the rest of QEMU"
>>>> >     2.  "target/avr: Update build system"
>>>> >     3.  "target/avr: Update MAINTAINERS file"
>>>> > 4.  split "target/avr: Add tests" patch into two patches
>>>> >     1.  "target/avr: Add Avocado test"
>>>> >     2.  "target/avr: Add boot serial test"
>>>> > 5.  Add instruction disassembly function
>>>> > 6.  change "since 4.2" to "since 5.0"
>>>> >
>>>> > changes since v36
>>>> > 1.  rebase
>>>> > 2.  tename
>>>> >     1.  NO_CPU_REGISTERS    -> NUMBER_OF_CPU_REGISTERS
>>>> >     2.  NO_IO_REGISTERS     -> NUMBER_OF_IO_REGISTERS
>>>> >     3.  to_A                -> to_regs_16_31_by_one
>>>> >     4.  to_B                -> to_regs_16_23_by_one
>>>> >     5.  to_C                -> to_regs_24_30_by_two
>>>> >     6.  to_D                -> to_regs_00_30_by_two
>>>> > 3.  add missing licences
>>>> > 4.  add usage example (see above)
>>>> > 5.  ass Sarah Harris <S.E.Harris@kent.ac.uk> as a reviewer to
>>>> MAINTAINERS
>>>> > 7.  use git commit sha1 instead of `master`` in avocado test
>>>> >
>>>> > Michael Rolnik (16):
>>>> >   target/avr: Add outward facing interfaces and core CPU logic
>>>> >   target/avr: Add instruction helpers
>>>> >   target/avr: Add instruction decoding
>>>> >   target/avr: Add instruction translation - Registers definition
>>>> >   target/avr: Add instruction translation - Arithmetic and Logic
>>>> >     Instructions
>>>> >   target/avr: Add instruction translation - Branch Instructions
>>>> >   target/avr: Add instruction translation - Bit and Bit-test
>>>> >     Instructions
>>>> >   target/avr: Add instruction translation - MCU Control Instructions
>>>> >   target/avr: Add instruction translation - CPU main translation
>>>> >     function
>>>> >   target/avr: Add instruction disassembly function
>>>> >   target/avr: Add example board configuration
>>>> >   target/avr: Register AVR support with the rest of QEMU
>>>> >   target/avr: Update build system
>>>> >   target/avr: Add boot serial test
>>>> >   target/avr: Add Avocado test
>>>> >   target/avr: Update MAINTAINERS file
>>>> >
>>>> > Sarah Harris (1):
>>>> >   target/avr: Add limited support for USART and 16 bit timer
>>>> peripherals
>>>> >
>>>> >  configure                        |    7 +
>>>> >  default-configs/avr-softmmu.mak  |    5 +
>>>> >  qapi/machine.json                |    3 +-
>>>> >  include/disas/dis-asm.h          |    6 +
>>>> >  include/hw/char/avr_usart.h      |   97 +
>>>> >  include/hw/misc/avr_mask.h       |   47 +
>>>> >  include/hw/timer/avr_timer16.h   |   97 +
>>>> >  include/sysemu/arch_init.h       |    1 +
>>>> >  target/avr/cpu-param.h           |   37 +
>>>> >  target/avr/cpu-qom.h             |   54 +
>>>> >  target/avr/cpu.h                 |  254 +++
>>>> >  target/avr/helper.h              |   29 +
>>>> >  arch_init.c                      |    2 +
>>>> >  hw/avr/sample.c                  |  282 +++
>>>> >  hw/char/avr_usart.c              |  324 ++++
>>>> >  hw/misc/avr_mask.c               |  112 ++
>>>> >  hw/timer/avr_timer16.c           |  605 ++++++
>>>> >  target/avr/cpu.c                 |  576 ++++++
>>>> >  target/avr/disas.c               |  228 +++
>>>> >  target/avr/gdbstub.c             |   85 +
>>>> >  target/avr/helper.c              |  354 ++++
>>>> >  target/avr/machine.c             |  121 ++
>>>> >  target/avr/translate.c           | 3052
>>>> ++++++++++++++++++++++++++++++
>>>> >  tests/boot-serial-test.c         |   10 +
>>>> >  tests/machine-none-test.c        |    1 +
>>>> >  MAINTAINERS                      |   11 +
>>>> >  gdb-xml/avr-cpu.xml              |   49 +
>>>> >  hw/Kconfig                       |    1 +
>>>> >  hw/avr/Kconfig                   |    6 +
>>>> >  hw/avr/Makefile.objs             |    1 +
>>>> >  hw/char/Kconfig                  |    3 +
>>>> >  hw/char/Makefile.objs            |    1 +
>>>> >  hw/misc/Kconfig                  |    3 +
>>>> >  hw/misc/Makefile.objs            |    2 +
>>>> >  hw/timer/Kconfig                 |    3 +
>>>> >  hw/timer/Makefile.objs           |    2 +
>>>> >  target/avr/Makefile.objs         |   34 +
>>>> >  target/avr/insn.decode           |  194 ++
>>>> >  tests/Makefile.include           |    2 +
>>>> >  tests/acceptance/machine_avr6.py |   56 +
>>>> >  40 files changed, 6756 insertions(+), 1 deletion(-)
>>>> >  create mode 100644 default-configs/avr-softmmu.mak
>>>> >  create mode 100644 include/hw/char/avr_usart.h
>>>> >  create mode 100644 include/hw/misc/avr_mask.h
>>>> >  create mode 100644 include/hw/timer/avr_timer16.h
>>>> >  create mode 100644 target/avr/cpu-param.h
>>>> >  create mode 100644 target/avr/cpu-qom.h
>>>> >  create mode 100644 target/avr/cpu.h
>>>> >  create mode 100644 target/avr/helper.h
>>>> >  create mode 100644 hw/avr/sample.c
>>>> >  create mode 100644 hw/char/avr_usart.c
>>>> >  create mode 100644 hw/misc/avr_mask.c
>>>> >  create mode 100644 hw/timer/avr_timer16.c
>>>> >  create mode 100644 target/avr/cpu.c
>>>> >  create mode 100644 target/avr/disas.c
>>>> >  create mode 100644 target/avr/gdbstub.c
>>>> >  create mode 100644 target/avr/helper.c
>>>> >  create mode 100644 target/avr/machine.c
>>>> >  create mode 100644 target/avr/translate.c
>>>> >  create mode 100644 gdb-xml/avr-cpu.xml
>>>> >  create mode 100644 hw/avr/Kconfig
>>>> >  create mode 100644 hw/avr/Makefile.objs
>>>> >  create mode 100644 target/avr/Makefile.objs
>>>> >  create mode 100644 target/avr/insn.decode
>>>> >  create mode 100644 tests/acceptance/machine_avr6.py
>>>> >
>>>> > --
>>>> > 2.17.2 (Apple Git-113)
>>>> >
>>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Michael Rolnik
>>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>

--0000000000001551cb05986820fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, Michael Rolnik &lt;<a href=3D"mailt=
o:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">I don&#39;t see why you say that the periphe=
rals are inside the chip, there is CPU within target/avr directory and then=
 there are some peripherals=C2=A0in hw directory, CPU does not depend on th=
em. what am I missing?</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote=
></blockquote><div><br></div><div>I meant these peripherals are physically =
inside the chip together with the core.</div><div><br></div><div>And USART =
in a micricontroler from 2010 is different than USART from one from 2018.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 3:22 PM A=
leksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" targe=
t=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br><br>On Thursday, November 28, 2=
019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_bla=
nk">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 27, 2019=
 at 11:06 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gm=
ail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Nov 27, 2019 =
at 6:53 PM Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=
=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This series of patches adds 8bit AVR cores to QEMU.<br>
&gt; All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully=
 tested yet.<br>
&gt; However I was able to execute simple code with functions. e.g fibonacc=
i calculation.<br>
&gt; This series of patches include a non real, sample board.<br>
&gt; No fuses support yet. PC is set to 0 at reset.<br>
&gt;<br>
<br>
I have a couple of general remarks, so I am responding to the cover<br>
letter, not individual patches.<br>
<br>
1) The licenses for Sarah devices differ than the rest - shouldn&#39;t all<=
br>
licenses be harmonized?</blockquote><div>Sarah,</div><div>do you mind if us=
e the same license I use for my code?</div><div>=C2=A0<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
2) There is an architectural problem with peripherals. It is possible<br>
that they evolve over time, so, for example, USART could not be the<br>
same for older and newer CPUs (in principle, newer peripheral is<br>
expected to be o sort of &quot;superset&quot; of the older). How do you sol=
ve<br>
that problem? Right now, it may not looks serious to you, but if you<br>
don;t think about that right now, from the outset, soon the code will<br>
become so entangled, ti woudl be almost very difficult to fix it.<br>
Please think about that, how would you solve it, is there a way to<br>
pass the information on the currently emulated CPU to the code<br>
covering a peripheral, and provide a different behaviour?<br></blockquote><=
div>Hi Aleksandar,</div><div><br></div><div>Please explain.</div><div><br><=
/div></div></div></blockquote><div><br></div><div>My concern is about perip=
herals inside the chip, together with the core.</div><div><br></div><div>If=
 one models, let&#39;s say an external (in the sense, it is a separate chip=
) ADC (analog-to-digital converter), one looks at specs, implement what is =
resonable possible in QEMU, plug it in in one of machines thst contains it,=
 and that&#39;s it. That ADC remains the same, of course, whatever the surr=
ounding system is.</div><div><br></div><div>In AVR case, I think we have a =
phenomenon likes of which we didn&#39;t see before (at least I don&#39;t kn=
ow about). Number of AVR microcontrollers is very large, and both cores and=
 peripherals evolved.</div><div><br></div><div>For cores, you handle differ=
ences with all these AVR_FEATURE macros, and this seems to be working, no s=
ignificant objection from my side, and btw that was not an easy task to exe=
cute, all admiration from me.</div><div><br></div><div>But what about perip=
herals inside the chip? A peripheral with the same name and the same genera=
l area of functionality may be differently specified for microcontrollers f=
rom 2010 and 2018. By the difference I don&#39;t mean starting address, but=
 the difference in behavior. I don&#39;t have time right now to spell many =
examples, but I read three different specs, and there are differences in US=
ART specifications.</div><div><br></div><div>I am not clear what is your en=
visioned solution for these cases. Would you such close, but not the same, =
flabors of a peripheral treat as if they are two completely separate cases =
of a peripheral? Or would you have a single peripheral that would somehow c=
onfigure itself depending on the core it is attached to?</div><div><br></di=
v><div>I hope I was clearer this time.</div><div><br></div><div>Aleksandar<=
/div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><div=
><br></div><div><br></div><div>I don&#39;t see any problem from CPU&#39;s p=
erspective.=C2=A0</div><div>as for the sample board is just a sample, I hop=
e other people will create real models or real hw.</div><div>there was no w=
ay I could provide a CPU alone, that&#39;s why there is sample.</div><div><=
br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; Following are examples of possible usages, assuming program.elf is com=
piled for AVR cpu<br>
&gt; 1.=C2=A0 Continious non interrupted execution<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel program.elf`<br>
&gt; 2.=C2=A0 Continious non interrupted execution with serial output into =
telnet window<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel program.elf -serial tc=
p::5678,server,nowait -nographic `<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `telent localhost 5678`<br>
&gt; 3.=C2=A0 Continious non interrupted execution with serial output into =
stdout<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel program.elf -serial st=
dio`<br>
&gt; 4.=C2=A0 Debugging wit GDB debugger<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel program.elf -s -S`<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `avr-gdb program.elf` and then within GDB shell=
 `target remote :1234`<br>
&gt; 5.=C2=A0 Print out executed instructions<br>
&gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel program.elf -d in_asm`=
<br>
&gt;<br>
<br>
Thank you so much for these examples!<br>
<br>
Aleksandar<br>
<br>
<br>
&gt;<br>
&gt; the patches include the following<br>
&gt; 1. just a basic 8bit AVR CPU, without instruction decoding or translat=
ion<br>
&gt; 2. CPU features which allow define the following 8bit AVR cores<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avr1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avr2 avr25<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avr3 avr31 avr35<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avr4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avr5 avr51<br>
&gt;=C2=A0 =C2=A0 =C2=A0 avr6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 xmega2 xmega4 xmega5 xmega6 xmega7<br>
&gt; 3. a definition of sample machine with SRAM, FLASH and CPU which allow=
s to execute simple code<br>
&gt; 4. encoding for all AVR instructions<br>
&gt; 5. interrupt handling<br>
&gt; 6. helpers for IN, OUT, SLEEP, WBR &amp; unsupported instructions<br>
&gt; 7. a decoder which given an opcode decides what istruction it is<br>
&gt; 8. translation of AVR instruction into TCG<br>
&gt; 9. all features together<br>
&gt;<br>
&gt; changes since v3<br>
&gt; 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x00000=
0ff) for faster address manipulaton<br>
&gt; 2. ffs changed to ctz32<br>
&gt; 3. duplicate code removed at avr_cpu_do_interrupt<br>
&gt; 4. using andc instead of not + and<br>
&gt; 5. fixing V flag calculation in varios instructions<br>
&gt; 6. freeing local variables in PUSH<br>
&gt; 7. tcg_const_local_i32 -&gt; tcg_const_i32<br>
&gt; 8. using sextract32 instead of my implementation<br>
&gt; 9. fixing BLD instruction<br>
&gt; 10.xor(r) instead of 0xff - r at COM<br>
&gt; 11.fixing MULS/MULSU not to modify inputs&#39; content<br>
&gt; 12.using SUB for NEG<br>
&gt; 13.fixing tcg_gen_qemu_ld/st call in XCH<br>
&gt;<br>
&gt; changes since v4<br>
&gt; 1. target is now defined as big endian in order to optimize push_ret/p=
op_ret<br>
&gt; 2. all style warnings are fixed<br>
&gt; 3. adding cpu_set/get_sreg functions<br>
&gt; 4. simplifying gen_goto_tb as there is no real paging<br>
&gt; 5. env-&gt;pc -&gt; env-&gt;pc_w<br>
&gt; 6. making flag dump more compact<br>
&gt; 7. more spacing<br>
&gt; 8. renaming CODE/DATA_INDEX -&gt; MMU_CODE/DATA_IDX<br>
&gt; 9. removing avr_set_feature<br>
&gt; 10. SPL/SPH set bug fix<br>
&gt; 11. switching stb_phys to cpu_stb_data<br>
&gt; 12. cleaning up avr_decode<br>
&gt; 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)<br>
&gt; 14. saving CPU features (savevm)<br>
&gt;<br>
&gt; changes since v5<br>
&gt; 1. BLD bug fix<br>
&gt; 2. decoder generator is added<br>
&gt;<br>
&gt; chages since v6<br>
&gt; 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_<w=
br>cpu_gdb_write_register<br>
&gt; 2. configure the target as little endian because otherwise GDB does no=
t work<br>
&gt; 3. fixing and testing gen_push_ret/gen_pop_ret<br>
&gt;<br>
&gt; changes since v7<br>
&gt; 1. folding back v6<br>
&gt; 2. logging at helper_outb and helper_inb are done for non supported ye=
t registers only<br>
&gt; 3. MAINTAINERS updated<br>
&gt;<br>
&gt; changes since v8<br>
&gt; 1. removing hw/avr from hw/Makefile.obj as it should not be built for =
all<br>
&gt; 2. making linux compilable<br>
&gt; 3. testing on<br>
&gt;=C2=A0 =C2=A0 =C2=A0a. Mac, Apple LLVM version 7.0.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0b. Ubuntu 12.04, gcc 4.9.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0c. Fedora 23, gcc 5.3.1<br>
&gt; 4. folding back some patches<br>
&gt; 5. translation bug fixes for ORI, CPI, XOR instructions<br>
&gt; 6. propper handling of cpu register writes though memory<br>
&gt;<br>
&gt; changes since v9<br>
&gt; 1. removing forward declarations of static functions<br>
&gt; 2. disabling debug prints<br>
&gt; 3. switching to case range instead of if else if ...<br>
&gt; 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to =
any device<br>
&gt; 5. commenst about sample board and sample IO device added<br>
&gt; 6. sample board description is more descriptive now<br>
&gt; 7. memory_region_allocate_system_<wbr>memory is used to create RAM<br>
&gt; 8. now there are helper_fullrd &amp; helper_fullwr when LD/ST try to a=
ccess registers<br>
&gt;<br>
&gt; changes since v10<br>
&gt; 1. movig back fullwr &amp; fullrd into the commit where outb and inb w=
ere introduced<br>
&gt; 2. changing tlb_fill function signature<br>
&gt; 3. adding empty line between functions<br>
&gt; 4. adding newline on the last line of the file<br>
&gt; 5. using tb-&gt;flags to generae full access ST/LD instructions<br>
&gt; 6. fixing SBRC bug<br>
&gt; 7. folding back 10th commit<br>
&gt; 8. whenever a new file is introduced it&#39;s added to Makefile.objs<b=
r>
&gt;<br>
&gt; changes since v11<br>
&gt; 1. updating to v2.7.0-rc<br>
&gt; 2. removing assignment to env-&gt;fullacc from gen_intermediate_code<b=
r>
&gt;<br>
&gt; changes since v12<br>
&gt; 1. fixing spacing<br>
&gt; 2. fixing get/put_segment functions<br>
&gt; 3. removing target-avr/machine.h file<br>
&gt; 4. VMSTATE_SINGLE_TEST -&gt; VMSTATE_SINGLE<br>
&gt; 5. comment spelling<br>
&gt; 6. removing hw/avr/sample_io.c<br>
&gt; 7. char const* -&gt; const char*<br>
&gt; 8. proper ram allocation<br>
&gt; 9. fixing breakpoint functionality.<br>
&gt; 10.env1 -&gt; env<br>
&gt; 11.fixing avr_cpu_gdb_write_register &amp; avr_cpu_gdb_read_register f=
unctions<br>
&gt; 12.any cpu is removed<br>
&gt; 12.feature bits are not saved into vm state<br>
&gt;<br>
&gt; changes since v13<br>
&gt; 1. rebasing to v2.7.0-rc1<br>
&gt;<br>
&gt; changes since v14<br>
&gt; 1. I made self review with git gui tool. (I did not know such a thing =
exists)<br>
&gt; 2. removing all double/tripple spaces<br>
&gt; 3. removing comment reference to SampleIO<br>
&gt; 4. folding back some changes, so there is not deleted lines in my code=
<br>
&gt; 5. moving avr configuration, within configure file, before chris<br>
&gt;<br>
&gt; changes since v15<br>
&gt; 1. removing IO registers cache from CPU<br>
&gt; 2. implementing CBI/SBI as read(helper_inb), modify, write(helper_outb=
)<br>
&gt; 3. implementing CBIC/SBIC as read(helper_inb), check, branch<br>
&gt; 4. adding missing tcg_temp_free_i32 for tcg_const_i32<br>
&gt;<br>
&gt; changes since v16<br>
&gt; 1. removing EXT IO registers knoledge from CPU. These registers are ac=
cessible<br>
&gt;=C2=A0 =C2=A0 by LD/ST only. CPU has no interest in them<br>
&gt;<br>
&gt; changes since v17 (by Richard Henderson)<br>
&gt; This is Michael&#39;s v17, with some adjustments of my own:<br>
&gt;<br>
&gt; 1. Fix the whitespace errors reported by &quot;git am&quot;,<br>
&gt; 2. Replace the utf-8 characters with normal ascii,<br>
&gt; 3. Ditch the separate compilation of translate.c.<br>
&gt;<br>
&gt; I retained the two separate files that could be regenerated<br>
&gt; from the included cpugen program, but merged in translate-insn.c.<br>
&gt; Not that it matters, but the code generated is about 3k smaller.<br>
&gt;<br>
&gt; changes since v18<br>
&gt; 1.=C2=A0 moving target-avr into target/avr<br>
&gt; 2.=C2=A0 do not call cpu_exec_initfn function from avr_cpu_initfn<br>
&gt; 3.=C2=A0 call cpu_exec_realizefn avr_cpu_realizefn<br>
&gt; 4.=C2=A0 do not fail sample machine creation if no rom is suplied<br>
&gt; 5.=C2=A0 add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code=
<br>
&gt; 6.=C2=A0 fix a register getters/setters in machine.c<br>
&gt; 7.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;17 to 1&lt;&lt;18<br>
&gt;<br>
&gt; changes since v19<br>
&gt; 1.=C2=A0 use decodetree.py tool to decode instructions<br>
&gt; 2.=C2=A0 adding USART<br>
&gt; 3.=C2=A0 adding 16 bit timer peripherals<br>
&gt; 4.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;18 to 1&lt;&lt;20<br>
&gt; 5.=C2=A0 renaming tlb_fill to avr_cpu_tlb_fill<br>
&gt;<br>
&gt; changes since v20<br>
&gt; 1.=C2=A0 use one CPU naming convention<br>
&gt; 2.=C2=A0 merging insn16.decode &amp; insn32.decode files<br>
&gt; 3.=C2=A0 modifying skip next instruction mechanizm<br>
&gt; 4.=C2=A0 translate BREAK as NOP for now<br>
&gt;<br>
&gt; changes since v21<br>
&gt; 1.=C2=A0 Reorganize bstate.<br>
&gt;=C2=A0 =C2=A0 =C2=A0This will make transition to &lt;exec/translator.h&=
gt; easier, and fixes a couple of bugs wrt single stepping<br>
&gt;=C2=A0 =C2=A0 =C2=A0by <a href=3D"mailto:richard.henderson@linaro.org" =
target=3D"_blank">richard.henderson@linaro.org</a><br>
&gt; 2.=C2=A0 Drop cpc and fix page cross condition.<br>
&gt;=C2=A0 =C2=A0 =C2=A0by <a href=3D"mailto:richard.henderson@linaro.org" =
target=3D"_blank">richard.henderson@linaro.org</a><br>
&gt; 3.=C2=A0 Refactor checking supported/unsupported instructions<br>
&gt; 4.=C2=A0 Add gdb-xml/avr-cpu.xml<br>
&gt;<br>
&gt; changes since v22<br>
&gt; 1.=C2=A0 Rebase<br>
&gt; 2.=C2=A0 Split long comment<br>
&gt;<br>
&gt; changes since v23<br>
&gt; 1.=C2=A0 remove avr_cpu_list_compare function<br>
&gt; 2.=C2=A0 modify avr_cpu_class_by_name function<br>
&gt; 3.=C2=A0 modify avr_cpu_list_entry function<br>
&gt; 4.=C2=A0 modify avr_cpu_list function<br>
&gt;<br>
&gt; changes since v24<br>
&gt; 1.=C2=A0 remove AVR_CPU_TYPE_NAME macro<br>
&gt;<br>
&gt; changes since v25<br>
&gt; 1.=C2=A0 fix patches. every file belong to one patch only<br>
&gt; 2.=C2=A0 change copyright year from 2016 to 2019<br>
&gt; 3.=C2=A0 create mask device to emulate prr0/prr1<br>
&gt;<br>
&gt; changes since v26<br>
&gt; 1.=C2=A0 add avocado acceptence test<br>
&gt; 2.=C2=A0 add boot serial test<br>
&gt;<br>
&gt; changes since v27<br>
&gt; 1.=C2=A0 list atmel2560 devices as unimplemented<br>
&gt; 2.=C2=A0 fix sram base/size<br>
&gt;<br>
&gt; changes since v28<br>
&gt; 1.=C2=A0 rebase<br>
&gt; 2.=C2=A0 fix includes &amp; build<br>
&gt;<br>
&gt; changes since v29<br>
&gt; 1.=C2=A0 fixing ownership<br>
&gt; 2.=C2=A0 using &#39;since&#39; instread of &#39;added in&#39;<br>
&gt;<br>
&gt; changes since v30<br>
&gt; 1.=C2=A0 rebase<br>
&gt;<br>
&gt; changes since v31<br>
&gt; 1.=C2=A0 splitting &#39;Add instruction translation&#39; commit<br>
&gt; 2.=C2=A0 fixing typo in qapi/machine.json sicne -&gt; since<br>
&gt; 3.=C2=A0 removing unintended changes in configure file<br>
&gt; 4.=C2=A0 adding Richard Henderson as a co developer to &#39;Add instru=
ction translation - CPU main translation funcions&#39; commit<br>
&gt;<br>
&gt; changes since v32<br>
&gt; 1.=C2=A0 modify cpu_get_sreg to treat sreg C as other flags, except sr=
eg Z<br>
&gt;<br>
&gt; changes since v33<br>
&gt; 1.=C2=A0 ensure flag C is always calculated as one bit<br>
&gt; 2.=C2=A0 calculate flag Z as one bit, without using inverse logic<br>
&gt;<br>
&gt; changes since v34<br>
&gt; 1.=C2=A0 rebase<br>
&gt;<br>
&gt; changes since v35<br>
&gt; 1.=C2=A0 rebase<br>
&gt; 2.=C2=A0 use NANOSECONDS_PER_SECOND instead of 1000000000 in avr_timer=
16.c<br>
&gt; 3.=C2=A0 split &quot;target/avr: Register AVR support with the rest of=
 QEMU&quot; into three patches<br>
&gt;=C2=A0 =C2=A0 =C2=A01.=C2=A0 &quot;target/avr: Register AVR support wit=
h the rest of QEMU&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A02.=C2=A0 &quot;target/avr: Update build system&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A03.=C2=A0 &quot;target/avr: Update MAINTAINERS file&=
quot;<br>
&gt; 4.=C2=A0 split &quot;target/avr: Add tests&quot; patch into two patche=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A01.=C2=A0 &quot;target/avr: Add Avocado test&quot;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A02.=C2=A0 &quot;target/avr: Add boot serial test&quo=
t;<br>
&gt; 5.=C2=A0 Add instruction disassembly function<br>
&gt; 6.=C2=A0 change &quot;since 4.2&quot; to &quot;since 5.0&quot;<br>
&gt;<br>
&gt; changes since v36<br>
&gt; 1.=C2=A0 rebase<br>
&gt; 2.=C2=A0 tename<br>
&gt;=C2=A0 =C2=A0 =C2=A01.=C2=A0 NO_CPU_REGISTERS=C2=A0 =C2=A0 -&gt; NUMBER=
_OF_CPU_REGISTERS<br>
&gt;=C2=A0 =C2=A0 =C2=A02.=C2=A0 NO_IO_REGISTERS=C2=A0 =C2=A0 =C2=A0-&gt; N=
UMBER_OF_IO_REGISTERS<br>
&gt;=C2=A0 =C2=A0 =C2=A03.=C2=A0 to_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -&gt; to_regs_16_31_by_one<br>
&gt;=C2=A0 =C2=A0 =C2=A04.=C2=A0 to_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -&gt; to_regs_16_23_by_one<br>
&gt;=C2=A0 =C2=A0 =C2=A05.=C2=A0 to_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -&gt; to_regs_24_30_by_two<br>
&gt;=C2=A0 =C2=A0 =C2=A06.=C2=A0 to_D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 -&gt; to_regs_00_30_by_two<br>
&gt; 3.=C2=A0 add missing licences<br>
&gt; 4.=C2=A0 add usage example (see above)<br>
&gt; 5.=C2=A0 ass Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk"=
 target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt; as a reviewer to MAINTAINE=
RS<br>
&gt; 7.=C2=A0 use git commit sha1 instead of `master`` in avocado test<br>
&gt;<br>
&gt; Michael Rolnik (16):<br>
&gt;=C2=A0 =C2=A0target/avr: Add outward facing interfaces and core CPU log=
ic<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction helpers<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction decoding<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction translation - Registers defini=
tion<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction translation - Arithmetic and L=
ogic<br>
&gt;=C2=A0 =C2=A0 =C2=A0Instructions<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction translation - Branch Instructi=
ons<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction translation - Bit and Bit-test=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0Instructions<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction translation - MCU Control Inst=
ructions<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction translation - CPU main transla=
tion<br>
&gt;=C2=A0 =C2=A0 =C2=A0function<br>
&gt;=C2=A0 =C2=A0target/avr: Add instruction disassembly function<br>
&gt;=C2=A0 =C2=A0target/avr: Add example board configuration<br>
&gt;=C2=A0 =C2=A0target/avr: Register AVR support with the rest of QEMU<br>
&gt;=C2=A0 =C2=A0target/avr: Update build system<br>
&gt;=C2=A0 =C2=A0target/avr: Add boot serial test<br>
&gt;=C2=A0 =C2=A0target/avr: Add Avocado test<br>
&gt;=C2=A0 =C2=A0target/avr: Update MAINTAINERS file<br>
&gt;<br>
&gt; Sarah Harris (1):<br>
&gt;=C2=A0 =C2=A0target/avr: Add limited support for USART and 16 bit timer=
 peripherals<br>
&gt;<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
&gt;=C2=A0 default-configs/avr-softmmu.<wbr>mak=C2=A0 |=C2=A0 =C2=A0 5 +<br=
>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;=C2=A0 include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 6 +<br>
&gt;=C2=A0 include/hw/char/avr_usart.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A097=
 +<br>
&gt;=C2=A0 include/hw/misc/avr_mask.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A047 +<br>
&gt;=C2=A0 include/hw/timer/avr_timer16.<wbr>h=C2=A0 =C2=A0|=C2=A0 =C2=A097=
 +<br>
&gt;=C2=A0 include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 1 +<br>
&gt;=C2=A0 target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A037 +<br>
&gt;=C2=A0 target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A054 +<br>
&gt;=C2=A0 target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 254 +++<br>
&gt;=C2=A0 target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A029 +<br>
&gt;=C2=A0 arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 282 +++<br>
&gt;=C2=A0 hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 324 ++++<br>
&gt;=C2=A0 hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 112 ++<br>
&gt;=C2=A0 hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 605 ++++++<br>
&gt;=C2=A0 target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 576 ++++++<br>
&gt;=C2=A0 target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 228 +++<br>
&gt;=C2=A0 target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A085 +<br>
&gt;=C2=A0 target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 354 ++++<br>
&gt;=C2=A0 target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 121 ++<br>
&gt;=C2=A0 target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 3052 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 tests/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A010 +<br>
&gt;=C2=A0 tests/machine-none-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 1 +<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A011 +<br>
&gt;=C2=A0 gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A049 +<br>
&gt;=C2=A0 hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
&gt;=C2=A0 hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;=C2=A0 hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A034 +<br>
&gt;=C2=A0 target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 194 ++<br>
&gt;=C2=A0 tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 tests/acceptance/machine_avr6.<wbr>py |=C2=A0 =C2=A056 +<br>
&gt;=C2=A0 40 files changed, 6756 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 default-configs/avr-softmmu.<wbr>mak<br>
&gt;=C2=A0 create mode 100644 include/hw/char/avr_usart.h<br>
&gt;=C2=A0 create mode 100644 include/hw/misc/avr_mask.h<br>
&gt;=C2=A0 create mode 100644 include/hw/timer/avr_timer16.h<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu-param.h<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu-qom.h<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu.h<br>
&gt;=C2=A0 create mode 100644 target/avr/helper.h<br>
&gt;=C2=A0 create mode 100644 hw/avr/sample.c<br>
&gt;=C2=A0 create mode 100644 hw/char/avr_usart.c<br>
&gt;=C2=A0 create mode 100644 hw/misc/avr_mask.c<br>
&gt;=C2=A0 create mode 100644 hw/timer/avr_timer16.c<br>
&gt;=C2=A0 create mode 100644 target/avr/cpu.c<br>
&gt;=C2=A0 create mode 100644 target/avr/disas.c<br>
&gt;=C2=A0 create mode 100644 target/avr/gdbstub.c<br>
&gt;=C2=A0 create mode 100644 target/avr/helper.c<br>
&gt;=C2=A0 create mode 100644 target/avr/machine.c<br>
&gt;=C2=A0 create mode 100644 target/avr/translate.c<br>
&gt;=C2=A0 create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt;=C2=A0 create mode 100644 hw/avr/Kconfig<br>
&gt;=C2=A0 create mode 100644 hw/avr/Makefile.objs<br>
&gt;=C2=A0 create mode 100644 target/avr/Makefile.objs<br>
&gt;=C2=A0 create mode 100644 target/avr/insn.decode<br>
&gt;=C2=A0 create mode 100644 tests/acceptance/machine_avr6.<wbr>py<br>
&gt;<br>
&gt; --<br>
&gt; 2.17.2 (Apple Git-113)<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div></div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--0000000000001551cb05986820fd--

