Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82108C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B70B206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ltEoMbyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B70B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI8f-0003Pf-Hp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4j-0005xW-No
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4h-0002fu-UT
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595437115; x=1626973115;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P/k2D2D4QAIblvv6h3Y5Rw3h3hsa6l5k5jMFvrCStiU=;
 b=ltEoMbyI5THOI4aB5bPIwnB0Lb3BQOXvZCmay2zBHVTkpdQZonjJX05L
 xR2b30fppbkZ0JqqBprOdXTusNSafUHnc9vtI1s1kZJX04+0x+ATQ/HDU
 gqgvBFb5QnyLmbLCPb/Zx/ReoLU7ggjURRbCKaKEfuLxHNef3ZIpoEkFq
 PbKTxfYP8s2eQXrznceDjR00JIImuVSPAtVen+6m1a0kxHbu2JJlo1EBn
 7dM6y9Fr5qKSB5XBbkAmozf9zXqGkwNFHUI+cBlWBhDH60Iv1VUnZVlC2
 MCwSQjD7fqcmp+YpNZ/0FzIMmmommO7JZqdpcPX+DGlRiYIV9jma8IMlV A==;
IronPort-SDR: NpYMQFqaM/ip+O/qW9tnzt3RxEUNKi8UPSD8EgBrlb/BUKl4/+JbTFuhOGH29NREekiwWuZOWH
 8BieRbgX2O8yehfGJtS6w/jfafQHZktZtkAw1mFrakikVv+M38EiL+eEa+hrJ3HnbVncIjxRGI
 aXOmp2ZO6rkX8Qhb/FHrmuHVMILUgTUoG4Xk3HDMjICjM1u8NQ1ngEFTZde3e3izfKbgKm75Lg
 GrPqUF3BjUS3k56qFVwrkAUder7qrcnJa0bzJCsyGoti1/w1pCnMdLztCCNdCBksR1fV3bfjht
 TeQ=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; d="scan'208";a="252418636"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 00:58:21 +0800
IronPort-SDR: hTMyhXynS3PWceY5QtaEPQla3z9HDNWfZFMCFb8WQXVxwDAwntC/DhwKTop+FuAlp4Dj/XAPcq
 x4PCbRP7Gci4+blhW4RsbfXIfY8OwtU78=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 09:46:38 -0700
IronPort-SDR: 4KkGJrx4Q5uTgYlouEphm1GTAmo3xFA9w4OtSEzxFdjHM5yA5crYWvbS9IX8GzpQe/9otaDn4E
 QCQvV2CkzCCw==
WDCIronportException: Internal
Received: from usa001575.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.115])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 09:58:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] target/riscv: fix vector index load/store constraints
Date: Wed, 22 Jul 2020 09:48:36 -0700
Message-Id: <20200722164838.1591305-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164838.1591305-1-alistair.francis@wdc.com>
References: <20200722164838.1591305-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=465c3c755=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 12:58:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Although not explicitly specified that the the destination
vector register groups cannot overlap the source vector register group,
it is still necessary.

And this constraint has been added to the v0.8 spec.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200721133742.2298-2-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 7b4752b911..887c6b8883 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -513,13 +513,21 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
     return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
+/*
+ * For vector indexed segment loads, the destination vector register
+ * groups cannot overlap the source vector register group (specified by
+ * `vs2`), else an illegal instruction exception is raised.
+ */
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
 {
     return (vext_check_isa_ill(s) &&
             vext_check_overlap_mask(s, a->rd, a->vm, false) &&
             vext_check_reg(s, a->rd, false) &&
             vext_check_reg(s, a->rs2, false) &&
-            vext_check_nf(s, a->nf));
+            vext_check_nf(s, a->nf) &&
+            ((a->nf == 1) ||
+             vext_check_overlap_group(a->rd, a->nf << s->lmul,
+                                      a->rs2, 1 << s->lmul)));
 }
 
 GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
-- 
2.27.0


