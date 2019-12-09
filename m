Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89594C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A8B2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EuUhOFC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A8B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNo7-0001gy-1q
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNau-0007WJ-7k
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNat-0007Wd-3g
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNas-0007TS-Rq; Mon, 09 Dec 2019 13:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915434; x=1607451434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v0SO8nhyQkJ4xqraF/XgpsgRnhZWo2ZbF8AlFDAUc7Q=;
 b=EuUhOFC7G3SO29L+FYaQNPWf9ekEn3CDyiS/O0y2ie7HKsmONi7ugJ/H
 PphOTscmWQpL/9XUMXSHxBvIg5CggLDccOf1LfsnKC5LLLauv9ExlYs6I
 oAAj85er/euaYjccX00qvpOhezzICj3VcvoP++Mo+ORXFzRosqudsQVaY
 vIlNJPqQDhHbDuzqJBA4JItH/HHvKtadaqUTcVH1gWA/0uZYDtBIpvR3m
 1rlRJKM+evLswL5/C3D51eTvnzITpvaC29KuHxrwSQdZdj9/QR8tFtH91
 l8bm8drxrBTiddX1LNz3pYvKRkEEAwBRRSGzkmY30LH8QAOEN1E5Xau28 g==;
IronPort-SDR: 07bIPC2TpVzegfAgi0Clxguxf73NepppW7imBVUoK/0fkIzbq6ce0aaTLEfXVozqp/BV2Jckx4
 qlBIonJXprnNijeKXAmPum66o+32hD4XwtaSbsrLwbQg8GzgmOZ0qF8onCllEZAH/V9gqhuNp/
 gBliQkMYrofjaG/LGTKCz6MIzJ9YemeXj5Q5HWzhLqWh8BxiQloiyWG5YiqdkfcsLtzg0cNvwh
 T+NSH9J0sl7dJTbSWery+RA6C6ndWdOlGfmlBVO4bLZAAsJWn04MszviYs1KccVSrJIQYsHuCW
 q0k=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="232461563"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:14 +0800
IronPort-SDR: TwFpygT84fSMUGfmMnu+lOTdRNEdri6rsqAGfWr4iKG3lW/jVTDElFshkVANygtal3Axvc8ofz
 VtdE1fLD9OyKy8Fgsr8sNfMNQ8f2bhOMNH25AdTQhTX80Yw+AjrvQuDDDFvTn1UnEBEyWoG29X
 ba2jVV1vlwZhl3jGjhgQQIBcWoBENSZgxvXbfDL/D2l4ypBuFME1rk9rPfvrBPDwDRsNUWkuzF
 Vp4ouEGtEI1okd3/nWBCG8M77GYcmE9CZoTg4hMU2vcvg8zclsKcUqcM7XPDfEmISLfyswbXQ5
 cYlbrceYwPCmuGlhkmFUa3rj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:30 -0800
IronPort-SDR: 7A/zOgJVTSkd/z2pzxkFFk+exTdhfOu/YydyXWHkEBmjIpatF8MBv4wr4fQG1AcIwijyZq3ONY
 jcATmcuf8gMCKTAeLXcslvnDHtDZC/D1YoYlxbUV6Y7bY+34rMaRV63cYHPOM/JNG5qzRj5lXj
 +jhRBl0gnk3JX9NGqcDA//qzM5gaU7LLT1ptUzv4X/7rgUMQJk6deBBBUg165g33Bq01710Dvx
 53VsqjvxHOeSpn+9RPJpHxNEtlLf3wESaxCIBesviv0O0x8uIFDP3k27v0+eE+gCqHgPJru9WR
 EVI=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:15 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 20/36] target/riscv: Add support for virtual interrupt
 setting
Date: Mon,  9 Dec 2019 10:11:32 -0800
Message-Id: <2389483485d4642a6e5670e2546c62e493e91fd6.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 63439c9370..85eed5d885 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -37,13 +37,36 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 #ifndef CONFIG_USER_ONLY
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
+    target_ulong irqs;
+
     target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
-    target_ulong pending = env->mip & env->mie;
-    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
-    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
-    target_ulong irqs = (pending & ~env->mideleg & -mie) |
-                        (pending &  env->mideleg & -sie);
+    target_ulong hs_mstatus_sie = get_field(env->mstatus_novirt, MSTATUS_SIE);
+
+    target_ulong pending = env->mip & env->mie &
+                               ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    target_ulong vspending = (env->mip & env->mie &
+                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
+
+    target_ulong mie    = env->priv < PRV_M ||
+                          (env->priv == PRV_M && mstatus_mie);
+    target_ulong sie    = env->priv < PRV_S ||
+                          (env->priv == PRV_S && mstatus_sie);
+    target_ulong hs_sie = env->priv < PRV_S ||
+                          (env->priv == PRV_S && hs_mstatus_sie);
+
+    if (riscv_cpu_virt_enabled(env)) {
+        target_ulong pending_hs_irq = pending & -hs_sie;
+
+        if (pending_hs_irq) {
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+            return ctz64(pending_hs_irq);
+        }
+
+        pending = vspending;
+    }
+
+    irqs = (pending & ~env->mideleg & -mie) | (pending &  env->mideleg & -sie);
 
     if (irqs) {
         return ctz64(irqs); /* since non-zero */
-- 
2.24.0


