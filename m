Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD37ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2327B207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2327B207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wFV-0000FL-QO
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDU-0006xD-Cu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i7wDT-0007m7-GQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:35:00 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i7wDT-0007jC-4b; Wed, 11 Sep 2019 02:34:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06282304|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.20373-0.00815328-0.788117; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03277; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FSRGAhQ_1568183690; 
Received: from localhost(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FSRGAhQ_1568183690)
 by smtp.aliyun-inc.com(10.147.42.198);
 Wed, 11 Sep 2019 14:34:50 +0800
From: liuzhiwei <zhiwei_liu@c-sky.com>
To: Alistair.Francis@wdc.com, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 wenmeng_zhang@c-sky.com
Date: Wed, 11 Sep 2019 14:25:25 +0800
Message-Id: <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] [PATCH v2 01/17] RISC-V: add vfp field in CPURISCVState
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307..c992b1d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -93,9 +93,37 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
+#define VLEN 128
+#define VUNIT(x) (VLEN / x)
+
 struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
+
+    /* vector coprocessor state.  */
+    struct {
+        union VECTOR {
+            float64  f64[VUNIT(64)];
+            float32  f32[VUNIT(32)];
+            float16  f16[VUNIT(16)];
+            uint64_t u64[VUNIT(64)];
+            int64_t  s64[VUNIT(64)];
+            uint32_t u32[VUNIT(32)];
+            int32_t  s32[VUNIT(32)];
+            uint16_t u16[VUNIT(16)];
+            int16_t  s16[VUNIT(16)];
+            uint8_t  u8[VUNIT(8)];
+            int8_t   s8[VUNIT(8)];
+        } vreg[32];
+        target_ulong vxrm;
+        target_ulong vxsat;
+        target_ulong vl;
+        target_ulong vstart;
+        target_ulong vtype;
+        float_status fp_status;
+    } vfp;
+
+    bool         foflag;
     target_ulong pc;
     target_ulong load_res;
     target_ulong load_val;
-- 
2.7.4


