Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8695C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 21:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795E42071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 21:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML9SS3f8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E42071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgVt-0008Mj-2j
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 16:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUF-0006yL-Ce
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgUC-0001wg-QU
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:52:35 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgUC-0001oN-FY
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:52:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id t14so12824665wmi.5
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QeWkZVfYBKhE7RxINVXpD4sQuIsJJq55o2thtBud0TU=;
 b=ML9SS3f8612nic2Tvnip6i2VuDAMwnv9BKCQJjTD6w2WDZJpNl13tbu1rmOXFKnUI9
 kIiWW/F9MuhvjrZz0BcFzIhLSvZBemzpVZ5FJVhtbJbtL74M+8DdZFHl044OOvtf5INn
 qY6AdyDI0gWNC6/vfRAChb3aPQ3NLp9u6zdXvY5Q3o+kyE6iO01x9Sb/+EnQ9Jn6lawG
 YhA+v64o0KTVQpXQjaSKzIxLO4GnUHnY1o8TAP+jCypUZPqOAS3Gf/x7YRniS2pvSTAT
 +JyuaCRIEDv/Cxpfsyt94z8hln0eRup/Au3Gynguykvytm9CGIMweVb+yWD8chxmff/5
 ouaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QeWkZVfYBKhE7RxINVXpD4sQuIsJJq55o2thtBud0TU=;
 b=Q4Gs4d5dWmtusuPSmoAPYlBfo0pdbGzBKwAJuhd4YSGn1uWgGhsSOkUbhYpgC53O9d
 Ud17QmEKaSRYmPZeNNamnLU9oUmfw0LXmjXTaPVQBCH4QPa4HCIKAy1ysVqKgXL8y/fb
 HnsZNfNMVRLms3QdJ96zoZO5ns9BkSaUz2JzWjjejICmm29dzK6zd6WmqikL2KX/EsXE
 nbgiZV7GuQvupevv9qkQNowDuwryRqUygtslCNlprZi1Xa9fjUQbD/3K4EwKd9vNdyxD
 +/7FuQhB8nAODLAC6mscyHG7eyv4Wz/Nz+idPlppLF9rWbUu7b+0qw3Z6Mxphuxvs03U
 iGFg==
X-Gm-Message-State: APjAAAVv4rTiQNMMYOg4qZNJH8w6FchctrLgwMu148x7T/mgHAd840Q7
 kwnhyj6BbdDjAIewCk9WVB4CYwcmJewt7g==
X-Google-Smtp-Source: APXvYqztnGIaOh2ZD+z5HenGOCXSKbXEQ+AjmbFsXJXB4rVofZKkLubp11pzJKrJTfJISTSQQF/+Gw==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr29421801wmb.76.1577656349897; 
 Sun, 29 Dec 2019 13:52:29 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.52.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:52:29 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 00/21] QEMU AVR 8 bit cores
Date: Sun, 29 Dec 2019 23:51:37 +0200
Message-Id: <20191229215158.5788-1-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches adds 8bit AVR cores to QEMU.
All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully tested yet.
However I was able to execute simple code with functions. e.g fibonacci calculation.
This series of patches include a non real, sample board.
No fuses support yet. PC is set to 0 at reset.

Following are examples of possible usages, assuming program.elf is compiled for AVR cpu
1.  Continious non interrupted execution
    run `qemu-system-avr -kernel program.elf` 
2.  Continious non interrupted execution with serial output into telnet window
    run `qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -nographic `
    run `telent localhost 5678`
3.  Continious non interrupted execution with serial output into stdout
    run `qemu-system-avr -kernel program.elf -serial stdio`
4.  Debugging wit GDB debugger
    run `qemu-system-avr -kernel program.elf -s -S`
    run `avr-gdb program.elf` and then within GDB shell `target remote :1234`
5.  Print out executed instructions
    run `qemu-system-avr -kernel program.elf -d in_asm` 


the patches include the following
1. just a basic 8bit AVR CPU, without instruction decoding or translation
2. CPU features which allow define the following 8bit AVR cores
     avr1
     avr2 avr25
     avr3 avr31 avr35
     avr4
     avr5 avr51
     avr6
     xmega2 xmega4 xmega5 xmega6 xmega7
3. a definition of sample machine with SRAM, FLASH and CPU which allows to execute simple code
4. encoding for all AVR instructions
5. interrupt handling
6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
7. a decoder which given an opcode decides what istruction it is
8. translation of AVR instruction into TCG
9. all features together

changes since v3
1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x000000ff) for faster address manipulaton
2. ffs changed to ctz32
3. duplicate code removed at avr_cpu_do_interrupt
4. using andc instead of not + and
5. fixing V flag calculation in varios instructions
6. freeing local variables in PUSH
7. tcg_const_local_i32 -> tcg_const_i32
8. using sextract32 instead of my implementation
9. fixing BLD instruction
10.xor(r) instead of 0xff - r at COM
11.fixing MULS/MULSU not to modify inputs' content
12.using SUB for NEG
13.fixing tcg_gen_qemu_ld/st call in XCH

changes since v4
1. target is now defined as big endian in order to optimize push_ret/pop_ret
2. all style warnings are fixed
3. adding cpu_set/get_sreg functions
4. simplifying gen_goto_tb as there is no real paging
5. env->pc -> env->pc_w
6. making flag dump more compact
7. more spacing
8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
9. removing avr_set_feature
10. SPL/SPH set bug fix
11. switching stb_phys to cpu_stb_data
12. cleaning up avr_decode
13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
14. saving CPU features (savevm)

changes since v5
1. BLD bug fix
2. decoder generator is added

chages since v6
1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_cpu_gdb_write_register
2. configure the target as little endian because otherwise GDB does not work
3. fixing and testing gen_push_ret/gen_pop_ret

changes since v7
1. folding back v6
2. logging at helper_outb and helper_inb are done for non supported yet registers only
3. MAINTAINERS updated

changes since v8
1. removing hw/avr from hw/Makefile.obj as it should not be built for all
2. making linux compilable
3. testing on
    a. Mac, Apple LLVM version 7.0.0
    b. Ubuntu 12.04, gcc 4.9.2
    c. Fedora 23, gcc 5.3.1
4. folding back some patches
5. translation bug fixes for ORI, CPI, XOR instructions
6. propper handling of cpu register writes though memory

changes since v9
1. removing forward declarations of static functions
2. disabling debug prints
3. switching to case range instead of if else if ...
4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to any device
5. commenst about sample board and sample IO device added
6. sample board description is more descriptive now
7. memory_region_allocate_system_memory is used to create RAM
8. now there are helper_fullrd & helper_fullwr when LD/ST try to access registers

changes since v10
1. movig back fullwr & fullrd into the commit where outb and inb were introduced
2. changing tlb_fill function signature
3. adding empty line between functions
4. adding newline on the last line of the file
5. using tb->flags to generae full access ST/LD instructions
6. fixing SBRC bug
7. folding back 10th commit
8. whenever a new file is introduced it's added to Makefile.objs

changes since v11
1. updating to v2.7.0-rc
2. removing assignment to env->fullacc from gen_intermediate_code

changes since v12
1. fixing spacing
2. fixing get/put_segment functions
3. removing target-avr/machine.h file
4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
5. comment spelling
6. removing hw/avr/sample_io.c
7. char const* -> const char*
8. proper ram allocation
9. fixing breakpoint functionality.
10.env1 -> env
11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register functions
12.any cpu is removed
12.feature bits are not saved into vm state

changes since v13
1. rebasing to v2.7.0-rc1

changes since v14
1. I made self review with git gui tool. (I did not know such a thing exists)
2. removing all double/tripple spaces
3. removing comment reference to SampleIO
4. folding back some changes, so there is not deleted lines in my code
5. moving avr configuration, within configure file, before chris

changes since v15
1. removing IO registers cache from CPU
2. implementing CBI/SBI as read(helper_inb), modify, write(helper_outb)
3. implementing CBIC/SBIC as read(helper_inb), check, branch
4. adding missing tcg_temp_free_i32 for tcg_const_i32

changes since v16
1. removing EXT IO registers knoledge from CPU. These registers are accessible
   by LD/ST only. CPU has no interest in them

changes since v17 (by Richard Henderson)
This is Michael's v17, with some adjustments of my own:

1. Fix the whitespace errors reported by "git am",
2. Replace the utf-8 characters with normal ascii,
3. Ditch the separate compilation of translate.c.

I retained the two separate files that could be regenerated
from the included cpugen program, but merged in translate-insn.c.
Not that it matters, but the code generated is about 3k smaller.

changes since v18
1.  moving target-avr into target/avr
2.  do not call cpu_exec_initfn function from avr_cpu_initfn
3.  call cpu_exec_realizefn avr_cpu_realizefn
4.  do not fail sample machine creation if no rom is suplied
5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
6.  fix a register getters/setters in machine.c
7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18

changes since v19
1.  use decodetree.py tool to decode instructions
2.  adding USART
3.  adding 16 bit timer peripherals
4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
5.  renaming tlb_fill to avr_cpu_tlb_fill

changes since v20
1.  use one CPU naming convention
2.  merging insn16.decode & insn32.decode files
3.  modifying skip next instruction mechanizm
4.  translate BREAK as NOP for now

changes since v21
1.  Reorganize bstate.
    This will make transition to <exec/translator.h> easier, and fixes a couple of bugs wrt single stepping
    by richard.henderson@linaro.org
2.  Drop cpc and fix page cross condition.
    by richard.henderson@linaro.org
3.  Refactor checking supported/unsupported instructions
4.  Add gdb-xml/avr-cpu.xml

changes since v22
1.  Rebase
2.  Split long comment

changes since v23
1.  remove avr_cpu_list_compare function
2.  modify avr_cpu_class_by_name function
3.  modify avr_cpu_list_entry function
4.  modify avr_cpu_list function

changes since v24
1.  remove AVR_CPU_TYPE_NAME macro

changes since v25
1.  fix patches. every file belong to one patch only
2.  change copyright year from 2016 to 2019
3.  create mask device to emulate prr0/prr1

changes since v26
1.  add avocado acceptence test
2.  add boot serial test

changes since v27
1.  list atmel2560 devices as unimplemented
2.  fix sram base/size

changes since v28
1.  rebase
2.  fix includes & build

changes since v29
1.  fixing ownership
2.  using 'since' instread of 'added in'

changes since v30
1.  rebase

changes since v31
1.  splitting 'Add instruction translation' commit
2.  fixing typo in qapi/machine.json sicne -> since
3.  removing unintended changes in configure file
4.  adding Richard Henderson as a co developer to 'Add instruction translation - CPU main translation funcions' commit

changes since v32
1.  modify cpu_get_sreg to treat sreg C as other flags, except sreg Z

changes since v33
1.  ensure flag C is always calculated as one bit
2.  calculate flag Z as one bit, without using inverse logic

changes since v34
1.  rebase

changes since v35
1.  rebase
2.  use NANOSECONDS_PER_SECOND instead of 1000000000 in avr_timer16.c
3.  split "target/avr: Register AVR support with the rest of QEMU" into three patches
    1.  "target/avr: Register AVR support with the rest of QEMU"
    2.  "target/avr: Update build system"
    3.  "target/avr: Update MAINTAINERS file"
4.  split "target/avr: Add tests" patch into two patches
    1.  "target/avr: Add Avocado test"
    2.  "target/avr: Add boot serial test"
5.  Add instruction disassembly function
6.  change "since 4.2" to "since 5.0"

changes since v36
1.  rebase
2.  rename
    1.  NO_CPU_REGISTERS    -> NUMBER_OF_CPU_REGISTERS
    2.  NO_IO_REGISTERS     -> NUMBER_OF_IO_REGISTERS
    3.  to_A                -> to_regs_16_31_by_one
    4.  to_B                -> to_regs_16_23_by_one
    5.  to_C                -> to_regs_24_30_by_two
    6.  to_D                -> to_regs_00_30_by_two
3.  add missing licences
4.  add usage example (see above)
5.  ass Sarah Harris <S.E.Harris@kent.ac.uk> as a reviewer to MAINTAINERS
7.  use git commit sha1 instead of `master`` in avocado test

changes since v37
1.  rebase
2.  moving all data transfer instructions into a separate commit
3.  splitting tests into 
    1.  avocado test
    2.  boot serial test
    3.  machine none test
4.  split periperals commit into 
    1.  timer
    2.  usart
    3.  mask
5.  add function `avr_flags_to_cpu_type` that translates ELF flags into core name
6.  add avrtiny, xmega3 cores
7.  remove unnecessary includes from target/avr/helper.c file
8.  remove empty lines from target/avr/translate.c file
9.  set number of interrupt lines to 64
10. determine cpu type by reading ELF flags
11. update license of all new files to be LGPL
12. udpate QEMU documentation

changes since v38
1.  rebase
2.  add examples of AVR emulator invokation into the QEMU doc
3.  reorder instructions to match AVR documentation
4.  fix elf loader function bug introduced by prev version

changes since v39
1.  rename target/avr to hw/avr for hw related commits
2.  spread instruction decoding commit
3.  add frequency parameter to AVR timer
4.  fix offset of some unimplemented registers

Michael Rolnik (21):
  target/avr: Add outward facing interfaces and core CPU logic
  target/avr: Add instruction helpers
  target/avr: Add instruction translation - Registers definition
  target/avr: Add instruction translation - Arithmetic and Logic
    Instructions
  target/avr: Add instruction translation - Branch Instructions
  target/avr: Add instruction translation - Data Transfer Instructions
  target/avr: Add instruction translation - Bit and Bit-test
    Instructions
  target/avr: Add instruction translation - MCU Control Instructions
  target/avr: Add instruction translation - CPU main translation
    function
  target/avr: Add instruction disassembly function
  hw/avr: Add limited support for USART peripheral
  hw/avr: Add limited support for 16 bit timer peripheral
  hw/avr: Add dummy mask device
  hw/avr: Add example board configuration
  target/avr: Add section about AVR into QEMU documentation
  target/avr: Register AVR support with the rest of QEMU
  target/avr: Add machine none test
  target/avr: Update build system
  target/avr: Add boot serial test
  target/avr: Add Avocado test
  target/avr: Update MAINTAINERS file

 qemu-doc.texi                    |   51 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 qapi/machine.json                |    3 +-
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    2 +
 include/hw/char/avr_usart.h      |   93 +
 include/hw/elf_ops.h             |    6 +-
 include/hw/loader.h              |    6 +-
 include/hw/misc/avr_mask.h       |   47 +
 include/hw/timer/avr_timer16.h   |   94 +
 include/sysemu/arch_init.h       |    1 +
 target/avr/cpu-param.h           |   37 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.h                 |  259 +++
 target/avr/helper.h              |   29 +
 arch_init.c                      |    2 +
 hw/avr/sample.c                  |  295 +++
 hw/char/avr_usart.c              |  320 ++++
 hw/core/loader.c                 |   15 +-
 hw/misc/avr_mask.c               |  112 ++
 hw/riscv/boot.c                  |    2 +-
 hw/timer/avr_timer16.c           |  602 ++++++
 target/avr/cpu.c                 |  826 ++++++++
 target/avr/disas.c               |  245 +++
 target/avr/gdbstub.c             |   84 +
 target/avr/helper.c              |  347 ++++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++
 tests/boot-serial-test.c         |   10 +
 tests/machine-none-test.c        |    1 +
 MAINTAINERS                      |   21 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/Kconfig                       |    1 +
 hw/avr/Kconfig                   |    6 +
 hw/avr/Makefile.objs             |    1 +
 hw/char/Kconfig                  |    3 +
 hw/char/Makefile.objs            |    1 +
 hw/misc/Kconfig                  |    3 +
 hw/misc/Makefile.objs            |    2 +
 hw/timer/Kconfig                 |    3 +
 hw/timer/Makefile.objs           |    2 +
 target/avr/Makefile.objs         |   34 +
 target/avr/insn.decode           |  183 ++
 tests/Makefile.include           |    2 +
 tests/acceptance/machine_avr6.py |   58 +
 46 files changed, 7049 insertions(+), 12 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 include/hw/misc/avr_mask.h
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/helper.h
 create mode 100644 hw/avr/sample.c
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 hw/misc/avr_mask.c
 create mode 100644 hw/timer/avr_timer16.c
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/disas.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/insn.decode
 create mode 100644 tests/acceptance/machine_avr6.py

-- 
2.17.2 (Apple Git-113)


