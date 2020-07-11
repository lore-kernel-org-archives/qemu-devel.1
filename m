Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878CEC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593B5207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593B5207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIHO-0007PW-JR
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDY-0007fX-Rf; Sat, 11 Jul 2020 12:19:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDW-0001Ln-9Z; Sat, 11 Jul 2020 12:19:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.531228-0.000452356-0.46832;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.I0GMGMe_1594484317; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0GMGMe_1594484317)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sun, 12 Jul 2020 00:18:38 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 01/11] riscv: Add RV64I instructions description
Date: Sun, 12 Jul 2020 00:16:45 +0800
Message-Id: <20200711161655.2856-2-zhiwei_liu@c-sky.com>
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

Avoid using stack pointer(x2), thread pointer(x3), global pointer(x4),
as they are not under control of risu.
Besides, avoid using x0 as base address register, because we can't
emit a valid random address by setting x0.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 rv64.risu | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 rv64.risu

diff --git a/rv64.risu b/rv64.risu
new file mode 100644
index 0000000..edf0d1f
--- /dev/null
+++ b/rv64.risu
@@ -0,0 +1,141 @@
+# Input file for risugen defining RISC-V instructions
+.mode riscv.rv64
+@RV64I
+
+# x2 stack pointer, x3 global pointer, x4 thread pointer
+# These registers should be reserved for signal handler.
+
+LUI RISCV imm:20 rd:5 0110111 \
+!constraints { greg($rd); }
+
+AUIPC RISCV imm:20 rd:5 0110111 \
+!constraints { greg($rd); }
+
+# Limit to current implementation, the base address register will be overide
+LB RISCV imm:12 rs1:5 000 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(1); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+LH RISCV imm:12 rs1:5 001 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(2); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+LW RISCV imm:12 rs1:5 010 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(4); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+LBU RISCV imm:12 rs1:5 100 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(1); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+LHU RISCV imm:12 rs1:5 101 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(2); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+SB RISCV imm5:7 rs2:5 rs1:5 000 imm:5 0100011 \
+!constraints { greg($rs2) && gbase($rs1) && $rs2 != $rs1; } \
+!memory { align(1); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+SH RISCV imm5:7 rs2:5 rs1:5 001 imm:5 0100011 \
+!constraints { greg($rs2) && gbase($rs1) && $rs2 != $rs1; } \
+!memory { align(2); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+SW RISCV imm5:7 rs2:5 rs1:5 010 imm:5 0100011 \
+!constraints { greg($rs2) && gbase($rs1) && $rs2 != $rs1; } \
+!memory { align(4); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+ADDI RISCV imm:12 rs1:5 000 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SLTI RISCV imm:12 rs1:5 010 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SLTIU RISCV imm:12 rs1:5 011 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+XORI RISCV imm:12 rs1:5 100 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+ORI RISCV imm:12 rs1:5 110 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+ANDI RISCV imm:12 rs1:5 111 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+ADD RISCV 0000000 rs2:5 rs1:5 000 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SUB RISCV 0100000 rs2:5 rs1:5 000 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SLL RISCV 0000000 rs2:5 rs1:5 001 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SLT RISCV 0000000 rs2:5 rs1:5 010 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SLTU  RISCV 0000000 rs2:5 rs1:5 011 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+XOR RISCV 0000000 rs2:5 rs1:5 100 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SRL RISCV 0000000 rs2:5 rs1:5 101 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SRA RISCV 0100000 rs2:5 rs1:5 101 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+OR RISCV 0000000 rs2:5 rs1:5 110 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+AND RISCV 0000000 rs2:5 rs1:5 111 rd:5 0110011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+LWU RISCV imm:12 rs1:5 110 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(4); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+LD RISCV imm:12 rs1:5 011 rd:5 0000011 \
+!constraints { greg($rd) && gbase($rs1); } \
+!memory { align(8); reg_plus_imm($rs1, sextract($imm, 12), $rd); }
+
+SD RISCV imm5:7 rs2:5 rs1:5 011 imm:5 0100011 \
+!constraints { greg($rs2) && gbase($rs1) && $rs2 != $rs1; } \
+!memory { align(8); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+SLLI RISCV 00000 sham5:7 rs1:5 001 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SRLI RISCV 00000 sham5:7 rs1:5 101 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SRAI RISCV 01000 sham5:7 rs1:5 101 rd:5 0010011 \
+!constraints { greg($rd) && greg($rs1); }
+
+ADDIW RISCV imm:12 rs1:5 000 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SLLIW RISCV 0000000 shamt:5 rs1:5 001 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SRLIW RISCV 0000000 shamt:5 rs1:5 101 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1); }
+
+SRAIW RISCV 0100000 shamt:5 rs1:5 101 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1); }
+
+ADDW RISCV 0000000 rs2:5 rs1:5 000 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SUBW RISCV 0100000 rs2:5 rs1:5 000 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SLLW RISCV 0000000 rs2:5 rs1:5 001 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SRLW RISCV 0000000 rs2:5 rs1:5 101 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
+
+SRAW RISCV 0100000 rs2:5 rs1:5 101 rd:5 0011011 \
+!constraints { greg($rd) && greg($rs1) && greg($rs2); }
-- 
2.23.0


