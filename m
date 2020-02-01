Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E58C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EFB2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YWlssfJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EFB2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhJq-00061l-DU
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGr-0000b5-HK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGq-00068M-2o
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGp-00066c-QW; Fri, 31 Jan 2020 20:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519303; x=1612055303;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YRa6ARi8+mYcdsjZeYRg4ygWAjXx/YacYe2wA7JM02o=;
 b=YWlssfJwW2G63Z/ju549sd9KFWgpXV21PjV/Lf8XkHr2H6wrOdjQKQBr
 KgZsxk1sgz5JhFRs92K9mKBVl634UQqvREd0CSQIAosueYxPiULYZYqtL
 fB5EMHrK2F16iU7V7vQrXbPLdqXSEcqcW07P7COzJECUoIXtJaQjW1nec
 bcFsuP//89xhU//s54D1S/qOIAkJ1FlsAYg4Tx4BGYr/uxdRU0L9z7tFp
 NYoaSN4QTmDf0kzJc8Ly0hBhG4oOKUBHFoDEg260GPXdC+UGiz2Z6v2dY
 /PuDOMqhpSxAJ901scx6VnPfCadWw7TqCsnKj5dLhWyKBxa+4gtt/icoa Q==;
IronPort-SDR: uiOgO3H61nxndAssytoXePYCM/S+dYFJPNbJd0vbtuRvnsZr6J+QuGY4y+kSN6qj8V7RO8Fajs
 ChmAMI34ZQFUOElmTz32dwlzPBKvmPm+iRQ5FHISld2xsgEOv03Myn4O/6jMtbMGmPfa6t/kEY
 v19MSdiVHIUsjm0Y8FZ5Rq0WRy47AhXGASMEjS+Y2zk88ae9PMPSTEGVcsxtb+L6oIYXii1UDl
 gVGFJx7NWHPwOBbL7Ti5Clh/EfZ1BELtTD8cj4V/O8Fc5XAMT+lJQtHk3WQ5vNEUmiEoknYSTE
 gAY=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872402"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:22 +0800
IronPort-SDR: UpDMHeyob1j8UC4sv74HVVcjPf/XywpLuCGdctuRy3x3YVslTLwjXw4Shv0W+Xy4TLT2Md5okO
 yxHlNMTV2xqza2jOZjZ6c/qd+5aZHGSFKqqV1l77h6s1CflwqnYSMXZHDnSMzbUkc1M7Zzy9RC
 3GlSQTsnY3szt3VxqtiIizTiNekrZYa0MaMLfBTfrX4gGAvlP90OpAixuHpIkUXWO3s0NFCqM+
 z5xLuXWOod/XFSfewuIxvusyyikFOFZfBDzzYccXNQi3pVFwRxjC/unp8um0103J7cu19FrFxF
 uu0IP+kUgrslXULilfwLYTFw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:31 -0800
IronPort-SDR: dscKByiUP6t5mdmOW+gsHz2J9yzGw1XM2/RbnF/E22YFmUCJ3o8fwADVgpuzOpf2EQ1RK4jQGv
 EOEw4Iv5Xv2r/Egr8IGqSVOw7ZzgcH0t35Dv2waixtc/4moYEeAnc8puOBHj67WTrUavtHILC2
 PFRvHllH2yCXD0DbM/KtRPYmopp5SRlG+NXKQJi8nlz1Yig8RJHgMUtTexGE3uz7MfbBMWcoFp
 kpNcA2+1qHi79o2N2OFtltJF3duAWlWmafUZCPc5F+VvOQtAl9Q0/jSoI4wNXnuXEA/dq/Lbqw
 8fU=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:23 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 04/35] target/riscv: Add support for the new execption
 numbers
Date: Fri, 31 Jan 2020 17:01:46 -0800
Message-Id: <e22c9c800f00864238d7658cc76e03dbd952bdf4.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.c        |  8 ++++++++
 target/riscv/cpu_bits.h   | 35 +++++++++++++++++++----------------
 target/riscv/cpu_helper.c |  7 +++++--
 target/riscv/csr.c        |  7 +++++--
 4 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index efbd676edb..2f62f5ea19 100644
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
index b8e85d5b20..8f746fb06f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -526,13 +526,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     static const int ecall_cause_map[] = {
         [PRV_U] = RISCV_EXCP_U_ECALL,
         [PRV_S] = RISCV_EXCP_S_ECALL,
-        [PRV_H] = RISCV_EXCP_H_ECALL,
+        [PRV_H] = RISCV_EXCP_VS_ECALL,
         [PRV_M] = RISCV_EXCP_M_ECALL
     };
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
+        case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
+        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
+        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
         case RISCV_EXCP_INST_ADDR_MIS:
         case RISCV_EXCP_INST_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
@@ -554,7 +557,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
     }
 
-    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 16 ?
+    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 23 ?
         (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)");
 
     if (env->priv <= PRV_S &&
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e34c292c5..ca27359c7e 100644
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
2.25.0


