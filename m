Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB9C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC8520650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omGRXLLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC8520650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXBR-0003mY-Hv
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iIWlw-0000aW-AZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iIWls-0006wa-UT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:38:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iIWls-0006wO-MH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:38:16 -0400
Received: by mail-oi1-x244.google.com with SMTP id k20so4597598oih.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=TGd5ZdtHlsXpr3/B4ZT6QXddJYTQWjmFDeYf+hEE/bU=;
 b=omGRXLLmds4xXHkSNk7FqpLCdwiDVNkJT+wyyltY9aXJ3G0DsL9AC0kWM6gtcfnV2R
 thwG6Z/cAkoDHKr4N8N9HCNnPcFaqZCJJuwA+k+1gMYhTlu8ErS1il2XR0LilztU77bn
 p1D4fw75NQhRGfS68TuBO86sysd67ZTwNo4RTJzInL/FJFeHfrjfrD7P9eaR+tHQqPG9
 aE4r7PItWTz0kTehz0pXP8NcMw+Ml007KXQ2rtAnAhlrM7vZ0JOaUQvNbdu0EpGEvbpF
 yAIOOgpeEusEWOdYuhncDur7xDpmj1dHmwPf/XN+h5g1c53emi730fPNZWxDRR8ZRh66
 RkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=TGd5ZdtHlsXpr3/B4ZT6QXddJYTQWjmFDeYf+hEE/bU=;
 b=eGkzeTQxh1zJvB85V0lupiEtIDy6ChrJA8aMJ0A1wFU4aFqg9YTG107Cl4pPVWM5MQ
 c7HTwJCu/MSPZ+pmdwTpNmtDea8y2eleu7k54M4hIT5v/rEyFN6rz4qyyBBUooaC1RDH
 nzEX7gwWhF813jtTjeSwURZdyzm4OMG0rtwYvlo2ahn0VxFXeCna3CjSa3ubQ0YOTugS
 Ty1LTZgh7IxqCdhDcNm25A3DT3zPEeNog+qmwr4SKx/UxPg2IVPleJhoMvUlqMN6Mi3t
 adZT1ETKiGOJ79xqcmU5CK/3VnH6dfVrM7N/u6VwPw3m18kJseSSLv4IRHCIXh/CX0Wm
 BiAw==
X-Gm-Message-State: APjAAAUWtbwZFTzUTSlqc8zfQ2ozI1aD/Vi6Hl6T06nNvpXepAYqQtv+
 vmyz6NjuQ9uMqhSCQNUyC2cXt4L+Qqaf7CbEBlQ=
X-Google-Smtp-Source: APXvYqyiQbfGEknUGAzs+FzvX8fIRvmCie80OCby7JkwWsW5y2m70965ol9kWh2YmDYd0ciOfQMAt+Q5rusjSaKEnYM=
X-Received: by 2002:a05:6808:341:: with SMTP id
 j1mr6778442oie.106.1570707495620; 
 Thu, 10 Oct 2019 04:38:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 10 Oct 2019 04:38:15
 -0700 (PDT)
In-Reply-To: <CAK4993j4pp65WbK4DCgcxdpZtAaCNuoyNY5XWd7hpZV2fbQVXA@mail.gmail.com>
References: <20190915122015.45852-1-mrolnik@gmail.com>
 <CAK4993hWEgHnphTu4_Y8F9VSOTgQkdDMN2D2m2bm3fxG5EQG-A@mail.gmail.com>
 <CAL1e-=gzAj558+fHkJjawX=YZAKHy=JuXWEBhMyKMu7sk73Wnw@mail.gmail.com>
 <CAK4993j4pp65WbK4DCgcxdpZtAaCNuoyNY5XWd7hpZV2fbQVXA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 10 Oct 2019 13:38:15 +0200
Message-ID: <CAL1e-=jMjoRAgkheozWRuc6fGo5XVcgO3LwRCaqkg4KbLFdgWQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v31 0/8] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000052949e05948cd6eb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000052949e05948cd6eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 9, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Hello Aleksandar.
>
>
> https://ww1.microchip.com/downloads/en/devicedoc/atmel-2549-8-bit-avr-
> microcontroller-atmega640-1280-1281-2560-2561_datasheet.pdf
>
>
>>
Thanks, Michael!

Could you please provide also a link to AVR instruction set reference
documentation that you used while creating this series, one that this
series should support?

Aleksandar



> On Wed, Oct 9, 2019 at 11:38 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>> 23.09.2019. 15.29, "Michael Rolnik" <mrolnik@gmail.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> >
>> > Hi all,
>> >
>> > is there any hope this will be ever pulled?
>> >
>> > regards,
>> > Michael
>> >
>>
>> Hello, Michael.
>>
>> I am practically new to your series, even though it is v31. Could you
>> perhaps include links to any documentation that you think it can be
>> pertinent to your solution (I apologize if you already did it somewhere
>> else)?
>>
>> I do admire your persistence.
>>
>> Yours, Aleksandar
>>
>> > On Sun, Sep 15, 2019 at 3:20 PM Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>> >>
>> >> This series of patches adds 8bit AVR cores to QEMU.
>> >> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not full=
y
>> tested yet.
>> >> However I was able to execute simple code with functions. e.g
>> fibonacci calculation.
>> >> This series of patches include a non real, sample board.
>> >> No fuses support yet. PC is set to 0 at reset.
>> >>
>> >> the patches include the following
>> >> 1. just a basic 8bit AVR CPU, without instruction decoding or
>> translation
>> >> 2. CPU features which allow define the following 8bit AVR cores
>> >>      avr1
>> >>      avr2 avr25
>> >>      avr3 avr31 avr35
>> >>      avr4
>> >>      avr5 avr51
>> >>      avr6
>> >>      xmega2 xmega4 xmega5 xmega6 xmega7
>> >> 3. a definition of sample machine with SRAM, FLASH and CPU which
>> allows to execute simple code
>> >> 4. encoding for all AVR instructions
>> >> 5. interrupt handling
>> >> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>> >> 7. a decoder which given an opcode decides what istruction it is
>> >> 8. translation of AVR instruction into TCG
>> >> 9. all features together
>> >>
>> >> changes since v3
>> >> 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of
>> 0x000000ff) for faster address manipulaton
>> >> 2. ffs changed to ctz32
>> >> 3. duplicate code removed at avr_cpu_do_interrupt
>> >> 4. using andc instead of not + and
>> >> 5. fixing V flag calculation in varios instructions
>> >> 6. freeing local variables in PUSH
>> >> 7. tcg_const_local_i32 -> tcg_const_i32
>> >> 8. using sextract32 instead of my implementation
>> >> 9. fixing BLD instruction
>> >> 10.xor(r) instead of 0xff - r at COM
>> >> 11.fixing MULS/MULSU not to modify inputs' content
>> >> 12.using SUB for NEG
>> >> 13.fixing tcg_gen_qemu_ld/st call in XCH
>> >>
>> >> changes since v4
>> >> 1. target is now defined as big endian in order to optimize
>> push_ret/pop_ret
>> >> 2. all style warnings are fixed
>> >> 3. adding cpu_set/get_sreg functions
>> >> 4. simplifying gen_goto_tb as there is no real paging
>> >> 5. env->pc -> env->pc_w
>> >> 6. making flag dump more compact
>> >> 7. more spacing
>> >> 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
>> >> 9. removing avr_set_feature
>> >> 10. SPL/SPH set bug fix
>> >> 11. switching stb_phys to cpu_stb_data
>> >> 12. cleaning up avr_decode
>> >> 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
>> >> 14. saving CPU features (savevm)
>> >>
>> >> changes since v5
>> >> 1. BLD bug fix
>> >> 2. decoder generator is added
>> >>
>> >> chages since v6
>> >> 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_
>> cpu_gdb_write_register
>> >> 2. configure the target as little endian because otherwise GDB does
>> not work
>> >> 3. fixing and testing gen_push_ret/gen_pop_ret
>> >>
>> >> changes since v7
>> >> 1. folding back v6
>> >> 2. logging at helper_outb and helper_inb are done for non supported
>> yet registers only
>> >> 3. MAINTAINERS updated
>> >>
>> >> changes since v8
>> >> 1. removing hw/avr from hw/Makefile.obj as it should not be built for
>> all
>> >> 2. making linux compilable
>> >> 3. testing on
>> >>     a. Mac, Apple LLVM version 7.0.0
>> >>     b. Ubuntu 12.04, gcc 4.9.2
>> >>     c. Fedora 23, gcc 5.3.1
>> >> 4. folding back some patches
>> >> 5. translation bug fixes for ORI, CPI, XOR instructions
>> >> 6. propper handling of cpu register writes though memory
>> >>
>> >> changes since v9
>> >> 1. removing forward declarations of static functions
>> >> 2. disabling debug prints
>> >> 3. switching to case range instead of if else if ...
>> >> 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to
>> any device
>> >> 5. commenst about sample board and sample IO device added
>> >> 6. sample board description is more descriptive now
>> >> 7. memory_region_allocate_system_memory is used to create RAM
>> >> 8. now there are helper_fullrd & helper_fullwr when LD/ST try to
>> access registers
>> >>
>> >> changes since v10
>> >> 1. movig back fullwr & fullrd into the commit where outb and inb were
>> introduced
>> >> 2. changing tlb_fill function signature
>> >> 3. adding empty line between functions
>> >> 4. adding newline on the last line of the file
>> >> 5. using tb->flags to generae full access ST/LD instructions
>> >> 6. fixing SBRC bug
>> >> 7. folding back 10th commit
>> >> 8. whenever a new file is introduced it's added to Makefile.objs
>> >>
>> >> changes since v11
>> >> 1. updating to v2.7.0-rc
>> >> 2. removing assignment to env->fullacc from gen_intermediate_code
>> >>
>> >> changes since v12
>> >> 1. fixing spacing
>> >> 2. fixing get/put_segment functions
>> >> 3. removing target-avr/machine.h file
>> >> 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
>> >> 5. comment spelling
>> >> 6. removing hw/avr/sample_io.c
>> >> 7. char const* -> const char*
>> >> 8. proper ram allocation
>> >> 9. fixing breakpoint functionality.
>> >> 10.env1 -> env
>> >> 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register
>> functions
>> >> 12.any cpu is removed
>> >> 12.feature bits are not saved into vm state
>> >>
>> >> changes since v13
>> >> 1. rebasing to v2.7.0-rc1
>> >>
>> >> changes since v14
>> >> 1. I made self review with git gui tool. (I did not know such a thing
>> exists)
>> >> 2. removing all double/tripple spaces
>> >> 3. removing comment reference to SampleIO
>> >> 4. folding back some changes, so there is not deleted lines in my cod=
e
>> >> 5. moving avr configuration, within configure file, before chris
>> >>
>> >> changes since v15
>> >> 1. removing IO registers cache from CPU
>> >> 2. implementing CBI/SBI as read(helper_inb), modify, write(helper_out=
b)
>> >> 3. implementing CBIC/SBIC as read(helper_inb), check, branch
>> >> 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>> >>
>> >> changes since v16
>> >> 1. removing EXT IO registers knoledge from CPU. These registers are
>> accessible
>> >>    by LD/ST only. CPU has no interest in them
>> >>
>> >> changes since v17 (by Richard Henderson)
>> >> This is Michael's v17, with some adjustments of my own:
>> >>
>> >> 1. Fix the whitespace errors reported by "git am",
>> >> 2. Replace the utf-8 characters with normal ascii,
>> >> 3. Ditch the separate compilation of translate.c.
>> >>
>> >> I retained the two separate files that could be regenerated
>> >> from the included cpugen program, but merged in translate-insn.c.
>> >> Not that it matters, but the code generated is about 3k smaller.
>> >>
>> >> changes since v18
>> >> 1.  moving target-avr into target/avr
>> >> 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
>> >> 3.  call cpu_exec_realizefn avr_cpu_realizefn
>> >> 4.  do not fail sample machine creation if no rom is suplied
>> >> 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
>> >> 6.  fix a register getters/setters in machine.c
>> >> 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>> >>
>> >> changes since v19
>> >> 1.  use decodetree.py tool to decode instructions
>> >> 2.  adding USART
>> >> 3.  adding 16 bit timer peripherals
>> >> 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
>> >> 5.  renaming tlb_fill to avr_cpu_tlb_fill
>> >>
>> >> changes since v20
>> >> 1.  use one CPU naming convention
>> >> 2.  merging insn16.decode & insn32.decode files
>> >> 3.  modifying skip next instruction mechanizm
>> >> 4.  translate BREAK as NOP for now
>> >>
>> >> changes since v21
>> >> 1.  Reorganize bstate.
>> >>     This will make transition to <exec/translator.h> easier, and fixe=
s
>> a couple of bugs wrt single stepping
>> >>     by richard.henderson@linaro.org
>> >> 2.  Drop cpc and fix page cross condition.
>> >>     by richard.henderson@linaro.org
>> >> 3.  Refactor checking supported/unsupported instructions
>> >> 4.  Add gdb-xml/avr-cpu.xml
>> >>
>> >> changes since v22
>> >> 1.  Rebase
>> >> 2.  Split long comment
>> >>
>> >> changes since v23
>> >> 1.  remove avr_cpu_list_compare function
>> >> 2.  modify avr_cpu_class_by_name function
>> >> 3.  modify avr_cpu_list_entry function
>> >> 4.  modify avr_cpu_list function
>> >>
>> >> changes since v24
>> >> 1.  remove AVR_CPU_TYPE_NAME macro
>> >>
>> >> changes since v25
>> >> 1.  fix patches. every file belong to one patch only
>> >> 2.  change copyright year from 2016 to 2019
>> >> 3.  create mask device to emulate prr0/prr1
>> >>
>> >> changes since v26
>> >> 1.  add avocado acceptence test
>> >> 2.  add boot serial test
>> >>
>> >> changes since v27
>> >> 1.  list atmel2560 devices as unimplemented
>> >> 2.  fix sram base/size
>> >>
>> >> changes since v28
>> >> 1.  rebase
>> >> 2.  fix includes & build
>> >>
>> >> changes since v29
>> >> 1.  fixing ownership
>> >> 2.  using 'since' instread of 'added in'
>> >>
>> >> changes since v30
>> >> 1.  rebase
>> >>
>> >> Michael Rolnik (7):
>> >>   target/avr: Add outward facing interfaces and core CPU logic
>> >>   target/avr: Add instruction helpers
>> >>   target/avr: Add instruction decoding
>> >>   target/avr: Add instruction translation
>> >>   target/avr: Add example board configuration
>> >>   target/avr: Register AVR support with the rest of QEMU, the build
>> >>     system, and the MAINTAINERS file
>> >>   target/avr: Add tests
>> >>
>> >> Sarah Harris (1):
>> >>   target/avr: Add limited support for USART and 16 bit timer
>> peripherals
>> >>
>> >>  MAINTAINERS                      |    6 +
>> >>  arch_init.c                      |    2 +
>> >>  configure                        |   89 +-
>> >>  default-configs/avr-softmmu.mak  |    5 +
>> >>  gdb-xml/avr-cpu.xml              |   49 +
>> >>  hw/Kconfig                       |    1 +
>> >>  hw/avr/Kconfig                   |    6 +
>> >>  hw/avr/Makefile.objs             |    1 +
>> >>  hw/avr/sample.c                  |  282 +++
>> >>  hw/char/Kconfig                  |    3 +
>> >>  hw/char/Makefile.objs            |    1 +
>> >>  hw/char/avr_usart.c              |  324 ++++
>> >>  hw/misc/Kconfig                  |    3 +
>> >>  hw/misc/Makefile.objs            |    2 +
>> >>  hw/misc/avr_mask.c               |  112 ++
>> >>  hw/timer/Kconfig                 |    3 +
>> >>  hw/timer/Makefile.objs           |    1 +
>> >>  hw/timer/avr_timer16.c           |  605 +++++++
>> >>  include/disas/dis-asm.h          |    6 +
>> >>  include/hw/char/avr_usart.h      |   97 +
>> >>  include/hw/misc/avr_mask.h       |   47 +
>> >>  include/hw/timer/avr_timer16.h   |   97 +
>> >>  include/sysemu/arch_init.h       |    1 +
>> >>  qapi/machine.json                |    3 +-
>> >>  target/avr/Makefile.objs         |   33 +
>> >>  target/avr/cpu-param.h           |   37 +
>> >>  target/avr/cpu-qom.h             |   54 +
>> >>  target/avr/cpu.c                 |  576 ++++++
>> >>  target/avr/cpu.h                 |  254 +++
>> >>  target/avr/gdbstub.c             |   85 +
>> >>  target/avr/helper.c              |  354 ++++
>> >>  target/avr/helper.h              |   29 +
>> >>  target/avr/insn.decode           |  175 ++
>> >>  target/avr/machine.c             |  121 ++
>> >>  target/avr/translate.c           | 2888 ++++++++++++++++++++++++++++=
++
>> >>  tests/Makefile.include           |    2 +
>> >>  tests/acceptance/machine_avr6.py |   36 +
>> >>  tests/boot-serial-test.c         |   10 +
>> >>  tests/machine-none-test.c        |    1 +
>> >>  39 files changed, 6359 insertions(+), 42 deletions(-)
>> >>  create mode 100644 default-configs/avr-softmmu.mak
>> >>  create mode 100644 gdb-xml/avr-cpu.xml
>> >>  create mode 100644 hw/avr/Kconfig
>> >>  create mode 100644 hw/avr/Makefile.objs
>> >>  create mode 100644 hw/avr/sample.c
>> >>  create mode 100644 hw/char/avr_usart.c
>> >>  create mode 100644 hw/misc/avr_mask.c
>> >>  create mode 100644 hw/timer/avr_timer16.c
>> >>  create mode 100644 include/hw/char/avr_usart.h
>> >>  create mode 100644 include/hw/misc/avr_mask.h
>> >>  create mode 100644 include/hw/timer/avr_timer16.h
>> >>  create mode 100644 target/avr/Makefile.objs
>> >>  create mode 100644 target/avr/cpu-param.h
>> >>  create mode 100644 target/avr/cpu-qom.h
>> >>  create mode 100644 target/avr/cpu.c
>> >>  create mode 100644 target/avr/cpu.h
>> >>  create mode 100644 target/avr/gdbstub.c
>> >>  create mode 100644 target/avr/helper.c
>> >>  create mode 100644 target/avr/helper.h
>> >>  create mode 100644 target/avr/insn.decode
>> >>  create mode 100644 target/avr/machine.c
>> >>  create mode 100644 target/avr/translate.c
>> >>  create mode 100644 tests/acceptance/machine_avr6.py
>> >>
>> >> --
>> >> 2.17.2 (Apple Git-113)
>> >>
>> >
>> >
>> > --
>> > Best Regards,
>> > Michael Rolnik
>>
>
>
> --
> Best Regards,
> Michael Rolnik
>

--00000000000052949e05948cd6eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, October 9, 2019, Michael Rolnik &lt;<a href=3D"mailto=
:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div>Hello Aleksandar.</div><div><br></div><=
div><br></div><a href=3D"https://ww1.microchip.com/downloads/en/devicedoc/a=
tmel-2549-8-bit-avr-microcontroller-atmega640-1280-1281-2560-2561_datasheet=
.pdf" target=3D"_blank">https://ww1.microchip.com/<wbr>downloads/en/deviced=
oc/atmel-<wbr>2549-8-bit-avr-<wbr>microcontroller-atmega640-<wbr>1280-1281-=
2560-2561_datasheet.<wbr>pdf</a><br><div><br></div></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br></blockquote></blockquote><div><br></div><div>Thanks, Mic=
hael!</div><div><br></div><div>Could you please provide also a link to AVR =
instruction set reference documentation that you used while creating this s=
eries, one that this series should support?</div><div><br></div><div>Aleksa=
ndar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct =
9, 2019 at 11:38 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.=
mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><p dir=3D"ltr"=
><br>
23.09.2019. 15.29, &quot;Michael Rolnik&quot; &lt;<a href=3D"mailto:mrolnik=
@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; is there any hope this will be ever pulled?<br>
&gt;<br>
&gt; regards,<br>
&gt; Michael<br>
&gt;</p>
<p dir=3D"ltr">Hello, Michael.</p>
<p dir=3D"ltr">I am practically new to your series, even though it is v31. =
Could you perhaps include links to any documentation that you think it can =
be pertinent to your solution (I apologize if you already did it somewhere =
else)?</p>
<p dir=3D"ltr">I do admire your persistence.</p>
<p dir=3D"ltr">Yours, Aleksandar<br></p>
<p dir=3D"ltr">&gt; On Sun, Sep 15, 2019 at 3:20 PM Michael Rolnik &lt;<a h=
ref=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt; This series of patches adds 8bit AVR cores to QEMU.<br>
&gt;&gt; All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not f=
ully tested yet.<br>
&gt;&gt; However I was able to execute simple code with functions. e.g fibo=
nacci calculation.<br>
&gt;&gt; This series of patches include a non real, sample board.<br>
&gt;&gt; No fuses support yet. PC is set to 0 at reset.<br>
&gt;&gt;<br>
&gt;&gt; the patches include the following<br>
&gt;&gt; 1. just a basic 8bit AVR CPU, without instruction decoding or tran=
slation<br>
&gt;&gt; 2. CPU features which allow define the following 8bit AVR cores<br=
>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0avr1<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0avr2 avr25<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0avr3 avr31 avr35<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0avr4<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0avr5 avr51<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0avr6<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0xmega2 xmega4 xmega5 xmega6 xmega7<br>
&gt;&gt; 3. a definition of sample machine with SRAM, FLASH and CPU which a=
llows to execute simple code<br>
&gt;&gt; 4. encoding for all AVR instructions<br>
&gt;&gt; 5. interrupt handling<br>
&gt;&gt; 6. helpers for IN, OUT, SLEEP, WBR &amp; unsupported instructions<=
br>
&gt;&gt; 7. a decoder which given an opcode decides what istruction it is<b=
r>
&gt;&gt; 8. translation of AVR instruction into TCG<br>
&gt;&gt; 9. all features together<br>
&gt;&gt;<br>
&gt;&gt; changes since v3<br>
&gt;&gt; 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x0=
00000ff) for faster address manipulaton<br>
&gt;&gt; 2. ffs changed to ctz32<br>
&gt;&gt; 3. duplicate code removed at avr_cpu_do_interrupt<br>
&gt;&gt; 4. using andc instead of not + and<br>
&gt;&gt; 5. fixing V flag calculation in varios instructions<br>
&gt;&gt; 6. freeing local variables in PUSH<br>
&gt;&gt; 7. tcg_const_local_i32 -&gt; tcg_const_i32<br>
&gt;&gt; 8. using sextract32 instead of my implementation<br>
&gt;&gt; 9. fixing BLD instruction<br>
&gt;&gt; 10.xor(r) instead of 0xff - r at COM<br>
&gt;&gt; 11.fixing MULS/MULSU not to modify inputs&#39; content<br>
&gt;&gt; 12.using SUB for NEG<br>
&gt;&gt; 13.fixing tcg_gen_qemu_ld/st call in XCH<br>
&gt;&gt;<br>
&gt;&gt; changes since v4<br>
&gt;&gt; 1. target is now defined as big endian in order to optimize push_r=
et/pop_ret<br>
&gt;&gt; 2. all style warnings are fixed<br>
&gt;&gt; 3. adding cpu_set/get_sreg functions<br>
&gt;&gt; 4. simplifying gen_goto_tb as there is no real paging<br>
&gt;&gt; 5. env-&gt;pc -&gt; env-&gt;pc_w<br>
&gt;&gt; 6. making flag dump more compact<br>
&gt;&gt; 7. more spacing<br>
&gt;&gt; 8. renaming CODE/DATA_INDEX -&gt; MMU_CODE/DATA_IDX<br>
&gt;&gt; 9. removing avr_set_feature<br>
&gt;&gt; 10. SPL/SPH set bug fix<br>
&gt;&gt; 11. switching stb_phys to cpu_stb_data<br>
&gt;&gt; 12. cleaning up avr_decode<br>
&gt;&gt; 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)<br>
&gt;&gt; 14. saving CPU features (savevm)<br>
&gt;&gt;<br>
&gt;&gt; changes since v5<br>
&gt;&gt; 1. BLD bug fix<br>
&gt;&gt; 2. decoder generator is added<br>
&gt;&gt;<br>
&gt;&gt; chages since v6<br>
&gt;&gt; 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/av=
r_<wbr>cpu_gdb_write_register<br>
&gt;&gt; 2. configure the target as little endian because otherwise GDB doe=
s not work<br>
&gt;&gt; 3. fixing and testing gen_push_ret/gen_pop_ret<br>
&gt;&gt;<br>
&gt;&gt; changes since v7<br>
&gt;&gt; 1. folding back v6<br>
&gt;&gt; 2. logging at helper_outb and helper_inb are done for non supporte=
d yet registers only<br>
&gt;&gt; 3. MAINTAINERS updated<br>
&gt;&gt;<br>
&gt;&gt; changes since v8<br>
&gt;&gt; 1. removing hw/avr from hw/Makefile.obj as it should not be built =
for all<br>
&gt;&gt; 2. making linux compilable<br>
&gt;&gt; 3. testing on<br>
&gt;&gt; =C2=A0 =C2=A0 a. Mac, Apple LLVM version 7.0.0<br>
&gt;&gt; =C2=A0 =C2=A0 b. Ubuntu 12.04, gcc 4.9.2<br>
&gt;&gt; =C2=A0 =C2=A0 c. Fedora 23, gcc 5.3.1<br>
&gt;&gt; 4. folding back some patches<br>
&gt;&gt; 5. translation bug fixes for ORI, CPI, XOR instructions<br>
&gt;&gt; 6. propper handling of cpu register writes though memory<br>
&gt;&gt;<br>
&gt;&gt; changes since v9<br>
&gt;&gt; 1. removing forward declarations of static functions<br>
&gt;&gt; 2. disabling debug prints<br>
&gt;&gt; 3. switching to case range instead of if else if ...<br>
&gt;&gt; 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed=
 to any device<br>
&gt;&gt; 5. commenst about sample board and sample IO device added<br>
&gt;&gt; 6. sample board description is more descriptive now<br>
&gt;&gt; 7. memory_region_allocate_system_<wbr>memory is used to create RAM=
<br>
&gt;&gt; 8. now there are helper_fullrd &amp; helper_fullwr when LD/ST try =
to access registers<br>
&gt;&gt;<br>
&gt;&gt; changes since v10<br>
&gt;&gt; 1. movig back fullwr &amp; fullrd into the commit where outb and i=
nb were introduced<br>
&gt;&gt; 2. changing tlb_fill function signature<br>
&gt;&gt; 3. adding empty line between functions<br>
&gt;&gt; 4. adding newline on the last line of the file<br>
&gt;&gt; 5. using tb-&gt;flags to generae full access ST/LD instructions<br=
>
&gt;&gt; 6. fixing SBRC bug<br>
&gt;&gt; 7. folding back 10th commit<br>
&gt;&gt; 8. whenever a new file is introduced it&#39;s added to Makefile.ob=
js<br>
&gt;&gt;<br>
&gt;&gt; changes since v11<br>
&gt;&gt; 1. updating to v2.7.0-rc<br>
&gt;&gt; 2. removing assignment to env-&gt;fullacc from gen_intermediate_co=
de<br>
&gt;&gt;<br>
&gt;&gt; changes since v12<br>
&gt;&gt; 1. fixing spacing<br>
&gt;&gt; 2. fixing get/put_segment functions<br>
&gt;&gt; 3. removing target-avr/machine.h file<br>
&gt;&gt; 4. VMSTATE_SINGLE_TEST -&gt; VMSTATE_SINGLE<br>
&gt;&gt; 5. comment spelling<br>
&gt;&gt; 6. removing hw/avr/sample_io.c<br>
&gt;&gt; 7. char const* -&gt; const char*<br>
&gt;&gt; 8. proper ram allocation<br>
&gt;&gt; 9. fixing breakpoint functionality.<br>
&gt;&gt; 10.env1 -&gt; env<br>
&gt;&gt; 11.fixing avr_cpu_gdb_write_register &amp; avr_cpu_gdb_read_regist=
er functions<br>
&gt;&gt; 12.any cpu is removed<br>
&gt;&gt; 12.feature bits are not saved into vm state<br>
&gt;&gt;<br>
&gt;&gt; changes since v13<br>
&gt;&gt; 1. rebasing to v2.7.0-rc1<br>
&gt;&gt;<br>
&gt;&gt; changes since v14<br>
&gt;&gt; 1. I made self review with git gui tool. (I did not know such a th=
ing exists)<br>
&gt;&gt; 2. removing all double/tripple spaces<br>
&gt;&gt; 3. removing comment reference to SampleIO<br>
&gt;&gt; 4. folding back some changes, so there is not deleted lines in my =
code<br>
&gt;&gt; 5. moving avr configuration, within configure file, before chris<b=
r>
&gt;&gt;<br>
&gt;&gt; changes since v15<br>
&gt;&gt; 1. removing IO registers cache from CPU<br>
&gt;&gt; 2. implementing CBI/SBI as read(helper_inb), modify, write(helper_=
outb)<br>
&gt;&gt; 3. implementing CBIC/SBIC as read(helper_inb), check, branch<br>
&gt;&gt; 4. adding missing tcg_temp_free_i32 for tcg_const_i32<br>
&gt;&gt;<br>
&gt;&gt; changes since v16<br>
&gt;&gt; 1. removing EXT IO registers knoledge from CPU. These registers ar=
e accessible<br>
&gt;&gt; =C2=A0 =C2=A0by LD/ST only. CPU has no interest in them<br>
&gt;&gt;<br>
&gt;&gt; changes since v17 (by Richard Henderson)<br>
&gt;&gt; This is Michael&#39;s v17, with some adjustments of my own:<br>
&gt;&gt;<br>
&gt;&gt; 1. Fix the whitespace errors reported by &quot;git am&quot;,<br>
&gt;&gt; 2. Replace the utf-8 characters with normal ascii,<br>
&gt;&gt; 3. Ditch the separate compilation of translate.c.<br>
&gt;&gt;<br>
&gt;&gt; I retained the two separate files that could be regenerated<br>
&gt;&gt; from the included cpugen program, but merged in translate-insn.c.<=
br>
&gt;&gt; Not that it matters, but the code generated is about 3k smaller.<b=
r>
&gt;&gt;<br>
&gt;&gt; changes since v18<br>
&gt;&gt; 1.=C2=A0 moving target-avr into target/avr<br>
&gt;&gt; 2.=C2=A0 do not call cpu_exec_initfn function from avr_cpu_initfn<=
br>
&gt;&gt; 3.=C2=A0 call cpu_exec_realizefn avr_cpu_realizefn<br>
&gt;&gt; 4.=C2=A0 do not fail sample machine creation if no rom is suplied<=
br>
&gt;&gt; 5.=C2=A0 add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_=
code<br>
&gt;&gt; 6.=C2=A0 fix a register getters/setters in machine.c<br>
&gt;&gt; 7.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;17 to 1&lt;&lt;18<br=
>
&gt;&gt;<br>
&gt;&gt; changes since v19<br>
&gt;&gt; 1.=C2=A0 use decodetree.py tool to decode instructions<br>
&gt;&gt; 2.=C2=A0 adding USART<br>
&gt;&gt; 3.=C2=A0 adding 16 bit timer peripherals<br>
&gt;&gt; 4.=C2=A0 changing QEMU_ARCH_AVR from 1&lt;&lt;18 to 1&lt;&lt;20<br=
>
&gt;&gt; 5.=C2=A0 renaming tlb_fill to avr_cpu_tlb_fill<br>
&gt;&gt;<br>
&gt;&gt; changes since v20<br>
&gt;&gt; 1.=C2=A0 use one CPU naming convention<br>
&gt;&gt; 2.=C2=A0 merging insn16.decode &amp; insn32.decode files<br>
&gt;&gt; 3.=C2=A0 modifying skip next instruction mechanizm<br>
&gt;&gt; 4.=C2=A0 translate BREAK as NOP for now<br>
&gt;&gt;<br>
&gt;&gt; changes since v21<br>
&gt;&gt; 1.=C2=A0 Reorganize bstate.<br>
&gt;&gt; =C2=A0 =C2=A0 This will make transition to &lt;exec/translator.h&g=
t; easier, and fixes a couple of bugs wrt single stepping<br>
&gt;&gt; =C2=A0 =C2=A0 by <a href=3D"mailto:richard.henderson@linaro.org" t=
arget=3D"_blank">richard.henderson@linaro.org</a><br>
&gt;&gt; 2.=C2=A0 Drop cpc and fix page cross condition.<br>
&gt;&gt; =C2=A0 =C2=A0 by <a href=3D"mailto:richard.henderson@linaro.org" t=
arget=3D"_blank">richard.henderson@linaro.org</a><br>
&gt;&gt; 3.=C2=A0 Refactor checking supported/unsupported instructions<br>
&gt;&gt; 4.=C2=A0 Add gdb-xml/avr-cpu.xml<br>
&gt;&gt;<br>
&gt;&gt; changes since v22<br>
&gt;&gt; 1.=C2=A0 Rebase<br>
&gt;&gt; 2.=C2=A0 Split long comment<br>
&gt;&gt;<br>
&gt;&gt; changes since v23<br>
&gt;&gt; 1.=C2=A0 remove avr_cpu_list_compare function<br>
&gt;&gt; 2.=C2=A0 modify avr_cpu_class_by_name function<br>
&gt;&gt; 3.=C2=A0 modify avr_cpu_list_entry function<br>
&gt;&gt; 4.=C2=A0 modify avr_cpu_list function<br>
&gt;&gt;<br>
&gt;&gt; changes since v24<br>
&gt;&gt; 1.=C2=A0 remove AVR_CPU_TYPE_NAME macro<br>
&gt;&gt;<br>
&gt;&gt; changes since v25<br>
&gt;&gt; 1.=C2=A0 fix patches. every file belong to one patch only<br>
&gt;&gt; 2.=C2=A0 change copyright year from 2016 to 2019<br>
&gt;&gt; 3.=C2=A0 create mask device to emulate prr0/prr1<br>
&gt;&gt;<br>
&gt;&gt; changes since v26<br>
&gt;&gt; 1.=C2=A0 add avocado acceptence test<br>
&gt;&gt; 2.=C2=A0 add boot serial test<br>
&gt;&gt;<br>
&gt;&gt; changes since v27<br>
&gt;&gt; 1.=C2=A0 list atmel2560 devices as unimplemented<br>
&gt;&gt; 2.=C2=A0 fix sram base/size<br>
&gt;&gt;<br>
&gt;&gt; changes since v28<br>
&gt;&gt; 1.=C2=A0 rebase<br>
&gt;&gt; 2.=C2=A0 fix includes &amp; build<br>
&gt;&gt;<br>
&gt;&gt; changes since v29<br>
&gt;&gt; 1.=C2=A0 fixing ownership<br>
&gt;&gt; 2.=C2=A0 using &#39;since&#39; instread of &#39;added in&#39;<br>
&gt;&gt;<br>
&gt;&gt; changes since v30<br>
&gt;&gt; 1.=C2=A0 rebase<br>
&gt;&gt;<br>
&gt;&gt; Michael Rolnik (7):<br>
&gt;&gt; =C2=A0 target/avr: Add outward facing interfaces and core CPU logi=
c<br>
&gt;&gt; =C2=A0 target/avr: Add instruction helpers<br>
&gt;&gt; =C2=A0 target/avr: Add instruction decoding<br>
&gt;&gt; =C2=A0 target/avr: Add instruction translation<br>
&gt;&gt; =C2=A0 target/avr: Add example board configuration<br>
&gt;&gt; =C2=A0 target/avr: Register AVR support with the rest of QEMU, the=
 build<br>
&gt;&gt; =C2=A0 =C2=A0 system, and the MAINTAINERS file<br>
&gt;&gt; =C2=A0 target/avr: Add tests<br>
&gt;&gt;<br>
&gt;&gt; Sarah Harris (1):<br>
&gt;&gt; =C2=A0 target/avr: Add limited support for USART and 16 bit timer =
peripherals<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +<br>
&gt;&gt; =C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt; =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A089 +-<br>
&gt;&gt; =C2=A0default-configs/avr-softmmu.<wbr>mak=C2=A0 |=C2=A0 =C2=A0 5 =
+<br>
&gt;&gt; =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A049 +<br>
&gt;&gt; =C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;&gt; =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
&gt;&gt; =C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
&gt;&gt; =C2=A0hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 282 +++<br>
&gt;&gt; =C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;&gt; =C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;&gt; =C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 324 ++++<br>
&gt;&gt; =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
&gt;&gt; =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;&gt; =C2=A0hw/misc/avr_mask.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 112 ++<br>
&gt;&gt; =C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
&gt;&gt; =C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 1 +<br>
&gt;&gt; =C2=A0hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 605 +++++++<br>
&gt;&gt; =C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 6 +<br>
&gt;&gt; =C2=A0include/hw/char/avr_usart.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A097 +<br>
&gt;&gt; =C2=A0include/hw/misc/avr_mask.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A047 +<br>
&gt;&gt; =C2=A0include/hw/timer/avr_timer16.<wbr>h=C2=A0 =C2=A0|=C2=A0 =C2=
=A097 +<br>
&gt;&gt; =C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A0 1 +<br>
&gt;&gt; =C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;&gt; =C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A033 +<br>
&gt;&gt; =C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A037 +<br>
&gt;&gt; =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A054 +<br>
&gt;&gt; =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 576 ++++++<br>
&gt;&gt; =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 254 +++<br>
&gt;&gt; =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A085 +<br>
&gt;&gt; =C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 354 ++++<br>
&gt;&gt; =C2=A0target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A029 +<br>
&gt;&gt; =C2=A0target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 175 ++<br>
&gt;&gt; =C2=A0target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 121 ++<br>
&gt;&gt; =C2=A0target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2888 ++++++++++++++++++++++++++++++<br>
&gt;&gt; =C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 2 +<br>
&gt;&gt; =C2=A0tests/acceptance/machine_<wbr>avr6.py |=C2=A0 =C2=A036 +<br>
&gt;&gt; =C2=A0tests/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A010 +<br>
&gt;&gt; =C2=A0tests/machine-none-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A0 1 +<br>
&gt;&gt; =C2=A039 files changed, 6359 insertions(+), 42 deletions(-)<br>
&gt;&gt; =C2=A0create mode 100644 default-configs/avr-softmmu.<wbr>mak<br>
&gt;&gt; =C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
&gt;&gt; =C2=A0create mode 100644 hw/avr/Kconfig<br>
&gt;&gt; =C2=A0create mode 100644 hw/avr/Makefile.objs<br>
&gt;&gt; =C2=A0create mode 100644 hw/avr/sample.c<br>
&gt;&gt; =C2=A0create mode 100644 hw/char/avr_usart.c<br>
&gt;&gt; =C2=A0create mode 100644 hw/misc/avr_mask.c<br>
&gt;&gt; =C2=A0create mode 100644 hw/timer/avr_timer16.c<br>
&gt;&gt; =C2=A0create mode 100644 include/hw/char/avr_usart.h<br>
&gt;&gt; =C2=A0create mode 100644 include/hw/misc/avr_mask.h<br>
&gt;&gt; =C2=A0create mode 100644 include/hw/timer/avr_timer16.h<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/Makefile.objs<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/cpu-param.h<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/cpu-qom.h<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/cpu.c<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/cpu.h<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/gdbstub.c<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/helper.c<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/helper.h<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/insn.decode<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/machine.c<br>
&gt;&gt; =C2=A0create mode 100644 target/avr/translate.c<br>
&gt;&gt; =C2=A0create mode 100644 tests/acceptance/machine_avr6.<wbr>py<br>
&gt;&gt;<br>
&gt;&gt; -- <br>
&gt;&gt; 2.17.2 (Apple Git-113)<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; -- <br>
&gt; Best Regards,<br>
&gt; Michael Rolnik</p>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--00000000000052949e05948cd6eb--

