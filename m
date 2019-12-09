Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E96C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B96206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qXWmvw9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B96206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNeX-0003se-7i
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaJ-0006hC-4I
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaH-0007A9-QE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaH-000793-I0; Mon, 09 Dec 2019 13:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915412; x=1607451412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nCEFrGsdqSlTsNdZgJBvup6ug01DbicTleCFMlg1Qxs=;
 b=qXWmvw9ex2Tj3JPRzTxHTbhoaycZ+4hSJmpMBkEpBiBhbYz4A+6rsCZM
 EQFQd6Pr6KI/ERgVF+F1WVId1P7DO6MHQXB5bNKcCqfYu91J0LBsqrpRD
 70LcbPVrfhdA9eZVvA9WbRjYc0+8ltE7ZLiPwH50AWuEl9ufdYmarRARJ
 NzXIaoGur6fypbPpkuVv3UE1TETIysyiNHpEVXvRCP/sdfXO2lCDX2Lh0
 AS0G8Jfy2PJm6/yCHTRMIAONtd5kDMcy4IFTlcz9Jilsd+0y3/CXXLnzR
 DqILvc/vEHpmuLGN5cU/y8pX5s22LJ8L7Ea9+jXUo5vzcGnpzRAFnsz58 w==;
IronPort-SDR: 92HWrKpgf247kuj258tlApGrNF+95sR61Y4GiwpbuN8mE8J/pHWX4oMgQ5PLD7fOEmDtpKJYJk
 2GCBMDdsVTZv+3mEWQ1QmhccTXv7QU5URofn1TJlxQxd3FsB7FmJPMxiwKq3poQNnOtnUVYONX
 odMUej/Vg0F6lD1+lyHYN+wYcxVb4BPKBaoxsWnGmB0y3sLbh6NQZDulymoMSV8G1OiQTgSfA5
 NY4oZ07c+OJBmvoFLcTrBIixvQbMab/Pc1keqwNtOYQvWyTea7GsiQU32k5jxd9+0MVJNzsrh4
 kuQ=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226411917"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:49 +0800
IronPort-SDR: RjcUdjM5UXjGllbnnkdDX2KhM6jR15f9eKaxxpjm4mGz/tKvRZBUNhkZC1/DSbv0tZwiv0OXYP
 C1GYhttQbUiBTdXfHXNtnbBTEZH1acsTviyQCFoSuNpTA99zYZXwqw5pigOdj8WxAxrJhbdz1d
 faRX+3dVoanEgZK7hyQbWGdR0WRJIgjH5dkr34iLrw/th0Ptj1fNoox81bP4Juv2zIS0LpLhDR
 XzaspyrBEGgq7O7Ys/3xFjRTdbIcOr5x8Pww44e8bGD7WEvoJ363Pvz1J0xsEaht+M1o/28G5U
 O6n5eOEBEFb65kv483+Fd9gs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:51 -0800
IronPort-SDR: jPUcFI1bzEt5s+Osudjg2aj1bneOy35qUqB1Cg1HCtY/VcuQtl7iF/ZCUJBY9DLxTz2j3WjF8U
 8a/Uo40i+/TOy6N+fRdUVgYWaerPdfthR7hB9l1Oe97bzKZAL4xVAU+KS+tWcY3hY2mFIRmclh
 pC779u3SnpZIUpkCq35/2NuqL/fj5kWaxPNBh4Ss8MHM6NPp+NvOUXbOT02/+Cj8LMAPGlHZir
 m1Oi5LIyAcKQQsOl3mU83TYsreoq8m4hVPoZalwJvPE9Nd+UHCqHWSt9KBWOCdxehiOgz5jUEG
 nqo=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:36 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 05/36] target/riscv: Add support for the new execption
 numbers
Date: Mon,  9 Dec 2019 10:10:53 -0800
Message-Id: <1d461d2c750cf9e5573294b82d874b3823817c7e.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The v0.5 Hypervisor spec add new execption numbers, let's add support
for those.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  8 ++++++++
 target/riscv/cpu_bits.h   | 35 +++++++++++++++++++----------------
 target/riscv/cpu_helper.c |  7 +++++--
 target/riscv/csr.c        |  7 +++++--
 4 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e521ebe2e1..d23d2cba64 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -67,6 +67,14 @@ const char * const riscv_excp_names[] = {
     "load_page_fault",
     "reserved",
     "store_page_fault"
+    "reserved",
+    "reserved",
+    "reserved",
+    "reserved",
+    "guest_exec_page_fault",
+    "guest_load_page_fault",
+    "reserved",
+    "guest_store_page_fault"
 };
 
 const char * const riscv_intr_names[] = {
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 25c0fb258d..9ce73c36de 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -488,22 +488,25 @@
 #define DEFAULT_RSTVEC      0x1000
 
 /* Exception causes */
-#define EXCP_NONE                          -1 /* sentinel value */
-#define RISCV_EXCP_INST_ADDR_MIS           0x0
-#define RISCV_EXCP_INST_ACCESS_FAULT       0x1
-#define RISCV_EXCP_ILLEGAL_INST            0x2
-#define RISCV_EXCP_BREAKPOINT              0x3
-#define RISCV_EXCP_LOAD_ADDR_MIS           0x4
-#define RISCV_EXCP_LOAD_ACCESS_FAULT       0x5
-#define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
-#define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
-#define RISCV_EXCP_U_ECALL                 0x8
-#define RISCV_EXCP_S_ECALL                 0x9
-#define RISCV_EXCP_H_ECALL                 0xa
-#define RISCV_EXCP_M_ECALL                 0xb
-#define RISCV_EXCP_INST_PAGE_FAULT         0xc /* since: priv-1.10.0 */
-#define RISCV_EXCP_LOAD_PAGE_FAULT         0xd /* since: priv-1.10.0 */
-#define RISCV_EXCP_STORE_PAGE_FAULT        0xf /* since: priv-1.10.0 */
+#define EXCP_NONE                                -1 /* sentinel value */
+#define RISCV_EXCP_INST_ADDR_MIS                 0x0
+#define RISCV_EXCP_INST_ACCESS_FAULT             0x1
+#define RISCV_EXCP_ILLEGAL_INST                  0x2
+#define RISCV_EXCP_BREAKPOINT                    0x3
+#define RISCV_EXCP_LOAD_ADDR_MIS                 0x4
+#define RISCV_EXCP_LOAD_ACCESS_FAULT             0x5
+#define RISCV_EXCP_STORE_AMO_ADDR_MIS            0x6
+#define RISCV_EXCP_STORE_AMO_ACCESS_FAULT        0x7
+#define RISCV_EXCP_U_ECALL                       0x8
+#define RISCV_EXCP_S_ECALL                      0x9
+#define RISCV_EXCP_VS_ECALL                      0xa
+#define RISCV_EXCP_M_ECALL                       0xb
+#define RISCV_EXCP_INST_PAGE_FAULT               0xc /* since: priv-1.10.0 */
+#define RISCV_EXCP_LOAD_PAGE_FAULT               0xd /* since: priv-1.10.0 */
+#define RISCV_EXCP_STORE_PAGE_FAULT              0xf /* since: priv-1.10.0 */
+#define RISCV_EXCP_INST_GUEST_PAGE_FAULT         0x14
+#define RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT       0x15
+#define RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT  0x17
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0de3a468eb..c201919c54 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -526,7 +526,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     static const int ecall_cause_map[] = {
         [PRV_U] = RISCV_EXCP_U_ECALL,
         [PRV_S] = RISCV_EXCP_S_ECALL,
-        [PRV_H] = RISCV_EXCP_H_ECALL,
+        [PRV_H] = RISCV_EXCP_VS_ECALL,
         [PRV_M] = RISCV_EXCP_M_ECALL
     };
 
@@ -542,6 +542,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_INST_PAGE_FAULT:
         case RISCV_EXCP_LOAD_PAGE_FAULT:
         case RISCV_EXCP_STORE_PAGE_FAULT:
+        case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
+        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
+        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
             tval = env->badaddr;
             break;
         default:
@@ -554,7 +557,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
     }
 
-    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 16 ?
+    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 23 ?
         (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)");
 
     if (env->priv <= PRV_S &&
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f0b1..6a0a59edfd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -242,11 +242,14 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT)) |
     (1ULL << (RISCV_EXCP_U_ECALL)) |
     (1ULL << (RISCV_EXCP_S_ECALL)) |
-    (1ULL << (RISCV_EXCP_H_ECALL)) |
+    (1ULL << (RISCV_EXCP_VS_ECALL)) |
     (1ULL << (RISCV_EXCP_M_ECALL)) |
     (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) |
     (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) |
-    (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT));
+    (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) |
+    (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) |
+    (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) |
+    (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT));
 static const target_ulong sstatus_v1_9_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_SD;
-- 
2.24.0


