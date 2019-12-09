Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5CDC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34369207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mVZcxvIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34369207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNu3-0000yO-K4
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb5-0007nT-O2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb4-0007c0-CD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:27 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb4-0007bZ-41; Mon, 09 Dec 2019 13:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915464; x=1607451464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=44jGmFQL2cic0LiyfDT/EeQrmVYsruy8bDbw1ooEJ4s=;
 b=mVZcxvIC5sQHseMaIqc88pMb+irkyTiOYi+aOlh+ZKRaEIqo4/XXBq2z
 eGo9lx2y+r+OXxK1JVmU1tGp5unWeuu7UJlL4mI08ZbaR/TJNXFvYUgWh
 qgGraShsxsqtSzlY7f9C9bNhLJ6LJFXZquQaqMDfFCki3ws+ms+dA0+6T
 deeHI1G8CZFJa1YJvHjj4Acmid3aLLyYi/FyTPX2VY3hJ8i9Ngc0Ck362
 alLYL821Sas8a7XEC3ecNUAsnH5K0JRSjeeqcQFhuxA3rMUU1gS7age0N
 c5OICInEqBkeHpp/SHA2PLB6LCa5ckJhupyu/gfG/vyIpAqAIcRfBIfMC A==;
IronPort-SDR: hsJbW43E1q1FGF/l/PAPEtKxbsIO2wkhjAVpH0EPJP/EDercLdCrOTbuSb5kGxL8FmsXTt0hTw
 kNGZkfIbUBOHi8BbUJhPe1DXUDobzTOTJPbs4cW8VWlXt0t6chO+IrUBruE22NHKjTnu8Fu7yO
 raHANgcR6I5zSWfcwgV3jV3lxxAq8PrbyPvalr6FpU23kQdUdU7aqcLHw09b04iSzhOZdE5daP
 SH786KCJAXWBlliFRozp20HJ/wHwG3zgjHvY3bY9j4mV4OQAOqm0QGkNzeAEc6K1MmBkMs/QPn
 e5A=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412008"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:42 +0800
IronPort-SDR: BDIu5j/u++4ytw1L+/B9B1ZfiB1DRSdFf2wxbXHzKEByk0ADGN11RTprKD/QS3FWHex4jCapq9
 gNgXJFZboe/4NOEIMzW0uF7unf10BQcw/BwjFM2j4C/pXbEIdeMsZGbjHl0KT3+Pt95laIc1nD
 5s8ygT5wAvRD0A2Njq1ByRSu0obxzPk/ZdC43la5T99UpPQXJ4VfE24nXDOicyndJmEbGjWxP3
 oJF5z++rcY2/TOMGCP0t57aOpHww7kteUV9HzhU1esPlXddKi+prp5ONvpa1AD+0SQWX+gZbTX
 aXmCGS5TE4RZkKP6oQz6uGQJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:41 -0800
IronPort-SDR: ppJGiQd7137mQISy01xnhOYpxB8m4Ko8wmqTa88Ssttret9ytZP4VA2WO0atrrwYhK3ITZRsNa
 GBeQq9j3TfBf1RuFQ4SWqp7lwvscgB9+XmTdFKIMtHEmfUsmLEE+FhrUFSorDq6G4qkPQipm/b
 1wfl4L8zDkXqpleckEeJGsFCZQ8WVkp3OaW149hVRsNQJNwDWc2CQLqAXBThcrY1lvvzcDZZlu
 hSIr/LIBbtvIb5E53Dj6N9VtwVThmdYIvpRUDSU6KXrpHko4UgETDX2LCbIuNV/TTZlYysLVTk
 vuk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:25 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 24/36] target/riscv: Add Hypervisor trap return support
Date: Mon,  9 Dec 2019 10:11:43 -0800
Message-Id: <faf9c409cc227798dea7a03270311f942c3ea7ad.1575914822.git.alistair.francis@wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 66 ++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index beb34e705b..e5128570e6 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -73,6 +73,8 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
 
 target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
 {
+    target_ulong prev_priv, prev_virt, mstatus;
+
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -87,16 +89,46 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong mstatus = *env->mstatus;
-    target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
-    mstatus = set_field(mstatus,
-        env->priv_ver >= PRIV_VERSION_1_10_0 ?
-        MSTATUS_SIE : MSTATUS_UIE << prev_priv,
-        get_field(mstatus, MSTATUS_SPIE));
-    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
-    mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+    mstatus = *env->mstatus;
+
+    if (riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
+        /* We support Hypervisor extensions and virtulisation is disabled */
+        target_ulong hstatus = env->hstatus;
+
+        prev_priv = get_field(mstatus, MSTATUS_SPP);
+        prev_virt = get_field(hstatus, HSTATUS_SPV);
+
+        hstatus = set_field(hstatus, HSTATUS_SPV,
+                                 get_field(hstatus, HSTATUS_SP2V));
+        mstatus = set_field(mstatus, MSTATUS_SPP,
+                            get_field(hstatus, HSTATUS_SP2P));
+        hstatus = set_field(hstatus, HSTATUS_SP2V, 0);
+        hstatus = set_field(hstatus, HSTATUS_SP2P, 0);
+        mstatus = set_field(mstatus, SSTATUS_SIE,
+                            get_field(mstatus, SSTATUS_SPIE));
+        mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
+
+        *env->mstatus = mstatus;
+        env->hstatus = hstatus;
+
+        if (prev_virt) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_virt_enabled(env, prev_virt);
+    } else {
+        prev_priv = get_field(mstatus, MSTATUS_SPP);
+
+        mstatus = set_field(mstatus,
+            env->priv_ver >= PRIV_VERSION_1_10_0 ?
+            MSTATUS_SIE : MSTATUS_UIE << prev_priv,
+            get_field(mstatus, MSTATUS_SPIE));
+        mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
+        mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+        *env->mstatus = mstatus;
+    }
+
     riscv_cpu_set_mode(env, prev_priv);
-    *env->mstatus = mstatus;
 
     return retpc;
 }
@@ -114,14 +146,24 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
     target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_MPIE));
-    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
-    mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
-    riscv_cpu_set_mode(env, prev_priv);
+    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
+    mstatus = set_field(mstatus, MSTATUS_MPP, 0);
+    mstatus = set_field(mstatus, MSTATUS_MPV, 0);
     *env->mstatus = mstatus;
+    riscv_cpu_set_mode(env, prev_priv);
+
+    if (riscv_has_ext(env, RVH)) {
+        if (prev_virt) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_virt_enabled(env, prev_virt);
+    }
 
     return retpc;
 }
-- 
2.24.0


