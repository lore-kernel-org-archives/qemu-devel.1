Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF36C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360DC2089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mrLujq2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360DC2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowJN-0004cI-F0
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI1-0002lW-GL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowHy-0002yi-PN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208419; x=1624744419;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t7HBMjMU0oepV9W49kqMAwqywewHydfV15kONJQ3LoQ=;
 b=mrLujq2aD5k+WiXpeD23hKVeXGXYs29R9+mLpe20W4JV3A4DSeVOptgj
 5+Di9KtB8uSEuTI15wAJaBVyJ5MQ2cHFBzMRTwy2n9stk1AZ6cLuRS5kA
 m95NYU9sObAmzrd+uud3eR0x7LbJJKlx+KegCW1r8ia0cDpeW5oz8mw05
 mK3SP7mNoPUFaIgCtBCAG6XuKUc9Bdtn6Gi68jr3oDKJ6reYsIeXeOfB+
 XeksBN19njb7HNkCFcovv3+gnyZeV1CiFy3VqlCp9sGlUOHUESbQVliAA
 BieTawH/gydwP5f2CjMSww7ao8O3alfr9uFuAUsP9xJs1JKLWQS2X/DYG g==;
IronPort-SDR: wXUY3UrsYKHEABCdwklvg6FYuezxfisKRRD9Ma/EbJv1PkqTA2M+A8TUuGHNcmgdC/4Ars+GuT
 KbXOJGTBACUTBzkZFkIJJkpvhdm2ZP9pFi3G7MUiwiwJqImUf/X3U4wj0Dgkd94XPEneO3/YxR
 que3siUcnAXSpxr3ZGZwv/bcTiyfhOO0Ylu4oIYOjdEokXdS2X5XQWrlrOE1G6CNWbLtDTkH/8
 vemjQfUmNO/Sty1otNdKiOJur/yF62xkKveSIbEVahCMbP6qZxJzrZD9edDr5Yy0H8e3bI8+gu
 S6U=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360012"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:35 +0800
IronPort-SDR: sHosuZNp6gA9E8YxgB45EzoUuUDCBXdInJyFgWFGs6Rkpr9p8d13q7GMT5bBUq/2s6V29euEZ9
 KdBCmRQ/JX8/KyKOX5oPnZQapn+kidJlQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:32 -0700
IronPort-SDR: 97/zO124RYDb08jUio8wxh9C09FfGYqAAbMBXPXT3CKlU+qyjwht3KQOOm1N5N9NvQF662fGeV
 4ydPXLa0xKTQ==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/63] riscv-to-apply queue
Date: Fri, 26 Jun 2020 14:43:07 -0700
Message-Id: <20200626214410.3613258-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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

The following changes since commit 553cf5d7c47bee05a3dec9461c1f8430316d516b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200626' into staging (2020-06-26 18:22:36 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200626-1

for you to fetch changes up to b39d59434ea10649fdb9e0a339c30c76e38c5e17:

  target/riscv: configure and turn on vector extension from command line (2020-06-26 14:22:15 -0700)

----------------------------------------------------------------
This PR contains two patches to improve PLIC support in QEMU.

The rest of the PR is adding support for the v0.7.1 RISC-V vector
extensions. This is experimental support as the vector extensions are
still in a draft state.

----------------------------------------------------------------
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
 hw/riscv/sifive_plic.c                  |   20 +-
 target/riscv/cpu.c                      |   50 +
 target/riscv/csr.c                      |   75 +-
 target/riscv/fpu_helper.c               |   33 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 2888 ++++++++++++++++++
 target/riscv/translate.c                |   27 +-
 target/riscv/vector_helper.c            | 4899 +++++++++++++++++++++++++++++++
 target/riscv/Makefile.objs              |    2 +-
 14 files changed, 9534 insertions(+), 50 deletions(-)
 create mode 100644 target/riscv/internals.h
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

