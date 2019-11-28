Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B44C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0B520656
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTqmZj2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0B520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOfG-0004yv-RS
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaMWe-00021Q-5T
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaMWZ-0002GQ-Ow
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:20:15 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaMWW-00026u-FB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:20:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id n5so12281259wmc.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h/NwIwl1KzXQY2A9Zd8PGXpNFflmJl7g6B5YB2hYAxQ=;
 b=OTqmZj2aHAwdSE9F7ce6YBjIyR0R9MEefERyz/6xIfV3yMI81q2zxDzjcke8IGd0Wk
 vZ+dBUuvFp8QtP44h8U5EK0yiwjPzU8G03s/oSJE6nMMjJcnsyKq4AuVPut2dYuhnBBp
 ljSW2VR6LU7RN4C6O/E2sBULRXvepyIEfwtC0e6mIUgUGbAXXg7twoBoKqienOmW7Qhz
 LgVV8DFbBu6e5lz2spemV+n0YkYcr8F4wt/borYOqaOJIAmFfdpEAzRMJdwr3eQixjY0
 TUhkH7wWnXoKnwEYHSV3ZvpjMBXQ5LhJ9mgpH3OdGkzztTJmM9w395n999vuV7wqMjrH
 Herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h/NwIwl1KzXQY2A9Zd8PGXpNFflmJl7g6B5YB2hYAxQ=;
 b=iutnQb5dfsYCDwYqKaHoVbOXT4KJLwD4sOmR4qOIm19Cs8qbD6LLwF/hQpSbm6iohD
 NuoG+S+NDPYfLEawt/DZAOHvFRnni8LZEEBCz6m7OeXLfujqqRa7iIFkHj3Yx856rtVA
 FkNbGjPeWZmRrvGji90pOQLnWl/NqFeF6GhQ2QcMehdCNtcEgRzQmJ3ZRSHh8TDUMMgj
 3Gmj5AvYzpBXILmrPogW5a7d3aQaWeqfLFyxmJb//GKm1dySUJ2nflo8Bd4fkoHUnImu
 lHy/tukMb4RPAgGhpmLJyeJehe5zhA+GYzgkV0zQNotJFDiPq9LNUK/Yr3iXGKQsi7T4
 MzLw==
X-Gm-Message-State: APjAAAUxGlWvauFjPRBuiGEVj3FcgnbIJ+VFu4J+SI/RDXcW/J9DaU1t
 J9JCZ9SmlTaQHyG+I1g+Td04Qg==
X-Google-Smtp-Source: APXvYqy1aN4VV9hGS4uRNeWYIqsnRtAt3mHeA6wsGqvSptcK/8Cnhbo4nIdjOpnTJiucj33hsNBfAA==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr6419200wma.134.1574958004517; 
 Thu, 28 Nov 2019 08:20:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f6sm24340974wrr.15.2019.11.28.08.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 08:20:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2CA4D1FF87;
 Thu, 28 Nov 2019 16:20:02 +0000 (GMT)
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
 <CAL1e-=ge=VyeQQRFVoZQPix0vSiWapt0+iByMmG6MmKc7KUCGg@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
In-reply-to: <CAL1e-=ge=VyeQQRFVoZQPix0vSiWapt0+iByMmG6MmKc7KUCGg@mail.gmail.com>
Date: Thu, 28 Nov 2019 16:20:02 +0000
Message-ID: <87o8wwezwt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> I don't see why you say that the peripherals are inside the chip, there =
is
>> CPU within target/avr directory and then there are some peripherals in hw
>> directory, CPU does not depend on them. what am I missing?
>>
>>>
>>>
> I meant these peripherals are physically inside the chip together with the
> core.
>
> And USART in a micricontroler from 2010 is different than USART from one
> from 2018.

Won't these be different chip parts? Or at least revs of the part?

I think broadly the difference between SoC devices is handled by
handling versioning in the board models - the board being in this case a
CPU core + a bunch of SoC components + the actual board itself.

All the target/cpu stuff needs to deal with is actual architectural
revs (c.f. target/arm/cpu[64].c).

>
>
>> On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>>
>>>
>>>
>>> On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com> wrot=
e:
>>>
>>>>
>>>>
>>>> On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic <
>>>> aleksandar.m.mail@gmail.com> wrote:
>>>>
>>>>> On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik <mrolnik@gmail.com>
>>>>> wrote:
>>>>> >
>>>>> > This series of patches adds 8bit AVR cores to QEMU.
>>>>> > All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not
>>>>> fully tested yet.
>>>>> > However I was able to execute simple code with functions. e.g
>>>>> fibonacci calculation.
>>>>> > This series of patches include a non real, sample board.
>>>>> > No fuses support yet. PC is set to 0 at reset.
>>>>> >
>>>>>
>>>>> I have a couple of general remarks, so I am responding to the cover
>>>>> letter, not individual patches.
>>>>>
>>>>> 1) The licenses for Sarah devices differ than the rest - shouldn't all
>>>>> licenses be harmonized?
>>>>
>>>> Sarah,
>>>> do you mind if use the same license I use for my code?
>>>>
>>>>
>>>>>
>>>>
>>>>
>>>>> 2) There is an architectural problem with peripherals. It is possible
>>>>> that they evolve over time, so, for example, USART could not be the
>>>>> same for older and newer CPUs (in principle, newer peripheral is
>>>>> expected to be o sort of "superset" of the older). How do you solve
>>>>> that problem? Right now, it may not looks serious to you, but if you
>>>>> don;t think about that right now, from the outset, soon the code will
>>>>> become so entangled, ti woudl be almost very difficult to fix it.
>>>>> Please think about that, how would you solve it, is there a way to
>>>>> pass the information on the currently emulated CPU to the code
>>>>> covering a peripheral, and provide a different behaviour?
>>>>>
>>>> Hi Aleksandar,
>>>>
>>>> Please explain.
>>>>
>>>>
>>> My concern is about peripherals inside the chip, together with the core.
>>>
>>> If one models, let's say an external (in the sense, it is a separate
>>> chip) ADC (analog-to-digital converter), one looks at specs, implement =
what
>>> is resonable possible in QEMU, plug it in in one of machines thst conta=
ins
>>> it, and that's it. That ADC remains the same, of course, whatever the
>>> surrounding system is.
>>>
>>> In AVR case, I think we have a phenomenon likes of which we didn't see
>>> before (at least I don't know about). Number of AVR microcontrollers is
>>> very large, and both cores and peripherals evolved.
>>>
>>> For cores, you handle differences with all these AVR_FEATURE macros, and
>>> this seems to be working, no significant objection from my side, and btw
>>> that was not an easy task to execute, all admiration from me.
>>>
>>> But what about peripherals inside the chip? A peripheral with the same
>>> name and the same general area of functionality may be differently
>>> specified for microcontrollers from 2010 and 2018. By the difference I
>>> don't mean starting address, but the difference in behavior. I don't ha=
ve
>>> time right now to spell many examples, but I read three different specs,
>>> and there are differences in USART specifications.
>>>
>>> I am not clear what is your envisioned solution for these cases. Would
>>> you such close, but not the same, flabors of a peripheral treat as if t=
hey
>>> are two completely separate cases of a peripheral? Or would you have a
>>> single peripheral that would somehow configure itself depending on the =
core
>>> it is attached to?
>>>
>>> I hope I was clearer this time.
>>>
>>> Aleksandar
>>>
>>>
>>>
>>>>
>>>>
>>>>
>>>> I don't see any problem from CPU's perspective.
>>>> as for the sample board is just a sample, I hope other people will
>>>> create real models or real hw.
>>>> there was no way I could provide a CPU alone, that's why there is samp=
le.
>>>>
>>>>
>>>>
>>>>>
>>>>> > Following are examples of possible usages, assuming program.elf is
>>>>> compiled for AVR cpu
>>>>> > 1.  Continious non interrupted execution
>>>>> >     run `qemu-system-avr -kernel program.elf`
>>>>> > 2.  Continious non interrupted execution with serial output into
>>>>> telnet window
>>>>> >     run `qemu-system-avr -kernel program.elf -serial
>>>>> tcp::5678,server,nowait -nographic `
>>>>> >     run `telent localhost 5678`
>>>>> > 3.  Continious non interrupted execution with serial output into
>>>>> stdout
>>>>> >     run `qemu-system-avr -kernel program.elf -serial stdio`
>>>>> > 4.  Debugging wit GDB debugger
>>>>> >     run `qemu-system-avr -kernel program.elf -s -S`
>>>>> >     run `avr-gdb program.elf` and then within GDB shell `target
>>>>> remote :1234`
>>>>> > 5.  Print out executed instructions
>>>>> >     run `qemu-system-avr -kernel program.elf -d in_asm`
>>>>> >
>>>>>
>>>>> Thank you so much for these examples!
>>>>>
>>>>> Aleksandar
>>>>>
>>>>>
>>>>> >
>>>>> > the patches include the following
>>>>> > 1. just a basic 8bit AVR CPU, without instruction decoding or
>>>>> translation
>>>>> > 2. CPU features which allow define the following 8bit AVR cores
>>>>> >      avr1
>>>>> >      avr2 avr25
>>>>> >      avr3 avr31 avr35
>>>>> >      avr4
>>>>> >      avr5 avr51
>>>>> >      avr6
>>>>> >      xmega2 xmega4 xmega5 xmega6 xmega7
>>>>> > 3. a definition of sample machine with SRAM, FLASH and CPU which
>>>>> allows to execute simple code
>>>>> > 4. encoding for all AVR instructions
>>>>> > 5. interrupt handling
>>>>> > 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>>>>> > 7. a decoder which given an opcode decides what istruction it is
>>>>> > 8. translation of AVR instruction into TCG
>>>>> > 9. all features together
>>>>> >
>>>>> > changes since v3
>>>>> > 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of
>>>>> 0x000000ff) for faster address manipulaton
>>>>> > 2. ffs changed to ctz32
>>>>> > 3. duplicate code removed at avr_cpu_do_interrupt
>>>>> > 4. using andc instead of not + and
>>>>> > 5. fixing V flag calculation in varios instructions
>>>>> > 6. freeing local variables in PUSH
>>>>> > 7. tcg_const_local_i32 -> tcg_const_i32
>>>>> > 8. using sextract32 instead of my implementation
>>>>> > 9. fixing BLD instruction
>>>>> > 10.xor(r) instead of 0xff - r at COM
>>>>> > 11.fixing MULS/MULSU not to modify inputs' content
>>>>> > 12.using SUB for NEG
>>>>> > 13.fixing tcg_gen_qemu_ld/st call in XCH
>>>>> >
>>>>> > changes since v4
>>>>> > 1. target is now defined as big endian in order to optimize
>>>>> push_ret/pop_ret
>>>>> > 2. all style warnings are fixed
>>>>> > 3. adding cpu_set/get_sreg functions
>>>>> > 4. simplifying gen_goto_tb as there is no real paging
>>>>> > 5. env->pc -> env->pc_w
>>>>> > 6. making flag dump more compact
>>>>> > 7. more spacing
>>>>> > 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
>>>>> > 9. removing avr_set_feature
>>>>> > 10. SPL/SPH set bug fix
>>>>> > 11. switching stb_phys to cpu_stb_data
>>>>> > 12. cleaning up avr_decode
>>>>> > 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
>>>>> > 14. saving CPU features (savevm)
>>>>> >
>>>>> > changes since v5
>>>>> > 1. BLD bug fix
>>>>> > 2. decoder generator is added
>>>>> >
>>>>> > chages since v6
>>>>> > 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_
>>>>> cpu_gdb_write_register
>>>>> > 2. configure the target as little endian because otherwise GDB does
>>>>> not work
>>>>> > 3. fixing and testing gen_push_ret/gen_pop_ret
>>>>> >
>>>>> > changes since v7
>>>>> > 1. folding back v6
>>>>> > 2. logging at helper_outb and helper_inb are done for non supported
>>>>> yet registers only
>>>>> > 3. MAINTAINERS updated
>>>>> >
>>>>> > changes since v8
>>>>> > 1. removing hw/avr from hw/Makefile.obj as it should not be built f=
or
>>>>> all
>>>>> > 2. making linux compilable
>>>>> > 3. testing on
>>>>> >     a. Mac, Apple LLVM version 7.0.0
>>>>> >     b. Ubuntu 12.04, gcc 4.9.2
>>>>> >     c. Fedora 23, gcc 5.3.1
>>>>> > 4. folding back some patches
>>>>> > 5. translation bug fixes for ORI, CPI, XOR instructions
>>>>> > 6. propper handling of cpu register writes though memory
>>>>> >
>>>>> > changes since v9
>>>>> > 1. removing forward declarations of static functions
>>>>> > 2. disabling debug prints
>>>>> > 3. switching to case range instead of if else if ...
>>>>> > 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed =
to
>>>>> any device
>>>>> > 5. commenst about sample board and sample IO device added
>>>>> > 6. sample board description is more descriptive now
>>>>> > 7. memory_region_allocate_system_memory is used to create RAM
>>>>> > 8. now there are helper_fullrd & helper_fullwr when LD/ST try to
>>>>> access registers
>>>>> >
>>>>> > changes since v10
>>>>> > 1. movig back fullwr & fullrd into the commit where outb and inb we=
re
>>>>> introduced
>>>>> > 2. changing tlb_fill function signature
>>>>> > 3. adding empty line between functions
>>>>> > 4. adding newline on the last line of the file
>>>>> > 5. using tb->flags to generae full access ST/LD instructions
>>>>> > 6. fixing SBRC bug
>>>>> > 7. folding back 10th commit
>>>>> > 8. whenever a new file is introduced it's added to Makefile.objs
>>>>> >
>>>>> > changes since v11
>>>>> > 1. updating to v2.7.0-rc
>>>>> > 2. removing assignment to env->fullacc from gen_intermediate_code
>>>>> >
>>>>> > changes since v12
>>>>> > 1. fixing spacing
>>>>> > 2. fixing get/put_segment functions
>>>>> > 3. removing target-avr/machine.h file
>>>>> > 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
>>>>> > 5. comment spelling
>>>>> > 6. removing hw/avr/sample_io.c
>>>>> > 7. char const* -> const char*
>>>>> > 8. proper ram allocation
>>>>> > 9. fixing breakpoint functionality.
>>>>> > 10.env1 -> env
>>>>> > 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register
>>>>> functions
>>>>> > 12.any cpu is removed
>>>>> > 12.feature bits are not saved into vm state
>>>>> >
>>>>> > changes since v13
>>>>> > 1. rebasing to v2.7.0-rc1
>>>>> >
>>>>> > changes since v14
>>>>> > 1. I made self review with git gui tool. (I did not know such a thi=
ng
>>>>> exists)
>>>>> > 2. removing all double/tripple spaces
>>>>> > 3. removing comment reference to SampleIO
>>>>> > 4. folding back some changes, so there is not deleted lines in my c=
ode
>>>>> > 5. moving avr configuration, within configure file, before chris
>>>>> >
>>>>> > changes since v15
>>>>> > 1. removing IO registers cache from CPU
>>>>> > 2. implementing CBI/SBI as read(helper_inb), modify,
>>>>> write(helper_outb)
>>>>> > 3. implementing CBIC/SBIC as read(helper_inb), check, branch
>>>>> > 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>>>>> >
>>>>> > changes since v16
>>>>> > 1. removing EXT IO registers knoledge from CPU. These registers are
>>>>> accessible
>>>>> >    by LD/ST only. CPU has no interest in them
>>>>> >
>>>>> > changes since v17 (by Richard Henderson)
>>>>> > This is Michael's v17, with some adjustments of my own:
>>>>> >
>>>>> > 1. Fix the whitespace errors reported by "git am",
>>>>> > 2. Replace the utf-8 characters with normal ascii,
>>>>> > 3. Ditch the separate compilation of translate.c.
>>>>> >
>>>>> > I retained the two separate files that could be regenerated
>>>>> > from the included cpugen program, but merged in translate-insn.c.
>>>>> > Not that it matters, but the code generated is about 3k smaller.
>>>>> >
>>>>> > changes since v18
>>>>> > 1.  moving target-avr into target/avr
>>>>> > 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
>>>>> > 3.  call cpu_exec_realizefn avr_cpu_realizefn
>>>>> > 4.  do not fail sample machine creation if no rom is suplied
>>>>> > 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
>>>>> > 6.  fix a register getters/setters in machine.c
>>>>> > 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>>>>> >
>>>>> > changes since v19
>>>>> > 1.  use decodetree.py tool to decode instructions
>>>>> > 2.  adding USART
>>>>> > 3.  adding 16 bit timer peripherals
>>>>> > 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
>>>>> > 5.  renaming tlb_fill to avr_cpu_tlb_fill
>>>>> >
>>>>> > changes since v20
>>>>> > 1.  use one CPU naming convention
>>>>> > 2.  merging insn16.decode & insn32.decode files
>>>>> > 3.  modifying skip next instruction mechanizm
>>>>> > 4.  translate BREAK as NOP for now
>>>>> >
>>>>> > changes since v21
>>>>> > 1.  Reorganize bstate.
>>>>> >     This will make transition to <exec/translator.h> easier, and
>>>>> fixes a couple of bugs wrt single stepping
>>>>> >     by richard.henderson@linaro.org
>>>>> > 2.  Drop cpc and fix page cross condition.
>>>>> >     by richard.henderson@linaro.org
>>>>> > 3.  Refactor checking supported/unsupported instructions
>>>>> > 4.  Add gdb-xml/avr-cpu.xml
>>>>> >
>>>>> > changes since v22
>>>>> > 1.  Rebase
>>>>> > 2.  Split long comment
>>>>> >
>>>>> > changes since v23
>>>>> > 1.  remove avr_cpu_list_compare function
>>>>> > 2.  modify avr_cpu_class_by_name function
>>>>> > 3.  modify avr_cpu_list_entry function
>>>>> > 4.  modify avr_cpu_list function
>>>>> >
>>>>> > changes since v24
>>>>> > 1.  remove AVR_CPU_TYPE_NAME macro
>>>>> >
>>>>> > changes since v25
>>>>> > 1.  fix patches. every file belong to one patch only
>>>>> > 2.  change copyright year from 2016 to 2019
>>>>> > 3.  create mask device to emulate prr0/prr1
>>>>> >
>>>>> > changes since v26
>>>>> > 1.  add avocado acceptence test
>>>>> > 2.  add boot serial test
>>>>> >
>>>>> > changes since v27
>>>>> > 1.  list atmel2560 devices as unimplemented
>>>>> > 2.  fix sram base/size
>>>>> >
>>>>> > changes since v28
>>>>> > 1.  rebase
>>>>> > 2.  fix includes & build
>>>>> >
>>>>> > changes since v29
>>>>> > 1.  fixing ownership
>>>>> > 2.  using 'since' instread of 'added in'
>>>>> >
>>>>> > changes since v30
>>>>> > 1.  rebase
>>>>> >
>>>>> > changes since v31
>>>>> > 1.  splitting 'Add instruction translation' commit
>>>>> > 2.  fixing typo in qapi/machine.json sicne -> since
>>>>> > 3.  removing unintended changes in configure file
>>>>> > 4.  adding Richard Henderson as a co developer to 'Add instruction
>>>>> translation - CPU main translation funcions' commit
>>>>> >
>>>>> > changes since v32
>>>>> > 1.  modify cpu_get_sreg to treat sreg C as other flags, except sreg=
 Z
>>>>> >
>>>>> > changes since v33
>>>>> > 1.  ensure flag C is always calculated as one bit
>>>>> > 2.  calculate flag Z as one bit, without using inverse logic
>>>>> >
>>>>> > changes since v34
>>>>> > 1.  rebase
>>>>> >
>>>>> > changes since v35
>>>>> > 1.  rebase
>>>>> > 2.  use NANOSECONDS_PER_SECOND instead of 1000000000 in avr_timer16=
.c
>>>>> > 3.  split "target/avr: Register AVR support with the rest of QEMU"
>>>>> into three patches
>>>>> >     1.  "target/avr: Register AVR support with the rest of QEMU"
>>>>> >     2.  "target/avr: Update build system"
>>>>> >     3.  "target/avr: Update MAINTAINERS file"
>>>>> > 4.  split "target/avr: Add tests" patch into two patches
>>>>> >     1.  "target/avr: Add Avocado test"
>>>>> >     2.  "target/avr: Add boot serial test"
>>>>> > 5.  Add instruction disassembly function
>>>>> > 6.  change "since 4.2" to "since 5.0"
>>>>> >
>>>>> > changes since v36
>>>>> > 1.  rebase
>>>>> > 2.  tename
>>>>> >     1.  NO_CPU_REGISTERS    -> NUMBER_OF_CPU_REGISTERS
>>>>> >     2.  NO_IO_REGISTERS     -> NUMBER_OF_IO_REGISTERS
>>>>> >     3.  to_A                -> to_regs_16_31_by_one
>>>>> >     4.  to_B                -> to_regs_16_23_by_one
>>>>> >     5.  to_C                -> to_regs_24_30_by_two
>>>>> >     6.  to_D                -> to_regs_00_30_by_two
>>>>> > 3.  add missing licences
>>>>> > 4.  add usage example (see above)
>>>>> > 5.  ass Sarah Harris <S.E.Harris@kent.ac.uk> as a reviewer to
>>>>> MAINTAINERS
>>>>> > 7.  use git commit sha1 instead of `master`` in avocado test
>>>>> >
>>>>> > Michael Rolnik (16):
>>>>> >   target/avr: Add outward facing interfaces and core CPU logic
>>>>> >   target/avr: Add instruction helpers
>>>>> >   target/avr: Add instruction decoding
>>>>> >   target/avr: Add instruction translation - Registers definition
>>>>> >   target/avr: Add instruction translation - Arithmetic and Logic
>>>>> >     Instructions
>>>>> >   target/avr: Add instruction translation - Branch Instructions
>>>>> >   target/avr: Add instruction translation - Bit and Bit-test
>>>>> >     Instructions
>>>>> >   target/avr: Add instruction translation - MCU Control Instructions
>>>>> >   target/avr: Add instruction translation - CPU main translation
>>>>> >     function
>>>>> >   target/avr: Add instruction disassembly function
>>>>> >   target/avr: Add example board configuration
>>>>> >   target/avr: Register AVR support with the rest of QEMU
>>>>> >   target/avr: Update build system
>>>>> >   target/avr: Add boot serial test
>>>>> >   target/avr: Add Avocado test
>>>>> >   target/avr: Update MAINTAINERS file
>>>>> >
>>>>> > Sarah Harris (1):
>>>>> >   target/avr: Add limited support for USART and 16 bit timer
>>>>> peripherals
>>>>> >
>>>>> >  configure                        |    7 +
>>>>> >  default-configs/avr-softmmu.mak  |    5 +
>>>>> >  qapi/machine.json                |    3 +-
>>>>> >  include/disas/dis-asm.h          |    6 +
>>>>> >  include/hw/char/avr_usart.h      |   97 +
>>>>> >  include/hw/misc/avr_mask.h       |   47 +
>>>>> >  include/hw/timer/avr_timer16.h   |   97 +
>>>>> >  include/sysemu/arch_init.h       |    1 +
>>>>> >  target/avr/cpu-param.h           |   37 +
>>>>> >  target/avr/cpu-qom.h             |   54 +
>>>>> >  target/avr/cpu.h                 |  254 +++
>>>>> >  target/avr/helper.h              |   29 +
>>>>> >  arch_init.c                      |    2 +
>>>>> >  hw/avr/sample.c                  |  282 +++
>>>>> >  hw/char/avr_usart.c              |  324 ++++
>>>>> >  hw/misc/avr_mask.c               |  112 ++
>>>>> >  hw/timer/avr_timer16.c           |  605 ++++++
>>>>> >  target/avr/cpu.c                 |  576 ++++++
>>>>> >  target/avr/disas.c               |  228 +++
>>>>> >  target/avr/gdbstub.c             |   85 +
>>>>> >  target/avr/helper.c              |  354 ++++
>>>>> >  target/avr/machine.c             |  121 ++
>>>>> >  target/avr/translate.c           | 3052
>>>>> ++++++++++++++++++++++++++++++
>>>>> >  tests/boot-serial-test.c         |   10 +
>>>>> >  tests/machine-none-test.c        |    1 +
>>>>> >  MAINTAINERS                      |   11 +
>>>>> >  gdb-xml/avr-cpu.xml              |   49 +
>>>>> >  hw/Kconfig                       |    1 +
>>>>> >  hw/avr/Kconfig                   |    6 +
>>>>> >  hw/avr/Makefile.objs             |    1 +
>>>>> >  hw/char/Kconfig                  |    3 +
>>>>> >  hw/char/Makefile.objs            |    1 +
>>>>> >  hw/misc/Kconfig                  |    3 +
>>>>> >  hw/misc/Makefile.objs            |    2 +
>>>>> >  hw/timer/Kconfig                 |    3 +
>>>>> >  hw/timer/Makefile.objs           |    2 +
>>>>> >  target/avr/Makefile.objs         |   34 +
>>>>> >  target/avr/insn.decode           |  194 ++
>>>>> >  tests/Makefile.include           |    2 +
>>>>> >  tests/acceptance/machine_avr6.py |   56 +
>>>>> >  40 files changed, 6756 insertions(+), 1 deletion(-)
>>>>> >  create mode 100644 default-configs/avr-softmmu.mak
>>>>> >  create mode 100644 include/hw/char/avr_usart.h
>>>>> >  create mode 100644 include/hw/misc/avr_mask.h
>>>>> >  create mode 100644 include/hw/timer/avr_timer16.h
>>>>> >  create mode 100644 target/avr/cpu-param.h
>>>>> >  create mode 100644 target/avr/cpu-qom.h
>>>>> >  create mode 100644 target/avr/cpu.h
>>>>> >  create mode 100644 target/avr/helper.h
>>>>> >  create mode 100644 hw/avr/sample.c
>>>>> >  create mode 100644 hw/char/avr_usart.c
>>>>> >  create mode 100644 hw/misc/avr_mask.c
>>>>> >  create mode 100644 hw/timer/avr_timer16.c
>>>>> >  create mode 100644 target/avr/cpu.c
>>>>> >  create mode 100644 target/avr/disas.c
>>>>> >  create mode 100644 target/avr/gdbstub.c
>>>>> >  create mode 100644 target/avr/helper.c
>>>>> >  create mode 100644 target/avr/machine.c
>>>>> >  create mode 100644 target/avr/translate.c
>>>>> >  create mode 100644 gdb-xml/avr-cpu.xml
>>>>> >  create mode 100644 hw/avr/Kconfig
>>>>> >  create mode 100644 hw/avr/Makefile.objs
>>>>> >  create mode 100644 target/avr/Makefile.objs
>>>>> >  create mode 100644 target/avr/insn.decode
>>>>> >  create mode 100644 tests/acceptance/machine_avr6.py
>>>>> >
>>>>> > --
>>>>> > 2.17.2 (Apple Git-113)
>>>>> >
>>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Michael Rolnik
>>>>
>>>
>>
>> --
>> Best Regards,
>> Michael Rolnik
>>


--=20
Alex Benn=C3=A9e

