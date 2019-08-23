Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4294B206BA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EppwWF1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4294B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JWI-0004kK-01
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCG-00011z-0u
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCC-0000Fv-Nj
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCB-0000FW-KU; Fri, 23 Aug 2019 19:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603779; x=1598139779;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+y0XBZHdU8b0WbXdYJMfk8x+pHSNEF+3XHeTA/blqYc=;
 b=EppwWF1b2lzbUeVbEIV2F9lJnGlzG7iv998oBQmK4bRGfKDtXyPUAirY
 n+7XKq+cFH2IvOIJjCPJYuP1cajOt4zZokkve4SJLbUHCx4/OQGe2qGEr
 WHoOBNA6s6mFv1M4Z/jEtYMsLCFfMOVGYir9RFO8Fin0nHFC+GX1/pQZL
 p9XD3q7Xufsua3EkynXTeAUMgeGjBDa3oifJ8DyOS5kcEMa5/cmVjdi/N
 eA0sX6+X98mQYymqn7OOEMzugwJwX70m6pElOJmvrzQ0mRuBM6W7b1LTw
 bOnQCg4apiml+VwumpoWBvOXmZl+ngedE7gp7P1jZ6f2L5HqbgDW6Kftw w==;
IronPort-SDR: lRo1OA0g0JtTsLWcesOX5tXyU0qojIZ2ruwvtDm1Mx2veBvVFYlFY0ZYELu6JySRK7pSgyjdaU
 tRbupTLCg6wbBnDr7H4mk2EX5GIeI8+oM+ZhXna2a1RVpxXz6KKCQWQj/irqgOHLU6/LZhKALv
 CYYt51KnItlbtQUVYwCyAERDNTM2/LMaoDSAsbflVbSpJQqXmyQlBqBtO522QHSFnVwFOECYLi
 Ix/8Wqqqu+cUf1OHjuZVJCopCP8BMUeFYWifF8lg9DyLQj8ubDaSWtUBOZmplR1sq5EmnlzdjN
 EvE=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="217013913"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:58 +0800
IronPort-SDR: k7BWIe7ze2t4F8OqCIIzfJRpPNKKnAfAE8cgNm2lQRC+65LFoNagrO+Z1FKA97Rcsz35UIQTMw
 yig10Hu5W7fq1oCTs9W6P9SpTANrbp2CqtD9kA7Dc7iCrka+/PvlKXlpwD6ZrkGKk1diQX5WGR
 7YBdyQKmoFufm3lhtCFyiO3m7XOU1pVJiXGsPNP77SZB8sHnhU/tV9zvd00I/dl1kKJ/uu4hVH
 aOIV+hi0eLiNk6+8bSxiyjsmDlJMOJMz4L0G3X85hnFQEoP2Fz4yBPWKu3Uui2F6QKPipSvXKB
 qVGlO8OmUonOKM8Ar0fmtelw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:32 -0700
IronPort-SDR: 3JbxYXra200AYk6zVx9sTLbV3NQNd2WBJmUZkKkIFMnhY9Qrfk07nvrwstvF/X/Lnj6Fv29kT2
 C+aGMlpmh8A4b1j4ArIy5se3MlKaAHLTGgmaefIoxrlC1dcMwRmfkxpu8ifEx+LBAgUMeX0yLJ
 DpYdreNc3k2YPdbgehhxwwixxKhR/1nA6BIbARKF2XDYowLg+/yGahEyA+r0pAKzkx0tjgj4le
 biyYtu+BpSj6L/7D4wR4ebYaU2Xacsvs496qhIuyEdp/ExBGgarojybGM9acs/RwmkpGHb5pJi
 mks=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:34 -0700
Message-Id: <6e2920dbef1ed86b8784827200525c5a112468b2.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 17/28] target/riscv: Add Hypervisor trap
 return support
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 66 ++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index beb34e705b..5bcf5d2ff7 100644
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
+        if (prev_virt == VIRT_ON) {
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
+        if (prev_virt == VIRT_ON) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_virt_enabled(env, prev_virt);
+    }
 
     return retpc;
 }
-- 
2.22.0


