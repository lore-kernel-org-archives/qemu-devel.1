Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78043C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B06207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B06207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIFr-00040a-GD
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDI-0007FZ-TM; Sat, 11 Jul 2020 12:18:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDD-0001Lw-Tt; Sat, 11 Jul 2020 12:18:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_system_inform|0.669281-0.0017065-0.329012;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.I0GMGMe_1594484317; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0GMGMe_1594484317)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sun, 12 Jul 2020 00:18:39 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 03/11] riscv: Add RV64A instructions description
Date: Sun, 12 Jul 2020 00:16:47 +0800
Message-Id: <20200711161655.2856-4-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200711161655.2856-1-zhiwei_liu@c-sky.com>
References: <20200711161655.2856-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 12:18:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 wxy194768@alibaba-inc.com, chihmin.chao@sifive.com, wenmeng_zhang@c-sky.com,
 Alistair.Francis@wdc.com, alex.bennee@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ensure $rs2 != $rs1, so that the $rs2 register's value
will not be covered when setting the $rs1 register's value to get
a valid address.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 rv64.risu | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/rv64.risu b/rv64.risu
index 2c4154e..ad5dee9 100644
--- a/rv64.risu
+++ b/rv64.risu
@@ -180,3 +180,93 @@ REMW RISCV 0000001 rs2:5 rs1:5 110 rd:5 0111011 \
 
 REMUW RISCV 0000001 rs2:5 rs1:5 111 rd:5 0111011 \
 !constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+@RV64A
+
+LR_W RISCV 00010 imm:2 00000 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(4); reg($rs1, $rd); }
+
+SC_W RISCV 00011 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOSWAP_W  RISCV 00001 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOADD_W   RISCV 00000 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOXOR_W   RISCV 00100 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOAND_W   RISCV 01100 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOOR_W    RISCV 01000 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOMIN_W   RISCV 10000 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOMAX_W   RISCV 10100 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOMINU_W  RISCV 11000 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+AMOMAXU_W  RISCV 11100 imm:2 rs2:5 rs1:5 010 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(4); reg($rs1, $rd); }
+
+LR_D       RISCV 00010 imm:2 00000 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(8); reg($rs1, $rd); }
+
+SC_D       RISCV 00011 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOSWAP_D  RISCV 00001 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOADD_D   RISCV 00000 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOXOR_D   RISCV 00100 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOAND_D   RISCV 01100 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOOR_D    RISCV 01000 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOMIN_D   RISCV 10000 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOMAX_D   RISCV 10100 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOMINU_D  RISCV 11000 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
+
+AMOMAXU_D  RISCV 11100 imm:2 rs2:5 rs1:5 011 rd:5 0101111 \
+!constraints { greg($rd) && greg($rs2) && gbase($rs1) && $rs2 != $rs1; }\
+!memory { align(8); reg($rs1, $rd); }
-- 
2.23.0


