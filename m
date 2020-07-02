Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A59C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B1A20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LFYzpgQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2AV-0005LY-Hx
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29Y-0003W6-6s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29V-00008W-Fh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707613; x=1625243613;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tNp40/T/NZ8yIXAU8hD8sKl7aw4LRX3jyITc2vbB214=;
 b=LFYzpgQzyFm2b4pk03mw8FaGsV7suk+5tIzXXiagOMXoywfINsYvV8KB
 NWgwnFFaW36cKhMwdWnYcuvSLQAF37BS4lpRk4ts+f531gIqL2NAY5jYT
 tstR2zZh1kp81dWP0T3gTLDODrrgBP2WSXZyEAEUnjIIjgiEx4UFx+t1g
 7Gl2cXUgPPuP0yj43Bx/ntnwEMepUUSvSKxUHAkAGGhFC7+lLWu2d3YAd
 jPV/ZZAenofxAx45RVq4IJDtisgAfJybevutU+IEM2o0uhOX9UwA7gLt3
 0UTs+Nxsj3uaC6dOWfSsLNboWXJ2QANtGAB/0oIvFU7VMVBl78slsJLEI g==;
IronPort-SDR: 8sNJULAkghwCki0YpvM/uW2Tl/bPQlircSAh15Y7765Wmtsudq9+CAiSohCC69E2p7kJGu33yT
 E8Wwc+KUdoedsUOIXbWcWWAYVW9QLDialQvTownVReqx7Zl3VE57c+sWPK2KWam/5UPN2YVlDj
 Lh71NAqChmr8M2gXzcnxk6cdiIteg8T2loywH/5c7s4QuvPYp9D9Q46+nJG9cY5gKX2SzBzT9s
 zHtQKeSyY6FZ/mH+dsbw8XFCOG10y9K6baIJqAXIFRDMwDmgcvbybnNp96Z0HLElt1ddnUreDz
 mvc=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498459"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:19 +0800
IronPort-SDR: jgqivqlRP6tX4eblUIfOwE1xguyr6ox66DDn9HPe5paPbdEE8xzsKxtYxH6JGJ6WAohgu5rCBD
 lWeu095EiozsNAuuSNraOgzTpuukOtFpI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:34 -0700
IronPort-SDR: YDS2ZbxHOx/qccWd1q4C+K5YCJc5zuf7qMf0ZfkxISsvek7PNsEHYkkss/buqeOCv6mc83RwKt
 S1KpcMA/dRnw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/64] riscv-to-apply queue
Date: Thu,  2 Jul 2020 09:22:50 -0700
Message-Id: <20200702162354.928528-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 64f0ad8ad8e13257e7c912df470d46784b55c3fd:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-02' into staging (2020-07-02 15:54:09 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200702-1

for you to fetch changes up to 6bf91617f47c74efc99ef48236765d9677c0898e:

  target/riscv: configure and turn on vector extension from command line (2020-07-02 09:19:34 -0700)

----------------------------------------------------------------
This PR contains two patches to improve PLIC support in QEMU.

It also contains one patch that fixes CLINT accesses for RISC-V. This
fixes a regression for most RISC-V boards.

The rest of the PR is adding support for the v0.7.1 RISC-V vector
extensions. This is experimental support as the vector extensions are
still in a draft state.

This is a v2 pull request that has fixed the building on big endian
machines failure.

----------------------------------------------------------------
Alistair Francis (1):
      hw/riscv: Allow 64 bit access to SiFive CLINT

Jessica Clarke (2):
      riscv: plic: Honour source priorities
      riscv: plic: Add a couple of mising sifive_plic_update calls

LIU Zhiwei (61):
      target/riscv: add vector extension field in CPURISCVState
      target/riscv: implementation-defined constant parameters
      target/riscv: support vector extension csr
      target/riscv: add vector configure instruction
      target/riscv: add an internals.h header
      target/riscv: add vector stride load and store instructions
      target/riscv: add vector index load and store instructions
      target/riscv: add fault-only-first unit stride load
      target/riscv: add vector amo operations
      target/riscv: vector single-width integer add and subtract
      target/riscv: vector widening integer add and subtract
      target/riscv: vector integer add-with-carry / subtract-with-borrow instructions
      target/riscv: vector bitwise logical instructions
      target/riscv: vector single-width bit shift instructions
      target/riscv: vector narrowing integer right shift instructions
      target/riscv: vector integer comparison instructions
      target/riscv: vector integer min/max instructions
      target/riscv: vector single-width integer multiply instructions
      target/riscv: vector integer divide instructions
      target/riscv: vector widening integer multiply instructions
      target/riscv: vector single-width integer multiply-add instructions
      target/riscv: vector widening integer multiply-add instructions
      target/riscv: vector integer merge and move instructions
      target/riscv: vector single-width saturating add and subtract
      target/riscv: vector single-width averaging add and subtract
      target/riscv: vector single-width fractional multiply with rounding and saturation
      target/riscv: vector widening saturating scaled multiply-add
      target/riscv: vector single-width scaling shift instructions
      target/riscv: vector narrowing fixed-point clip instructions
      target/riscv: vector single-width floating-point add/subtract instructions
      target/riscv: vector widening floating-point add/subtract instructions
      target/riscv: vector single-width floating-point multiply/divide instructions
      target/riscv: vector widening floating-point multiply
      target/riscv: vector single-width floating-point fused multiply-add instructions
      target/riscv: vector widening floating-point fused multiply-add instructions
      target/riscv: vector floating-point square-root instruction
      target/riscv: vector floating-point min/max instructions
      target/riscv: vector floating-point sign-injection instructions
      target/riscv: vector floating-point compare instructions
      target/riscv: vector floating-point classify instructions
      target/riscv: vector floating-point merge instructions
      target/riscv: vector floating-point/integer type-convert instructions
      target/riscv: widening floating-point/integer type-convert instructions
      target/riscv: narrowing floating-point/integer type-convert instructions
      target/riscv: vector single-width integer reduction instructions
      target/riscv: vector wideing integer reduction instructions
      target/riscv: vector single-width floating-point reduction instructions
      target/riscv: vector widening floating-point reduction instructions
      target/riscv: vector mask-register logical instructions
      target/riscv: vector mask population count vmpopc
      target/riscv: vmfirst find-first-set mask bit
      target/riscv: set-X-first mask bit
      target/riscv: vector iota instruction
      target/riscv: vector element index instruction
      target/riscv: integer extract instruction
      target/riscv: integer scalar move instruction
      target/riscv: floating-point scalar move instructions
      target/riscv: vector slide instructions
      target/riscv: vector register gather instruction
      target/riscv: vector compress instruction
      target/riscv: configure and turn on vector extension from command line

 target/riscv/cpu.h                      |   82 +-
 target/riscv/cpu_bits.h                 |   15 +
 target/riscv/helper.h                   | 1069 +++++++
 target/riscv/internals.h                |   41 +
 target/riscv/insn32-64.decode           |   11 +
 target/riscv/insn32.decode              |  372 +++
 hw/riscv/sifive_clint.c                 |    2 +-
 hw/riscv/sifive_plic.c                  |   20 +-
 target/riscv/cpu.c                      |   50 +
 target/riscv/csr.c                      |   75 +-
 target/riscv/fpu_helper.c               |   33 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 2888 ++++++++++++++++++
 target/riscv/translate.c                |   27 +-
 target/riscv/vector_helper.c            | 4899 +++++++++++++++++++++++++++++++
 target/riscv/Makefile.objs              |    2 +-
 15 files changed, 9535 insertions(+), 51 deletions(-)
 create mode 100644 target/riscv/internals.h
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

