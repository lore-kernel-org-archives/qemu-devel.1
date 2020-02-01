Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC7C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087102063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MdPskFEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087102063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhHw-0002Xd-5E
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGq-0000ZB-QF
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGp-000686-GH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGp-00066c-80; Fri, 31 Jan 2020 20:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519302; x=1612055302;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PFUcfA2x+6lUqaouFEAXoIoEkXt+TZqzgYDrm1X6fb4=;
 b=MdPskFEC29j+5g6QLtV+tQ3X3Z7DKkKefOAXrTsgaBpWWbIIXv9YXein
 7YT4VgqAQYiZP7SkOLJIyCmrTUA3zqgzAaWcgWgFLEgwR2uAlg+hRLKNE
 Y/iX8xyfPCUD57y1d79b7elJgJtyXS53IT157RKMKQLLTqmJyvPqQtTrQ
 /+B1pPw96PGrc2tA/cGJGQ07Nm0lqLVpNcT+7Tn3oCucV76D2/g1ist34
 hTgh7DqLjlov1TkozbeivKU/CDFiRw3WpHCoJUuqwdy5tFIR1V4whgXIa
 lEdH1ZB70BDaUP1g+UzLIkit2orDcfa8Pt/SVUkCut4jL+UdLGY5mQjCM A==;
IronPort-SDR: pwq8Jv+GB0RM+rwA8FSYaH80m8cvC/R1g+vOoHsHvu9YuYc6S2YtuGxOobviogGonNtwZbAvk+
 Jhu0p/HM8dy477bMTY5GJFd4+ZaGECx2ZW78JSk9ft3DV+LU9HymJAPGaJja25I1Qfa5aLKgyk
 5h/whIBUMZLHGvr0akxwTnrNs7xn7BYJjn6dAiIPx/qFVWjuAhSmwTqRExfVU6TveVHo/m+GH0
 TXRwNCKmnDxxSyf20rybriiT8/RrR0T7IufC3rDSUs5XUb6OAsB4WPk42YHWR16zS+kztn49GH
 +yQ=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:20 +0800
IronPort-SDR: Ok01ic0NyNw21MFep9Y+vY0s6AkpXZwU56MkK5rbQoPLwxrlLiwpBpkIhr4wYjM8MDC6viioDZ
 6JmECJ3/n2D2M13WRhWQlwLcaYUmDxvaoebtQ/csFxfq/iA+Jm0bxomlm0CDYCHr+bVIN5RwIn
 elyC4GBvbLcKFUOlUtrb2wDoFMF73oBaLu4gvBPuuzLmoddvvV2fz9Ocu81SZTlKohwvR9+tXX
 M622CyVAMxI0gaoZw7UgYbVfw30i6az9iFzCCOcQ9BNLRXcrT3Fhn5HimMo0FNthR+Tw7ZuUCx
 +qPcMIyGjPmEHNbuj2mRNbIX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:28 -0800
IronPort-SDR: eoiuZaOSYq8zC4xZfiNxdcFi4Ym43oq4rJSBwdE71IMUKv7OxUwoEis5lfuMEIcq5Pz0nNEomb
 V+WAvjHoSLYSF9HVG8O4npBd/l+tJSe3kabEYNOhVcyDIeRHZYTHCXyl1z2zEL+B+1+O/QsbWs
 Ii3nMUqycPLs8VAdpsGGYPduDYr4Mk31h2Znj2u/aamTYOEL/fClFv7Z/orMXTDqB0JG9vAacN
 g6NAKSQxHTMrP593NL99p/07h/vZybEHVP0Y8mrK7WyyyXcXEcKhHOYujvzLWsk/JnlHyBIhhV
 MxY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:20 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 03/35] target/riscv: Add the Hypervisor CSRs to CPUState
Date: Fri, 31 Jan 2020 17:01:43 -0800
Message-Id: <5e15673b88378ed4a7d6c2d53932f1486cb61dfd.1580518859.git.alistair.francis@wdc.com>
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

Add the Hypervisor CSRs to CPUState and at the same time (to avoid
bisect issues) update the CSR macros for the v0.5 Hyp spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h      | 21 +++++++++++++++++++++
 target/riscv/cpu_bits.h | 34 +++++++++++++++++++++-------------
 target/riscv/gdbstub.c  | 11 ++++++-----
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 010125efd6..c7f7ae5c38 100644
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
2.25.0


