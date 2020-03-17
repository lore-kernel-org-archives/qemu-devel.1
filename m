Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D8C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E758120724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9sUVNGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E758120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFKk-0005pl-3r
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCZ-0003Xv-Qd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCX-0002W0-GD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCW-0002Hd-OV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id b2so20323164wrj.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5cQNBV/VUsq4brIXVqShTiqeScMAL4wRq36Vuu4EOI0=;
 b=s9sUVNGinCGL9QxaFrltGt9wkwrrCLisNp98Ad5KBWD0N81DXXWAhHCOQpNE0ELX87
 64bIUuYtTEoOQq0cViUI0LtpBXBWyVlRcoynS8VsLUVMj7ds6hoxDcjoTHamtDnLk4+R
 heIS9sW7r6bsyKkKjnxpCU5DGppMvxgBx4u8sWuMU+3vUIXPB6pdZ3m4UJwMeS8+m/kv
 yxFiHoCkgGR1YpzUwDBWz7COn9LaEB4FfV243bO/uU5nK6hSWvNjc8RzRdmpFR1BkRd1
 9DwBa5eD4FgeuQZ+iyOCbr/bPTItSxKyJk+hz7kUUpVOQ8MUgLsoXMXXlj0OIgXevEWf
 gMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5cQNBV/VUsq4brIXVqShTiqeScMAL4wRq36Vuu4EOI0=;
 b=tRTm6Wob9c3BkA1t5RK9SO03uiOw5QNxktMSQyifUDBujPblbXV6Legu09NTcAvPYo
 oBmGwt2mp4OP8xE3NSuJIts++OGfdCwFgPgE8zxHZcvzsQrKuoJrlJIyGcXH5/u6z8VK
 2xlNhjMmgX3y7AZenx9nC8BQh3r1Dfa2eD97ifIv9RsSga9MKHYUSxSZUlwgzgC1FhEQ
 iSPY4moDSVsTpp49iCk7tAQ3XPOKwyp4LxjYf8F9+2TjCYPe4uRDef8HQT59txCYKoU5
 ghggYL6p7y3D+wB/0VqHKApIKRKVz1L4FnRl8lWMZeAUP2gpjm8Ba68KrsFYzRv+wj8u
 lChg==
X-Gm-Message-State: ANhLgQ17xAVY37xBM/9QaU538eLvNek+demRBFVocdaENbcrfnLkQWiL
 P3l77B4Sx4UWQY3CsYwfYmSA4VcE
X-Google-Smtp-Source: ADFU+vsDlgi72TzkMDabzQYhb/QxNmtweXlHarshftxRv2hSu2H+AgY4mXShTOjklENR46646Ao1Lg==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr6486488wrv.337.1584462978395; 
 Tue, 17 Mar 2020 09:36:18 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] target: Add the Renesas RX architecture
Date: Tue, 17 Mar 2020 17:36:03 +0100
Message-Id: <20200317163616.30027-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull request adds the architectural part of the Renesas RX
architecture.  Richard Henderson temporarily handed it over for
the 5.0 release.

The following changes since commit a98135f727595382e200d04c2996e868b7925a01:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/target_renesas_rx-20200317

for you to fetch changes up to d9ecf331340137dc091bdcf3d3ef60087deac9ac:

  Add rx-softmmu (2020-03-17 16:01:58 +0100)

----------------------------------------------------------------

Introduce the architectural part of the Renesas RX
architecture emulation, developed by Yoshinori Sato.

CI jobs results:
  https://gitlab.com/philmd/qemu/pipelines/127060924
  https://travis-ci.org/github/philmd/qemu/builds/663524971

----------------------------------------------------------------

Richard Henderson (6):
  target/rx: Disassemble rx_index_addr into a string
  target/rx: Replace operand with prt_ldmi in disassembler
  target/rx: Use prt_ldmi for XCHG_mr disassembly
  target/rx: Emit all disassembly in one prt()
  target/rx: Collect all bytes during disassembly
  target/rx: Dump bytes for each insn during disassembly

Yoshinori Sato (7):
  hw/registerfields.h: Add 8bit and 16bit register macros
  MAINTAINERS: Add entry for the Renesas RX architecture
  target/rx: TCG translation
  target/rx: TCG helpers
  target/rx: CPU definitions
  target/rx: RX disassembler
  Add rx-softmmu

 configure                       |   11 +-
 default-configs/rx-softmmu.mak  |    2 +
 qapi/machine.json               |    4 +-
 include/disas/dis-asm.h         |    5 +
 include/exec/poison.h           |    1 +
 include/hw/registerfields.h     |   30 +
 include/sysemu/arch_init.h      |    1 +
 target/rx/cpu-param.h           |   30 +
 target/rx/cpu-qom.h             |   54 +
 target/rx/cpu.h                 |  180 +++
 target/rx/helper.h              |   31 +
 target/rx/insns.decode          |  621 ++++++++
 arch_init.c                     |    2 +
 target/rx/cpu.c                 |  226 +++
 target/rx/disas.c               | 1446 ++++++++++++++++++
 target/rx/gdbstub.c             |  112 ++
 target/rx/helper.c              |  149 ++
 target/rx/op_helper.c           |  470 ++++++
 target/rx/translate.c           | 2439 +++++++++++++++++++++++++++++++
 tests/qtest/machine-none-test.c |    1 +
 MAINTAINERS                     |    5 +
 gdb-xml/rx-core.xml             |   70 +
 target/rx/Makefile.objs         |   11 +
 23 files changed, 5899 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 target/rx/cpu-param.h
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/helper.h
 create mode 100644 target/rx/insns.decode
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/disas.c
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c
 create mode 100644 gdb-xml/rx-core.xml
 create mode 100644 target/rx/Makefile.objs

-- 
2.21.1


