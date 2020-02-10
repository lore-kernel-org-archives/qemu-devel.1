Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605EC4741C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24B422525
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24B422525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j14CO-00050Y-Va
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 03:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j14Bg-0003ns-Vq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j14Bf-0008F0-PM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:13:00 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j14Bf-0008Bd-A5; Mon, 10 Feb 2020 03:12:59 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.161179|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.291525-0.0425897-0.665885;
 DS=CONTINUE|ham_system_inform|0.0211774-0.00132143-0.977501;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03302; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmO5bfp_1581322371; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmO5bfp_1581322371)
 by smtp.aliyun-inc.com(10.147.40.44); Mon, 10 Feb 2020 16:12:51 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 0/4]target-riscv: support vector extension part 1 
Date: Mon, 10 Feb 2020 16:12:36 +0800
Message-Id: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the first part of v4 patchset. The changelog of v4 is only coverd
the part1.

Features:
  * support specification riscv-v-spec-0.7.1.
  * support basic vector extension.
  * support Zvlsseg.
  * support Zvamo.
  * not support Zvediv as it is changing.
  * fixed SLEN 128bit.
  * element width support 8bit, 16bit, 32bit, 64bit.

Changelog:

v4
  * adjust max vlen to 512 bits.
  * check maximum on elen(64bits).
  * check minimum on vlen(128bits).
  * check if rs1 is x0 in vsetvl/vsetvli.
  * use gen_goto_tb in vsetvli instead of exit_tb.
  * fixup fetch vlmax from rs2, not env->vext.type.
v3
  * support VLEN configure from qemu command line.
  * support ELEN configure from qemu command line.
  * support vector specification version configure from qemu command line.
  * only default on for "any" cpu, others turn on from command line.
  * use a continous memory block for vector register description.
V2
  * use float16_compare{_quiet}
  * only use GETPC() in outer most helper
  * add ctx.ext_v Property

LIU Zhiwei (4):
  target/riscv: add vector extension field in CPURISCVState
  target/riscv: configure and turn on vector extension from command line
  target/riscv: support vector extension csr
  target/riscv: add vector configure instruction

 MAINTAINERS                             |  1 +
 target/riscv/Makefile.objs              |  2 +-
 target/riscv/cpu.c                      | 48 ++++++++++++++-
 target/riscv/cpu.h                      | 82 ++++++++++++++++++++++---
 target/riscv/cpu_bits.h                 | 15 +++++
 target/riscv/csr.c                      | 72 +++++++++++++++++++++-
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              |  5 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 69 +++++++++++++++++++++
 target/riscv/translate.c                | 17 ++++-
 target/riscv/vector_helper.c            | 49 +++++++++++++++
 11 files changed, 346 insertions(+), 16 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

-- 
2.23.0


