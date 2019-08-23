Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C45C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557C521848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fzW9C2t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557C521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BT3-000411-U6
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQx-0001gb-6i
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQw-00008Z-5G
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:24:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BQv-00006k-Qy; Fri, 23 Aug 2019 11:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566573898; x=1598109898;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iTOWHLEw0bbhWGN9g//sIyITc6JGe0udKgWEP4MPj3w=;
 b=fzW9C2t79H1gR/Bi+l3ldTMNy8HKmz0rPjsRTOl8N7gqbbnzqDesv9yn
 lNit5h6sGKPO8grOBjVOq833eS3IWk8guDutADlYAx6iz4EskKb1xb7hJ
 ryYm35Yxt0oYSPK/+hRLnoUEuuqe2xtz1goZUhPyG2M89VC9B4DMwqlOK
 XQtDA79mjp7zgXn6WWfCB4qhd5zZK4N7IXLYhgHvxo8onh5+Ktd8ZL+G3
 PzZgsEb5bcUoxmM/BmH1/I+JwPi27N6Rway899VKP80Z6RupQQFuPy5GM
 /JMjp5h548Xc69wLndIIDWyiSahFWhpbZNglR9pYumwzBzbGM76rkuiLF A==;
IronPort-SDR: 3FZt9nrxNGt5Uk3kXmB+4000IbEW1GmyUB9QVFrNafKzI6kA/BfxI/CEO9fUdD5kkUC6SRjbgD
 2zTsnIAEB7YHKcLVlJmllrlbNQm7UFrXV1Sv76yxAQC4A8w5XqaCy1QBRjMAGhfhnRnuVKihcv
 Z/xaNCZDXAVgV+VLbO4F1hngq6dIhX11f69BXAf/ozk9tUQT2fM/7sYVhWqNlQrNv16KzrCJBF
 b1xpKQ2qYEF6pCDXg1P4wCL8NipokI5yaEgMel5/1/yLPEI7PYNM3wPkkxM0BM1KJf4Y8T/pFs
 5VM=
X-IronPort-AV: E=Sophos;i="5.64,421,1559491200"; d="scan'208";a="121112427"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 23:24:57 +0800
IronPort-SDR: ordmkUUW1nLFCu43lvN4c08vykgHKsgb0pQeX7zNT1r31cJU3Kbb7CYfvS5Oz3Xif94PtFBd7n
 xIUQaiBYiKBXGTzByfrgwggIhg8YpnJ7KJK/+zFN7v6UIno0La14r7Nm8nTAjESP1o97rbI3Tk
 sMK+BxuW/tYuM5etB+nghyR/COQ1F5oz2Zxq4q2FxHEXixMlvGud0rpk0/metIWRZrW4dxbjIL
 j1N3jgBdLOT07+hIl+AsA6Meydjc7s5xYTwXtFJdq+8mZMenxTyL+M1X4tJ5B6l2lXj9Au9LFl
 vYFhRO20ipuCLidQra+0tKmG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:22:14 -0700
IronPort-SDR: zQpO8CTzi/+ja/ITBErAb+ppkvtdaXgF5vmDmyUkJ0gXcHVQav1pIvcob9+5p0QULwAS8X5eAX
 8an9FIImIcutgo8hB2fvp3eQ5cRe0fJw5uhItJ9lTXFt7MCgCJ9kIdCktVJjkpJ/TAAIYPtBBS
 JSSf8ZK69y4xOyy+SzerrV/z5RIscTWROCn6i4j8e1sBGnkdTh7rfUUgm2IVPbsgZjcj+pznEs
 xgF6NHk+Z92GScsZoCDmYb3el12goceVYPSeMKy3vMb8jUFqX9QVtgCtCJOg+FKwVN5NGSGDZ2
 ABU=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 08:24:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 08:21:17 -0700
Message-Id: <10379ff923d36b17dcca0a9ef6c0599b346106be.1566573576.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566573576.git.alistair.francis@wdc.com>
References: <cover.1566573576.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v4 4/7] target/riscv: Update the Hypervisor
 CSRs to v0.4
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the Hypervisor CSR addresses to match the v0.4 spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 target/riscv/cpu_bits.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 11f971ad5d..e99834856c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -173,6 +173,24 @@
 #define CSR_SPTBR           0x180
 #define CSR_SATP            0x180
 
+/* Hpervisor CSRs */
+#define CSR_HSTATUS         0x600
+#define CSR_HEDELEG         0x602
+#define CSR_HIDELEG         0x603
+#define CSR_HCOUNTERNEN     0x606
+#define CSR_HGATP           0x680
+
+#if defined(TARGET_RISCV32)
+#define HGATP_MODE           SATP32_MODE
+#define HGATP_VMID           SATP32_ASID
+#define HGATP_PPN            SATP32_PPN
+#endif
+#if defined(TARGET_RISCV64)
+#define HGATP_MODE           SATP64_MODE
+#define HGATP_VMID           SATP64_ASID
+#define HGATP_PPN            SATP64_PPN
+#endif
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
@@ -206,23 +224,6 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
-/* Hpervisor CSRs */
-#define CSR_HSTATUS         0xa00
-#define CSR_HEDELEG         0xa02
-#define CSR_HIDELEG         0xa03
-#define CSR_HGATP           0xa80
-
-#if defined(TARGET_RISCV32)
-#define HGATP_MODE           SATP32_MODE
-#define HGATP_ASID           SATP32_ASID
-#define HGATP_PPN            SATP32_PPN
-#endif
-#if defined(TARGET_RISCV64)
-#define HGATP_MODE           SATP64_MODE
-#define HGATP_ASID           SATP64_ASID
-#define HGATP_PPN            SATP64_PPN
-#endif
-
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.22.0


