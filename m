Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA7C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9668120880
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/TsOFIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9668120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPqu-0005gS-OL
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaPWf-0005r1-5B
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaPWT-0006K7-3S
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:32:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaPWS-0005yL-G9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:32:16 -0500
Received: by mail-ot1-x341.google.com with SMTP id r24so22993774otk.12
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=R6vYmnZtpzHPcgc6QtubRv7omCmJm9MIUD6XM+0LNv0=;
 b=O/TsOFIy9/W67tcO1gcv/nGn+m1ZbsELJwLO1JZCdEY5HMv64mfPFCce4wA80N74u9
 U5Q1bZhuQR6ZVo//+ft9/H/6lvGLKJV0DT+zHlEJHLHoqr4dMV3KcXYVJortYV126EmN
 N3bCT+Wlv49FQDRcDPc57XVcc/4TSdtdET1M5Yo0Hb1xr50ZjbeXbOkC7MgBmJO4UjGA
 8CFTopjkcvfeEFgxoxj5c2/LLZaIlaAZ7OgqBKfj4xTPQsI6FnmkX2W1o69UCViizHwV
 sieBWjhJ+V7XxDCP0HtX2KLt3/6HirBM/XDofKzbpGt4fIcpab5Ox/byPeA+Pmi16Rfr
 h9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=R6vYmnZtpzHPcgc6QtubRv7omCmJm9MIUD6XM+0LNv0=;
 b=A41OQFuSHqECWpZiQ7eBKJTyv2FuDH9c1JHE4TcfO6cK4Dl5w0oUWKbIXvXslXCl8h
 Tj0Dw6ONUtWS8gU+GwNcCgr6FodImekDjdYQd6TQy1J/EZHW9QCX1oiGSiZS7m1KxWmI
 2h5aM3MXXVrYG5Ys58tpqwQpLxAfgkN8yPflTZ79WwsGnjxUlnU0sPz/57VYn41TauxF
 N5wab1Y1L1la8vxRK9jOeuUFEbJdDcvAgg99PHzRcyRYsulBv0xa6hxfBAsMwmevi0op
 plsImPj048FI607UhCucAOwjqDPRSwsFGPLv77BOsmT0QJFiHZKmRZfCbsM6l3ls7RGM
 cdJQ==
X-Gm-Message-State: APjAAAXozmerRQBmT4TCk9JCfcvDNyAitZo9sXKz7z9zl9Xoz4gofOtc
 KybpaKGaAS7WHD5C7EZGDtx6mZDFwyKLc4xhA6qg5g==
X-Google-Smtp-Source: APXvYqz5Z29x+oVPJs5HTftYbl13hxi6eLuqrjZ7fWNLNXmHDcu0wdXjUvpi1DllxioveVLVaDJ4Ik4DIHryP5Ze4qM=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr8236878oto.64.1574969531309; 
 Thu, 28 Nov 2019 11:32:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 11:32:10
 -0800 (PST)
In-Reply-To: <87o8wwezwt.fsf@linaro.org>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
 <CAL1e-=ge=VyeQQRFVoZQPix0vSiWapt0+iByMmG6MmKc7KUCGg@mail.gmail.com>
 <87o8wwezwt.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 20:32:10 +0100
Message-ID: <CAL1e-=juHhcV+EoszWh+ZSUPcgQHgLsWyL+aG-CKruqHZ0d2=A@mail.gmail.com>
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007222bd05986d2b03"
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007222bd05986d2b03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 28, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>
> > On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com>
> wrote:
> >
> >> I don't see why you say that the peripherals are inside the chip, ther=
e
> is
> >> CPU within target/avr directory and then there are some peripherals in
> hw
> >> directory, CPU does not depend on them. what am I missing?
> >>
> >>>
> >>>
> > I meant these peripherals are physically inside the chip together with
> the
> > core.
> >
> > And USART in a micricontroler from 2010 is different than USART from on=
e
> > from 2018.
>
> Won't these be different chip parts? Or at least revs of the part?
>
> I think broadly the difference between SoC devices is handled by
> handling versioning in the board models - the board being in this case a
> CPU core + a bunch of SoC components + the actual board itself.
>
> All the target/cpu stuff needs to deal with is actual architectural
> revs (c.f. target/arm/cpu[64].c).
>
>
This sounds like a very good way of dealing with this.

I don't want to force Michael to implement some of such cases before
integration, but just to think about such cases - for future improvements
and developments.

Alex, I appreciate your advice, very nice of you!

Aleksandar




> >
> >
> >> On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic <
> >> aleksandar.m.mail@gmail.com> wrote:
> >>
> >>>
> >>>
> >>> On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com>
> wrote:
> >>>
> >>>>
> >>>>
> >>>> On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic <
> >>>> aleksandar.m.mail@gmail.com> wrote:
> >>>>
> >>>>> On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik <mrolnik@gmail.com>
> >>>>> wrote:
> >>>>> >
> >>>>> > This series of patches adds 8bit AVR cores to QEMU.
> >>>>> > All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not
> >>>>> fully tested yet.
> >>>>> > However I was able to execute simple code with functions. e.g
> >>>>> fibonacci calculation.
> >>>>> > This series of patches include a non real, sample board.
> >>>>> > No fuses support yet. PC is set to 0 at reset.
> >>>>> >
> >>>>>
> >>>>> I have a couple of general remarks, so I am responding to the cover
> >>>>> letter, not individual patches.
> >>>>>
> >>>>> 1) The licenses for Sarah devices differ than the rest - shouldn't
> all
> >>>>> licenses be harmonized?
> >>>>
> >>>> Sarah,
> >>>> do you mind if use the same license I use for my code?
> >>>>
> >>>>
> >>>>>
> >>>>
> >>>>
> >>>>> 2) There is an architectural problem with peripherals. It is possib=
le
> >>>>> that they evolve over time, so, for example, USART could not be the
> >>>>> same for older and newer CPUs (in principle, newer peripheral is
> >>>>> expected to be o sort of "superset" of the older). How do you solve
> >>>>> that problem? Right now, it may not looks serious to you, but if yo=
u
> >>>>> don;t think about that right now, from the outset, soon the code wi=
ll
> >>>>> become so entangled, ti woudl be almost very difficult to fix it.
> >>>>> Please think about that, how would you solve it, is there a way to
> >>>>> pass the information on the currently emulated CPU to the code
> >>>>> covering a peripheral, and provide a different behaviour?
> >>>>>
> >>>> Hi Aleksandar,
> >>>>
> >>>> Please explain.
> >>>>
> >>>>
> >>> My concern is about peripherals inside the chip, together with the
> core.
> >>>
> >>> If one models, let's say an external (in the sense, it is a separate
> >>> chip) ADC (analog-to-digital converter), one looks at specs, implemen=
t
> what
> >>> is resonable possible in QEMU, plug it in in one of machines thst
> contains
> >>> it, and that's it. That ADC remains the same, of course, whatever the
> >>> surrounding system is.
> >>>
> >>> In AVR case, I think we have a phenomenon likes of which we didn't se=
e
> >>> before (at least I don't know about). Number of AVR microcontrollers =
is
> >>> very large, and both cores and peripherals evolved.
> >>>
> >>> For cores, you handle differences with all these AVR_FEATURE macros,
> and
> >>> this seems to be working, no significant objection from my side, and
> btw
> >>> that was not an easy task to execute, all admiration from me.
> >>>
> >>> But what about peripherals inside the chip? A peripheral with the sam=
e
> >>> name and the same general area of functionality may be differently
> >>> specified for microcontrollers from 2010 and 2018. By the difference =
I
> >>> don't mean starting address, but the difference in behavior. I don't
> have
> >>> time right now to spell many examples, but I read three different
> specs,
> >>> and there are differences in USART specifications.
> >>>
> >>> I am not clear what is your envisioned solution for these cases. Woul=
d
> >>> you such close, but not the same, flabors of a peripheral treat as if
> they
> >>> are two completely separate cases of a peripheral? Or would you have =
a
> >>> single peripheral that would somehow configure itself depending on th=
e
> core
> >>> it is attached to?
> >>>
> >>> I hope I was clearer this time.
> >>>
> >>> Aleksandar
> >>>
> >>>
> >>>
> >>>>
> >>>>
> >>>>
> >>>> I don't see any problem from CPU's perspective.
> >>>> as for the sample board is just a sample, I hope other people will
> >>>> create real models or real hw.
> >>>> there was no way I could provide a CPU alone, that's why there is
> sample.
> >>>>
> >>>>
> >>>>
> >>>>>
> >>>>> > Following are examples of possible usages, assuming program.elf i=
s
> >>>>> compiled for AVR cpu
> >>>>> > 1.  Continious non interrupted execution
> >>>>> >     run `qemu-system-avr -kernel program.elf`
> >>>>> > 2.  Continious non interrupted execution with serial output into
> >>>>> telnet window
> >>>>> >     run `qemu-system-avr -kernel program.elf -serial
> >>>>> tcp::5678,server,nowait -nographic `
> >>>>> >     run `telent localhost 5678`
> >>>>> > 3.  Continious non interrupted execution with serial output into
> >>>>> stdout
> >>>>> >     run `qemu-system-avr -kernel program.elf -serial stdio`
> >>>>> > 4.  Debugging wit GDB debugger
> >>>>> >     run `qemu-system-avr -kernel program.elf -s -S`
> >>>>> >     run `avr-gdb program.elf` and then within GDB shell `target
> >>>>> remote :1234`
> >>>>> > 5.  Print out executed instructions
> >>>>> >     run `qemu-system-avr -kernel program.elf -d in_asm`
> >>>>> >
> >>>>>
> >>>>> Thank you so much for these examples!
> >>>>>
> >>>>> Aleksandar
> >>>>>
> >>>>>
> >>>>> >
> >>>>> > the patches include the following
> >>>>> > 1. just a basic 8bit AVR CPU, without instruction decoding or
> >>>>> translation
> >>>>> > 2. CPU features which allow define the following 8bit AVR cores
> >>>>> >      avr1
> >>>>> >      avr2 avr25
> >>>>> >      avr3 avr31 avr35
> >>>>> >      avr4
> >>>>> >      avr5 avr51
> >>>>> >      avr6
> >>>>> >      xmega2 xmega4 xmega5 xmega6 xmega7
> >>>>> > 3. a definition of sample machine with SRAM, FLASH and CPU which
> >>>>> allows to execute simple code
> >>>>> > 4. encoding for all AVR instructions
> >>>>> > 5. interrupt handling
> >>>>> > 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
> >>>>> > 7. a decoder which given an opcode decides what istruction it is
> >>>>> > 8. translation of AVR instruction into TCG
> >>>>> > 9. all features together
> >>>>> >
> >>>>> > changes since v3
> >>>>> > 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of
> >>>>> 0x000000ff) for faster address manipulaton
> >>>>> > 2. ffs changed to ctz32
> >>>>> > 3. duplicate code removed at avr_cpu_do_interrupt
> >>>>> > 4. using andc instead of not + and
> >>>>> > 5. fixing V flag calculation in varios instructions
> >>>>> > 6. freeing local variables in PUSH
> >>>>> > 7. tcg_const_local_i32 -> tcg_const_i32
> >>>>> > 8. using sextract32 instead of my implementation
> >>>>> > 9. fixing BLD instruction
> >>>>> > 10.xor(r) instead of 0xff - r at COM
> >>>>> > 11.fixing MULS/MULSU not to modify inputs' content
> >>>>> > 12.using SUB for NEG
> >>>>> > 13.fixing tcg_gen_qemu_ld/st call in XCH
> >>>>> >
> >>>>> > changes since v4
> >>>>> > 1. target is now defined as big endian in order to optimize
> >>>>> push_ret/pop_ret
> >>>>> > 2. all style warnings are fixed
> >>>>> > 3. adding cpu_set/get_sreg functions
> >>>>> > 4. simplifying gen_goto_tb as there is no real paging
> >>>>> > 5. env->pc -> env->pc_w
> >>>>> > 6. making flag dump more compact
> >>>>> > 7. more spacing
> >>>>> > 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
> >>>>> > 9. removing avr_set_feature
> >>>>> > 10. SPL/SPH set bug fix
> >>>>> > 11. switching stb_phys to cpu_stb_data
> >>>>> > 12. cleaning up avr_decode
> >>>>> > 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
> >>>>> > 14. saving CPU features (savevm)
> >>>>> >
> >>>>> > changes since v5
> >>>>> > 1. BLD bug fix
> >>>>> > 2. decoder generator is added
> >>>>> >
> >>>>> > chages since v6
> >>>>> > 1. using cpu_get_sreg/cpu_set_sreg in
> avr_cpu_gdb_read_register/avr_
> >>>>> cpu_gdb_write_register
> >>>>> > 2. configure the target as little endian because otherwise GDB do=
es
> >>>>> not work
> >>>>> > 3. fixing and testing gen_push_ret/gen_pop_ret
> >>>>> >
> >>>>> > changes since v7
> >>>>> > 1. folding back v6
> >>>>> > 2. logging at helper_outb and helper_inb are done for non support=
ed
> >>>>> yet registers only
> >>>>> > 3. MAINTAINERS updated
> >>>>> >
> >>>>> > changes since v8
> >>>>> > 1. removing hw/avr from hw/Makefile.obj as it should not be built
> for
> >>>>> all
> >>>>> > 2. making linux compilable
> >>>>> > 3. testing on
> >>>>> >     a. Mac, Apple LLVM version 7.0.0
> >>>>> >     b. Ubuntu 12.04, gcc 4.9.2
> >>>>> >     c. Fedora 23, gcc 5.3.1
> >>>>> > 4. folding back some patches
> >>>>> > 5. translation bug fixes for ORI, CPI, XOR instructions
> >>>>> > 6. propper handling of cpu register writes though memory
> >>>>> >
> >>>>> > changes since v9
> >>>>> > 1. removing forward declarations of static functions
> >>>>> > 2. disabling debug prints
> >>>>> > 3. switching to case range instead of if else if ...
> >>>>> > 4. LD/ST IN/OUT accessing CPU maintainder registers are not route=
d
> to
> >>>>> any device
> >>>>> > 5. commenst about sample board and sample IO device added
> >>>>> > 6. sample board description is more descriptive now
> >>>>> > 7. memory_region_allocate_system_memory is used to create RAM
> >>>>> > 8. now there are helper_fullrd & helper_fullwr when LD/ST try to
> >>>>> access registers
> >>>>> >
> >>>>> > changes since v10
> >>>>> > 1. movig back fullwr & fullrd into the commit where outb and inb
> were
> >>>>> introduced
> >>>>> > 2. changing tlb_fill function signature
> >>>>> > 3. adding empty line between functions
> >>>>> > 4. adding newline on the last line of the file
> >>>>> > 5. using tb->flags to generae full access ST/LD instructions
> >>>>> > 6. fixing SBRC bug
> >>>>> > 7. folding back 10th commit
> >>>>> > 8. whenever a new file is introduced it's added to Makefile.objs
> >>>>> >
> >>>>> > changes since v11
> >>>>> > 1. updating to v2.7.0-rc
> >>>>> > 2. removing assignment to env->fullacc from gen_intermediate_code
> >>>>> >
> >>>>> > changes since v12
> >>>>> > 1. fixing spacing
> >>>>> > 2. fixing get/put_segment functions
> >>>>> > 3. removing target-avr/machine.h file
> >>>>> > 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
> >>>>> > 5. comment spelling
> >>>>> > 6. removing hw/avr/sample_io.c
> >>>>> > 7. char const* -> const char*
> >>>>> > 8. proper ram allocation
> >>>>> > 9. fixing breakpoint functionality.
> >>>>> > 10.env1 -> env
> >>>>> > 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register
> >>>>> functions
> >>>>> > 12.any cpu is removed
> >>>>> > 12.feature bits are not saved into vm state
> >>>>> >
> >>>>> > changes since v13
> >>>>> > 1. rebasing to v2.7.0-rc1
> >>>>> >
> >>>>> > changes since v14
> >>>>> > 1. I made self review with git gui tool. (I did not know such a
> thing
> >>>>> exists)
> >>>>> > 2. removing all double/tripple spaces
> >>>>> > 3. removing comment reference to SampleIO
> >>>>> > 4. folding back some changes, so there is not deleted lines in my
> code
> >>>>> > 5. moving avr configuration, within configure file, before chris
> >>>>> >
> >>>>> > changes since v15
> >>>>> > 1. removing IO registers cache from CPU
> >>>>> > 2. implementing CBI/SBI as read(helper_inb), modify,
> >>>>> write(helper_outb)
> >>>>> > 3. implementing CBIC/SBIC as read(helper_inb), check, branch
> >>>>> > 4. adding missing tcg_temp_free_i32 for tcg_const_i32
> >>>>> >
> >>>>> > changes since v16
> >>>>> > 1. removing EXT IO registers knoledge from CPU. These registers a=
re
> >>>>> accessible
> >>>>> >    by LD/ST only. CPU has no interest in them
> >>>>> >
> >>>>> > changes since v17 (by Richard Henderson)
> >>>>> > This is Michael's v17, with some adjustments of my own:
> >>>>> >
> >>>>> > 1. Fix the whitespace errors reported by "git am",
> >>>>> > 2. Replace the utf-8 characters with normal ascii,
> >>>>> > 3. Ditch the separate compilation of translate.c.
> >>>>> >
> >>>>> > I retained the two separate files that could be regenerated
> >>>>> > from the included cpugen program, but merged in translate-insn.c.
> >>>>> > Not that it matters, but the code generated is about 3k smaller.
> >>>>> >
> >>>>> > changes since v18
> >>>>> > 1.  moving target-avr into target/avr
> >>>>> > 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
> >>>>> > 3.  call cpu_exec_realizefn avr_cpu_realizefn
> >>>>> > 4.  do not fail sample machine creation if no rom is suplied
> >>>>> > 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
> >>>>> > 6.  fix a register getters/setters in machine.c
> >>>>> > 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
> >>>>> >
> >>>>> > changes since v19
> >>>>> > 1.  use decodetree.py tool to decode instructions
> >>>>> > 2.  adding USART
> >>>>> > 3.  adding 16 bit timer peripherals
> >>>>> > 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
> >>>>> > 5.  renaming tlb_fill to avr_cpu_tlb_fill
> >>>>> >
> >>>>> > changes since v20
> >>>>> > 1.  use one CPU naming convention
> >>>>> > 2.  merging insn16.decode & insn32.decode files
> >>>>> > 3.  modifying skip next instruction mechanizm
> >>>>> > 4.  translate BREAK as NOP for now
> >>>>> >
> >>>>> > changes since v21
> >>>>> > 1.  Reorganize bstate.
> >>>>> >     This will make transition to <exec/translator.h> easier, and
> >>>>> fixes a couple of bugs wrt single stepping
> >>>>> >     by richard.henderson@linaro.org
> >>>>> > 2.  Drop cpc and fix page cross condition.
> >>>>> >     by richard.henderson@linaro.org
> >>>>> > 3.  Refactor checking supported/unsupported instructions
> >>>>> > 4.  Add gdb-xml/avr-cpu.xml
> >>>>> >
> >>>>> > changes since v22
> >>>>> > 1.  Rebase
> >>>>> > 2.  Split long comment
> >>>>> >
> >>>>> > changes since v23
> >>>>> > 1.  remove avr_cpu_list_compare function
> >>>>> > 2.  modify avr_cpu_class_by_name function
> >>>>> > 3.  modify avr_cpu_list_entry function
> >>>>> > 4.  modify avr_cpu_list function
> >>>>> >
> >>>>> > changes since v24
> >>>>> > 1.  remove AVR_CPU_TYPE_NAME macro
> >>>>> >
> >>>>> > changes since v25
> >>>>> > 1.  fix patches. every file belong to one patch only
> >>>>> > 2.  change copyright year from 2016 to 2019
> >>>>> > 3.  create mask device to emulate prr0/prr1
> >>>>> >
> >>>>> > changes since v26
> >>>>> > 1.  add avocado acceptence test
> >>>>> > 2.  add boot serial test
> >>>>> >
> >>>>> > changes since v27
> >>>>> > 1.  list atmel2560 devices as unimplemented
> >>>>> > 2.  fix sram base/size
> >>>>> >
> >>>>> > changes since v28
> >>>>> > 1.  rebase
> >>>>> > 2.  fix includes & build
> >>>>> >
> >>>>> > changes since v29
> >>>>> > 1.  fixing ownership
> >>>>> > 2.  using 'since' instread of 'added in'
> >>>>> >
> >>>>> > changes since v30
> >>>>> > 1.  rebase
> >>>>> >
> >>>>> > changes since v31
> >>>>> > 1.  splitting 'Add instruction translation' commit
> >>>>> > 2.  fixing typo in qapi/machine.json sicne -> since
> >>>>> > 3.  removing unintended changes in configure file
> >>>>> > 4.  adding Richard Henderson as a co developer to 'Add instructio=
n
> >>>>> translation - CPU main translation funcions' commit
> >>>>> >
> >>>>> > changes since v32
> >>>>> > 1.  modify cpu_get_sreg to treat sreg C as other flags, except
> sreg Z
> >>>>> >
> >>>>> > changes since v33
> >>>>> > 1.  ensure flag C is always calculated as one bit
> >>>>> > 2.  calculate flag Z as one bit, without using inverse logic
> >>>>> >
> >>>>> > changes since v34
> >>>>> > 1.  rebase
> >>>>> >
> >>>>> > changes since v35
> >>>>> > 1.  rebase
> >>>>> > 2.  use NANOSECONDS_PER_SECOND instead of 1000000000 in
> avr_timer16.c
> >>>>> > 3.  split "target/avr: Register AVR support with the rest of QEMU=
"
> >>>>> into three patches
> >>>>> >     1.  "target/avr: Register AVR support with the rest of QEMU"
> >>>>> >     2.  "target/avr: Update build system"
> >>>>> >     3.  "target/avr: Update MAINTAINERS file"
> >>>>> > 4.  split "target/avr: Add tests" patch into two patches
> >>>>> >     1.  "target/avr: Add Avocado test"
> >>>>> >     2.  "target/avr: Add boot serial test"
> >>>>> > 5.  Add instruction disassembly function
> >>>>> > 6.  change "since 4.2" to "since 5.0"
> >>>>> >
> >>>>> > changes since v36
> >>>>> > 1.  rebase
> >>>>> > 2.  tename
> >>>>> >     1.  NO_CPU_REGISTERS    -> NUMBER_OF_CPU_REGISTERS
> >>>>> >     2.  NO_IO_REGISTERS     -> NUMBER_OF_IO_REGISTERS
> >>>>> >     3.  to_A                -> to_regs_16_31_by_one
> >>>>> >     4.  to_B                -> to_regs_16_23_by_one
> >>>>> >     5.  to_C                -> to_regs_24_30_by_two
> >>>>> >     6.  to_D                -> to_regs_00_30_by_two
> >>>>> > 3.  add missing licences
> >>>>> > 4.  add usage example (see above)
> >>>>> > 5.  ass Sarah Harris <S.E.Harris@kent.ac.uk> as a reviewer to
> >>>>> MAINTAINERS
> >>>>> > 7.  use git commit sha1 instead of `master`` in avocado test
> >>>>> >
> >>>>> > Michael Rolnik (16):
> >>>>> >   target/avr: Add outward facing interfaces and core CPU logic
> >>>>> >   target/avr: Add instruction helpers
> >>>>> >   target/avr: Add instruction decoding
> >>>>> >   target/avr: Add instruction translation - Registers definition
> >>>>> >   target/avr: Add instruction translation - Arithmetic and Logic
> >>>>> >     Instructions
> >>>>> >   target/avr: Add instruction translation - Branch Instructions
> >>>>> >   target/avr: Add instruction translation - Bit and Bit-test
> >>>>> >     Instructions
> >>>>> >   target/avr: Add instruction translation - MCU Control
> Instructions
> >>>>> >   target/avr: Add instruction translation - CPU main translation
> >>>>> >     function
> >>>>> >   target/avr: Add instruction disassembly function
> >>>>> >   target/avr: Add example board configuration
> >>>>> >   target/avr: Register AVR support with the rest of QEMU
> >>>>> >   target/avr: Update build system
> >>>>> >   target/avr: Add boot serial test
> >>>>> >   target/avr: Add Avocado test
> >>>>> >   target/avr: Update MAINTAINERS file
> >>>>> >
> >>>>> > Sarah Harris (1):
> >>>>> >   target/avr: Add limited support for USART and 16 bit timer
> >>>>> peripherals
> >>>>> >
> >>>>> >  configure                        |    7 +
> >>>>> >  default-configs/avr-softmmu.mak  |    5 +
> >>>>> >  qapi/machine.json                |    3 +-
> >>>>> >  include/disas/dis-asm.h          |    6 +
> >>>>> >  include/hw/char/avr_usart.h      |   97 +
> >>>>> >  include/hw/misc/avr_mask.h       |   47 +
> >>>>> >  include/hw/timer/avr_timer16.h   |   97 +
> >>>>> >  include/sysemu/arch_init.h       |    1 +
> >>>>> >  target/avr/cpu-param.h           |   37 +
> >>>>> >  target/avr/cpu-qom.h             |   54 +
> >>>>> >  target/avr/cpu.h                 |  254 +++
> >>>>> >  target/avr/helper.h              |   29 +
> >>>>> >  arch_init.c                      |    2 +
> >>>>> >  hw/avr/sample.c                  |  282 +++
> >>>>> >  hw/char/avr_usart.c              |  324 ++++
> >>>>> >  hw/misc/avr_mask.c               |  112 ++
> >>>>> >  hw/timer/avr_timer16.c           |  605 ++++++
> >>>>> >  target/avr/cpu.c                 |  576 ++++++
> >>>>> >  target/avr/disas.c               |  228 +++
> >>>>> >  target/avr/gdbstub.c             |   85 +
> >>>>> >  target/avr/helper.c              |  354 ++++
> >>>>> >  target/avr/machine.c             |  121 ++
> >>>>> >  target/avr/translate.c           | 3052
> >>>>> ++++++++++++++++++++++++++++++
> >>>>> >  tests/boot-serial-test.c         |   10 +
> >>>>> >  tests/machine-none-test.c        |    1 +
> >>>>> >  MAINTAINERS                      |   11 +
> >>>>> >  gdb-xml/avr-cpu.xml              |   49 +
> >>>>> >  hw/Kconfig                       |    1 +
> >>>>> >  hw/avr/Kconfig                   |    6 +
> >>>>> >  hw/avr/Makefile.objs             |    1 +
> >>>>> >  hw/char/Kconfig                  |    3 +
> >>>>> >  hw/char/Makefile.objs            |    1 +
> >>>>> >  hw/misc/Kconfig                  |    3 +
> >>>>> >  hw/misc/Makefile.objs            |    2 +
> >>>>> >  hw/timer/Kconfig                 |    3 +
> >>>>> >  hw/timer/Makefile.objs           |    2 +
> >>>>> >  target/avr/Makefile.objs         |   34 +
> >>>>> >  target/avr/insn.decode           |  194 ++
> >>>>> >  tests/Makefile.include           |    2 +
> >>>>> >  tests/acceptance/machine_avr6.py |   56 +
> >>>>> >  40 files changed, 6756 insertions(+), 1 deletion(-)
> >>>>> >  create mode 100644 default-configs/avr-softmmu.mak
> >>>>> >  create mode 100644 include/hw/char/avr_usart.h
> >>>>> >  create mode 100644 include/hw/misc/avr_mask.h
> >>>>> >  create mode 100644 include/hw/timer/avr_timer16.h
> >>>>> >  create mode 100644 target/avr/cpu-param.h
> >>>>> >  create mode 100644 target/avr/cpu-qom.h
> >>>>> >  create mode 100644 target/avr/cpu.h
> >>>>> >  create mode 100644 target/avr/helper.h
> >>>>> >  create mode 100644 hw/avr/sample.c
> >>>>> >  create mode 100644 hw/char/avr_usart.c
> >>>>> >  create mode 100644 hw/misc/avr_mask.c
> >>>>> >  create mode 100644 hw/timer/avr_timer16.c
> >>>>> >  create mode 100644 target/avr/cpu.c
> >>>>> >  create mode 100644 target/avr/disas.c
> >>>>> >  create mode 100644 target/avr/gdbstub.c
> >>>>> >  create mode 100644 target/avr/helper.c
> >>>>> >  create mode 100644 target/avr/machine.c
> >>>>> >  create mode 100644 target/avr/translate.c
> >>>>> >  create mode 100644 gdb-xml/avr-cpu.xml
> >>>>> >  create mode 100644 hw/avr/Kconfig
> >>>>> >  create mode 100644 hw/avr/Makefile.objs
> >>>>> >  create mode 100644 target/avr/Makefile.objs
> >>>>> >  create mode 100644 target/avr/insn.decode
> >>>>> >  create mode 100644 tests/acceptance/machine_avr6.py
> >>>>> >
> >>>>> > --
> >>>>> > 2.17.2 (Apple Git-113)
> >>>>> >
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Best Regards,
> >>>> Michael Rolnik
> >>>>
> >>>
> >>
> >> --
> >> Best Regards,
> >> Michael Rolnik
> >>
>
>
> --
> Alex Benn=C3=A9e
>
>

--0000000000007222bd05986d2b03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, Alex Benn=C3=A9e &lt;<a href=3D"mai=
lto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><br>
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">alek=
sandar.m.mail@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Thursday, November 28, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; I don&#39;t see why you say that the peripherals are inside the ch=
ip, there is<br>
&gt;&gt; CPU within target/avr directory and then there are some peripheral=
s in hw<br>
&gt;&gt; directory, CPU does not depend on them. what am I missing?<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt; I meant these peripherals are physically inside the chip together with=
 the<br>
&gt; core.<br>
&gt;<br>
&gt; And USART in a micricontroler from 2010 is different than USART from o=
ne<br>
&gt; from 2018.<br>
<br>
Won&#39;t these be different chip parts? Or at least revs of the part?<br>
<br>
I think broadly the difference between SoC devices is handled by<br>
handling versioning in the board models - the board being in this case a<br=
>
CPU core + a bunch of SoC components + the actual board itself.<br>
<br>
All the target/cpu stuff needs to deal with is actual architectural<br>
revs (c.f. target/arm/cpu[64].c).<br>
<br></blockquote><div><br></div><div>This sounds like a very good way of de=
aling with this.</div><div><br></div><div>I don&#39;t want to force Michael=
 to implement some of such cases before integration, but just to think abou=
t such cases - for future improvements and developments.</div><div><br></di=
v><div>Alex, I appreciate your advice, very nice of you!</div><div><br></di=
v><div>Aleksandar</div><div><br></div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
&gt;<br>
&gt;<br>
&gt;&gt; On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic &lt;<br>
&gt;&gt; <a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@g=
mail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Thursday, November 28, 2019, Michael Rolnik &lt;<a href=3D"=
mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic &lt;<=
br>
&gt;&gt;&gt;&gt; <a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.=
m.mail@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik &lt;<a =
href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; This series of patches adds 8bit AVR cores to QEM=
U.<br>
&gt;&gt;&gt;&gt;&gt; &gt; All instruction, except BREAK/DES/SPM/SPMX, are i=
mplemented. Not<br>
&gt;&gt;&gt;&gt;&gt; fully tested yet.<br>
&gt;&gt;&gt;&gt;&gt; &gt; However I was able to execute simple code with fu=
nctions. e.g<br>
&gt;&gt;&gt;&gt;&gt; fibonacci calculation.<br>
&gt;&gt;&gt;&gt;&gt; &gt; This series of patches include a non real, sample=
 board.<br>
&gt;&gt;&gt;&gt;&gt; &gt; No fuses support yet. PC is set to 0 at reset.<br=
>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I have a couple of general remarks, so I am responding=
 to the cover<br>
&gt;&gt;&gt;&gt;&gt; letter, not individual patches.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; 1) The licenses for Sarah devices differ than the rest=
 - shouldn&#39;t all<br>
&gt;&gt;&gt;&gt;&gt; licenses be harmonized?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Sarah,<br>
&gt;&gt;&gt;&gt; do you mind if use the same license I use for my code?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; 2) There is an architectural problem with peripherals.=
 It is possible<br>
&gt;&gt;&gt;&gt;&gt; that they evolve over time, so, for example, USART cou=
ld not be the<br>
&gt;&gt;&gt;&gt;&gt; same for older and newer CPUs (in principle, newer per=
ipheral is<br>
&gt;&gt;&gt;&gt;&gt; expected to be o sort of &quot;superset&quot; of the o=
lder). How do you solve<br>
&gt;&gt;&gt;&gt;&gt; that problem? Right now, it may not looks serious to y=
ou, but if you<br>
&gt;&gt;&gt;&gt;&gt; don;t think about that right now, from the outset, soo=
n the code will<br>
&gt;&gt;&gt;&gt;&gt; become so entangled, ti woudl be almost very difficult=
 to fix it.<br>
&gt;&gt;&gt;&gt;&gt; Please think about that, how would you solve it, is th=
ere a way to<br>
&gt;&gt;&gt;&gt;&gt; pass the information on the currently emulated CPU to =
the code<br>
&gt;&gt;&gt;&gt;&gt; covering a peripheral, and provide a different behavio=
ur?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Aleksandar,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Please explain.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; My concern is about peripherals inside the chip, together with=
 the core.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If one models, let&#39;s say an external (in the sense, it is =
a separate<br>
&gt;&gt;&gt; chip) ADC (analog-to-digital converter), one looks at specs, i=
mplement what<br>
&gt;&gt;&gt; is resonable possible in QEMU, plug it in in one of machines t=
hst contains<br>
&gt;&gt;&gt; it, and that&#39;s it. That ADC remains the same, of course, w=
hatever the<br>
&gt;&gt;&gt; surrounding system is.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In AVR case, I think we have a phenomenon likes of which we di=
dn&#39;t see<br>
&gt;&gt;&gt; before (at least I don&#39;t know about). Number of AVR microc=
ontrollers is<br>
&gt;&gt;&gt; very large, and both cores and peripherals evolved.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For cores, you handle differences with all these AVR_FEATURE m=
acros, and<br>
&gt;&gt;&gt; this seems to be working, no significant objection from my sid=
e, and btw<br>
&gt;&gt;&gt; that was not an easy task to execute, all admiration from me.<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; But what about peripherals inside the chip? A peripheral with =
the same<br>
&gt;&gt;&gt; name and the same general area of functionality may be differe=
ntly<br>
&gt;&gt;&gt; specified for microcontrollers from 2010 and 2018. By the diff=
erence I<br>
&gt;&gt;&gt; don&#39;t mean starting address, but the difference in behavio=
r. I don&#39;t have<br>
&gt;&gt;&gt; time right now to spell many examples, but I read three differ=
ent specs,<br>
&gt;&gt;&gt; and there are differences in USART specifications.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am not clear what is your envisioned solution for these case=
s. Would<br>
&gt;&gt;&gt; you such close, but not the same, flabors of a peripheral trea=
t as if they<br>
&gt;&gt;&gt; are two completely separate cases of a peripheral? Or would yo=
u have a<br>
&gt;&gt;&gt; single peripheral that would somehow configure itself dependin=
g on the core<br>
&gt;&gt;&gt; it is attached to?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I hope I was clearer this time.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Aleksandar<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I don&#39;t see any problem from CPU&#39;s perspective.<br=
>
&gt;&gt;&gt;&gt; as for the sample board is just a sample, I hope other peo=
ple will<br>
&gt;&gt;&gt;&gt; create real models or real hw.<br>
&gt;&gt;&gt;&gt; there was no way I could provide a CPU alone, that&#39;s w=
hy there is sample.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; Following are examples of possible usages, assumi=
ng program.elf is<br>
&gt;&gt;&gt;&gt;&gt; compiled for AVR cpu<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 Continious non interrupted execution<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel p=
rogram.elf`<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 Continious non interrupted execution wit=
h serial output into<br>
&gt;&gt;&gt;&gt;&gt; telnet window<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel p=
rogram.elf -serial<br>
&gt;&gt;&gt;&gt;&gt; tcp::5678,server,nowait -nographic `<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `telent localhost 5678`<br=
>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 Continious non interrupted execution wit=
h serial output into<br>
&gt;&gt;&gt;&gt;&gt; stdout<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel p=
rogram.elf -serial stdio`<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 Debugging wit GDB debugger<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel p=
rogram.elf -s -S`<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `avr-gdb program.elf` and =
then within GDB shell `target<br>
&gt;&gt;&gt;&gt;&gt; remote :1234`<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5.=C2=A0 Print out executed instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0run `qemu-system-avr -kernel p=
rogram.elf -d in_asm`<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Thank you so much for these examples!<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Aleksandar<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; the patches include the following<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. just a basic 8bit AVR CPU, without instruction=
 decoding or<br>
&gt;&gt;&gt;&gt;&gt; translation<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. CPU features which allow define the following =
8bit AVR cores<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 avr1<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 avr2 avr25<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 avr3 avr31 avr35<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 avr4<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 avr5 avr51<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 avr6<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 xmega2 xmega4 xmega5 xmega6 x=
mega7<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. a definition of sample machine with SRAM, FLAS=
H and CPU which<br>
&gt;&gt;&gt;&gt;&gt; allows to execute simple code<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. encoding for all AVR instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. interrupt handling<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. helpers for IN, OUT, SLEEP, WBR &amp; unsuppor=
ted instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7. a decoder which given an opcode decides what i=
struction it is<br>
&gt;&gt;&gt;&gt;&gt; &gt; 8. translation of AVR instruction into TCG<br>
&gt;&gt;&gt;&gt;&gt; &gt; 9. all features together<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v3<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. rampD/X/Y/Z registers are encoded as 0x00ff000=
0 (instead of<br>
&gt;&gt;&gt;&gt;&gt; 0x000000ff) for faster address manipulaton<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. ffs changed to ctz32<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. duplicate code removed at avr_cpu_do_interrupt=
<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. using andc instead of not + and<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. fixing V flag calculation in varios instructio=
ns<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. freeing local variables in PUSH<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7. tcg_const_local_i32 -&gt; tcg_const_i32<br>
&gt;&gt;&gt;&gt;&gt; &gt; 8. using sextract32 instead of my implementation<=
br>
&gt;&gt;&gt;&gt;&gt; &gt; 9. fixing BLD instruction<br>
&gt;&gt;&gt;&gt;&gt; &gt; 10.xor(r) instead of 0xff - r at COM<br>
&gt;&gt;&gt;&gt;&gt; &gt; 11.fixing MULS/MULSU not to modify inputs&#39; co=
ntent<br>
&gt;&gt;&gt;&gt;&gt; &gt; 12.using SUB for NEG<br>
&gt;&gt;&gt;&gt;&gt; &gt; 13.fixing tcg_gen_qemu_ld/st call in XCH<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v4<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. target is now defined as big endian in order t=
o optimize<br>
&gt;&gt;&gt;&gt;&gt; push_ret/pop_ret<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. all style warnings are fixed<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. adding cpu_set/get_sreg functions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. simplifying gen_goto_tb as there is no real pa=
ging<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. env-&gt;pc -&gt; env-&gt;pc_w<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. making flag dump more compact<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7. more spacing<br>
&gt;&gt;&gt;&gt;&gt; &gt; 8. renaming CODE/DATA_INDEX -&gt; MMU_CODE/DATA_I=
DX<br>
&gt;&gt;&gt;&gt;&gt; &gt; 9. removing avr_set_feature<br>
&gt;&gt;&gt;&gt;&gt; &gt; 10. SPL/SPH set bug fix<br>
&gt;&gt;&gt;&gt;&gt; &gt; 11. switching stb_phys to cpu_stb_data<br>
&gt;&gt;&gt;&gt;&gt; &gt; 12. cleaning up avr_decode<br>
&gt;&gt;&gt;&gt;&gt; &gt; 13. saving sreg, rampD/X/Y/Z, eind in HW format (=
savevm)<br>
&gt;&gt;&gt;&gt;&gt; &gt; 14. saving CPU features (savevm)<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v5<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. BLD bug fix<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. decoder generator is added<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; chages since v6<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb=
_read_register/avr_<br>
&gt;&gt;&gt;&gt;&gt; cpu_gdb_write_register<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. configure the target as little endian because =
otherwise GDB does<br>
&gt;&gt;&gt;&gt;&gt; not work<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. fixing and testing gen_push_ret/gen_pop_ret<br=
>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v7<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. folding back v6<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. logging at helper_outb and helper_inb are done=
 for non supported<br>
&gt;&gt;&gt;&gt;&gt; yet registers only<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. MAINTAINERS updated<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v8<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. removing hw/avr from hw/Makefile.obj as it sho=
uld not be built for<br>
&gt;&gt;&gt;&gt;&gt; all<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. making linux compilable<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. testing on<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0a. Mac, Apple LLVM version 7.0=
.0<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0b. Ubuntu 12.04, gcc 4.9.2<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0c. Fedora 23, gcc 5.3.1<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. folding back some patches<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. translation bug fixes for ORI, CPI, XOR instru=
ctions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. propper handling of cpu register writes though=
 memory<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v9<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. removing forward declarations of static functi=
ons<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. disabling debug prints<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. switching to case range instead of if else if =
...<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. LD/ST IN/OUT accessing CPU maintainder registe=
rs are not routed to<br>
&gt;&gt;&gt;&gt;&gt; any device<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. commenst about sample board and sample IO devi=
ce added<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. sample board description is more descriptive n=
ow<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7. memory_region_allocate_system_<wbr>memory is u=
sed to create RAM<br>
&gt;&gt;&gt;&gt;&gt; &gt; 8. now there are helper_fullrd &amp; helper_fullw=
r when LD/ST try to<br>
&gt;&gt;&gt;&gt;&gt; access registers<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v10<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. movig back fullwr &amp; fullrd into the commit=
 where outb and inb were<br>
&gt;&gt;&gt;&gt;&gt; introduced<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. changing tlb_fill function signature<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. adding empty line between functions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. adding newline on the last line of the file<br=
>
&gt;&gt;&gt;&gt;&gt; &gt; 5. using tb-&gt;flags to generae full access ST/L=
D instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. fixing SBRC bug<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7. folding back 10th commit<br>
&gt;&gt;&gt;&gt;&gt; &gt; 8. whenever a new file is introduced it&#39;s add=
ed to Makefile.objs<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v11<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. updating to v2.7.0-rc<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. removing assignment to env-&gt;fullacc from ge=
n_intermediate_code<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v12<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. fixing spacing<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. fixing get/put_segment functions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. removing target-avr/machine.h file<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. VMSTATE_SINGLE_TEST -&gt; VMSTATE_SINGLE<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. comment spelling<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6. removing hw/avr/sample_io.c<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7. char const* -&gt; const char*<br>
&gt;&gt;&gt;&gt;&gt; &gt; 8. proper ram allocation<br>
&gt;&gt;&gt;&gt;&gt; &gt; 9. fixing breakpoint functionality.<br>
&gt;&gt;&gt;&gt;&gt; &gt; 10.env1 -&gt; env<br>
&gt;&gt;&gt;&gt;&gt; &gt; 11.fixing avr_cpu_gdb_write_register &amp; avr_cp=
u_gdb_read_register<br>
&gt;&gt;&gt;&gt;&gt; functions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 12.any cpu is removed<br>
&gt;&gt;&gt;&gt;&gt; &gt; 12.feature bits are not saved into vm state<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v13<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. rebasing to v2.7.0-rc1<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v14<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. I made self review with git gui tool. (I did n=
ot know such a thing<br>
&gt;&gt;&gt;&gt;&gt; exists)<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. removing all double/tripple spaces<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. removing comment reference to SampleIO<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. folding back some changes, so there is not del=
eted lines in my code<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5. moving avr configuration, within configure fil=
e, before chris<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v15<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. removing IO registers cache from CPU<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. implementing CBI/SBI as read(helper_inb), modi=
fy,<br>
&gt;&gt;&gt;&gt;&gt; write(helper_outb)<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. implementing CBIC/SBIC as read(helper_inb), ch=
eck, branch<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4. adding missing tcg_temp_free_i32 for tcg_const=
_i32<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v16<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. removing EXT IO registers knoledge from CPU. T=
hese registers are<br>
&gt;&gt;&gt;&gt;&gt; accessible<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 by LD/ST only. CPU has no interest i=
n them<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v17 (by Richard Henderson)<br>
&gt;&gt;&gt;&gt;&gt; &gt; This is Michael&#39;s v17, with some adjustments =
of my own:<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1. Fix the whitespace errors reported by &quot;gi=
t am&quot;,<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2. Replace the utf-8 characters with normal ascii=
,<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3. Ditch the separate compilation of translate.c.=
<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; I retained the two separate files that could be r=
egenerated<br>
&gt;&gt;&gt;&gt;&gt; &gt; from the included cpugen program, but merged in t=
ranslate-insn.c.<br>
&gt;&gt;&gt;&gt;&gt; &gt; Not that it matters, but the code generated is ab=
out 3k smaller.<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v18<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 moving target-avr into target/avr<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 do not call cpu_exec_initfn function fro=
m avr_cpu_initfn<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 call cpu_exec_realizefn avr_cpu_realizef=
n<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 do not fail sample machine creation if n=
o rom is suplied<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5.=C2=A0 add tcg_gen_exit_tb(0) for BS_BRANCH in =
gen_intermediate_code<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6.=C2=A0 fix a register getters/setters in machin=
e.c<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;17 =
to 1&lt;&lt;18<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v19<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 use decodetree.py tool to decode instruc=
tions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 adding USART<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 adding 16 bit timer peripherals<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;18 =
to 1&lt;&lt;20<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5.=C2=A0 renaming tlb_fill to avr_cpu_tlb_fill<br=
>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v20<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 use one CPU naming convention<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 merging insn16.decode &amp; insn32.decod=
e files<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 modifying skip next instruction mechaniz=
m<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 translate BREAK as NOP for now<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v21<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 Reorganize bstate.<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0This will make transition to &=
lt;exec/translator.h&gt; easier, and<br>
&gt;&gt;&gt;&gt;&gt; fixes a couple of bugs wrt single stepping<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0by <a href=3D"mailto:richard.h=
enderson@linaro.org">richard.henderson@linaro.org</a><br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 Drop cpc and fix page cross condition.<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0by <a href=3D"mailto:richard.h=
enderson@linaro.org">richard.henderson@linaro.org</a><br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 Refactor checking supported/unsupported =
instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 Add gdb-xml/avr-cpu.xml<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v22<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 Rebase<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 Split long comment<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v23<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 remove avr_cpu_list_compare function<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 modify avr_cpu_class_by_name function<br=
>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 modify avr_cpu_list_entry function<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 modify avr_cpu_list function<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v24<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 remove AVR_CPU_TYPE_NAME macro<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v25<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 fix patches. every file belong to one pa=
tch only<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 change copyright year from 2016 to 2019<=
br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 create mask device to emulate prr0/prr1<=
br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v26<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 add avocado acceptence test<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 add boot serial test<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v27<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 list atmel2560 devices as unimplemented<=
br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 fix sram base/size<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v28<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 rebase<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 fix includes &amp; build<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v29<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 fixing ownership<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 using &#39;since&#39; instread of &#39;a=
dded in&#39;<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v30<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 rebase<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v31<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 splitting &#39;Add instruction translati=
on&#39; commit<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 fixing typo in qapi/machine.json sicne -=
&gt; since<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 removing unintended changes in configure=
 file<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 adding Richard Henderson as a co develop=
er to &#39;Add instruction<br>
&gt;&gt;&gt;&gt;&gt; translation - CPU main translation funcions&#39; commi=
t<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v32<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 modify cpu_get_sreg to treat sreg C as o=
ther flags, except sreg Z<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v33<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 ensure flag C is always calculated as on=
e bit<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 calculate flag Z as one bit, without usi=
ng inverse logic<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v34<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 rebase<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v35<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 rebase<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 use NANOSECONDS_PER_SECOND instead of 10=
00000000 in avr_timer16.c<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 split &quot;target/avr: Register AVR sup=
port with the rest of QEMU&quot;<br>
&gt;&gt;&gt;&gt;&gt; into three patches<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A01.=C2=A0 &quot;target/avr: Reg=
ister AVR support with the rest of QEMU&quot;<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A02.=C2=A0 &quot;target/avr: Upd=
ate build system&quot;<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A03.=C2=A0 &quot;target/avr: Upd=
ate MAINTAINERS file&quot;<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 split &quot;target/avr: Add tests&quot; =
patch into two patches<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A01.=C2=A0 &quot;target/avr: Add=
 Avocado test&quot;<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A02.=C2=A0 &quot;target/avr: Add=
 boot serial test&quot;<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5.=C2=A0 Add instruction disassembly function<br>
&gt;&gt;&gt;&gt;&gt; &gt; 6.=C2=A0 change &quot;since 4.2&quot; to &quot;si=
nce 5.0&quot;<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; changes since v36<br>
&gt;&gt;&gt;&gt;&gt; &gt; 1.=C2=A0 rebase<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.=C2=A0 tename<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A01.=C2=A0 NO_CPU_REGISTERS=C2=
=A0 =C2=A0 -&gt; NUMBER_OF_CPU_REGISTERS<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A02.=C2=A0 NO_IO_REGISTERS=C2=A0=
 =C2=A0 =C2=A0-&gt; NUMBER_OF_IO_REGISTERS<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A03.=C2=A0 to_A=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; to_regs_16_31_by_one<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A04.=C2=A0 to_B=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; to_regs_16_23_by_one<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A05.=C2=A0 to_C=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; to_regs_24_30_by_two<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A06.=C2=A0 to_D=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; to_regs_00_30_by_two<br>
&gt;&gt;&gt;&gt;&gt; &gt; 3.=C2=A0 add missing licences<br>
&gt;&gt;&gt;&gt;&gt; &gt; 4.=C2=A0 add usage example (see above)<br>
&gt;&gt;&gt;&gt;&gt; &gt; 5.=C2=A0 ass Sarah Harris &lt;<a href=3D"mailto:S=
.E.Harris@kent.ac.uk">S.E.Harris@kent.ac.uk</a>&gt; as a reviewer to<br>
&gt;&gt;&gt;&gt;&gt; MAINTAINERS<br>
&gt;&gt;&gt;&gt;&gt; &gt; 7.=C2=A0 use git commit sha1 instead of `master``=
 in avocado test<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; Michael Rolnik (16):<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add outward facing interf=
aces and core CPU logic<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction helpers<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction decoding<=
br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction translati=
on - Registers definition<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction translati=
on - Arithmetic and Logic<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction translati=
on - Branch Instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction translati=
on - Bit and Bit-test<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction translati=
on - MCU Control Instructions<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction translati=
on - CPU main translation<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0function<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add instruction disassemb=
ly function<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add example board configu=
ration<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Register AVR support with=
 the rest of QEMU<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Update build system<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add boot serial test<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add Avocado test<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Update MAINTAINERS file<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; Sarah Harris (1):<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 =C2=A0target/avr: Add limited support for U=
SART and 16 bit timer<br>
&gt;&gt;&gt;&gt;&gt; peripherals<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 default-configs/avr-softmmu.<wbr>mak=C2=A0 =
|=C2=A0 =C2=A0 5 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 include/hw/char/avr_usart.h=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A097 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 include/hw/misc/avr_mask.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A047 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 include/hw/timer/avr_timer16.h=C2=A0 =C2=A0=
|=C2=A0 =C2=A097 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A054 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 254 +++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A029 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 282 +++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 324 ++++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 112 ++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 605 ++++++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 576 ++++++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 228 +++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A085 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 354 ++++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 121 ++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 3052<br>
&gt;&gt;&gt;&gt;&gt; ++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 tests/boot-serial-test.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A010 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 tests/machine-none-test.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A011 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A049 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A034 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 194 ++<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 tests/acceptance/machine_avr6.<wbr>py |=C2=
=A0 =C2=A056 +<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 40 files changed, 6756 insertions(+), 1 del=
etion(-)<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 default-configs/avr-soft=
mmu.<wbr>mak<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 include/hw/char/avr_usar=
t.h<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 include/hw/misc/avr_mask=
.h<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 include/hw/timer/avr_tim=
er16.h<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/cpu-param.h<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/cpu-qom.h<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/cpu.h<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/helper.h<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 hw/avr/sample.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 hw/char/avr_usart.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 hw/misc/avr_mask.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 hw/timer/avr_timer16.c<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/disas.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/gdbstub.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/helper.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/machine.c<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/translate.c<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 hw/avr/Kconfig<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 hw/avr/Makefile.objs<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/Makefile.objs=
<br>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 target/avr/insn.decode<b=
r>
&gt;&gt;&gt;&gt;&gt; &gt;=C2=A0 create mode 100644 tests/acceptance/machine=
_avr6.<wbr>py<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt; &gt; --<br>
&gt;&gt;&gt;&gt;&gt; &gt; 2.17.2 (Apple Git-113)<br>
&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Best Regards,<br>
&gt;&gt;&gt;&gt; Michael Rolnik<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Best Regards,<br>
&gt;&gt; Michael Rolnik<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
<br>
</blockquote>

--0000000000007222bd05986d2b03--

