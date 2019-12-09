Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E90C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBEC2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rqNoPDJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBEC2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNeN-0003c0-FP
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaF-0006ce-S5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaE-00078c-JO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:35 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaE-00077f-B9; Mon, 09 Dec 2019 13:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915395; x=1607451395;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eDhmGY3IwRn13ta4fPcQvnOxJ2q4aLyJ5Tn0JitqhXs=;
 b=rqNoPDJb6/fcvp8Rb+rXK0oh8YS4r03CSX9AA9OOL++ZB4R+m9Ej6chW
 sg3JLadWv0rszaloBH8RPiNqoGg4b0iien2/JemfstdcnwxHODxWqlElN
 ieivGGuHiAvUfHhUUPF5Z3oSAMqVNGOSv6IccQAc2aQ+a5z12TZreNXZJ
 ZOoNLEY8ZDI2XOH6hSIau3VmGxIAUay8/7f/cf6VNoqrX9NHJ55sDDvHg
 WRWJLJMUAT9xh5LQ7tN8AUy1B2vbyYmiNpXr1vxAiIftOKPO+qFtCpMAk
 Py0SBRPy7DpLD8SDT9PJ456cLSKTud2hjMmIOuW7MYwIPCj9h85inlAh8 g==;
IronPort-SDR: Y/9Jhi9krwgk0CVXaEUcT3TnRzlAljEj5LPF1wm+rXWcI9lu+XTKihCA1U5bHRG9Gx8VnQi3eP
 2zgai5bvViw1l7iTHDQ8UdgXytzm51Mzcj64dH04VKHPCFbysT1+JJ2SC9CCeBcsQErLfq5FyV
 V27hYHhEKA2kjat323UtwdQUnTMGZok011p0j5B9LtOBT/aXYT832CUklnM7yuKwRnta2putS6
 fyG6ezMwM3Sm8TWg8IN+0ppBe8vFHmy8MSVuvEQQc6vZ9sPoe++BNJyHSRIfOqdNQvvo+4IPGJ
 25s=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="126543423"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:33 +0800
IronPort-SDR: YjzZ3zLMBoEBPELpbhOpEy6e8ExriUADxEqwlKsAX9EEkF5NImjAb6kaF/3ujZIWKZyyJDLc/0
 y5wbmTrSiVJD6TFiQucHgyTjhHSQTQbzqcerXzm77wj7cT6o3riblCoU3eZOaDJYvJI2IGh7g5
 75MQLJbt1kQI8VHgeTZ5dDl15lCAkfzaXjNbLDnOEqBqANtJlPtXa8YEJJFYOaeKERLTebgDPL
 YVt28g21/3m2iuIdlUc2p272sxXjuzUAwRXm/iRnly/XyRpogEmWQrdieWgEH0jN6cHHJtNALR
 OCc8562I5bRW76XpnvJUIWz6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:10 -0800
IronPort-SDR: C7Hk5aqiZDPXE19NgLHlo4Eaqimm74bsfCR5nA8Lae8SrvqWBPnDPzx3nDD6BgYa1mhkJglWLA
 npsd2vWTEl8lwEhDYrEP0AfX6WqC5WPvFjdSrkGLImeuKslo4MvgelpPGkzNIPEc7yyhS1Gsoe
 ouhbPnjKDmNqpAc+nv+0OJBW7C50wudHKQqixq37RoqoS4FXeQym+ayQXlSolGOxHSx+M6mKNm
 scaEPFU4v13Ys5cyrZ692GViKWlKMB82pRVkI9sSa4F4Uu03mntLM/a1mG3YEB6gKlM5S1R936
 0xk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:16:32 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 04/36] target/riscv: Add the Hypervisor CSRs to CPUState
Date: Mon,  9 Dec 2019 10:10:50 -0800
Message-Id: <4b2d4e889d460e27d8f674d110fd1561768cd035.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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

Add the Hypervisor CSRs to CPUState and at the same time (to avoid
bisect issues) update the CSR macros for the v0.5 Hyp spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      | 21 +++++++++++++++++++++
 target/riscv/cpu_bits.h | 34 +++++++++++++++++++++-------------
 target/riscv/gdbstub.c  | 11 ++++++-----
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 91e1c56fc4..bab938103d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -143,6 +143,27 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    /* Hypervisor CSRs */
+    target_ulong hstatus;
+    target_ulong hedeleg;
+    target_ulong hideleg;
+    target_ulong hcounteren;
+    target_ulong htval;
+    target_ulong htinst;
+    target_ulong hgatp;
+
+    /* Virtual CSRs */
+    target_ulong vsstatus;
+    target_ulong vstvec;
+    target_ulong vsscratch;
+    target_ulong vsepc;
+    target_ulong vscause;
+    target_ulong vstval;
+    target_ulong vsatp;
+
+    target_ulong mtval2;
+    target_ulong mtinst;
+
     target_ulong scounteren;
     target_ulong mcounteren;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e99834856c..25c0fb258d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -177,8 +177,14 @@
 #define CSR_HSTATUS         0x600
 #define CSR_HEDELEG         0x602
 #define CSR_HIDELEG         0x603
-#define CSR_HCOUNTERNEN     0x606
+#define CSR_HIE             0x604
+#define CSR_HCOUNTEREN      0x606
+#define CSR_HTVAL           0x643
+#define CSR_HIP             0x644
+#define CSR_HTINST          0x64A
 #define CSR_HGATP           0x680
+#define CSR_HTIMEDELTA      0x605
+#define CSR_HTIMEDELTAH     0x615
 
 #if defined(TARGET_RISCV32)
 #define HGATP_MODE           SATP32_MODE
@@ -191,6 +197,20 @@
 #define HGATP_PPN            SATP64_PPN
 #endif
 
+/* Virtual CSRs */
+#define CSR_VSSTATUS        0x200
+#define CSR_VSIE            0x204
+#define CSR_VSTVEC          0x205
+#define CSR_VSSCRATCH       0x240
+#define CSR_VSEPC           0x241
+#define CSR_VSCAUSE         0x242
+#define CSR_VSTVAL          0x243
+#define CSR_VSIP            0x244
+#define CSR_VSATP           0x280
+
+#define CSR_MTINST          0x34a
+#define CSR_MTVAL2          0x34b
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
@@ -313,17 +333,6 @@
 #define CSR_MHPMCOUNTER30H  0xb9e
 #define CSR_MHPMCOUNTER31H  0xb9f
 
-/* Legacy Hypervisor Trap Setup (priv v1.9.1) */
-#define CSR_HIE             0x204
-#define CSR_HTVEC           0x205
-
-/* Legacy Hypervisor Trap Handling (priv v1.9.1) */
-#define CSR_HSCRATCH        0x240
-#define CSR_HEPC            0x241
-#define CSR_HCAUSE          0x242
-#define CSR_HBADADDR        0x243
-#define CSR_HIP             0x244
-
 /* Legacy Machine Protection and Translation (priv v1.9.1) */
 #define CSR_MBASE           0x380
 #define CSR_MBOUND          0x381
@@ -400,7 +409,6 @@
 
 /* hstatus CSR bits */
 #define HSTATUS_SPRV         0x00000001
-#define HSTATUS_STL          0x00000040
 #define HSTATUS_SPV          0x00000080
 #define HSTATUS_SP2P         0x00000100
 #define HSTATUS_SP2V         0x00000200
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1a7947e019..6d606f0d90 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -130,6 +130,8 @@ static int csr_register_map[] = {
     CSR_MCAUSE,
     CSR_MTVAL,
     CSR_MIP,
+    CSR_MTINST,
+    CSR_MTVAL2,
     CSR_PMPCFG0,
     CSR_PMPCFG1,
     CSR_PMPCFG2,
@@ -252,12 +254,11 @@ static int csr_register_map[] = {
     CSR_HEDELEG,
     CSR_HIDELEG,
     CSR_HIE,
-    CSR_HTVEC,
-    CSR_HSCRATCH,
-    CSR_HEPC,
-    CSR_HCAUSE,
-    CSR_HBADADDR,
+    CSR_HCOUNTEREN,
+    CSR_HTVAL,
     CSR_HIP,
+    CSR_HTINST,
+    CSR_HGATP,
     CSR_MBASE,
     CSR_MBOUND,
     CSR_MIBASE,
-- 
2.24.0


