Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAE2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA39206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MCoHMJIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA39206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9P5-00040x-HI
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO917-00057t-G8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO913-0004Rt-2b
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49531)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO912-0004OP-04; Fri, 25 Oct 2019 19:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046153; x=1603582153;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bMeqtbfW+9JJ0VJKdr9KVccHLjaihEfmrV++mdO5OKc=;
 b=MCoHMJIFwmYaZvwahltfNFIqBTEjwjT3zTad7TjX73UakzjFyFIjRgtR
 rUsrf9Qc4pIlNZ9V0UYKS9JHfFV17N5fslSuiCtbFwIxBT2y2iCPQ3Svj
 byoraSw2yM9iNYDoRA6WsHZ4V4xBrml8w6cCbBWaDPfPD8WUfIiCs6h/g
 X3xEkTvmAdXdtJq/wkq3XfFyaolbtgIY/SzhmvXWAgt9iA9KUiehf0d3p
 TtjJL8suUEmaxt1ktnxCvf3ufzOzwmmlBSjqFdYEkQEn1QwkDosI5P2zb
 Nj0X571PxmiA6CpMjFqi+zy2cUQ2pZorEWTk7MYqKMLZQoskDlRqEve8t A==;
IronPort-SDR: 6CvtZbNcC+HJdzFu5AhKbuydRY8i6FJ+6afNzap2yIeqQeABum9h5Y1LvVHOktpJ8p4qIlS33m
 EB+g1z/akHlcolEdiNE66gxvRFgmS0RNTqRf5zVWAy+TYDRtDpFReYUgfelju6WjSvPxo4cFvy
 q4HjLtdyB5W35a6Y7+k4GwQxYh44HzoCuEMKGk6ZsLZcSwehahfnnkmKDeK68VmR9buitlw21+
 8JC3CedxYWrOsYbKk9binI1/3uB0NbiSTeHcSEQnsfFT6AzEkZ7X/smR0d5RruQaqMM4W+zRhF
 PLU=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="222508982"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:09 +0800
IronPort-SDR: ig+AI3gfw1w8psFMoHyN9kVq88TtNesyvHo/nZI7+BYaaCBnfcjCKN0N9TOhg28ZbL68UZq1RV
 jXJEfPTJapFY0ulL8f+wY0RiwzUO3bUBK6BVhLcbBTktqYyPzq3cSYZNCSFLZwOAT64WvO7V0a
 n1OuGLi2E9Avjp49jlo8mtR2IsVTaTAmLUuCnWGpe41bwRIDJfmQtWh2LU5KHGrll+kvY+Jog7
 PJ8Y3xokzvQJp7pBZVHd0Z4/iUHGGMujbAs4wIVwtzwXF7lgkQvpIve0wbXMM795AkFi0X/kHH
 Ql1G1ckjI1ZpnJzV2dt4odsX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:37 -0700
IronPort-SDR: aVDC+lYXPtcx6LG5TNg9FyAu+vsmWuJPolmy4fRORhMWFYL+4+RBSe1GpdpmCwrphhyDlwdUZK
 SVZTHEpERZMIQ4KCvRBVRYAT5V/luK9r8mU9rRV8R0r9hOmSB8QcU+MlgH/eCdjzdhNr6N4D08
 SdFAeW66CC+4g1BaHYU4YX27xQlvy+N9k9gdcVkCA8GbtQDiIpLo9K6JjKdL1GOfl0m0GqPClE
 dwsIcwSCgJkgfSIAaklbB5LVN99BcYIW7HAp5Shcwsqo/GRiT8fdGxfEvBmHPZI5esXiltAjbO
 PZk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:29:05 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 18/27] target/riscv: Add Hypervisor trap return support
Date: Fri, 25 Oct 2019 16:24:09 -0700
Message-Id: <e4ec1a85991bf7e0bbd224768cfb5ca41ffdc8da.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
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
2.23.0


