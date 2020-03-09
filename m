Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C8C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F7620674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F7620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBEb3-0007lz-C9
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBEa7-00076X-K1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBEa5-0001my-MF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:20:15 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBEa5-0001j9-Bc; Mon, 09 Mar 2020 05:20:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07495327|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.03378-0.000359325-0.965861;
 FP=1649258829762365013|1|1|7|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com;
 NM=1; PH=DS; RN=10; RT=10; SR=0; TI=SMTPD_---.GyVpCil_1583745606; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyVpCil_1583745606)
 by smtp.aliyun-inc.com(10.147.41.121);
 Mon, 09 Mar 2020 17:20:07 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 00/60] target/riscv: support vector extension v0.7.1
Date: Mon,  9 Mar 2020 17:19:04 +0800
Message-Id: <20200309092004.13335-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements the vector extension for RISC-V on QEMU.

You can also find the patchset and all *test cases* in
my repo(https://github.com/romanheros/qemu.git branch:vector-upstream-v3).
All the test cases are in the directory qemu/tests/riscv/vector/. They are
riscv64 linux user mode programs.

You can test the patchset by the script qemu/tests/riscv/vector/runcase.sh.

Features:
  * support specification riscv-v-spec-0.7.1.(https://github.com/riscv/riscv-v-spec/releases/tag/0.7.1/)
  * support basic vector extension.
  * support Zvlsseg.
  * support Zvamo.
  * not support Zvediv as it is changing.
  * SLEN always equals VLEN.
  * element width support 8bit, 16bit, 32bit, 64bit.

Changelog:
v3
  * move check code from execution-time to translation-time
  * use a continous memory block for vector register description.
  * vector registers as direct fields in RISCVCPUState.
  * support VLEN configure from qemu command line.
  * support ELEN configure from qemu command line.
  * support vector specification version configure from qemu command line.
  * probe pages before real load or store access.
  * use probe_page_check for no-fault operations in linux user mode.
  * generation atomic exit exception when in parallel environment.
  * fixup a lot of concrete bugs.

V2
  * use float16_compare{_quiet}
  * only use GETPC() in outer most helper
  * add ctx.ext_v Property


LIU Zhiwei (60):
  target/riscv: add vector extension field in CPURISCVState
  target/riscv: implementation-defined constant parameters
  target/riscv: support vector extension csr
  target/riscv: add vector configure instruction
  target/riscv: add vector stride load and store instructions
  target/riscv: add vector index load and store instructions
  target/riscv: add fault-only-first unit stride load
  target/riscv: add vector amo operations
  target/riscv: vector single-width integer add and subtract
  target/riscv: vector widening integer add and subtract
  target/riscv: vector integer add-with-carry / subtract-with-borrow
    instructions
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
  target/riscv: vector single-width fractional multiply with rounding
    and saturation
  target/riscv: vector widening saturating scaled multiply-add
  target/riscv: vector single-width scaling shift instructions
  target/riscv: vector narrowing fixed-point clip instructions
  target/riscv: vector single-width floating-point add/subtract
    instructions
  target/riscv: vector widening floating-point add/subtract instructions
  target/riscv: vector single-width floating-point multiply/divide
    instructions
  target/riscv: vector widening floating-point multiply
  target/riscv: vector single-width floating-point fused multiply-add
    instructions
  target/riscv: vector widening floating-point fused multiply-add
    instructions
  target/riscv: vector floating-point square-root instruction
  target/riscv: vector floating-point min/max instructions
  target/riscv: vector floating-point sign-injection instructions
  target/riscv: vector floating-point compare instructions
  target/riscv: vector floating-point classify instructions
  target/riscv: vector floating-point merge instructions
  target/riscv: vector floating-point/integer type-convert instructions
  target/riscv: widening floating-point/integer type-convert
    instructions
  target/riscv: narrowing floating-point/integer type-convert
    instructions
  target/riscv: vector single-width integer reduction instructions
  target/riscv: vector wideing integer reduction instructions
  target/riscv: vector single-width floating-point reduction
    instructions
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

 target/riscv/Makefile.objs              |    2 +-
 target/riscv/cpu.c                      |   49 +
 target/riscv/cpu.h                      |   89 +-
 target/riscv/cpu_bits.h                 |   15 +
 target/riscv/csr.c                      |   75 +-
 target/riscv/helper.h                   | 1075 +++++
 target/riscv/insn32-64.decode           |   11 +
 target/riscv/insn32.decode              |  366 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 2386 ++++++++++++
 target/riscv/translate.c                |   24 +-
 target/riscv/vector_helper.c            | 4745 +++++++++++++++++++++++
 11 files changed, 8824 insertions(+), 13 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

-- 
2.23.0


