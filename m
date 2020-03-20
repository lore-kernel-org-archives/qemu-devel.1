Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F4C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238182072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDgEHO6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238182072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFF1G-0002vk-Bx
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jFF0P-0002FT-4t
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jFF0N-0004JE-Pb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:35:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jFF0N-0004I4-JS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:35:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id w10so6792914wrm.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yn4TFHJlu4nQcb9sHGpLWVYMC4ENuN5Ul3T7gBmUkcg=;
 b=DDgEHO6nJoP+vu9TNCYTEXl6EmAuQvfsp/C9b/CHo5thq4i8+El9VqtczPVdUgLISN
 Ts3sgp6/mZMCOaBmBWy67aedIQ3R7hVtCqGlyWQw5jPILWK4+7mvMjAGCMOg51xVTJMs
 UMhSc6KxhTpRybvQrj95QmR7/0RvuAkPzMo5iIVKTaALmBXI6LGYKdtf9jgBx2UgkyvR
 GO+ttQUx9bHqKQP6fT2QBWi8G3hHSIlrDcYc2mAFoT+4ycemV1JNNh9oeJW0g2lsncn7
 eowhfem8H5h5iTj3QZq2ZLO9nqmUbBJoQ05sERd97l2hOD7PGAGs7SDA3zLBPrMdioL8
 TFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=yn4TFHJlu4nQcb9sHGpLWVYMC4ENuN5Ul3T7gBmUkcg=;
 b=IpBk9v2iKxKOClVmgYZ+TQnITltgaANWmZ2o3t17Ln0ohadhElVAmY7Y9Uf/0KxMii
 skZFKV+nFAyLhtwJ04fbEFe0ZFB3tQ+o5ym84znXSpRwuzcLq9i//HDVhIw9oQw9zs72
 L8hDKJbB2bhxHBj9T5PuP41ynme7x3N3pOScm8bwWv4Qyi39IexdDFGISTNnrGI43EVI
 uCG0q8xsJRNWS5cWQi91lUp+HROblQjWP0bxF26ANSfYHHtkz2ARZpJ8cq9MR9INfp2T
 hWc7euUbuLUzvKhH9URr8TmeU2uYjryafS9HsahfPQ3uqIlIuDh3kV95IjD0qXu2/Ee7
 9scQ==
X-Gm-Message-State: ANhLgQ07A0hs7w8IZ7kgQ0MA6xPbMhsQzHmbNq1UNQHlDOKnHENYRF9L
 9weNG31S/Ukv5YkJYkQ+scZw6yrO
X-Google-Smtp-Source: ADFU+vuHPLDDw9uooN1u5wFSqu0v9gy9EBP7IsGQoeAQGcOojYPcHoN75nwGz1+hbYuVCINSqcWuEQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr9978744wrn.3.1584700553768;
 Fri, 20 Mar 2020 03:35:53 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id s7sm7740221wro.10.2020.03.20.03.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 03:35:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/13] target: Add the Renesas RX architecture
Date: Fri, 20 Mar 2020 11:35:50 +0100
Message-Id: <20200320103551.29246-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Since v1: Rebased
- Use GByteArray in gdbstub (commit a010bdbe),
- Use device_class_set_parent_reset (commit 781c67ca)

The following changes since commit 4dd6517e369828171290b65e11f6a45aeeed15af:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2020-03-19 14:22:46 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/target_renesas_rx-20200320

for you to fetch changes up to c8c35e5f51c4d54bced7aa05fbd8e2371e493182:

  Add rx-softmmu (2020-03-19 17:58:05 +0100)

----------------------------------------------------------------

Introduce the architectural part of the Renesas RX
architecture emulation, developed by Yoshinori Sato.

CI jobs results:
  https://gitlab.com/philmd/qemu/pipelines/127886344
  https://travis-ci.org/github/philmd/qemu/builds/664579420

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
 target/rx/cpu-qom.h             |   53 +
 target/rx/cpu.h                 |  180 +++
 target/rx/helper.h              |   31 +
 target/rx/insns.decode          |  621 ++++++++
 arch_init.c                     |    2 +
 target/rx/cpu.c                 |  225 +++
 target/rx/disas.c               | 1446 ++++++++++++++++++
 target/rx/gdbstub.c             |  112 ++
 target/rx/helper.c              |  149 ++
 target/rx/op_helper.c           |  470 ++++++
 target/rx/translate.c           | 2439 +++++++++++++++++++++++++++++++
 tests/qtest/machine-none-test.c |    1 +
 MAINTAINERS                     |    5 +
 gdb-xml/rx-core.xml             |   70 +
 target/rx/Makefile.objs         |   11 +
 23 files changed, 5897 insertions(+), 2 deletions(-)
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


