Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD343C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A7E20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A7E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13k0-0004Ss-Q6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13iw-0002qr-7c
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j13it-00053S-CN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:43:16 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j13is-0004VR-Un; Mon, 10 Feb 2020 02:43:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1200019|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.171164-0.0255705-0.803265;
 DS=CONTINUE|ham_regular_dialog|0.0128578-0.000116229-0.987026;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03305; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmNZEYU_1581320582; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmNZEYU_1581320582)
 by smtp.aliyun-inc.com(10.147.41.158);
 Mon, 10 Feb 2020 15:43:03 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 0/5] target/riscv: support vector extension part 2
Date: Mon, 10 Feb 2020 15:42:51 +0800
Message-Id: <20200210074256.11412-1-zhiwei_liu@c-sky.com>
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

This is the second part of v3 patchset. This changelog of v3 is only coverd
the part2.

Features:
  * support specification riscv-v-spec-0.7.1.
  * support basic vector extension.
  * support Zvlsseg.
  * support Zvamo.
  * not support Zvediv as it is changing.
  * fixed SLEN 128bit.
  * element width support 8bit, 16bit, 32bit, 64bit.

Changelog:
v3
  * move check code from execution time to translation time.
  * probe pages before real load or store access.
  * use probe_page_check for no-fault operations in linux user mode.
  * add atomic and noatomic operation for vector amo instructions.
V2
  * use float16_compare{_quiet}
  * only use GETPC() in outer most helper
  * add ctx.ext_v Property

LIU Zhiwei (5):
  target/riscv: add vector unit stride load and store instructions
  target/riscv: add vector stride load and store instructions
  target/riscv: add vector index load and store instructions
  target/riscv: add fault-only-first unit stride load
  target/riscv: add vector amo operations

 target/riscv/helper.h                   |  219 ++++
 target/riscv/insn32-64.decode           |   11 +
 target/riscv/insn32.decode              |   67 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  851 +++++++++++++++
 target/riscv/translate.c                |    2 +
 target/riscv/vector_helper.c            | 1251 +++++++++++++++++++++++
 6 files changed, 2401 insertions(+)

-- 
2.23.0


