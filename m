Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74690C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FB22071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hShgaqz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FB22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNj1a-0004hH-SB
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizo-0003Fd-OW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizk-0006SS-0V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id s13so820667wmh.4
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LrHgZkISLM1ydfwp8MrK69lTuM/ET+raTjZhevDX13M=;
 b=hShgaqz3LFp9BsOOGdloO2H+X11n4qapO8p8rfmo+pJydruUL4bDq+hOkas2f5eiLw
 ppb83XNByw2oT59mGRNlonwJGaMBObsmzuloIeP+SgI4rjPrGGx+u7rp5D9w7NF+EjHK
 JTqRwb84PksRmVKdjzwxtfLxo7ig1VmcpNe7WtRHyQVex2C8HLS6RxWUbLVo+ui20wlP
 XjDN8jGG2S1L6uTcIAGYHhd0xQuJzcXHaUk04NlETQ9J+iveb7dJf1rlXmmett2wRacU
 F/W4QD6v7FoUiaLdr6EZok7/wBKkejELBJpxwKrOUbQmKkhiBIYfUuI5GUbwQa3VF6wo
 wpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LrHgZkISLM1ydfwp8MrK69lTuM/ET+raTjZhevDX13M=;
 b=CPoMKoRi7k1YLIEw3aDf44xHRzD4Ndg3kf3dirKd5SDynmAMuRNFKVwSoRqhA39LxC
 iGNd/IViFmnrpklae2ZJDgk9vbRaF+vck2c3sYbgA7SqJm7ZMVl9VXijHk/NTbeRV+Q3
 713vCVOjd9E4fWVQSVjR3VcdWIR7Btmq+CgNOvv1g9xI7OU7tkvW7YAAOSNGd3hl/+ua
 268WqiPh8sBaSw2y5k8q03mBRxBPZ5jAaugLiV6pcE7NyJ/OyHtqsiXnz+oJUrgyeBQd
 YVRJYjNvFh2DWgpXKsW6giH2yi9Gk1l1UiAyky3aatztRePB2GLUNzd6yuzftZeYKtpQ
 yAvA==
X-Gm-Message-State: AOAM5323ns+grmTbK57TbTyltJZ/sMh594vkmfYJhPt4jjyyuU2kWY31
 bZW9a9uz6S7vZ+MRZ8UpOXNtzqwlCM4F4w==
X-Google-Smtp-Source: ABdhPJyQ0Qg2Tiy8zOwIg3lEDUXUzYngrKsxFz7UJ0sI2Kdq8eDRHwXcffoinqXO49fff0O/NtnmWg==
X-Received: by 2002:a1c:2307:: with SMTP id j7mr3834443wmj.177.1601498791886; 
 Wed, 30 Sep 2020 13:46:31 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:31 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 00/14] *** ARC port for review ***
Date: Wed, 30 Sep 2020 21:45:50 +0100
Message-Id: <20200930204604.20663-1-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cupertino Miranda <cmiranda@synopsys.com>

Hello everyone,

It is with utmost pleasure that on behalf of Synopsys I initiate the
upstream process for our ARCv2 architecture QEMU port.

I am one of the main contributors to this port and member of the
Synopsys GNU toolchain team, together with Claudiu Zissulescu and 
Shahab Vahedi.

ARCv2 processors use RISC, and employ the 16-/32-bit instruction set
architecture (ISA).
ARC processors are configurable and extensible for a wide range of uses
in system on a chip (SoC) devices.
It is a common processor in deeply embedded systems, used in storage,
digital home, mobile, automotive, and Internet of Things (IoT) 
applications.

To facilitate reviewing, we split the files through several commits,
attempting to keep file size to reviewable chunks.

The port as presented implements the system softmmu hardware emulation,
capable to boot and run Linux kernel.
It has also been integrated as a patch in Zephyr project, where it is
being used.
To validate and guarantee correctness of the port through development, 
we have created TCG tests from the very beggining, covering the most 
fundamental CPU features.
For the remaining instructions we validate the port through compiler 
testsuites, like DejaGNU, comparing results with real hardware 
executions.

Would like also to thank our colleagues Vineet Gupta and Alexey Broadkin
for their contributions, which due to the collapse of the development
commits, got their contributions overcast by major ones.

Link for Synopsys ARC processor page:
 - https://www.synopsys.com/designware-ip/processor-solutions.html

ARC PRM for both HS and EM processors can be found in:
 - https://www.synopsys.com/dw/doc.php/ds/cc/programmers-reference-manual-ARC-EM.pdf
 - https://www.synopsys.com/dw/doc.php/ds/cc/programmers-reference-manual-ARC-HS.pdf.

Looking forward to your comments and suggestions.

Best regards,
Cupertino Miranda

*** BLURB HERE ***

Claudiu Zissulescu (5):
  arc: Decoder code
  arc: Opcode definitions table
  arc: Add IRQ and timer subsystem support
  arc: Add Synopsys ARC emulation boards
  tests/tcg: ARC: Add TCG instruction definition tests

Cupertino Miranda (5):
  arc: Add initial core cpu files
  arc: TCG and decoder glue code and helpers
  arc: TCG instruction definitions
  arc: Add BCR and AUX registers implementation
  arc: Add memory management unit (MMU) support

Shahab Vahedi (4):
  arc: TCG instruction generator and hand-definitions
  arc: Add memory protection unit (MPU) support
  arc: Add gdbstub and XML for debugging support
  arc: Add support for ARCv2

 configure                             |     5 +
 default-configs/arc-softmmu.mak       |     5 +
 disas.c                               |     2 +
 disas/arc.c                           |   460 +
 disas/meson.build                     |     1 +
 gdb-xml/arc-aux-minimal.xml           |    32 +
 gdb-xml/arc-aux-other.xml             |   235 +
 gdb-xml/arc-core-v2.xml               |    45 +
 hw/arc/Makefile.objs                  |    21 +
 hw/arc/arc_sim.c                      |   143 +
 hw/arc/arc_uart.c                     |   267 +
 hw/arc/board-hsdk.c                   |   107 +
 hw/arc/boot.c                         |    95 +
 hw/arc/boot.h                         |    21 +
 hw/arc/meson.build                    |    13 +
 hw/arc/nsim.c                         |    86 +
 hw/arc/pic_cpu.c                      |   111 +
 hw/arc/sample.c                       |    77 +
 hw/arc/sim-hs.c                       |   107 +
 hw/meson.build                        |     1 +
 include/disas/dis-asm.h               |    10 +-
 include/elf.h                         |     3 +
 include/exec/poison.h                 |     2 +
 include/hw/arc/arc_uart.h             |    43 +
 include/hw/arc/cpudevs.h              |    10 +
 include/sysemu/arch_init.h            |     1 +
 meson.build                           |     3 +-
 softmmu/arch_init.c                   |     2 +
 target/arc/Makefile.objs              |    34 +
 target/arc/arc-common.h               |    55 +
 target/arc/cache.c                    |   180 +
 target/arc/cache.h                    |    42 +
 target/arc/cpu-param.h                |    20 +
 target/arc/cpu-qom.h                  |    53 +
 target/arc/cpu.c                      |   468 +
 target/arc/cpu.h                      |   532 +
 target/arc/decoder.c                  |  1276 ++
 target/arc/decoder.h                  |   350 +
 target/arc/extra_mapping.def          |    40 +
 target/arc/flags.def                  |    85 +
 target/arc/gdbstub.c                  |   421 +
 target/arc/helper.c                   |   293 +
 target/arc/helper.h                   |    46 +
 target/arc/internals.h                |    37 +
 target/arc/irq.c                      |   658 +
 target/arc/irq.h                      |    37 +
 target/arc/meson.build                |    20 +
 target/arc/mmu.c                      |   775 +
 target/arc/mmu.h                      |   165 +
 target/arc/mpu.c                      |   653 +
 target/arc/mpu.h                      |   140 +
 target/arc/op_helper.c                |   749 +
 target/arc/opcodes.def                | 19976 ++++++++++++++++++++++++
 target/arc/operands.def               |   123 +
 target/arc/regs-detail.def            |   542 +
 target/arc/regs.c                     |   139 +
 target/arc/regs.def                   |   399 +
 target/arc/regs.h                     |   118 +
 target/arc/semfunc-helper.c           |   492 +
 target/arc/semfunc-helper.h           |   280 +
 target/arc/semfunc.c                  |  8474 ++++++++++
 target/arc/semfunc.h                  |    61 +
 target/arc/semfunc_mapping.def        |   329 +
 target/arc/timer.c                    |   456 +
 target/arc/timer.h                    |    32 +
 target/arc/translate.c                |  1344 ++
 target/arc/translate.h                |   202 +
 target/meson.build                    |     1 +
 tests/Makefile.include                |     1 +
 tests/tcg/Makefile.qemu               |    16 +-
 tests/tcg/Makefile.target             |     9 +-
 tests/tcg/arc/Makefile                |   112 +
 tests/tcg/arc/Makefile.softmmu-target |    36 +
 tests/tcg/arc/Makefile.target         |   101 +
 tests/tcg/arc/check_add.S             |    11 +
 tests/tcg/arc/check_addx.S            |    71 +
 tests/tcg/arc/check_andx.S            |    36 +
 tests/tcg/arc/check_aslx.S            |    57 +
 tests/tcg/arc/check_asrx.S            |    86 +
 tests/tcg/arc/check_basic1.S          |    30 +
 tests/tcg/arc/check_basic2.S          |    26 +
 tests/tcg/arc/check_beq.S             |    14 +
 tests/tcg/arc/check_beqx.S            |    26 +
 tests/tcg/arc/check_big_tb.S          |   173 +
 tests/tcg/arc/check_bnex.S            |    26 +
 tests/tcg/arc/check_breqx.S           |    26 +
 tests/tcg/arc/check_brgex.S           |    26 +
 tests/tcg/arc/check_brhsx.S           |    27 +
 tests/tcg/arc/check_brlox.S           |    26 +
 tests/tcg/arc/check_brltx.S           |    26 +
 tests/tcg/arc/check_brnex.S           |    26 +
 tests/tcg/arc/check_bta.S             |   294 +
 tests/tcg/arc/check_carry.S           |    15 +
 tests/tcg/arc/check_enter_leave.S     |   715 +
 tests/tcg/arc/check_excp.S            |    17 +
 tests/tcg/arc/check_excp_1.c          |    15 +
 tests/tcg/arc/check_excp_jumpdl_mmu.S |    44 +
 tests/tcg/arc/check_excp_mmu.S        |    69 +
 tests/tcg/arc/check_flags.S           |    23 +
 tests/tcg/arc/check_ldaw_mmu.S        |    71 +
 tests/tcg/arc/check_ldstx.S           |    37 +
 tests/tcg/arc/check_lp.S              |    12 +
 tests/tcg/arc/check_lp02.S            |    72 +
 tests/tcg/arc/check_lp03.S            |    49 +
 tests/tcg/arc/check_lp04.S            |    48 +
 tests/tcg/arc/check_lp05.S            |    23 +
 tests/tcg/arc/check_lp06.S            |   163 +
 tests/tcg/arc/check_lsrx.S            |    33 +
 tests/tcg/arc/check_mac.S             |   228 +
 tests/tcg/arc/check_manip_10_mmu.S    |   173 +
 tests/tcg/arc/check_manip_4_mmu.S     |   158 +
 tests/tcg/arc/check_manip_5_mmu.S     |   166 +
 tests/tcg/arc/check_manip_mmu.S       |   565 +
 tests/tcg/arc/check_mmu.S             |    59 +
 tests/tcg/arc/check_mpu.S             |   703 +
 tests/tcg/arc/check_mpyd.S            |   543 +
 tests/tcg/arc/check_mpyw.S            |    41 +
 tests/tcg/arc/check_norm.S            |    40 +
 tests/tcg/arc/check_orx.S             |    34 +
 tests/tcg/arc/check_prefetch.S        |    37 +
 tests/tcg/arc/check_rolx.S            |    47 +
 tests/tcg/arc/check_rorx.S            |    64 +
 tests/tcg/arc/check_rtc.S             |    29 +
 tests/tcg/arc/check_rtie_user.S       |    30 +
 tests/tcg/arc/check_stld.S            |    10 +
 tests/tcg/arc/check_subf.S            |    67 +
 tests/tcg/arc/check_subx.S            |    43 +
 tests/tcg/arc/check_swi.S             |   115 +
 tests/tcg/arc/check_swirq.S           |    27 +
 tests/tcg/arc/check_swirq1.S          |    31 +
 tests/tcg/arc/check_swirq3.S          |    49 +
 tests/tcg/arc/check_t01.S             |    12 +
 tests/tcg/arc/check_t02.S             |     9 +
 tests/tcg/arc/check_timer0.S          |    36 +
 tests/tcg/arc/check_timer0_loop.S     |    34 +
 tests/tcg/arc/check_timer0_loop3.S    |    46 +
 tests/tcg/arc/check_timer0_retrig.S   |    29 +
 tests/tcg/arc/check_timer0_sleep.S    |    33 +
 tests/tcg/arc/check_timerX_freq.S     |    87 +
 tests/tcg/arc/check_vadd.S            |   510 +
 tests/tcg/arc/check_vsub.S            |   510 +
 tests/tcg/arc/check_xorx.S            |    32 +
 tests/tcg/arc/ivt.S                   |    38 +
 tests/tcg/arc/macros.inc              |   261 +
 tests/tcg/arc/memory.x                |    12 +
 tests/tcg/arc/mmu.inc                 |   132 +
 tests/tcg/arc/mpu.inc                 |   269 +
 tests/tcg/arc/tarc.ld                 |    15 +
 tests/tcg/arc/tarc_mmu.ld             |    15 +
 tests/tcg/arc/test_macros.h           |   257 +
 tests/tcg/configure.sh                |     3 +-
 151 files changed, 50283 insertions(+), 9 deletions(-)
 create mode 100644 default-configs/arc-softmmu.mak
 create mode 100644 disas/arc.c
 create mode 100644 gdb-xml/arc-aux-minimal.xml
 create mode 100644 gdb-xml/arc-aux-other.xml
 create mode 100644 gdb-xml/arc-core-v2.xml
 create mode 100644 hw/arc/Makefile.objs
 create mode 100644 hw/arc/arc_sim.c
 create mode 100644 hw/arc/arc_uart.c
 create mode 100644 hw/arc/board-hsdk.c
 create mode 100644 hw/arc/boot.c
 create mode 100644 hw/arc/boot.h
 create mode 100644 hw/arc/meson.build
 create mode 100644 hw/arc/nsim.c
 create mode 100644 hw/arc/pic_cpu.c
 create mode 100644 hw/arc/sample.c
 create mode 100644 hw/arc/sim-hs.c
 create mode 100644 include/hw/arc/arc_uart.h
 create mode 100644 include/hw/arc/cpudevs.h
 create mode 100644 target/arc/Makefile.objs
 create mode 100644 target/arc/arc-common.h
 create mode 100644 target/arc/cache.c
 create mode 100644 target/arc/cache.h
 create mode 100644 target/arc/cpu-param.h
 create mode 100644 target/arc/cpu-qom.h
 create mode 100644 target/arc/cpu.c
 create mode 100644 target/arc/cpu.h
 create mode 100644 target/arc/decoder.c
 create mode 100644 target/arc/decoder.h
 create mode 100644 target/arc/extra_mapping.def
 create mode 100644 target/arc/flags.def
 create mode 100644 target/arc/gdbstub.c
 create mode 100644 target/arc/helper.c
 create mode 100644 target/arc/helper.h
 create mode 100644 target/arc/internals.h
 create mode 100644 target/arc/irq.c
 create mode 100644 target/arc/irq.h
 create mode 100644 target/arc/meson.build
 create mode 100644 target/arc/mmu.c
 create mode 100644 target/arc/mmu.h
 create mode 100644 target/arc/mpu.c
 create mode 100644 target/arc/mpu.h
 create mode 100644 target/arc/op_helper.c
 create mode 100644 target/arc/opcodes.def
 create mode 100644 target/arc/operands.def
 create mode 100644 target/arc/regs-detail.def
 create mode 100644 target/arc/regs.c
 create mode 100644 target/arc/regs.def
 create mode 100644 target/arc/regs.h
 create mode 100644 target/arc/semfunc-helper.c
 create mode 100644 target/arc/semfunc-helper.h
 create mode 100644 target/arc/semfunc.c
 create mode 100644 target/arc/semfunc.h
 create mode 100644 target/arc/semfunc_mapping.def
 create mode 100644 target/arc/timer.c
 create mode 100644 target/arc/timer.h
 create mode 100644 target/arc/translate.c
 create mode 100644 target/arc/translate.h
 create mode 100644 tests/tcg/arc/Makefile
 create mode 100644 tests/tcg/arc/Makefile.softmmu-target
 create mode 100644 tests/tcg/arc/Makefile.target
 create mode 100644 tests/tcg/arc/check_add.S
 create mode 100644 tests/tcg/arc/check_addx.S
 create mode 100644 tests/tcg/arc/check_andx.S
 create mode 100644 tests/tcg/arc/check_aslx.S
 create mode 100644 tests/tcg/arc/check_asrx.S
 create mode 100644 tests/tcg/arc/check_basic1.S
 create mode 100644 tests/tcg/arc/check_basic2.S
 create mode 100644 tests/tcg/arc/check_beq.S
 create mode 100644 tests/tcg/arc/check_beqx.S
 create mode 100644 tests/tcg/arc/check_big_tb.S
 create mode 100644 tests/tcg/arc/check_bnex.S
 create mode 100644 tests/tcg/arc/check_breqx.S
 create mode 100644 tests/tcg/arc/check_brgex.S
 create mode 100644 tests/tcg/arc/check_brhsx.S
 create mode 100644 tests/tcg/arc/check_brlox.S
 create mode 100644 tests/tcg/arc/check_brltx.S
 create mode 100644 tests/tcg/arc/check_brnex.S
 create mode 100644 tests/tcg/arc/check_bta.S
 create mode 100644 tests/tcg/arc/check_carry.S
 create mode 100644 tests/tcg/arc/check_enter_leave.S
 create mode 100644 tests/tcg/arc/check_excp.S
 create mode 100644 tests/tcg/arc/check_excp_1.c
 create mode 100644 tests/tcg/arc/check_excp_jumpdl_mmu.S
 create mode 100644 tests/tcg/arc/check_excp_mmu.S
 create mode 100644 tests/tcg/arc/check_flags.S
 create mode 100644 tests/tcg/arc/check_ldaw_mmu.S
 create mode 100644 tests/tcg/arc/check_ldstx.S
 create mode 100644 tests/tcg/arc/check_lp.S
 create mode 100644 tests/tcg/arc/check_lp02.S
 create mode 100644 tests/tcg/arc/check_lp03.S
 create mode 100644 tests/tcg/arc/check_lp04.S
 create mode 100644 tests/tcg/arc/check_lp05.S
 create mode 100644 tests/tcg/arc/check_lp06.S
 create mode 100644 tests/tcg/arc/check_lsrx.S
 create mode 100644 tests/tcg/arc/check_mac.S
 create mode 100644 tests/tcg/arc/check_manip_10_mmu.S
 create mode 100644 tests/tcg/arc/check_manip_4_mmu.S
 create mode 100644 tests/tcg/arc/check_manip_5_mmu.S
 create mode 100644 tests/tcg/arc/check_manip_mmu.S
 create mode 100644 tests/tcg/arc/check_mmu.S
 create mode 100644 tests/tcg/arc/check_mpu.S
 create mode 100644 tests/tcg/arc/check_mpyd.S
 create mode 100644 tests/tcg/arc/check_mpyw.S
 create mode 100644 tests/tcg/arc/check_norm.S
 create mode 100644 tests/tcg/arc/check_orx.S
 create mode 100644 tests/tcg/arc/check_prefetch.S
 create mode 100644 tests/tcg/arc/check_rolx.S
 create mode 100644 tests/tcg/arc/check_rorx.S
 create mode 100644 tests/tcg/arc/check_rtc.S
 create mode 100644 tests/tcg/arc/check_rtie_user.S
 create mode 100644 tests/tcg/arc/check_stld.S
 create mode 100644 tests/tcg/arc/check_subf.S
 create mode 100644 tests/tcg/arc/check_subx.S
 create mode 100644 tests/tcg/arc/check_swi.S
 create mode 100644 tests/tcg/arc/check_swirq.S
 create mode 100644 tests/tcg/arc/check_swirq1.S
 create mode 100644 tests/tcg/arc/check_swirq3.S
 create mode 100644 tests/tcg/arc/check_t01.S
 create mode 100644 tests/tcg/arc/check_t02.S
 create mode 100644 tests/tcg/arc/check_timer0.S
 create mode 100644 tests/tcg/arc/check_timer0_loop.S
 create mode 100644 tests/tcg/arc/check_timer0_loop3.S
 create mode 100644 tests/tcg/arc/check_timer0_retrig.S
 create mode 100644 tests/tcg/arc/check_timer0_sleep.S
 create mode 100644 tests/tcg/arc/check_timerX_freq.S
 create mode 100644 tests/tcg/arc/check_vadd.S
 create mode 100644 tests/tcg/arc/check_vsub.S
 create mode 100644 tests/tcg/arc/check_xorx.S
 create mode 100644 tests/tcg/arc/ivt.S
 create mode 100644 tests/tcg/arc/macros.inc
 create mode 100644 tests/tcg/arc/memory.x
 create mode 100644 tests/tcg/arc/mmu.inc
 create mode 100644 tests/tcg/arc/mpu.inc
 create mode 100644 tests/tcg/arc/tarc.ld
 create mode 100644 tests/tcg/arc/tarc_mmu.ld
 create mode 100644 tests/tcg/arc/test_macros.h

-- 
2.20.1


