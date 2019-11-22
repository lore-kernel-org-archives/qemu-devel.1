Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FAAC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875702067D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKKRlES7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875702067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53685 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDR6-0005JE-Ct
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYCv5-0003Ir-BM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYCv2-00063M-8w
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:40:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYCuz-0005wp-MB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:40:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id d5so6887602otp.4
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eHPp76cVG/utQvqcTDOpPAEg9OOhfTKltC/XyNTOvLs=;
 b=DKKRlES7GWNxgEZppYEEYkXYQkQMKM/R9ZNsFXKLta/hvrv0EfKJUmL6eR+k+yjFz8
 vPZY/WWXlV1tlNaYImsSbdaKV1GB3k0VUdSBaTjSBntAq6haJLOUcUvO1Om3PIw2GSqs
 CxutcX6CJ115aCMMHQIRFiC4cAQPppq+yBz4ziLBTlKxTSfk2PRxyg3jkMxEJjJsBaE3
 8J9NBvGRv0XADZBDra38DsQ+veYrM6AD7f04ZQg9NpMzfeRp0o3mvDH5BRpEKiXhzbgi
 m07ZEVpnP/IZJI/q9DHlTXnIfcbv9bZ75lNROSbukz8C0h2oHdVsrSeFQBWg4eP6Q2e3
 bjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eHPp76cVG/utQvqcTDOpPAEg9OOhfTKltC/XyNTOvLs=;
 b=bz0gRkXbmBWxpdvf5BzyK/1EBLljW8jCZZ/bdFDMOyf8tSNMN1lIMQt4GhY7lzYBCK
 JL2YbljJzDuI+pVGoe4UUO8pinIIBA5K/em0BTV+QQVPigD6dOfAPrduKhi8dvb8D5vz
 7YsiVZMj29tFLYq4JqUaiaCsi/ywy3zEho0CY2H4i7jLJNjKn5uHryyUMEhtZy5NcQyw
 nbzdfUzBnCahl0m11Y5jDK2fvUYG90Ksqny79CAyn0dMVl1OLTeQRsFTj4LCvNJzgkFZ
 W+ms7cZL5qAvDzDqOjPANq4IEHMrtC6ohBGOdguXptHqZAvfsgo4hRQgPdlM3vzAkHg0
 EmdQ==
X-Gm-Message-State: APjAAAWoFN1f1fcuf5bbQL5578vj3yXYjUA1XSEuwYS4QaZTgQ03vOpB
 59HxP9OWVXNV6y3UMsYXo8FUK7eoSeobcT88Ng0=
X-Google-Smtp-Source: APXvYqyyct/92A81bqLijntopbeFrCOrxIciGv3FIUJCYs2j2tmSCBDVK6tpXzS/rY3d1VtZZ/RZHYJeti5nrzSkzUE=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr11099920otc.121.1574444425678; 
 Fri, 22 Nov 2019 09:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
In-Reply-To: <20191029212430.20617-1-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 18:40:14 +0100
Message-ID: <CAL1e-=jrJki5cK9yTptYkm4TjYykZ57=N1o3N9kTHSewpLw4Cw@mail.gmail.com>
Subject: Re: [PATCH v35 00/13] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 10:25 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> This series of patches adds 8bit AVR cores to QEMU.
> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully tested yet.
> However I was able to execute simple code with functions. e.g fibonacci calculation.
> This series of patches include a non real, sample board.
> No fuses support yet. PC is set to 0 at reset.
>
> the patches include the following
> 1. just a basic 8bit AVR CPU, without instruction decoding or translation
> 2. CPU features which allow define the following 8bit AVR cores
>      avr1
>      avr2 avr25
>      avr3 avr31 avr35
>      avr4
>      avr5 avr51
>      avr6
>      xmega2 xmega4 xmega5 xmega6 xmega7
> 3. a definition of sample machine with SRAM, FLASH and CPU which allows to execute simple code
> 4. encoding for all AVR instructions
> 5. interrupt handling
> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
> 7. a decoder which given an opcode decides what istruction it is
> 8. translation of AVR instruction into TCG
> 9. all features together
>

Hello Michael.

I noticed some imperfection in your patches: If your patch contains
changes in, let's say, cpu.h and cpu.c files, your diff orders the
chunks like this: first changes to cpu.c, and after that, cpu.h (sa,
alphabetically), making the review of the patch a little unegronomic.
Could you please run the script scrpits/git.orderfile in your dev
directory, so that your git diffs are organized better?

Thanks,
Aleksandar

P.S. The entire script content:

#
# order file for git, to produce patches which are easier to review
# by diffing the important stuff like interface changes first.
#
# one-off usage:
#   git diff -O scripts/git.orderfile ...
#
# add to git config:
#   git config diff.orderFile scripts/git.orderfile
#

# Documentation
docs/*
*.texi

# build system
configure
Makefile*
*.mak

# qapi schema
qapi/*.json
qga/*.json

# headers
*.h

# code
*.c


> changes since v3
> 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x000000ff) for faster address manipulaton
> 2. ffs changed to ctz32
> 3. duplicate code removed at avr_cpu_do_interrupt
> 4. using andc instead of not + and
> 5. fixing V flag calculation in varios instructions
> 6. freeing local variables in PUSH
> 7. tcg_const_local_i32 -> tcg_const_i32
> 8. using sextract32 instead of my implementation
> 9. fixing BLD instruction
> 10.xor(r) instead of 0xff - r at COM
> 11.fixing MULS/MULSU not to modify inputs' content
> 12.using SUB for NEG
> 13.fixing tcg_gen_qemu_ld/st call in XCH
>
> changes since v4
> 1. target is now defined as big endian in order to optimize push_ret/pop_ret
> 2. all style warnings are fixed
> 3. adding cpu_set/get_sreg functions
> 4. simplifying gen_goto_tb as there is no real paging
> 5. env->pc -> env->pc_w
> 6. making flag dump more compact
> 7. more spacing
> 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
> 9. removing avr_set_feature
> 10. SPL/SPH set bug fix
> 11. switching stb_phys to cpu_stb_data
> 12. cleaning up avr_decode
> 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
> 14. saving CPU features (savevm)
>
> changes since v5
> 1. BLD bug fix
> 2. decoder generator is added
>
> chages since v6
> 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_cpu_gdb_write_register
> 2. configure the target as little endian because otherwise GDB does not work
> 3. fixing and testing gen_push_ret/gen_pop_ret
>
> changes since v7
> 1. folding back v6
> 2. logging at helper_outb and helper_inb are done for non supported yet registers only
> 3. MAINTAINERS updated
>
> changes since v8
> 1. removing hw/avr from hw/Makefile.obj as it should not be built for all
> 2. making linux compilable
> 3. testing on
>     a. Mac, Apple LLVM version 7.0.0
>     b. Ubuntu 12.04, gcc 4.9.2
>     c. Fedora 23, gcc 5.3.1
> 4. folding back some patches
> 5. translation bug fixes for ORI, CPI, XOR instructions
> 6. propper handling of cpu register writes though memory
>
> changes since v9
> 1. removing forward declarations of static functions
> 2. disabling debug prints
> 3. switching to case range instead of if else if ...
> 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to any device
> 5. commenst about sample board and sample IO device added
> 6. sample board description is more descriptive now
> 7. memory_region_allocate_system_memory is used to create RAM
> 8. now there are helper_fullrd & helper_fullwr when LD/ST try to access registers
>
> changes since v10
> 1. movig back fullwr & fullrd into the commit where outb and inb were introduced
> 2. changing tlb_fill function signature
> 3. adding empty line between functions
> 4. adding newline on the last line of the file
> 5. using tb->flags to generae full access ST/LD instructions
> 6. fixing SBRC bug
> 7. folding back 10th commit
> 8. whenever a new file is introduced it's added to Makefile.objs
>
> changes since v11
> 1. updating to v2.7.0-rc
> 2. removing assignment to env->fullacc from gen_intermediate_code
>
> changes since v12
> 1. fixing spacing
> 2. fixing get/put_segment functions
> 3. removing target-avr/machine.h file
> 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
> 5. comment spelling
> 6. removing hw/avr/sample_io.c
> 7. char const* -> const char*
> 8. proper ram allocation
> 9. fixing breakpoint functionality.
> 10.env1 -> env
> 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register functions
> 12.any cpu is removed
> 12.feature bits are not saved into vm state
>
> changes since v13
> 1. rebasing to v2.7.0-rc1
>
> changes since v14
> 1. I made self review with git gui tool. (I did not know such a thing exists)
> 2. removing all double/tripple spaces
> 3. removing comment reference to SampleIO
> 4. folding back some changes, so there is not deleted lines in my code
> 5. moving avr configuration, within configure file, before chris
>
> changes since v15
> 1. removing IO registers cache from CPU
> 2. implementing CBI/SBI as read(helper_inb), modify, write(helper_outb)
> 3. implementing CBIC/SBIC as read(helper_inb), check, branch
> 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>
> changes since v16
> 1. removing EXT IO registers knoledge from CPU. These registers are accessible
>    by LD/ST only. CPU has no interest in them
>
> changes since v17 (by Richard Henderson)
> This is Michael's v17, with some adjustments of my own:
>
> 1. Fix the whitespace errors reported by "git am",
> 2. Replace the utf-8 characters with normal ascii,
> 3. Ditch the separate compilation of translate.c.
>
> I retained the two separate files that could be regenerated
> from the included cpugen program, but merged in translate-insn.c.
> Not that it matters, but the code generated is about 3k smaller.
>
> changes since v18
> 1.  moving target-avr into target/avr
> 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
> 3.  call cpu_exec_realizefn avr_cpu_realizefn
> 4.  do not fail sample machine creation if no rom is suplied
> 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
> 6.  fix a register getters/setters in machine.c
> 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>
> changes since v19
> 1.  use decodetree.py tool to decode instructions
> 2.  adding USART
> 3.  adding 16 bit timer peripherals
> 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
> 5.  renaming tlb_fill to avr_cpu_tlb_fill
>
> changes since v20
> 1.  use one CPU naming convention
> 2.  merging insn16.decode & insn32.decode files
> 3.  modifying skip next instruction mechanizm
> 4.  translate BREAK as NOP for now
>
> changes since v21
> 1.  Reorganize bstate.
>     This will make transition to <exec/translator.h> easier, and fixes a couple of bugs wrt single stepping
>     by richard.henderson@linaro.org
> 2.  Drop cpc and fix page cross condition.
>     by richard.henderson@linaro.org
> 3.  Refactor checking supported/unsupported instructions
> 4.  Add gdb-xml/avr-cpu.xml
>
> changes since v22
> 1.  Rebase
> 2.  Split long comment
>
> changes since v23
> 1.  remove avr_cpu_list_compare function
> 2.  modify avr_cpu_class_by_name function
> 3.  modify avr_cpu_list_entry function
> 4.  modify avr_cpu_list function
>
> changes since v24
> 1.  remove AVR_CPU_TYPE_NAME macro
>
> changes since v25
> 1.  fix patches. every file belong to one patch only
> 2.  change copyright year from 2016 to 2019
> 3.  create mask device to emulate prr0/prr1
>
> changes since v26
> 1.  add avocado acceptence test
> 2.  add boot serial test
>
> changes since v27
> 1.  list atmel2560 devices as unimplemented
> 2.  fix sram base/size
>
> changes since v28
> 1.  rebase
> 2.  fix includes & build
>
> changes since v29
> 1.  fixing ownership
> 2.  using 'since' instread of 'added in'
>
> changes since v30
> 1.  rebase
>
> changes since v31
> 1.  splitting 'Add instruction translation' commit
> 2.  fixing typo in qapi/machine.json sicne -> since
> 3.  removing unintended changes in configure file
> 4.  adding Richard Henderson as a co developer to 'Add instruction translation - CPU main translation funcions' commit
>
> changes since v32
> 1.  modify cpu_get_sreg to treat sreg C as other flags, except sreg Z
>
> changes since v33
> 1.  ensure flag C is always calculated as one bit
> 2.  calculate flag Z as one bit, without using inverse logic
>
> changes since v34
> 1.  rebase
>
> Michael Rolnik (12):
>   target/avr: Add outward facing interfaces and core CPU logic
>   target/avr: Add instruction helpers
>   target/avr: Add instruction decoding
>   target/avr: Add instruction translation - Registers definition
>   target/avr: Add instruction translation - Arithmetic and Logic
>     Instructions
>   target/avr: Add instruction translation - Branch Instructions
>   target/avr: Add instruction translation - Bit and Bit-test
>     Instructions
>   target/avr: Add instruction translation - MCU Control Instructions
>   target/avr: Add instruction translation - CPU main translation
>     function
>   target/avr: Add example board configuration
>   target/avr: Register AVR support with the rest of QEMU, the build
>     system, and the WMAINTAINERS file
>   target/avr: Add tests
>
> Sarah Harris (1):
>   target/avr: Add limited support for USART and 16 bit timer peripherals
>
>  MAINTAINERS                      |    9 +
>  arch_init.c                      |    2 +
>  configure                        |    7 +
>  default-configs/avr-softmmu.mak  |    5 +
>  gdb-xml/avr-cpu.xml              |   49 +
>  hw/Kconfig                       |    1 +
>  hw/avr/Kconfig                   |    6 +
>  hw/avr/Makefile.objs             |    1 +
>  hw/avr/sample.c                  |  282 +++
>  hw/char/Kconfig                  |    3 +
>  hw/char/Makefile.objs            |    1 +
>  hw/char/avr_usart.c              |  324 ++++
>  hw/misc/Kconfig                  |    3 +
>  hw/misc/Makefile.objs            |    2 +
>  hw/misc/avr_mask.c               |  112 ++
>  hw/timer/Kconfig                 |    3 +
>  hw/timer/Makefile.objs           |    2 +
>  hw/timer/avr_timer16.c           |  605 ++++++
>  include/disas/dis-asm.h          |    6 +
>  include/hw/char/avr_usart.h      |   97 +
>  include/hw/misc/avr_mask.h       |   47 +
>  include/hw/timer/avr_timer16.h   |   97 +
>  include/sysemu/arch_init.h       |    1 +
>  qapi/machine.json                |    3 +-
>  target/avr/Makefile.objs         |   33 +
>  target/avr/cpu-param.h           |   37 +
>  target/avr/cpu-qom.h             |   54 +
>  target/avr/cpu.c                 |  576 ++++++
>  target/avr/cpu.h                 |  253 +++
>  target/avr/gdbstub.c             |   85 +
>  target/avr/helper.c              |  354 ++++
>  target/avr/helper.h              |   29 +
>  target/avr/insn.decode           |  175 ++
>  target/avr/machine.c             |  121 ++
>  target/avr/translate.c           | 3028 ++++++++++++++++++++++++++++++
>  tests/Makefile.include           |    2 +
>  tests/acceptance/machine_avr6.py |   36 +
>  tests/boot-serial-test.c         |   10 +
>  tests/machine-none-test.c        |    1 +
>  39 files changed, 6461 insertions(+), 1 deletion(-)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 gdb-xml/avr-cpu.xml
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>  create mode 100644 hw/avr/sample.c
>  create mode 100644 hw/char/avr_usart.c
>  create mode 100644 hw/misc/avr_mask.c
>  create mode 100644 hw/timer/avr_timer16.c
>  create mode 100644 include/hw/char/avr_usart.h
>  create mode 100644 include/hw/misc/avr_mask.h
>  create mode 100644 include/hw/timer/avr_timer16.h
>  create mode 100644 target/avr/Makefile.objs
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.c
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/gdbstub.c
>  create mode 100644 target/avr/helper.c
>  create mode 100644 target/avr/helper.h
>  create mode 100644 target/avr/insn.decode
>  create mode 100644 target/avr/machine.c
>  create mode 100644 target/avr/translate.c
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> --
> 2.17.2 (Apple Git-113)
>

