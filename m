Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C11EC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3F720838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3F720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3ai-0001tf-8h
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jU3XY-0004b0-Ev
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jU3W7-0006YN-G7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jU3W6-0006WW-Pu; Thu, 30 Apr 2020 03:21:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.704462-0.000721421-0.294816;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.HQfovas_1588231302; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HQfovas_1588231302) by smtp.aliyun-inc.com(10.147.40.7);
 Thu, 30 Apr 2020 15:21:43 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: peter.maydell@linaro.org
Subject: [RFC PATCH 1/8] riscv: Add RV64I instructions description
Date: Thu, 30 Apr 2020 15:21:32 +0800
Message-Id: <20200430072139.4602-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 03:21:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com, palmer@dabbelt.com,
 alistair23@gmail.com, alex.bennee@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 riscv64.risu | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 riscv64.risu

diff --git a/riscv64.risu b/riscv64.risu
new file mode 100644
index 0000000..98141ab
--- /dev/null
+++ b/riscv64.risu
@@ -0,0 +1,141 @@
+# Input file for risugen defining RISC-V instructions
+.mode riscv
+@RV64I
+
+# x2 stack pointer, x3 global pointer, x4 thread pointer
+# These registers should be reserved for signal handler.
+
+LUI RISCV imm:20 rd:5 0110111 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 }
+
+AUIPC RISCV imm:20 rd:5 0110111 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 }
+
+# Limit to current implementation, the base address register will be overide
+LB RISCV imm:12 rs1:5 000 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(1); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+LH RISCV imm:12 rs1:5 001 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(2); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+LW RISCV imm:12 rs1:5 010 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(4); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+LBU RISCV imm:12 rs1:5 100 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(1); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+LHU RISCV imm:12 rs1:5 101 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(2); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+SB RISCV imm5:7 rs2:5 rs1:5 000 imm:5 0100011 \
+!constraints { $rs1 != 0 && $rs1 != 2 && $rs1 !=3 && $rs1 != 4 && $rs2 != 2 } \
+!memory { align(1); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+SH RISCV imm5:7 rs2:5 rs1:5 001 imm:5 0100011 \
+!constraints { $rs1 != 0 && $rs1 != 2 && $rs1 !=3 && $rs1 != 4 && $rs2 != 2 } \
+!memory { align(2); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+SW RISCV imm5:7 rs2:5 rs1:5 010 imm:5 0100011 \
+!constraints { $rs1 != 0 && $rs1 != 2 && $rs1 !=3 && $rs1 != 4 && $rs2 != 2 } \
+!memory { align(4); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+ADDI RISCV imm:12 rs1:5 000 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SLTI RISCV imm:12 rs1:5 010 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SLTIU RISCV imm:12 rs1:5 011 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+XORI RISCV imm:12 rs1:5 100 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+ORI RISCV imm:12 rs1:5 110 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+ANDI RISCV imm:12 rs1:5 111 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+ADD RISCV 0000000 rs2:5 rs1:5 000 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+SUB RISCV 0100000 rs2:5 rs1:5 000 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+SLL RISCV 0000000 rs2:5 rs1:5 001 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+SLT RISCV 0000000 rs2:5 rs1:5 010 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+SLTU  RISCV 0000000 rs2:5 rs1:5 011 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+XOR RISCV 0000000 rs2:5 rs1:5 100 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+SRL RISCV 0000000 rs2:5 rs1:5 101 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+SRA RISCV 0100000 rs2:5 rs1:5 101 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+OR RISCV 0000000 rs2:5 rs1:5 110 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+AND RISCV 0000000 rs2:5 rs1:5 111 rd:5 0110011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 && $rs2 != 2 }
+
+LWU RISCV imm:12 rs1:5 110 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(4); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+LD RISCV imm:12 rs1:5 011 rd:5 0000011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 0 && $rs1 != 2 && $rs1 != 3 && $rs1 != 4 } \
+!memory { align(8); reg_plus_imm($rs1, sextract($imm, 12)); }
+
+SD RISCV imm5:7 rs2:5 rs1:5 011 imm:5 0100011 \
+!constraints { $rs1 != 0 && $rs1 != 2 && $rs1 !=3 && $rs1 != 4 && $rs2 != 2} \
+!memory { align(8); reg_plus_imm($rs1, sextract($imm5 << 5 | $imm, 12)); }
+
+SLLI RISCV 00000 sham5:7 rs1:5 001 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SRLI RISCV 00000 sham5:7 rs1:5 101 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SRAI RISCV 01000 sham5:7 rs1:5 101 rd:5 0010011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+ADDIW RISCV imm:12 rs1:5 000 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SLLIW RISCV 0000000 shamt:5 rs1:5 001 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SRLIW RISCV 0000000 shamt:5 rs1:5 101 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SRAIW RISCV 0100000 shamt:5 rs1:5 101 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+ADDW RISCV 0000000 rs2:5 rs1:5 000 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SUBW RISCV 0100000 rs2:5 rs1:5 000 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SLLW RISCV 0000000 rs2:5 rs1:5 001 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SRLW RISCV 0000000 rs2:5 rs1:5 101 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
+
+SRAW RISCV 0100000 rs2:5 rs1:5 101 rd:5 0011011 \
+!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }
-- 
2.23.0


