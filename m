Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F17C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CBD2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ookE7eJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CBD2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibt4H-0004al-QC
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibt2w-0003zT-9r
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibt2r-0004wd-NM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:15:54 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibt2r-0004tj-CY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:15:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id o9so908162ote.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=bWUnJoztRm2hFyB2wFKtfJcuWrmPTd0j1Rl8/REqBUA=;
 b=ookE7eJS1sBcdVvVfsDuBiSir0cBzxQh9Cmo9lqBTwp2yQAr0v8p/xQm5bV0B2oJVw
 I0evjgTGRZt66twUx9C+kjTxJH6hlNzVS0HOD6lhFcEAEFv28hN9lHnjkugyWG3OJJcz
 pGe6d2jNuGYU2cZ20bFqErni0idw4qVIu+e8U4k4kQ8ngCFrF4ZzGszRqHXp1pMkfLTG
 nyOQZdglgVvBgVKQjLJ90y/XvkmFvV0R5lUh8E1BLj7SfrCkL18DEHlQpxsWFmcIqNga
 KzyisLdnRLJX6aYNj0wyHyrD5Hc2W4auhdouEAiSNdavgr5iscgnI7iUl/p/yv8S9rvp
 1smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=bWUnJoztRm2hFyB2wFKtfJcuWrmPTd0j1Rl8/REqBUA=;
 b=eAIEh9JSm2lv1ZaHLNdFQRkOQSGm0cnfYvpJ1MPym3SMj1SHy1OQy4LBTkhDPkPa6v
 bYueVGhwqMkkq34Bd/nF0CDKjurWPp95Zhk7lQTM0y1VdEQmysm0Ko/hiLMkqGC0D8CR
 BFuFmNw4LM0iIHC8/5Y4brqx3pCQin8mruf9KADI8v/Sv+oCTwe14nVBQnt3o7q5dWnw
 sDFy6O2VNCMe46USQWr6VfkkeNXN+KtBJqBUcvoOWQPgapZZodJ5ykgRyNKXSYsnzoiZ
 zOalQ8lDtIapMI3pMsWf3QgtDRDs6nSGNnFHbzvxz66D7MuelGnLawbskftP2tUW9atA
 OzhQ==
X-Gm-Message-State: APjAAAUdMat8mPCRVFeYzNTxW8DFsrobbw7ZpDG7uQ+JSk9bofKAr8gU
 PL8ylQITCPfpOP4K43Wp0bLcVJ3G503flQ2GpiQ=
X-Google-Smtp-Source: APXvYqxq2M73B3KCGY6CvgDT2Nsl14vzFOS+Jhz/J42FBvxOmBX17Z+EniTyeUvQUkN11QKGmhFPmoZOmVFU7Cw6OoY=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr793126oth.121.1575321340191;
 Mon, 02 Dec 2019 13:15:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 2 Dec 2019 13:15:39 -0800 (PST)
In-Reply-To: <CAK4993jbZDjoJ5x_9b1pHo7imgborCZgd7k+2EZMUKdge17xcQ@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=jNaLAm2D0pq1fQjOV8VNvgQK=hDFQhRttPK=XGciBGiw@mail.gmail.com>
 <CAK4993gcVLrj08s20wG94WMa7sLEJNeJpW=b18xVFctc3icx3g@mail.gmail.com>
 <CAL1e-=ieOQMPBbRL-jWmYfkxvhJp018P36tA53S4+jHu7GVKqQ@mail.gmail.com>
 <CAL1e-=huQjFjJ0rE4G19FvEjPOJ5QuU=JhFDKSXcL47MpZAAzQ@mail.gmail.com>
 <CAK4993jR5nRbCOXY1X_O8HFX-2Y28hjAe4rObU9hvued=u93gg@mail.gmail.com>
 <CAL1e-=j-W7s+3G=ht6iYufWpu_5R5G+ijVEaczqjpBDVcY5yUg@mail.gmail.com>
 <CAK4993jbZDjoJ5x_9b1pHo7imgborCZgd7k+2EZMUKdge17xcQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Dec 2019 22:15:39 +0100
Message-ID: <CAL1e-=h0L0WTyjT_1-sgwJPyNVu0sY+H6FQL4eH2U4a5eLLSUg@mail.gmail.com>
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e3aa3b0598bf1490"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e3aa3b0598bf1490
Content-Type: text/plain; charset="UTF-8"

On Monday, December 2, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> how can I get this elf flags from within QEMU?
>
>>
>>
In one of files from your "machine" patch, you have this snippet:

+        bytes_loaded = load_elf(
+            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0,
0);

With this line you a kind of "blindly" load whatever you find in the file
"filename". I think you need to modify load_elf() to fetch the information
on what core the elf in question is compiled for. Additionally, you most
likely have to check if the elf file is compiled for AVR at all.

I don't know enough about AVR-specifics of ELF format, but I know that we
in MIPS read successfuly some MIPS-specific things we need to know. Do some
research for ELF format headrr content for AVR.

This is really missing in your series, seriously.

Please keep in mind that I don't have right now at hand any dev system, so
all I said here is off of my head.

You have to do some code digging.

Best regards, Aleksandar


> On Mon, Dec 2, 2019 at 4:01 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Monday, December 2, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>> No, I don't.
>>> but I also can load and execute a binary file which does not have this
>>> information.
>>>
>>>>
>>>>
>> OK. Let's think about that for a while. I currently think you have here
>> an opportunity to add a really clean interface from the outset of AVR
>> support in QEMU (that even some established platforms don't have in full),
>> which is, trust me, very important for future. And it not that difficult to
>> implement at all. But let's both think for a while.
>>
>> Best regards,
>> Aleksandar
>>
>>
>>
>>> On Mon, Dec 2, 2019 at 11:59 AM Aleksandar Markovic <
>>> aleksandar.m.mail@gmail.com> wrote:
>>>
>>>>
>>>>
>>>> On Monday, December 2, 2019, Aleksandar Markovic <
>>>> aleksandar.m.mail@gmail.com> wrote:
>>>>
>>>>>
>>>>>
>>>>> On Saturday, November 30, 2019, Michael Rolnik <mrolnik@gmail.com>
>>>>> wrote:
>>>>>
>>>>>> There is *-cpu *option where you can specify what CPU you want, if
>>>>>> this option is not specified avr6 (avr6-avr-cpu) is chosen.
>>>>>>
>>>>>> *./avr-softmmu/qemu-system-avr -cpu help*
>>>>>> avr1-avr-cpu
>>>>>> avr2-avr-cpu
>>>>>> avr25-avr-cpu
>>>>>> avr3-avr-cpu
>>>>>> avr31-avr-cpu
>>>>>> avr35-avr-cpu
>>>>>> avr4-avr-cpu
>>>>>> avr5-avr-cpu
>>>>>> avr51-avr-cpu
>>>>>> avr6-avr-cpu
>>>>>> xmega2-avr-cpu
>>>>>> xmega4-avr-cpu
>>>>>> xmega5-avr-cpu
>>>>>> xmega6-avr-cpu
>>>>>> xmega7-avr-cpu
>>>>>>
>>>>>>
>>>>> What happens if you specify a core via -cpu, and supply elf file
>>>>> compiled for another core?
>>>>>
>>>>>
>>>> It looks there is some related info written in ELF header. This is from
>>>> a binutils header:
>>>>
>>>> (so it looks you could detect the core from elf file - do you do that
>>>> detection right now?)
>>>>
>>>> #define E_AVR_MACH_AVR1     1
>>>> #define E_AVR_MACH_AVR2     2
>>>> #define E_AVR_MACH_AVR25   25
>>>> #define E_AVR_MACH_AVR3     3
>>>> #define E_AVR_MACH_AVR31   31
>>>> #define E_AVR_MACH_AVR35   35
>>>> #define E_AVR_MACH_AVR4     4
>>>> #define E_AVR_MACH_AVR5     5
>>>> #define E_AVR_MACH_AVR51   51
>>>> #define E_AVR_MACH_AVR6     6
>>>> #define E_AVR_MACH_AVRTINY 100
>>>> #define E_AVR_MACH_XMEGA1  101
>>>> #define E_AVR_MACH_XMEGA2  102
>>>> #define E_AVR_MACH_XMEGA3  103
>>>> #define E_AVR_MACH_XMEGA4  104
>>>> #define E_AVR_MACH_XMEGA5  105
>>>> #define E_AVR_MACH_XMEGA6  106
>>>> #define E_AVR_MACH_XMEGA7  107
>>>>
>>>>
>>>>
>>>> Best regards,
>>>>> Akeksandar
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Michael Rolnik
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Sat, Nov 30, 2019 at 1:28 PM Aleksandar Markovic <
>>>>>> aleksandar.m.mail@gmail.com> wrote:
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> This series of patches adds 8bit AVR cores to QEMU.
>>>>>>>> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not
>>>>>>>> fully tested yet.
>>>>>>>> However I was able to execute simple code with functions. e.g
>>>>>>>> fibonacci calculation.
>>>>>>>> This series of patches include a non real, sample board.
>>>>>>>> No fuses support yet. PC is set to 0 at reset.
>>>>>>>>
>>>>>>>> Following are examples of possible usages, assuming program.elf is
>>>>>>>> compiled for AVR cpu
>>>>>>>> 1.  Continious non interrupted execution
>>>>>>>>     run `qemu-system-avr -kernel program.elf`
>>>>>>>> 2.  Continious non interrupted execution with serial output into
>>>>>>>> telnet window
>>>>>>>>     run `qemu-system-avr -kernel program.elf -serial
>>>>>>>> tcp::5678,server,nowait -nographic `
>>>>>>>>     run `telent localhost 5678`
>>>>>>>> 3.  Continious non interrupted execution with serial output into
>>>>>>>> stdout
>>>>>>>>     run `qemu-system-avr -kernel program.elf -serial stdio`
>>>>>>>> 4.  Debugging wit GDB debugger
>>>>>>>>     run `qemu-system-avr -kernel program.elf -s -S`
>>>>>>>>     run `avr-gdb program.elf` and then within GDB shell `target
>>>>>>>> remote :1234`
>>>>>>>> 5.  Print out executed instructions
>>>>>>>>     run `qemu-system-avr -kernel program.elf -d in_asm`
>>>>>>>>
>>>>>>>>
>>>>>>> Hi, Michael.
>>>>>>>
>>>>>>> Can you explain to me the mechanisms of recognition of what
>>>>>>> core/microcontroller QEMU is supposed to emulate in the examples above?
>>>>>>>
>>>>>>> Yours, Aleksandar
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> the patches include the following
>>>>>>>> 1. just a basic 8bit AVR CPU, without instruction decoding or
>>>>>>>> translation
>>>>>>>> 2. CPU features which allow define the following 8bit AVR cores
>>>>>>>>      avr1
>>>>>>>>      avr2 avr25
>>>>>>>>      avr3 avr31 avr35
>>>>>>>>      avr4
>>>>>>>>      avr5 avr51
>>>>>>>>      avr6
>>>>>>>>      xmega2 xmega4 xmega5 xmega6 xmega7
>>>>>>>> 3. a definition of sample machine with SRAM, FLASH and CPU which
>>>>>>>> allows to execute simple code
>>>>>>>> 4. encoding for all AVR instructions
>>>>>>>> 5. interrupt handling
>>>>>>>> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>>>>>>>> 7. a decoder which given an opcode decides what istruction it is
>>>>>>>> 8. translation of AVR instruction into TCG
>>>>>>>> 9. all features together
>>>>>>>>
>>>>>>>> changes since v3
>>>>>>>> 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of
>>>>>>>> 0x000000ff) for faster address manipulaton
>>>>>>>> 2. ffs changed to ctz32
>>>>>>>> 3. duplicate code removed at avr_cpu_do_interrupt
>>>>>>>> 4. using andc instead of not + and
>>>>>>>> 5. fixing V flag calculation in varios instructions
>>>>>>>> 6. freeing local variables in PUSH
>>>>>>>> 7. tcg_const_local_i32 -> tcg_const_i32
>>>>>>>> 8. using sextract32 instead of my implementation
>>>>>>>> 9. fixing BLD instruction
>>>>>>>> 10.xor(r) instead of 0xff - r at COM
>>>>>>>> 11.fixing MULS/MULSU not to modify inputs' content
>>>>>>>> 12.using SUB for NEG
>>>>>>>> 13.fixing tcg_gen_qemu_ld/st call in XCH
>>>>>>>>
>>>>>>>> changes since v4
>>>>>>>> 1. target is now defined as big endian in order to optimize
>>>>>>>> push_ret/pop_ret
>>>>>>>> 2. all style warnings are fixed
>>>>>>>> 3. adding cpu_set/get_sreg functions
>>>>>>>> 4. simplifying gen_goto_tb as there is no real paging
>>>>>>>> 5. env->pc -> env->pc_w
>>>>>>>> 6. making flag dump more compact
>>>>>>>> 7. more spacing
>>>>>>>> 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
>>>>>>>> 9. removing avr_set_feature
>>>>>>>> 10. SPL/SPH set bug fix
>>>>>>>> 11. switching stb_phys to cpu_stb_data
>>>>>>>> 12. cleaning up avr_decode
>>>>>>>> 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
>>>>>>>> 14. saving CPU features (savevm)
>>>>>>>>
>>>>>>>> changes since v5
>>>>>>>> 1. BLD bug fix
>>>>>>>> 2. decoder generator is added
>>>>>>>>
>>>>>>>> chages since v6
>>>>>>>> 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_
>>>>>>>> cpu_gdb_write_register
>>>>>>>> 2. configure the target as little endian because otherwise GDB does
>>>>>>>> not work
>>>>>>>> 3. fixing and testing gen_push_ret/gen_pop_ret
>>>>>>>>
>>>>>>>> changes since v7
>>>>>>>> 1. folding back v6
>>>>>>>> 2. logging at helper_outb and helper_inb are done for non supported
>>>>>>>> yet registers only
>>>>>>>> 3. MAINTAINERS updated
>>>>>>>>
>>>>>>>> changes since v8
>>>>>>>> 1. removing hw/avr from hw/Makefile.obj as it should not be built
>>>>>>>> for all
>>>>>>>> 2. making linux compilable
>>>>>>>> 3. testing on
>>>>>>>>     a. Mac, Apple LLVM version 7.0.0
>>>>>>>>     b. Ubuntu 12.04, gcc 4.9.2
>>>>>>>>     c. Fedora 23, gcc 5.3.1
>>>>>>>> 4. folding back some patches
>>>>>>>> 5. translation bug fixes for ORI, CPI, XOR instructions
>>>>>>>> 6. propper handling of cpu register writes though memory
>>>>>>>>
>>>>>>>> changes since v9
>>>>>>>> 1. removing forward declarations of static functions
>>>>>>>> 2. disabling debug prints
>>>>>>>> 3. switching to case range instead of if else if ...
>>>>>>>> 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed
>>>>>>>> to any device
>>>>>>>> 5. commenst about sample board and sample IO device added
>>>>>>>> 6. sample board description is more descriptive now
>>>>>>>> 7. memory_region_allocate_system_memory is used to create RAM
>>>>>>>> 8. now there are helper_fullrd & helper_fullwr when LD/ST try to
>>>>>>>> access registers
>>>>>>>>
>>>>>>>> changes since v10
>>>>>>>> 1. movig back fullwr & fullrd into the commit where outb and inb
>>>>>>>> were introduced
>>>>>>>> 2. changing tlb_fill function signature
>>>>>>>> 3. adding empty line between functions
>>>>>>>> 4. adding newline on the last line of the file
>>>>>>>> 5. using tb->flags to generae full access ST/LD instructions
>>>>>>>> 6. fixing SBRC bug
>>>>>>>> 7. folding back 10th commit
>>>>>>>> 8. whenever a new file is introduced it's added to Makefile.objs
>>>>>>>>
>>>>>>>> changes since v11
>>>>>>>> 1. updating to v2.7.0-rc
>>>>>>>> 2. removing assignment to env->fullacc from gen_intermediate_code
>>>>>>>>
>>>>>>>> changes since v12
>>>>>>>> 1. fixing spacing
>>>>>>>> 2. fixing get/put_segment functions
>>>>>>>> 3. removing target-avr/machine.h file
>>>>>>>> 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
>>>>>>>> 5. comment spelling
>>>>>>>> 6. removing hw/avr/sample_io.c
>>>>>>>> 7. char const* -> const char*
>>>>>>>> 8. proper ram allocation
>>>>>>>> 9. fixing breakpoint functionality.
>>>>>>>> 10.env1 -> env
>>>>>>>> 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register
>>>>>>>> functions
>>>>>>>> 12.any cpu is removed
>>>>>>>> 12.feature bits are not saved into vm state
>>>>>>>>
>>>>>>>> changes since v13
>>>>>>>> 1. rebasing to v2.7.0-rc1
>>>>>>>>
>>>>>>>> changes since v14
>>>>>>>> 1. I made self review with git gui tool. (I did not know such a
>>>>>>>> thing exists)
>>>>>>>> 2. removing all double/tripple spaces
>>>>>>>> 3. removing comment reference to SampleIO
>>>>>>>> 4. folding back some changes, so there is not deleted lines in my
>>>>>>>> code
>>>>>>>> 5. moving avr configuration, within configure file, before chris
>>>>>>>>
>>>>>>>> changes since v15
>>>>>>>> 1. removing IO registers cache from CPU
>>>>>>>> 2. implementing CBI/SBI as read(helper_inb), modify,
>>>>>>>> write(helper_outb)
>>>>>>>> 3. implementing CBIC/SBIC as read(helper_inb), check, branch
>>>>>>>> 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>>>>>>>>
>>>>>>>> changes since v16
>>>>>>>> 1. removing EXT IO registers knoledge from CPU. These registers are
>>>>>>>> accessible
>>>>>>>>    by LD/ST only. CPU has no interest in them
>>>>>>>>
>>>>>>>> changes since v17 (by Richard Henderson)
>>>>>>>> This is Michael's v17, with some adjustments of my own:
>>>>>>>>
>>>>>>>> 1. Fix the whitespace errors reported by "git am",
>>>>>>>> 2. Replace the utf-8 characters with normal ascii,
>>>>>>>> 3. Ditch the separate compilation of translate.c.
>>>>>>>>
>>>>>>>> I retained the two separate files that could be regenerated
>>>>>>>> from the included cpugen program, but merged in translate-insn.c.
>>>>>>>> Not that it matters, but the code generated is about 3k smaller.
>>>>>>>>
>>>>>>>> changes since v18
>>>>>>>> 1.  moving target-avr into target/avr
>>>>>>>> 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
>>>>>>>> 3.  call cpu_exec_realizefn avr_cpu_realizefn
>>>>>>>> 4.  do not fail sample machine creation if no rom is suplied
>>>>>>>> 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
>>>>>>>> 6.  fix a register getters/setters in machine.c
>>>>>>>> 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>>>>>>>>
>>>>>>>> changes since v19
>>>>>>>> 1.  use decodetree.py tool to decode instructions
>>>>>>>> 2.  adding USART
>>>>>>>> 3.  adding 16 bit timer peripherals
>>>>>>>> 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
>>>>>>>> 5.  renaming tlb_fill to avr_cpu_tlb_fill
>>>>>>>>
>>>>>>>> changes since v20
>>>>>>>> 1.  use one CPU naming convention
>>>>>>>> 2.  merging insn16.decode & insn32.decode files
>>>>>>>> 3.  modifying skip next instruction mechanizm
>>>>>>>> 4.  translate BREAK as NOP for now
>>>>>>>>
>>>>>>>> changes since v21
>>>>>>>> 1.  Reorganize bstate.
>>>>>>>>     This will make transition to <exec/translator.h> easier, and
>>>>>>>> fixes a couple of bugs wrt single stepping
>>>>>>>>     by richard.henderson@linaro.org
>>>>>>>> 2.  Drop cpc and fix page cross condition.
>>>>>>>>     by richard.henderson@linaro.org
>>>>>>>> 3.  Refactor checking supported/unsupported instructions
>>>>>>>> 4.  Add gdb-xml/avr-cpu.xml
>>>>>>>>
>>>>>>>> changes since v22
>>>>>>>> 1.  Rebase
>>>>>>>> 2.  Split long comment
>>>>>>>>
>>>>>>>> changes since v23
>>>>>>>> 1.  remove avr_cpu_list_compare function
>>>>>>>> 2.  modify avr_cpu_class_by_name function
>>>>>>>> 3.  modify avr_cpu_list_entry function
>>>>>>>> 4.  modify avr_cpu_list function
>>>>>>>>
>>>>>>>> changes since v24
>>>>>>>> 1.  remove AVR_CPU_TYPE_NAME macro
>>>>>>>>
>>>>>>>> changes since v25
>>>>>>>> 1.  fix patches. every file belong to one patch only
>>>>>>>> 2.  change copyright year from 2016 to 2019
>>>>>>>> 3.  create mask device to emulate prr0/prr1
>>>>>>>>
>>>>>>>> changes since v26
>>>>>>>> 1.  add avocado acceptence test
>>>>>>>> 2.  add boot serial test
>>>>>>>>
>>>>>>>> changes since v27
>>>>>>>> 1.  list atmel2560 devices as unimplemented
>>>>>>>> 2.  fix sram base/size
>>>>>>>>
>>>>>>>> changes since v28
>>>>>>>> 1.  rebase
>>>>>>>> 2.  fix includes & build
>>>>>>>>
>>>>>>>> changes since v29
>>>>>>>> 1.  fixing ownership
>>>>>>>> 2.  using 'since' instread of 'added in'
>>>>>>>>
>>>>>>>> changes since v30
>>>>>>>> 1.  rebase
>>>>>>>>
>>>>>>>> changes since v31
>>>>>>>> 1.  splitting 'Add instruction translation' commit
>>>>>>>> 2.  fixing typo in qapi/machine.json sicne -> since
>>>>>>>> 3.  removing unintended changes in configure file
>>>>>>>> 4.  adding Richard Henderson as a co developer to 'Add instruction
>>>>>>>> translation - CPU main translation funcions' commit
>>>>>>>>
>>>>>>>> changes since v32
>>>>>>>> 1.  modify cpu_get_sreg to treat sreg C as other flags, except sreg
>>>>>>>> Z
>>>>>>>>
>>>>>>>> changes since v33
>>>>>>>> 1.  ensure flag C is always calculated as one bit
>>>>>>>> 2.  calculate flag Z as one bit, without using inverse logic
>>>>>>>>
>>>>>>>> changes since v34
>>>>>>>> 1.  rebase
>>>>>>>>
>>>>>>>> changes since v35
>>>>>>>> 1.  rebase
>>>>>>>> 2.  use NANOSECONDS_PER_SECOND instead of 1000000000 in
>>>>>>>> avr_timer16.c
>>>>>>>> 3.  split "target/avr: Register AVR support with the rest of QEMU"
>>>>>>>> into three patches
>>>>>>>>     1.  "target/avr: Register AVR support with the rest of QEMU"
>>>>>>>>     2.  "target/avr: Update build system"
>>>>>>>>     3.  "target/avr: Update MAINTAINERS file"
>>>>>>>> 4.  split "target/avr: Add tests" patch into two patches
>>>>>>>>     1.  "target/avr: Add Avocado test"
>>>>>>>>     2.  "target/avr: Add boot serial test"
>>>>>>>> 5.  Add instruction disassembly function
>>>>>>>> 6.  change "since 4.2" to "since 5.0"
>>>>>>>>
>>>>>>>> changes since v36
>>>>>>>> 1.  rebase
>>>>>>>> 2.  tename
>>>>>>>>     1.  NO_CPU_REGISTERS    -> NUMBER_OF_CPU_REGISTERS
>>>>>>>>     2.  NO_IO_REGISTERS     -> NUMBER_OF_IO_REGISTERS
>>>>>>>>     3.  to_A                -> to_regs_16_31_by_one
>>>>>>>>     4.  to_B                -> to_regs_16_23_by_one
>>>>>>>>     5.  to_C                -> to_regs_24_30_by_two
>>>>>>>>     6.  to_D                -> to_regs_00_30_by_two
>>>>>>>> 3.  add missing licences
>>>>>>>> 4.  add usage example (see above)
>>>>>>>> 5.  ass Sarah Harris <S.E.Harris@kent.ac.uk> as a reviewer to
>>>>>>>> MAINTAINERS
>>>>>>>> 7.  use git commit sha1 instead of `master`` in avocado test
>>>>>>>>
>>>>>>>> Michael Rolnik (16):
>>>>>>>>   target/avr: Add outward facing interfaces and core CPU logic
>>>>>>>>   target/avr: Add instruction helpers
>>>>>>>>   target/avr: Add instruction decoding
>>>>>>>>   target/avr: Add instruction translation - Registers definition
>>>>>>>>   target/avr: Add instruction translation - Arithmetic and Logic
>>>>>>>>     Instructions
>>>>>>>>   target/avr: Add instruction translation - Branch Instructions
>>>>>>>>   target/avr: Add instruction translation - Bit and Bit-test
>>>>>>>>     Instructions
>>>>>>>>   target/avr: Add instruction translation - MCU Control Instructions
>>>>>>>>   target/avr: Add instruction translation - CPU main translation
>>>>>>>>     function
>>>>>>>>   target/avr: Add instruction disassembly function
>>>>>>>>   target/avr: Add example board configuration
>>>>>>>>   target/avr: Register AVR support with the rest of QEMU
>>>>>>>>   target/avr: Update build system
>>>>>>>>   target/avr: Add boot serial test
>>>>>>>>   target/avr: Add Avocado test
>>>>>>>>   target/avr: Update MAINTAINERS file
>>>>>>>>
>>>>>>>> Sarah Harris (1):
>>>>>>>>   target/avr: Add limited support for USART and 16 bit timer
>>>>>>>> peripherals
>>>>>>>>
>>>>>>>>  configure                        |    7 +
>>>>>>>>  default-configs/avr-softmmu.mak  |    5 +
>>>>>>>>  qapi/machine.json                |    3 +-
>>>>>>>>  include/disas/dis-asm.h          |    6 +
>>>>>>>>  include/hw/char/avr_usart.h      |   97 +
>>>>>>>>  include/hw/misc/avr_mask.h       |   47 +
>>>>>>>>  include/hw/timer/avr_timer16.h   |   97 +
>>>>>>>>  include/sysemu/arch_init.h       |    1 +
>>>>>>>>  target/avr/cpu-param.h           |   37 +
>>>>>>>>  target/avr/cpu-qom.h             |   54 +
>>>>>>>>  target/avr/cpu.h                 |  254 +++
>>>>>>>>  target/avr/helper.h              |   29 +
>>>>>>>>  arch_init.c                      |    2 +
>>>>>>>>  hw/avr/sample.c                  |  282 +++
>>>>>>>>  hw/char/avr_usart.c              |  324 ++++
>>>>>>>>  hw/misc/avr_mask.c               |  112 ++
>>>>>>>>  hw/timer/avr_timer16.c           |  605 ++++++
>>>>>>>>  target/avr/cpu.c                 |  576 ++++++
>>>>>>>>  target/avr/disas.c               |  228 +++
>>>>>>>>  target/avr/gdbstub.c             |   85 +
>>>>>>>>  target/avr/helper.c              |  354 ++++
>>>>>>>>  target/avr/machine.c             |  121 ++
>>>>>>>>  target/avr/translate.c           | 3052
>>>>>>>> ++++++++++++++++++++++++++++++
>>>>>>>>  tests/boot-serial-test.c         |   10 +
>>>>>>>>  tests/machine-none-test.c        |    1 +
>>>>>>>>  MAINTAINERS                      |   11 +
>>>>>>>>  gdb-xml/avr-cpu.xml              |   49 +
>>>>>>>>  hw/Kconfig                       |    1 +
>>>>>>>>  hw/avr/Kconfig                   |    6 +
>>>>>>>>  hw/avr/Makefile.objs             |    1 +
>>>>>>>>  hw/char/Kconfig                  |    3 +
>>>>>>>>  hw/char/Makefile.objs            |    1 +
>>>>>>>>  hw/misc/Kconfig                  |    3 +
>>>>>>>>  hw/misc/Makefile.objs            |    2 +
>>>>>>>>  hw/timer/Kconfig                 |    3 +
>>>>>>>>  hw/timer/Makefile.objs           |    2 +
>>>>>>>>  target/avr/Makefile.objs         |   34 +
>>>>>>>>  target/avr/insn.decode           |  194 ++
>>>>>>>>  tests/Makefile.include           |    2 +
>>>>>>>>  tests/acceptance/machine_avr6.py |   56 +
>>>>>>>>  40 files changed, 6756 insertions(+), 1 deletion(-)
>>>>>>>>  create mode 100644 default-configs/avr-softmmu.mak
>>>>>>>>  create mode 100644 include/hw/char/avr_usart.h
>>>>>>>>  create mode 100644 include/hw/misc/avr_mask.h
>>>>>>>>  create mode 100644 include/hw/timer/avr_timer16.h
>>>>>>>>  create mode 100644 target/avr/cpu-param.h
>>>>>>>>  create mode 100644 target/avr/cpu-qom.h
>>>>>>>>  create mode 100644 target/avr/cpu.h
>>>>>>>>  create mode 100644 target/avr/helper.h
>>>>>>>>  create mode 100644 hw/avr/sample.c
>>>>>>>>  create mode 100644 hw/char/avr_usart.c
>>>>>>>>  create mode 100644 hw/misc/avr_mask.c
>>>>>>>>  create mode 100644 hw/timer/avr_timer16.c
>>>>>>>>  create mode 100644 target/avr/cpu.c
>>>>>>>>  create mode 100644 target/avr/disas.c
>>>>>>>>  create mode 100644 target/avr/gdbstub.c
>>>>>>>>  create mode 100644 target/avr/helper.c
>>>>>>>>  create mode 100644 target/avr/machine.c
>>>>>>>>  create mode 100644 target/avr/translate.c
>>>>>>>>  create mode 100644 gdb-xml/avr-cpu.xml
>>>>>>>>  create mode 100644 hw/avr/Kconfig
>>>>>>>>  create mode 100644 hw/avr/Makefile.objs
>>>>>>>>  create mode 100644 target/avr/Makefile.objs
>>>>>>>>  create mode 100644 target/avr/insn.decode
>>>>>>>>  create mode 100644 tests/acceptance/machine_avr6.py
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.17.2 (Apple Git-113)
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>> --
>>>>>> Best Regards,
>>>>>> Michael Rolnik
>>>>>>
>>>>>
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

--000000000000e3aa3b0598bf1490
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 2, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr">how can I get this elf flags from within QEMU?</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br></blockquote></blockquote><div><br><=
/div><div>In one of files from your &quot;machine&quot; patch, you have thi=
s snippet:</div><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 byt=
es_loaded =3D load_elf(</span><br style=3D"color:rgb(34,34,34);font-size:14=
px;line-height:22.1200008392334px"><span style=3D"color:rgb(34,34,34);font-=
size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0, 0);=
</span><br style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px"></div><div><br></div><div>With this line you a kind of &quot;bl=
indly&quot; load whatever you find in the file &quot;filename&quot;. I thin=
k you need to modify load_elf() to fetch the information on what core the e=
lf in question is compiled for. Additionally, you most likely have to check=
 if the elf file is compiled for AVR at all.</div><div><br></div><div>I don=
&#39;t know enough about AVR-specifics of ELF format, but I know that we in=
 MIPS read successfuly some MIPS-specific things we need to know. Do some r=
esearch for ELF format headrr content for AVR.</div><div><br></div><div>Thi=
s is really missing in your series, seriously.</div><div><br></div><div>Ple=
ase keep in mind that I don&#39;t have right now at hand any dev system, so=
 all I said here is off of my head.</div><div><br></div><div>You have to do=
 some code digging.</div><div><br></div><div>Best regards, Aleksandar</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 2, 2019 at 4:01 PM Aleksa=
ndar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"=
_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br><br>On Monday, December 2, 2019, Mic=
hael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrol=
nik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr">No, I don&#39;t.=C2=A0<div>but I also can load and =
execute a binary file which=C2=A0does not have this information.</div></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><br></blockquote></block=
quote><div><br></div><div>OK. Let&#39;s think about that for a while. I cur=
rently think you have here an opportunity to add a really clean interface f=
rom the outset of AVR support in QEMU (that even some established platforms=
 don&#39;t have in full), which is, trust me, very important for future. An=
d it not that difficult to implement at all. But let&#39;s both think for a=
 while.</div><div><br></div><div>Best regards,</div><div>Aleksandar</div><d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Dec 2, 2019 at 11:59 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksa=
ndar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br=
>On Monday, December 2, 2019, Aleksandar Markovic &lt;<a href=3D"mailto:ale=
ksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>=
&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On=
 Saturday, November 30, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@=
gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">There is <font fac=
e=3D"monospace"><b>-cpu </b></font>option where you can specify what CPU yo=
u want, if this option is not specified avr6 (<font face=3D"monospace">avr6=
-avr-cpu</font>) is chosen.=C2=A0<div><br></div><div><font face=3D"monospac=
e"><b>./avr-softmmu/qemu-system-avr -cpu help</b><br>avr1-avr-cpu<br>avr2-a=
vr-cpu<br>avr25-avr-cpu<br>avr3-avr-cpu<br>avr31-avr-cpu<br>avr35-avr-cpu<b=
r>avr4-avr-cpu<br>avr5-avr-cpu<br>avr51-avr-cpu<br>avr6-avr-cpu<br>xmega2-a=
vr-cpu<br>xmega4-avr-cpu<br>xmega5-avr-cpu<br>xmega6-avr-cpu<br>xmega7-avr-=
cpu</font><br></div><div><font face=3D"monospace"><br></font></div><div></d=
iv></div></blockquote><div><br></div><div>What happens if you specify a cor=
e via -cpu, and supply elf file compiled for another core?</div><div><br></=
div></blockquote><div><br></div><div>It looks there is some related info wr=
itten in ELF header. This is from a binutils header:</div><div><br></div><d=
iv>(so it looks you could detect the core from elf file - do you do that de=
tection right now?)</div><div><br></div><div><pre>#define E_AVR_MACH_AVR1  =
   1
#define E_AVR_MACH_AVR2     2
#define E_AVR_MACH_AVR25   25
#define E_AVR_MACH_AVR3     3
#define E_AVR_MACH_AVR31   31
#define E_AVR_MACH_AVR35   35
#define E_AVR_MACH_AVR4     4
#define E_AVR_MACH_AVR5     5
#define E_AVR_MACH_AVR51   51
#define E_AVR_MACH_AVR6     6=20
#define E_AVR_MACH_AVRTINY 100
#define E_AVR_MACH_XMEGA1  101
#define E_AVR_MACH_XMEGA2  102
#define E_AVR_MACH_XMEGA3  103
#define E_AVR_MACH_XMEGA4  104
#define E_AVR_MACH_XMEGA5  105
#define E_AVR_MACH_XMEGA6  106
#define E_AVR_MACH_XMEGA7  107

<br></pre></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div>Best regards,</div><div>Akeksandar</div><div><br></div><div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div></div><div><font face=3D"arial, sans-serif">Regards,</f=
ont></div><div><font face=3D"arial, sans-serif">Michael Rolnik</font></div>=
<div><font face=3D"monospace"><br></font></div><div><br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 3=
0, 2019 at 1:28 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.m=
ail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Wedn=
esday, November 27, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmai=
l.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">This series of patches adds 8bit AVR co=
res to QEMU.<br>
All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully test=
ed yet.<br>
However I was able to execute simple code with functions. e.g fibonacci cal=
culation.<br>
This series of patches include a non real, sample board.<br>
No fuses support yet. PC is set to 0 at reset.<br>
<br>
Following are examples of possible usages, assuming program.elf is compiled=
 for AVR cpu<br>
1.=C2=A0 Continious non interrupted execution<br>
=C2=A0 =C2=A0 run `qemu-system-avr -kernel program.elf` <br>
2.=C2=A0 Continious non interrupted execution with serial output into telne=
t window<br>
=C2=A0 =C2=A0 run `qemu-system-avr -kernel program.elf -serial tcp::5678,se=
rver,nowait -nographic `<br>
=C2=A0 =C2=A0 run `telent localhost 5678`<br>
3.=C2=A0 Continious non interrupted execution with serial output into stdou=
t<br>
=C2=A0 =C2=A0 run `qemu-system-avr -kernel program.elf -serial stdio`<br>
4.=C2=A0 Debugging wit GDB debugger<br>
=C2=A0 =C2=A0 run `qemu-system-avr -kernel program.elf -s -S`<br>
=C2=A0 =C2=A0 run `avr-gdb program.elf` and then within GDB shell `target r=
emote :1234`<br>
5.=C2=A0 Print out executed instructions<br>
=C2=A0 =C2=A0 run `qemu-system-avr -kernel program.elf -d in_asm` <br>
<br></blockquote><div><br></div><div>Hi, Michael.</div><div><br></div><div>=
Can you explain to me the mechanisms of recognition of what core/microcontr=
oller QEMU is supposed to emulate in the examples above?</div><div><br></di=
v><div>Yours, Aleksandar</div><div><br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
the patches include the following<br>
1. just a basic 8bit AVR CPU, without instruction decoding or translation<b=
r>
2. CPU features which allow define the following 8bit AVR cores<br>
=C2=A0 =C2=A0 =C2=A0avr1<br>
=C2=A0 =C2=A0 =C2=A0avr2 avr25<br>
=C2=A0 =C2=A0 =C2=A0avr3 avr31 avr35<br>
=C2=A0 =C2=A0 =C2=A0avr4<br>
=C2=A0 =C2=A0 =C2=A0avr5 avr51<br>
=C2=A0 =C2=A0 =C2=A0avr6<br>
=C2=A0 =C2=A0 =C2=A0xmega2 xmega4 xmega5 xmega6 xmega7<br>
3. a definition of sample machine with SRAM, FLASH and CPU which allows to =
execute simple code<br>
4. encoding for all AVR instructions<br>
5. interrupt handling<br>
6. helpers for IN, OUT, SLEEP, WBR &amp; unsupported instructions<br>
7. a decoder which given an opcode decides what istruction it is<br>
8. translation of AVR instruction into TCG<br>
9. all features together<br>
<br>
changes since v3<br>
1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x000000ff) =
for faster address manipulaton<br>
2. ffs changed to ctz32<br>
3. duplicate code removed at avr_cpu_do_interrupt<br>
4. using andc instead of not + and<br>
5. fixing V flag calculation in varios instructions<br>
6. freeing local variables in PUSH<br>
7. tcg_const_local_i32 -&gt; tcg_const_i32<br>
8. using sextract32 instead of my implementation<br>
9. fixing BLD instruction<br>
10.xor(r) instead of 0xff - r at COM<br>
11.fixing MULS/MULSU not to modify inputs&#39; content<br>
12.using SUB for NEG<br>
13.fixing tcg_gen_qemu_ld/st call in XCH<br>
<br>
changes since v4<br>
1. target is now defined as big endian in order to optimize push_ret/pop_re=
t<br>
2. all style warnings are fixed<br>
3. adding cpu_set/get_sreg functions<br>
4. simplifying gen_goto_tb as there is no real paging<br>
5. env-&gt;pc -&gt; env-&gt;pc_w<br>
6. making flag dump more compact<br>
7. more spacing<br>
8. renaming CODE/DATA_INDEX -&gt; MMU_CODE/DATA_IDX<br>
9. removing avr_set_feature<br>
10. SPL/SPH set bug fix<br>
11. switching stb_phys to cpu_stb_data<br>
12. cleaning up avr_decode<br>
13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)<br>
14. saving CPU features (savevm)<br>
<br>
changes since v5<br>
1. BLD bug fix<br>
2. decoder generator is added<br>
<br>
chages since v6<br>
1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_<wbr>cp=
u_gdb_write_register<br>
2. configure the target as little endian because otherwise GDB does not wor=
k<br>
3. fixing and testing gen_push_ret/gen_pop_ret<br>
<br>
changes since v7<br>
1. folding back v6<br>
2. logging at helper_outb and helper_inb are done for non supported yet reg=
isters only<br>
3. MAINTAINERS updated<br>
<br>
changes since v8<br>
1. removing hw/avr from hw/Makefile.obj as it should not be built for all<b=
r>
2. making linux compilable<br>
3. testing on<br>
=C2=A0 =C2=A0 a. Mac, Apple LLVM version 7.0.0<br>
=C2=A0 =C2=A0 b. Ubuntu 12.04, gcc 4.9.2<br>
=C2=A0 =C2=A0 c. Fedora 23, gcc 5.3.1<br>
4. folding back some patches<br>
5. translation bug fixes for ORI, CPI, XOR instructions<br>
6. propper handling of cpu register writes though memory<br>
<br>
changes since v9<br>
1. removing forward declarations of static functions<br>
2. disabling debug prints<br>
3. switching to case range instead of if else if ...<br>
4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to any d=
evice<br>
5. commenst about sample board and sample IO device added<br>
6. sample board description is more descriptive now<br>
7. memory_region_allocate_system_<wbr>memory is used to create RAM<br>
8. now there are helper_fullrd &amp; helper_fullwr when LD/ST try to access=
 registers<br>
<br>
changes since v10<br>
1. movig back fullwr &amp; fullrd into the commit where outb and inb were i=
ntroduced<br>
2. changing tlb_fill function signature<br>
3. adding empty line between functions<br>
4. adding newline on the last line of the file<br>
5. using tb-&gt;flags to generae full access ST/LD instructions<br>
6. fixing SBRC bug<br>
7. folding back 10th commit<br>
8. whenever a new file is introduced it&#39;s added to Makefile.objs<br>
<br>
changes since v11<br>
1. updating to v2.7.0-rc<br>
2. removing assignment to env-&gt;fullacc from gen_intermediate_code<br>
<br>
changes since v12<br>
1. fixing spacing<br>
2. fixing get/put_segment functions<br>
3. removing target-avr/machine.h file<br>
4. VMSTATE_SINGLE_TEST -&gt; VMSTATE_SINGLE<br>
5. comment spelling<br>
6. removing hw/avr/sample_io.c<br>
7. char const* -&gt; const char*<br>
8. proper ram allocation<br>
9. fixing breakpoint functionality.<br>
10.env1 -&gt; env<br>
11.fixing avr_cpu_gdb_write_register &amp; avr_cpu_gdb_read_register functi=
ons<br>
12.any cpu is removed<br>
12.feature bits are not saved into vm state<br>
<br>
changes since v13<br>
1. rebasing to v2.7.0-rc1<br>
<br>
changes since v14<br>
1. I made self review with git gui tool. (I did not know such a thing exist=
s)<br>
2. removing all double/tripple spaces<br>
3. removing comment reference to SampleIO<br>
4. folding back some changes, so there is not deleted lines in my code<br>
5. moving avr configuration, within configure file, before chris<br>
<br>
changes since v15<br>
1. removing IO registers cache from CPU<br>
2. implementing CBI/SBI as read(helper_inb), modify, write(helper_outb)<br>
3. implementing CBIC/SBIC as read(helper_inb), check, branch<br>
4. adding missing tcg_temp_free_i32 for tcg_const_i32<br>
<br>
changes since v16<br>
1. removing EXT IO registers knoledge from CPU. These registers are accessi=
ble<br>
=C2=A0 =C2=A0by LD/ST only. CPU has no interest in them<br>
<br>
changes since v17 (by Richard Henderson)<br>
This is Michael&#39;s v17, with some adjustments of my own:<br>
<br>
1. Fix the whitespace errors reported by &quot;git am&quot;,<br>
2. Replace the utf-8 characters with normal ascii,<br>
3. Ditch the separate compilation of translate.c.<br>
<br>
I retained the two separate files that could be regenerated<br>
from the included cpugen program, but merged in translate-insn.c.<br>
Not that it matters, but the code generated is about 3k smaller.<br>
<br>
changes since v18<br>
1.=C2=A0 moving target-avr into target/avr<br>
2.=C2=A0 do not call cpu_exec_initfn function from avr_cpu_initfn<br>
3.=C2=A0 call cpu_exec_realizefn avr_cpu_realizefn<br>
4.=C2=A0 do not fail sample machine creation if no rom is suplied<br>
5.=C2=A0 add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code<br>
6.=C2=A0 fix a register getters/setters in machine.c<br>
7.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;17 to 1&lt;&lt;18<br>
<br>
changes since v19<br>
1.=C2=A0 use decodetree.py tool to decode instructions<br>
2.=C2=A0 adding USART<br>
3.=C2=A0 adding 16 bit timer peripherals<br>
4.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;18 to 1&lt;&lt;20<br>
5.=C2=A0 renaming tlb_fill to avr_cpu_tlb_fill<br>
<br>
changes since v20<br>
1.=C2=A0 use one CPU naming convention<br>
2.=C2=A0 merging insn16.decode &amp; insn32.decode files<br>
3.=C2=A0 modifying skip next instruction mechanizm<br>
4.=C2=A0 translate BREAK as NOP for now<br>
<br>
changes since v21<br>
1.=C2=A0 Reorganize bstate.<br>
=C2=A0 =C2=A0 This will make transition to &lt;exec/translator.h&gt; easier=
, and fixes a couple of bugs wrt single stepping<br>
=C2=A0 =C2=A0 by <a href=3D"mailto:richard.henderson@linaro.org" target=3D"=
_blank">richard.henderson@linaro.org</a><br>
2.=C2=A0 Drop cpc and fix page cross condition.<br>
=C2=A0 =C2=A0 by <a href=3D"mailto:richard.henderson@linaro.org" target=3D"=
_blank">richard.henderson@linaro.org</a><br>
3.=C2=A0 Refactor checking supported/unsupported instructions<br>
4.=C2=A0 Add gdb-xml/avr-cpu.xml<br>
<br>
changes since v22<br>
1.=C2=A0 Rebase<br>
2.=C2=A0 Split long comment<br>
<br>
changes since v23<br>
1.=C2=A0 remove avr_cpu_list_compare function<br>
2.=C2=A0 modify avr_cpu_class_by_name function<br>
3.=C2=A0 modify avr_cpu_list_entry function<br>
4.=C2=A0 modify avr_cpu_list function<br>
<br>
changes since v24<br>
1.=C2=A0 remove AVR_CPU_TYPE_NAME macro<br>
<br>
changes since v25<br>
1.=C2=A0 fix patches. every file belong to one patch only<br>
2.=C2=A0 change copyright year from 2016 to 2019<br>
3.=C2=A0 create mask device to emulate prr0/prr1<br>
<br>
changes since v26<br>
1.=C2=A0 add avocado acceptence test<br>
2.=C2=A0 add boot serial test<br>
<br>
changes since v27<br>
1.=C2=A0 list atmel2560 devices as unimplemented<br>
2.=C2=A0 fix sram base/size<br>
<br>
changes since v28<br>
1.=C2=A0 rebase<br>
2.=C2=A0 fix includes &amp; build<br>
<br>
changes since v29<br>
1.=C2=A0 fixing ownership<br>
2.=C2=A0 using &#39;since&#39; instread of &#39;added in&#39;<br>
<br>
changes since v30<br>
1.=C2=A0 rebase<br>
<br>
changes since v31<br>
1.=C2=A0 splitting &#39;Add instruction translation&#39; commit<br>
2.=C2=A0 fixing typo in qapi/machine.json sicne -&gt; since<br>
3.=C2=A0 removing unintended changes in configure file<br>
4.=C2=A0 adding Richard Henderson as a co developer to &#39;Add instruction=
 translation - CPU main translation funcions&#39; commit<br>
<br>
changes since v32<br>
1.=C2=A0 modify cpu_get_sreg to treat sreg C as other flags, except sreg Z<=
br>
<br>
changes since v33<br>
1.=C2=A0 ensure flag C is always calculated as one bit<br>
2.=C2=A0 calculate flag Z as one bit, without using inverse logic<br>
<br>
changes since v34<br>
1.=C2=A0 rebase<br>
<br>
changes since v35<br>
1.=C2=A0 rebase<br>
2.=C2=A0 use NANOSECONDS_PER_SECOND instead of 1000000000 in avr_timer16.c<=
br>
3.=C2=A0 split &quot;target/avr: Register AVR support with the rest of QEMU=
&quot; into three patches<br>
=C2=A0 =C2=A0 1.=C2=A0 &quot;target/avr: Register AVR support with the rest=
 of QEMU&quot;<br>
=C2=A0 =C2=A0 2.=C2=A0 &quot;target/avr: Update build system&quot;<br>
=C2=A0 =C2=A0 3.=C2=A0 &quot;target/avr: Update MAINTAINERS file&quot;<br>
4.=C2=A0 split &quot;target/avr: Add tests&quot; patch into two patches<br>
=C2=A0 =C2=A0 1.=C2=A0 &quot;target/avr: Add Avocado test&quot;<br>
=C2=A0 =C2=A0 2.=C2=A0 &quot;target/avr: Add boot serial test&quot;<br>
5.=C2=A0 Add instruction disassembly function<br>
6.=C2=A0 change &quot;since 4.2&quot; to &quot;since 5.0&quot;<br>
<br>
changes since v36<br>
1.=C2=A0 rebase<br>
2.=C2=A0 tename<br>
=C2=A0 =C2=A0 1.=C2=A0 NO_CPU_REGISTERS=C2=A0 =C2=A0 -&gt; NUMBER_OF_CPU_RE=
GISTERS<br>
=C2=A0 =C2=A0 2.=C2=A0 NO_IO_REGISTERS=C2=A0 =C2=A0 =C2=A0-&gt; NUMBER_OF_I=
O_REGISTERS<br>
=C2=A0 =C2=A0 3.=C2=A0 to_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -&gt; to_regs_16_31_by_one<br>
=C2=A0 =C2=A0 4.=C2=A0 to_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -&gt; to_regs_16_23_by_one<br>
=C2=A0 =C2=A0 5.=C2=A0 to_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -&gt; to_regs_24_30_by_two<br>
=C2=A0 =C2=A0 6.=C2=A0 to_D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -&gt; to_regs_00_30_by_two<br>
3.=C2=A0 add missing licences<br>
4.=C2=A0 add usage example (see above)<br>
5.=C2=A0 ass Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" targ=
et=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt; as a reviewer to MAINTAINERS<br=
>
7.=C2=A0 use git commit sha1 instead of `master`` in avocado test<br>
<br>
Michael Rolnik (16):<br>
=C2=A0 target/avr: Add outward facing interfaces and core CPU logic<br>
=C2=A0 target/avr: Add instruction helpers<br>
=C2=A0 target/avr: Add instruction decoding<br>
=C2=A0 target/avr: Add instruction translation - Registers definition<br>
=C2=A0 target/avr: Add instruction translation - Arithmetic and Logic<br>
=C2=A0 =C2=A0 Instructions<br>
=C2=A0 target/avr: Add instruction translation - Branch Instructions<br>
=C2=A0 target/avr: Add instruction translation - Bit and Bit-test<br>
=C2=A0 =C2=A0 Instructions<br>
=C2=A0 target/avr: Add instruction translation - MCU Control Instructions<b=
r>
=C2=A0 target/avr: Add instruction translation - CPU main translation<br>
=C2=A0 =C2=A0 function<br>
=C2=A0 target/avr: Add instruction disassembly function<br>
=C2=A0 target/avr: Add example board configuration<br>
=C2=A0 target/avr: Register AVR support with the rest of QEMU<br>
=C2=A0 target/avr: Update build system<br>
=C2=A0 target/avr: Add boot serial test<br>
=C2=A0 target/avr: Add Avocado test<br>
=C2=A0 target/avr: Update MAINTAINERS file<br>
<br>
Sarah Harris (1):<br>
=C2=A0 target/avr: Add limited support for USART and 16 bit timer periphera=
ls<br>
<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
=C2=A0default-configs/avr-softmmu.<wbr>mak=C2=A0 |=C2=A0 =C2=A0 5 +<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 3 +-<br>
=C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 6 +<br>
=C2=A0include/hw/char/avr_usart.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A097 +<br=
>
=C2=A0include/hw/misc/avr_mask.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A047=
 +<br>
=C2=A0include/hw/timer/avr_timer16.<wbr>h=C2=A0 =C2=A0|=C2=A0 =C2=A097 +<br=
>
=C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1=
 +<br>
=C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A037 +<br>
=C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A054 +<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 254 +++<br>
=C2=A0target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A029 +<br>
=C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 282 +++<br>
=C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 324 ++++<br>
=C2=A0hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 112 ++<br>
=C2=A0hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 605 ++++++<br>
=C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 576 ++++++<br>
=C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 228 +++<br>
=C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A085 +<br>
=C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 354 ++++<br>
=C2=A0target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 121 ++<br>
=C2=A0target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3052=
 ++++++++++++++++++++++++++++++<br>
=C2=A0tests/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A010 +<br>
=C2=A0tests/machine-none-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1=
 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A011 +<br>
=C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A049 +<br>
=C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
=C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 1 +<br>
=C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 1 +<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 2 +<br>
=C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 2 +<br>
=C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A034 +<br>
=C2=A0target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 194 ++<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 2 +<br>
=C2=A0tests/acceptance/machine_<wbr>avr6.py |=C2=A0 =C2=A056 +<br>
=C2=A040 files changed, 6756 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 default-configs/<a href=3D"http://avr-softmmu.ma" =
target=3D"_blank">avr-softmmu.ma</a><wbr>k<br>
=C2=A0create mode 100644 include/hw/char/avr_usart.h<br>
=C2=A0create mode 100644 include/hw/misc/avr_mask.h<br>
=C2=A0create mode 100644 include/hw/timer/avr_timer16.h<br>
=C2=A0create mode 100644 target/avr/cpu-param.h<br>
=C2=A0create mode 100644 target/avr/cpu-qom.h<br>
=C2=A0create mode 100644 target/avr/cpu.h<br>
=C2=A0create mode 100644 target/avr/helper.h<br>
=C2=A0create mode 100644 hw/avr/sample.c<br>
=C2=A0create mode 100644 hw/char/avr_usart.c<br>
=C2=A0create mode 100644 hw/misc/avr_mask.c<br>
=C2=A0create mode 100644 hw/timer/avr_timer16.c<br>
=C2=A0create mode 100644 target/avr/cpu.c<br>
=C2=A0create mode 100644 target/avr/disas.c<br>
=C2=A0create mode 100644 target/avr/gdbstub.c<br>
=C2=A0create mode 100644 target/avr/helper.c<br>
=C2=A0create mode 100644 target/avr/machine.c<br>
=C2=A0create mode 100644 target/avr/translate.c<br>
=C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
=C2=A0create mode 100644 hw/avr/Kconfig<br>
=C2=A0create mode 100644 hw/avr/Makefile.objs<br>
=C2=A0create mode 100644 target/avr/Makefile.objs<br>
=C2=A0create mode 100644 target/avr/insn.decode<br>
=C2=A0create mode 100644 tests/acceptance/machine_avr6.<wbr>py<br>
<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--000000000000e3aa3b0598bf1490--

