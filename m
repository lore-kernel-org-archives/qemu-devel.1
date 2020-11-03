Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95108C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1471920735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BJnPBrZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1471920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyLV-0003MU-3J
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJT-0001Vg-0k
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:35 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJO-0001FT-L0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417611; x=1635953611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cMeZtoj9DB4HkpjRauvIaJM+wOrM0RhLa9f8ywoWSAE=;
 b=BJnPBrZVcQVcxeZbrUQHpA8onZ6cN28wYQSSVzYWBGRqr3PPzE5rNyK8
 Gv3Bqz89e1HqA6NvzDLmC2Qw/y0Gz2dOTgyh+SpXkYRz9R4oiWExBQ7kg
 mRyeD6aNeBnPKIfcfpMz23Sh7CRfOIwytBrqRv6qoRx65KBRKKVoHJnc9
 EXgfBDP949CFFPl/aV0mpXSL4/vxgp44xT8T+VW1K8PSplEUb2q35ZQyI
 Y2DsQtmChre14sveEAiqfhlXnFxOvKxrIEYvmID78pHX6LwflTwwWfEYR
 6m5Lv0vtAJoDcI75j66X2NEqFL7SSSR7VWqryLQLAYljiess9wi1v+mq8 A==;
IronPort-SDR: YUQElEpCtaL2lBp9fZ9Hs+aDVZB4/uHCMPcUvEJ61BwaHr089c+PppaSVNRZBcxxK0rf4/Hphv
 ri/pQ++yP3Cfw20ySKTzyIcVydTsalqzV6hBhqF4QQeKUn+6nCuZp2iWffCIgWlXj+LWZI0SVl
 1qwY+UlmOerC+NVrwwzyeKYZHjr+voJFL2U3J+1b/XhLNyGqsLLls8t4xOs3rdsXtZdomc5sq+
 UXmciehh0Ws+0/Ac4XHwJeEZIk0gsyMwmRXqc+9NBu2ubuEH1K67qfFoT9kkrhcCQOB3KDm4zW
 31g=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867455"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:24 +0800
IronPort-SDR: jNK5cTJTu7bM4AVRQIjLK5ik8VyjEoJog9YBWejKKn1lLa/3+9/watmV4+pQ+E1hNWbicrOJjg
 r341CFVYJKNLswg1eucJE+aItT0ZEQ+As0Z9lD0ESXyfmnTo6HW/bKGAaO/PVajjl0aahYl68h
 oZjCVTXwL5T4Qs6tmR8miOqE4x0FfjTK8w/DhLjFqFsJwqfFctSgJkDNXscH30FXb7qdJ6tfSy
 JVrgrLQ8vuUdNRWSw/fccBg+VPXC4hgcgL32GQ7CVkDoGXVdbCuvPkWsGrGZ+Nto7GEAzQkkQ3
 /s1LfhBWWmNXImDUm/ST0ADk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:33 -0800
IronPort-SDR: chYPQj2SrOYmYMZYFMEHHCc0hg92fTGAoBhlXHngo/w0uj3JD89H+mSgoE87NdDGzJRy4v9OSq
 bZTD6/5/G+uRcRRM6TRLcbNvj+4/GGAOWbbKzpfs5exkaW3P0xp0R5CxFbJ3PmxgFd6O8hoNQm
 efFbThapH7FoPYW39An6GyZ7yRhsoMhK1IvsVbtCyafRoLH+CxpArUHM39lltykkKFqX4kFmnZ
 zdC0ily8Aqa40Av2Vqi1JZkikyKc1kqqfDEyUOCs6fYJCnxaaeBrC/IToov7nxkDYsUGqrHaCs
 8wM=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:25 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 04/19] target/riscv: Add basic vmstate description of CPU
Date: Tue,  3 Nov 2020 07:21:35 -0800
Message-Id: <20201103152150.2677566-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

Add basic CPU state description to the newly created machine.c

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201026115530.304-3-jiangyifei@huawei.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h |  4 +++
 target/riscv/cpu.c       |  8 +----
 target/riscv/machine.c   | 74 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |  3 +-
 4 files changed, 81 insertions(+), 8 deletions(-)
 create mode 100644 target/riscv/machine.c

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f1a546dba6..b15ad394bb 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -38,6 +38,10 @@ target_ulong fclass_d(uint64_t frs1);
 #define SEW32 2
 #define SEW64 3
 
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_riscv_cpu;
+#endif
+
 static inline uint64_t nanbox_s(float32 f)
 {
     return f | MAKE_64BIT_MASK(32, 32);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dd05a220c7..6a0264fc6b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "internals.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -498,13 +499,6 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
 
-#ifndef CONFIG_USER_ONLY
-static const VMStateDescription vmstate_riscv_cpu = {
-    .name = "cpu",
-    .unmigratable = 1,
-};
-#endif
-
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
     DEFINE_PROP_BOOL("e", RISCVCPU, cfg.ext_e, false),
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
new file mode 100644
index 0000000000..32edbcba7c
--- /dev/null
+++ b/target/riscv/machine.c
@@ -0,0 +1,74 @@
+/*
+ * RISC-V VMState Description
+ *
+ * Copyright (c) 2020 Huawei Technologies Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "migration/cpu.h"
+
+const VMStateDescription vmstate_riscv_cpu = {
+    .name = "cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
+        VMSTATE_UINTTL(env.pc, RISCVCPU),
+        VMSTATE_UINTTL(env.load_res, RISCVCPU),
+        VMSTATE_UINTTL(env.load_val, RISCVCPU),
+        VMSTATE_UINTTL(env.frm, RISCVCPU),
+        VMSTATE_UINTTL(env.badaddr, RISCVCPU),
+        VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
+        VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
+        VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
+        VMSTATE_UINTTL(env.misa, RISCVCPU),
+        VMSTATE_UINTTL(env.misa_mask, RISCVCPU),
+        VMSTATE_UINT32(env.features, RISCVCPU),
+        VMSTATE_UINTTL(env.priv, RISCVCPU),
+        VMSTATE_UINTTL(env.virt, RISCVCPU),
+        VMSTATE_UINTTL(env.resetvec, RISCVCPU),
+        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
+        VMSTATE_UINT64(env.mstatus, RISCVCPU),
+        VMSTATE_UINTTL(env.mip, RISCVCPU),
+        VMSTATE_UINT32(env.miclaim, RISCVCPU),
+        VMSTATE_UINTTL(env.mie, RISCVCPU),
+        VMSTATE_UINTTL(env.mideleg, RISCVCPU),
+        VMSTATE_UINTTL(env.sptbr, RISCVCPU),
+        VMSTATE_UINTTL(env.satp, RISCVCPU),
+        VMSTATE_UINTTL(env.sbadaddr, RISCVCPU),
+        VMSTATE_UINTTL(env.mbadaddr, RISCVCPU),
+        VMSTATE_UINTTL(env.medeleg, RISCVCPU),
+        VMSTATE_UINTTL(env.stvec, RISCVCPU),
+        VMSTATE_UINTTL(env.sepc, RISCVCPU),
+        VMSTATE_UINTTL(env.scause, RISCVCPU),
+        VMSTATE_UINTTL(env.mtvec, RISCVCPU),
+        VMSTATE_UINTTL(env.mepc, RISCVCPU),
+        VMSTATE_UINTTL(env.mcause, RISCVCPU),
+        VMSTATE_UINTTL(env.mtval, RISCVCPU),
+        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.sscratch, RISCVCPU),
+        VMSTATE_UINTTL(env.mscratch, RISCVCPU),
+        VMSTATE_UINT64(env.mfromhost, RISCVCPU),
+        VMSTATE_UINT64(env.mtohost, RISCVCPU),
+        VMSTATE_UINT64(env.timecmp, RISCVCPU),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index abd647fea1..14a5c62dac 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -27,7 +27,8 @@ riscv_ss.add(files(
 riscv_softmmu_ss = ss.source_set()
 riscv_softmmu_ss.add(files(
   'pmp.c',
-  'monitor.c'
+  'monitor.c',
+  'machine.c'
 ))
 
 target_arch += {'riscv': riscv_ss}
-- 
2.28.0


