Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BAC76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE9A22BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C7IXwFEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE9A22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqiu6-0007pL-DF
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqita-000647-L6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitZ-0007oE-ET
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:55:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10276a3d6=alistair.francis@wdc.com>)
 id 1hqitZ-0007UQ-1Q; Thu, 25 Jul 2019 14:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564080917; x=1595616917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u00lN/Vscwx/F8PySPCI62Njf+0oQxoE3C2IhTaEmzE=;
 b=C7IXwFEa5Mspzb6ocsvfkrdBR493OaA8/RUsUE1/07SVn2+oyJ93Glp1
 Gnu9QS4vIHqkZi7Yx+qb6tl0/E9OtiiaDK4BzLy5txxFMea++HMZpcLsI
 +w7rt1WeH1ktxAVj9Y/oAs46egLbREqurAMp6GQvrB1lC9YuYCRQ9qZjd
 pTOhwCVHW4xd5CnrfM9SZSZX4kCLc7hvmNCjy4NcX8/FS/Fef/4f5qL/3
 34AUS5CoN+JozTF4JlL8FPqg742sDEtRnK0zv2hju5XYpDgxxBV/fPEGl
 qYObEi7fY1a3bPOSEDXyKZgd2LNGSIbvxIXIKkyEsVErnUMabai0POsND Q==;
IronPort-SDR: bUcIxTw8GVB6nAVbk1CML/2vsO735ZbeWP8XFqf8idaccJtCtSOPk5m0y3XXcJjmNf/lFAc3RM
 SzwRF8omRxKTOh36O/wYlR/GwHeZ/BPz1sTowzW4XXnN7iRcd0n9KuXHaKeQRXVCqZrqkSZDvz
 25sIXWHLOiCfkswX6i3oiRMoQQfFqu3yWFICLhRrPTdnYqvSQ2H587FrWbvAg6MzshOGw+Y14U
 jHYBdAlGvBTKZHSJSXnN/lS0xfuKuTMjvwTuzcuYQKk1rFeSZR/ppI4NGIq8CEW8YobRBQUSN5
 98I=
X-IronPort-AV: E=Sophos;i="5.64,307,1559491200"; d="scan'208";a="220533155"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 02:55:16 +0800
IronPort-SDR: 5u5P+dfHlTtuVgL3H+lAQ7y6cBYlBhPe35WYmZSE8wjIENclUrmeU42EHHXUnB5brMkQ9a69+u
 FvQt18W+1BwqpKNFuE19EgCg7yODXOLbth0f4bqzzDh82XTnMSaI9CofVgts/j6oKRl4xRyVUz
 7D8BU4+XNhCwx2loZC+pssb8FKNdndTbpd9SI8YFH4wKO6JCexRVtHY3fw04bQLBUmNWW0XoMr
 GgDMzQ6X8dyz5UKqldlg1wwkWASUdbyAWDnVheSNHirDOXl6ozf86uWbHPDHXABarA4SskHyC7
 6oim8wlG1gR+njKG6YMcbMla
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 25 Jul 2019 11:53:27 -0700
IronPort-SDR: q+bikiQR1S/9+EoqdJTPVwPhULlr1b3s96U0jojqqRiXdQNiQtq+Y88KYkyYTOG/4e7TbFfy2z
 BvZd9EsYwOQAHFXoTc+KORdVAGUFM25Yc1XFK8z4i4Yx3l7MnLdrq+5ILaiN+i5esPxPuRwPGj
 0Qs0ha+EKUnGxF+/fyr/z6WOAtZSjSNX16EyNp1vk9zO9yEtwzB5YXA1exQ8QXRrIvXty//Oba
 Mb7eD8AeqmWquGrahC2ku/QFkmXbArlqAUXlySJUfF74J2IVr21H6grBGeGAxqnytkl1mWKHWx
 myY=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Jul 2019 11:55:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 25 Jul 2019 11:52:11 -0700
Message-Id: <10db21dad60854653b7b6272a44a63e2473af2b0.1564080680.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564080680.git.alistair.francis@wdc.com>
References: <cover.1564080680.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH-4.2 v1 5/6] target/riscv: Update the Hypervisor
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
index 11f971ad5d..97b96c4e19 100644
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
+#define HGATP_ASID           SATP32_ASID
+#define HGATP_PPN            SATP32_PPN
+#endif
+#if defined(TARGET_RISCV64)
+#define HGATP_MODE           SATP64_MODE
+#define HGATP_ASID           SATP64_ASID
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


