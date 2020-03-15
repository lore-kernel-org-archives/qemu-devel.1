Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB09C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B504205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQBwUpE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B504205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTLj-0001Bu-2O
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJQ-0007zb-0I
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJO-0002EP-Kq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJO-00026T-E2
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id 6so14746027wmi.5
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cZ9GiVKz8fswrnYgF/KxthEcRdn/GQHRDePrvPQn24I=;
 b=MQBwUpE9XvEnVUpk2gPlwLDV5J0y+r9/qIr1UhGRZrKNb/WNvS5kaxRHyBa3h7eyKk
 q7WeISg0kcEkAqiGYm7B7i4okRLwQg1BbasTYCqLJBbTqP/28dGcwNMH/K9IZlztLlrP
 frbYXnS5rzfVBn+ILsnhSy9DxAJTfUYXpokjgoellv3GMdkR72Xxn9qZjBxzorGF/LcT
 E4W0k8Xh6iL8/pU42MF38zouENG+RZWg2jcFOkbhGRkPTxea/g86NHaFmWqZTAJVV3Z5
 XmZa4uTzttZsFV4tuhLCG2P3NSpKMvSRrBFOu9OlGyqTG6xYHSYa9P5je6x/bnGp5J1+
 ZMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=cZ9GiVKz8fswrnYgF/KxthEcRdn/GQHRDePrvPQn24I=;
 b=Trxi0bkWDSjpWPGYON/iHUBnv9MeRNFFoj259hTj8rvx91u4AMfnDXGq4H4ecL6ZwI
 ZMqpR4Hwd2FH/sS9dPbR8j7pz7EAUzzRa/0wv3gd/K86YZxxw01VLMNiMfslQxnA2OF1
 SUVZKSkWzzgaQQ4kBAVlsvDBsW88DmqgJnLbCh+b/ZnY/i0MUUlmu6y01lIYsfsXD3Ed
 VjexI3Sh92po/cGhzIUjx2pMttmXq6d+tnL2oAZZkHESfp2E+KR2U0Pdimh1gT2OyJ/7
 mXATvNLsi5P01BibyT1W5z1fGbZElXn2sKz8xQ3UWWDtm9fM9jdoWN1z5/lgYfnSZi/V
 T1aw==
X-Gm-Message-State: ANhLgQ2o0yLYL9BFdj5AG32YKPBBzutmhUctSbCR/WY9ybIFCQjKHUGQ
 Qc7Sf6JC7k1nFLKDe4hvo3etySPq
X-Google-Smtp-Source: ADFU+vuWnC3mwvU9O43CgJ9GiD0oOAvfq02s5iR5w5H53iZTzga1pQ3VqrnpqY5aZhaCT2YIazu2Lg==
X-Received: by 2002:a05:600c:2250:: with SMTP id
 a16mr12894484wmm.57.1584278892896; 
 Sun, 15 Mar 2020 06:28:12 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] target: Add Renesas RX architecture
Date: Sun, 15 Mar 2020 14:27:56 +0100
Message-Id: <20200315132810.7022-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a merger of Yoshinori's v32 of the Renesas RX
architecture emulation.
Richard temporarily handed it over for the 5.0 release.

This part adds the architectural part. The hardware part
will follow.

Call this release, or merge, candidate 1.

repo: https://gitlab.com/philmd/qemu.git
branch: rx_target_merger

Richard Henderson (6):
  target/rx: Disassemble rx_index_addr into a string
  target/rx: Replace operand with prt_ldmi in disassembler
  target/rx: Use prt_ldmi for XCHG_mr disassembly
  target/rx: Emit all disassembly in one prt()
  target/rx: Collect all bytes during disassembly
  target/rx: Dump bytes for each insn during disassembly

Yoshinori Sato (7):
  hw/registerfields.h: Add 8bit and 16bit register macros
  MAINTAINERS: Cover Renesas RX architecture
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
 include/hw/registerfields.h     |   32 +-
 include/sysemu/arch_init.h      |    1 +
 target/rx/cpu-param.h           |   31 +
 target/rx/cpu-qom.h             |   43 +
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
 23 files changed, 5890 insertions(+), 3 deletions(-)
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


