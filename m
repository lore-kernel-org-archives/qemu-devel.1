Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442612072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndce9HV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442612072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmpR-0002xQ-9S
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnJ-0001Pt-V6
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:02:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:32869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnH-0003ea-Oa
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:02:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id b8so6629827wrn.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PtIQnmYqmP/KaEsVLSNpFu0nRzeAC0WPtzPT3DpTUi0=;
 b=Ndce9HV8xQX92ey3QeHlk5wWsnS/aCkKt79IqnxY0XDqbK7FdhRgkeTD+8BV75qn8l
 km37h3PmmVjcpI4ZObT8bNeg98NK60xVOIyvwhyjV3P/prNnKsLT3EvtioDWJLaKNlFg
 Z3mqg0mhF0wZRn1aasvz5kNiF74epWBEGvcbLKtq2/Se/0EWv1s0AZuxvhJiEwu7+K0q
 LZD7g/4WXIxezHTvhS8M8xorLbv+cSWNuGJekIgIhkSf24evqcFujIvB2vMuRNx7P42N
 q/b9d3ncOmST38Gipc6bkY835UlQ2X5eSc2PuACG45t9gxCrQqTeJxvbeq6TbHg81+A0
 /kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PtIQnmYqmP/KaEsVLSNpFu0nRzeAC0WPtzPT3DpTUi0=;
 b=NcL6m892bg7V4kyoxKJHwvd4FL5ogSpb7ljwSVM/r0I5UqGHfnBpiJp67YVKg3tIaz
 pBa5RVeE6/Hf6yFhAz/qDVkrI0s1Hy+LOEPl9Bf1iWvISRldwCb4sP1J43iE13U3UhJ4
 emR1bxWU58zFEY5aEsT+5buw+0klF+/4SFJorUAUHJuuHx+9Kvdhceq9mtXOHeKe3Jay
 HaXWQz01yLNEmsiXJSfBrZ4yneTLwMNLPLpKXRNUD0YUza2hc5DQ6pbJiEB4/9cQ6MRd
 6VOL/OkymgHHgdkbdiOtWohEKEmtLw56GLnJCmRNvijyYrZjjLR40lEU5vx1wmRwE5LS
 5L1g==
X-Gm-Message-State: AOAM530sfYhaVrAyP9PNHgX65wwk6stPpuFEA2EbyYEdlNwEBJonkbkS
 WrF5700acrqq5LKRtnI9W2qKPESFU9c=
X-Google-Smtp-Source: ABdhPJxRwkufBHKQppy6b4pcm/B9fpz8ITrpGlMHg3ld86TEYCiWQeoFmjUq037NSKH5QnRAuYpgWA==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr9750267wrw.138.1602943365689; 
 Sat, 17 Oct 2020 07:02:45 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id u6sm7443951wmj.40.2020.10.17.07.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:02:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/44] mips-next patches for 2020-10-17
Date: Sat, 17 Oct 2020 16:01:59 +0200
Message-Id: <20201017140243.1078718-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7daf8f8d011cdd5d3e86930ed2bde969425c790c=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng=3D=0D
 (2020-10-16 17:39:01 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/mips-next-20201017=0D
=0D
for you to fetch changes up to 68fa519a6cb455005317bd61f95214b58b2f1e69:=0D
=0D
  target/mips: Increase number of TLB entries on the 34Kf core (16 -> 64) (=
20=3D=0D
20-10-17 13:59:40 +0200)=0D
=0D
----------------------------------------------------------------=0D
MIPS patches queue=0D
=0D
. Fix some comment spelling errors=0D
. Demacro some TCG helpers=0D
. Add loongson-ext lswc2/lsdc2 group of instructions=0D
. Log unimplemented cache opcode=0D
. Increase number of TLB entries on the 34Kf core=0D
. Allow the CPU to use dynamic frequencies=0D
. Calculate the CP0 timer period using the CPU frequency=0D
. Set CPU frequency for each machine=0D
. Fix Malta FPGA I/O region size=0D
. Allow running qtests when ROM is missing=0D
. Add record/replay acceptance tests=0D
. Update MIPS CPU documentation=0D
. MAINTAINERS updates=0D
=0D
CI jobs results:=0D
  https://gitlab.com/philmd/qemu/-/pipelines/203931842=0D
  https://travis-ci.org/github/philmd/qemu/builds/736491461=0D
  https://cirrus-ci.com/build/6272264062631936=0D
  https://app.shippable.com/github/philmd/qemu/runs/886/summary/console=0D
----------------------------------------------------------------=0D
=0D
Aleksandar Markovic (4):=0D
  target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>=0D
  target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>=0D
  target/mips: Demacro helpers for <MAX|MAXA|MIN|MINA>.<D|S>=0D
  MAINTAINERS: Remove myself=0D
=0D
Eduardo Habkost (1):=0D
  hw/mips: Rename TYPE_MIPS_BOSTON to TYPE_BOSTON=0D
=0D
Huacai Chen (1):=0D
  docs/system: Update MIPS CPU documentation=0D
=0D
Jiaxun Yang (3):=0D
  target/mips: Add loongson-ext lswc2 group of instructions (Part 1)=0D
  target/mips: Add loongson-ext lswc2 group of instructions (Part 2)=0D
  target/mips: Add loongson-ext lsdc2 group of instructions=0D
=0D
Luc Michel (1):=0D
  hw/core/clock: Add the clock_new helper function=0D
=0D
Pavel Dovgalyuk (2):=0D
  hw/mips: Remove exit(1) in case of missing ROM=0D
  tests/acceptance: Add MIPS record/replay tests=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (31):=0D
  util/cutils: Introduce freq_to_str() to display Hertz units=0D
  hw/qdev-clock: Display error hint when clock is missing from device=0D
  target/mips/op_helper: Convert multiple if() to switch case=0D
  target/mips/op_helper: Document Invalidate/Writeback opcodes as no-op=0D
  target/mips/op_helper: Log unimplemented cache opcode=0D
  target/mips: Move cpu_mips_get_random() with CP0 helpers=0D
  target/mips/cp0_timer: Explicit unit in variable name=0D
  target/mips/cp0_timer: Document TIMER_PERIOD origin=0D
  target/mips: Move cp0_count_ns to CPUMIPSState=0D
  target/mips/cpu: Calculate the CP0 timer period using the CPU=0D
    frequency=0D
  target/mips/cpu: Make cp0_count_rate a property=0D
  target/mips/cpu: Allow the CPU to use dynamic frequencies=0D
  target/mips/cpu: Introduce mips_cpu_create_with_clock() helper=0D
  hw/mips/r4k: Explicit CPU frequency is 200 MHz=0D
  hw/mips/fuloong2e: Set CPU frequency to 533 MHz=0D
  hw/mips/mipssim: Correct CPU frequency=0D
  hw/mips/jazz: Correct CPU frequencies=0D
  hw/mips/cps: Expose input clock and connect it to CPU cores=0D
  hw/mips/boston: Set CPU frequency to 1 GHz=0D
  hw/mips/malta: Set CPU frequency to 320 MHz=0D
  hw/mips/cps: Do not allow use without input clock=0D
  target/mips/cpu: Display warning when CPU is used without input clock=0D
  hw/mips/malta: Fix FPGA I/O region size=0D
  hw/mips/malta: Move gt64120 related code together=0D
  hw/mips/malta: Use clearer qdev style=0D
  hw/mips: Simplify loading 64-bit ELF kernels=0D
  hw/mips: Simplify code using ROUND_UP(INITRD_PAGE_SIZE)=0D
  MAINTAINERS: Put myself forward for MIPS target=0D
  MAINTAINERS: Downgrade MIPS Boston to 'Odd Fixes', fix Paul Burton=0D
    mail=0D
  MAINTAINERS: Remove duplicated Malta test entries=0D
  target/mips: Increase number of TLB entries on the 34Kf core (16 ->=0D
    64)=0D
=0D
zhaolichang (1):=0D
  target/mips: Fix some comment spelling errors=0D
=0D
 docs/system/cpu-models-mips.rst.inc |  10 +-=0D
 include/hw/clock.h                  |  13 +=0D
 include/hw/mips/cps.h               |   2 +=0D
 include/hw/mips/mips.h              |   4 +-=0D
 include/qemu/cutils.h               |  12 +=0D
 target/mips/cpu.h                   |  26 ++=0D
 target/mips/internal.h              |   4 +-=0D
 hw/core/clock.c                     |  15 +=0D
 hw/core/qdev-clock.c                |  11 +=0D
 hw/mips/boston.c                    |  21 +-=0D
 hw/mips/cps.c                       |   9 +=0D
 hw/mips/fuloong2e.c                 |  18 +-=0D
 hw/mips/jazz.c                      |  23 +-=0D
 hw/mips/malta.c                     |  59 ++--=0D
 hw/mips/mipssim.c                   |  30 +-=0D
 hw/mips/r4k.c                       |  16 +-=0D
 target/mips/cp0_helper.c            |  25 ++=0D
 target/mips/cp0_timer.c             |  51 +---=0D
 target/mips/cpu.c                   |  55 +++-=0D
 target/mips/fpu_helper.c            | 220 ++++++++++----=0D
 target/mips/op_helper.c             |  27 +-=0D
 target/mips/translate.c             | 453 +++++++++++++++++++++++++++-=0D
 util/cutils.c                       |  14 +=0D
 MAINTAINERS                         |  25 +-=0D
 target/mips/translate_init.c.inc    |   4 +-=0D
 tests/acceptance/replay_kernel.py   | 167 +++++++++-=0D
 26 files changed, 1119 insertions(+), 195 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

