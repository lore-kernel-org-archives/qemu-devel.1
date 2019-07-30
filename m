Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A96C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59709205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SWM/25lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59709205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbkN-0000l1-Lb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58806)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhf-0005ga-Ov
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhe-0002EB-Nv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhc-00025U-CU; Tue, 30 Jul 2019 19:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564529924; x=1596065924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QZpfN+9MLyliw63TCQlK8Hfjlr2GhFEuBVQNAdzVumM=;
 b=SWM/25lYdALfCoADTdbVyHfXXhbFz4KTCGR7GF8+3VHaQZDE6fj8cPeJ
 u3C08wRVvu4FKkznxjAQYro0u58kf3BI5NhHe7H1fs5EA+HdajGe8+qOr
 I84KhriWdhLTNO7kjSl9+GRpTl9BQptAb5evK7gjO2OLvIuUxnukxEB7H
 6UpiWHkk1uiDPB1BSVCG/A2Sj6xvcIw9JzAqzxpUgOo80plZB5xC32Znq
 v2bm6/Wj63hSzkw9Ba+QXehVzZ6t8y5BDiVtJpPfWbDu8BilqSyUYmiAi
 QtA+usUxNzTFPCPqdSw3qU6MKb8lTi/UG6bHzWI4j1aYYMadGRzZS/qcz Q==;
IronPort-SDR: Hd1EhEaHb2BChgED1CtCZmxz2D6Q25pb5BvoGZ58vdovQFmqx5y66GFYiFGK5UnB5iefiXxZoV
 tFM0WStZuKT7Vp9HctKjmweigmqhEzFsx6ToC3sGSvW86pf0Hiy0sZL/e2/TcXUSTyLYRLgNNr
 36T1vA/KcnTrN6xpnL3y9XmHpEQQ0aOpFd7ieV1KX8AeD5Y1P88+uVutDSnFsAsd2RwM7GNN+C
 PdD1zp8A6JHmGfzMRW+UaNjF2Yd0VOOkW7Z1XZbjUA8tpQ51Pt6XRJMNdfOEdghh51SlmHDCDY
 QZg=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; d="scan'208";a="221001699"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 07:38:40 +0800
IronPort-SDR: T2f4+Wh4QL5VAJVQndHzLgbg5tqOjcUF/0q649LA+k0Eo0HzDazrZr5rBRwmKu4MyUuXtgEBtH
 OHNC/6wHdqGngLPuFhofkLBcezOQ0rYELHQCxt46FmQ0PuHEg6qBve5sT+CbyVR+QdNuZJwZ5G
 +ErmvKhVTLxY4cLL9+4uBPXMJoRVOtsLbramd5BGOPqd0btnpwJuE4lvb3+tXlMmVzuUSGm/D2
 K+OqkcN/88kao6RUvvgLqwAerLBkh9HW6nCKR2MDQAlq+Ww2gH7adErbpaub+jl2ZYfoxZPCp6
 z6HA0jDGimZN4PA3DsLrPPwd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 30 Jul 2019 16:36:41 -0700
IronPort-SDR: KlqEXsXsswSxrqLF5MB8YuJB7fNQUmkXGCEw7y+bcG3OiiveXWyDUciae6ywRbY3pWv5doyreS
 SUMhkinB5a+wWlMgKfcjyb6DsUHL3TIgCfwIYSJFf6+Mj5CPsbuv8wDIVZHoYdAeGjZVtJl+gV
 zP9SS773Y58zAi1NiLrxKEd6D18+0i3uWz4vSJFMlLsGzvHWU65mNLwycmfrV2UTTYsgIItwk/
 41Oahi7dTOb45m7LlwStyva+meaY/p65xsZc6DYOPq5IJlfCFAOXtWSG5iHBa3vTEwvzl3U86N
 SQ4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Jul 2019 16:38:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 30 Jul 2019 16:35:32 -0700
Message-Id: <dc666f1d37590b76d66415941bc24fe5a7cb46b4.1564529681.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564529681.git.alistair.francis@wdc.com>
References: <cover.1564529681.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH-4.2 v2 4/5] target/riscv: Update the Hypervisor
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the Hypervisor CSR addresses to match the v0.4 spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


