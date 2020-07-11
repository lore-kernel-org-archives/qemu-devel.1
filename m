Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D42C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1B3207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1B3207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIEV-0000e4-HC
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDK-0007H2-9H; Sat, 11 Jul 2020 12:18:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDE-0001Lx-AU; Sat, 11 Jul 2020 12:18:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07460231|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.252457-0.00103191-0.746511;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03299; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.I0GMGMe_1594484317; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0GMGMe_1594484317)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sun, 12 Jul 2020 00:18:40 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 06/11] riscv: Add RV64C instructions description
Date: Sun, 12 Jul 2020 00:16:50 +0800
Message-Id: <20200711161655.2856-7-zhiwei_liu@c-sky.com>
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

Make it a separate file, so that we can get subarch to recgonize the
instrcution length.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 rv64c.risu | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 rv64c.risu

diff --git a/rv64c.risu b/rv64c.risu
new file mode 100644
index 0000000..fdd8afb
--- /dev/null
+++ b/rv64c.risu
@@ -0,0 +1,97 @@
+# Input file for risugen defining RISC-V instructions
+.mode riscv.rv64c
+
+@RV64C
+
+# we borrow X11 to store stack register
+C_LWSP RISCV 010 imm5:1 rd:5 imm2:3 imm6:2 10 \
+!constraints { greg($rd) && $rd != 0 && $rd != 11; } \
+!memory { align(4); stack_plus_imm($imm5 * 32 + $imm2 * 4 + $imm6 * 64, $rd); }
+
+C_LDSP RISCV 011 imm5:1 rd:5 imm3:2 imm6:3 10 \
+!constraints { greg($rd) && $rd != 0 && $rd != 11; } \
+!memory { align(8); stack_plus_imm($imm5 * 32 + $imm3 * 8 + $imm6 * 64, $rd); }
+
+C_FLDSP RISCV 001 imm5:1 rd:5 imm3:2 imm6:3 10 \
+!memory { align(8); stack_plus_imm($imm5 * 32 + $imm3 * 8 + $imm6 * 64); }
+
+C_SWSP RISCV 110 imm2:4 imm6:2 rs2:5 10 \
+!constraints { greg($rs2) && $rs2 != 11; } \
+!memory { align(4); stack_plus_imm($imm2 * 4 + $imm6 * 64); }
+
+C_SDSP RISCV 111 imm3:3 imm6:3 rs2:5 10 \
+!constraints { greg($rs2) && $rs2 != 11; } \
+!memory { align(8); stack_plus_imm($imm3 * 8 + $imm6 * 64); }
+
+C_FSDSP RISCV 101 imm3:3 imm6:3 rs2:5 10 \
+!memory { align(8); stack_plus_imm($imm3 * 8 + $imm6 * 64); }
+
+# encode x11 into 0b011 in CL format
+C_LW RISCV 010 imm3:3 rs1:3 imm2:1 imm6:1 rd:3 00 \
+!memory { align(4); reg_plus_imm($rs1 + 8, $imm2 * 4 + $imm3 * 8 + $imm6 * 64, $rd + 8); }
+
+C_LD RISCV 011 imm3:3 rs1:3 imm6:2 rd:3 00 \
+!memory { align(8); reg_plus_imm($rs1 + 8, $imm3 * 8 + $imm6 * 64, $rd + 8); }
+
+C_FLD RISCV 001 imm3:3 rs1:3 imm6:2 rd:3 00 \
+!memory { align(8); reg_plus_imm($rs1 + 8, $imm3 * 8 + $imm6 * 64); }
+
+C_SW RISCV 110 imm3:3 rs1:3 imm2:1 imm6:1 rs2:3 00 \
+!constraints { $rs2 != $rs1; } \
+!memory { align(4); reg_plus_imm($rs1 + 8, $imm2 * 4 + $imm3 * 8 + $imm6 * 64); }
+
+C_SD RISCV 111 imm3:3 rs1:3 imm6:2 rs2:3 00 \
+!constraints { $rs2 != $rs1; } \
+!memory { align(8); reg_plus_imm($rs1 + 8, $imm3 * 8 + $imm6 * 64); }
+
+C_FSD RISCV 101 imm3:3 rs1:3 imm6:2 rs2:3 00 \
+!memory { align(8); reg_plus_imm($rs1 + 8, $imm3 * 8 + $imm6 * 64); }
+
+C_LI RISCV 010 imm5:1 rd:5 imm:5 01 \
+!constraints { gbase($rd); }
+
+C_LUI RISCV 011 imm17:1 rd:5 imm12:5 01 \
+!constraints { gbase($rd) && ($imm17 != 0 || $imm12 != 0); }
+
+C_ADDI RISCV 000 imm5:1 rd:5 imm:5 01 \
+!constraints { gbase($rd) && ($imm5 != 0 || $imm != 0); }
+
+C_ADDIW RISCV 001 imm5:1 rd:5 imm:5 01 \
+!constraints { gbase($rd); }
+
+# Todo C_ADDI16SP, as it need stack as destination
+# Move sp to aother register through the memory address function.
+
+# C_ADDI4SPN RISCV 000 imm4:2 imm6:4 imm2:1 imm3:1 rd:3 00 \
+# !constraints { $imm4 != 0 || $imm6 != 0 || $imm2 != 0 || $imm3 != 0; }
+
+C_SLLI RISCV 000 shamt5:1 rd:5 shamt:5 10 \
+!constraints { gbase($rd) && ($shamt5 != 0 || $shamt != 0); }
+
+C_SRLI RISCV 100 shamt5:1 00 rd:3 shamt:5 01 \
+!constraints { ($shamt5 != 0 || $shamt != 0); }
+
+C_SRAI RISCV 100 shamt5:1 01 rd:3 shamt:5 01 \
+!constraints { ($shamt5 != 0 || $shamt != 0); }
+
+C_ANDI RISCV 100 imm5:1 10 rd:3 imm:5 01
+
+C_MV RISCV 100 0 rd:5 rs2:5 10 \
+!constraints { gbase($rd) && gbase($rs2); }
+
+C_ADD RISCV 100 1 rd:5 rs2:5 10 \
+!constraints { gbase($rd) && gbase($rs2); }
+
+C_AND RISCV 100 0 11 rd:3 11 rs2:3 01
+
+C_OR RISCV 100 0 11 rd:3 10 rs2:3 01
+
+C_XOR RISCV 100 0 11 rd:3 01 rs2:3 01
+
+C_SUB RISCV 100 0 11 rd:3 01 rs2:3 01
+
+C_SUBW RISCV 100 1 11 rd:3 00 rs2:3 01
+
+C_ADDW RISCV 100 1 11 rd:3 01 rs2:3 01
+
+C_NOP RISCV 0000000000000001
-- 
2.23.0


