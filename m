Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50925C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB03208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dxtlUfDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB03208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzxB-0006Wk-BA
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFu-0002yj-9y; Fri, 23 Oct 2020 11:45:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFl-0003kI-3e; Fri, 23 Oct 2020 11:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467917; x=1635003917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O3sfZ2KzydHNy1g6w/eUT+Fc1jPN29GudGPR1+ohh/U=;
 b=dxtlUfDRhzlP8GEip96j4Vh9GQB4wOErBIqSF3B5ZXlML4Ezb7h6345P
 bNII8BkO+VjNpwwJN444q4IhHmNwzTX1NGhe96/WjxTKlLzmNxXc8pH0b
 V31oE8MyMNeKcVVRMfBSsFLStjqIR/xT3x3bV/pSajJJ90+JJomyUO07L
 jv51hta6MBdaenKowzuJRRaGR+o7pA/juwv00IKt9jIyIsNxVP30JlLJp
 gJtpHwwbKmSyu7t5F7cj4+XCeDvSoVb+6XJmA00ac934jkyqdivmrMFKf
 xOmqeljogFG5sTEi7NoLFapOAMUO6HTkYyrqhvUJUhfLZOBd0CL7+Rjc4 g==;
IronPort-SDR: UUC7FZCjz5revNemiNGnSEhq9GIOHN4ZvubZIKpERdb4mK9iC8JoBI6L04qVNtvKZ+B+BPmFu6
 4BXgkqg0MzccNvys51eaEZ4UB6iYi8baCjoEoxqRy19yxnSvZ5h9zacfjz948SrR6sWN+DY8VC
 RQlizlGqbbKC4HhRiAgwb2wLv154LVy9/S+8b70YNCjAwxxoae+vjNjGnSIPzClRyBVDqPSV1L
 gGce3pCjsIQzRn207Bk/Wyjbn4pOx2Fiea/Q+B31Ax3d9N9nOkBjK9iSt+eKJvJa55Y9Rnsuuv
 aC4=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="151960178"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:45:15 +0800
IronPort-SDR: zkVkEUPiNQ5aiYWrclyzHCLRTCFm7ijOUva5nqNJc3pLsa2XTjzCvNu04gmdP1cip44/+gGYnN
 VrPWxnnsr6l2V76jb/Dex0rH0ISID4tl1GA7UHYfv+AI09KV0+wn3yK/S1E8JkQpU197p8bVYy
 QUhfJuq2Ut/1abVfJl/cw7cRXDAwJXzpSojPAgAM5g5gayNQ266N4INSydmyJ4irjPYeIpWvKs
 Clld3YAdBPeI8PKLO400LWLM2BpYKasSgHQUI56rlij6zp23woUVsEtaczWUee0Q++4yzE/J9F
 pzFz/ImBqrEeODpHWMxbHvk5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:37 -0700
IronPort-SDR: mhye8snEVw+tCpwrYf2DWCtoGdjkDEukkz9JFm1qRmwELw1v0BuG/d2UlTr2bQCNFK4xhLhkfu
 bZtyGYkspua8IoruSWxf325mUXi8nTtlzschfNd4I5JpWUZE02QYCUCOQ5bgxSLdLAr+PqZ2xP
 5vQj0CGRGPRT1fGA9DatBT2VgTlBIMTk79IwuXChnssIVI1gXSG68agxV8+EciyZO9M+4wG7Z6
 B/aRDMpZoGRw2y7x04uwYPfFByXmwpiqY3ClCT5gEqaf6VBRG40ewdNLrim8pINOx7HddQwCxp
 O00=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:45:15 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 15/16] target/riscv: Convert the get/set_field() to support
 64-bit values
Date: Fri, 23 Oct 2020 08:33:54 -0700
Message-Id: <b1d3b41c49c5c7373ffde9908ffd340731807d13.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:34
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the get_field() and set_field() macros to work on 64-bit values
even on 32-bit RISC-V.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index d9ad694b3f..db46739b1c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -4,10 +4,10 @@
 #define TARGET_RISCV_CPU_BITS_H
 
 #define get_field(reg, mask) (((reg) & \
-                 (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
-#define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
-                 (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
-                 (target_ulong)(mask)))
+                 (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
+#define set_field(reg, mask, val) (((reg) & ~(uint64_t)(mask)) | \
+                 (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
+                 (uint64_t)(mask)))
 
 /* Floating point round mode */
 #define FSR_RD_SHIFT        5
-- 
2.28.0


