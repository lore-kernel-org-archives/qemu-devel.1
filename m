Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4204C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B483321655
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W/dqnB1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B483321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JEI-0002xg-IJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC1-0000sJ-Bw
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBz-0000BM-0m
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBy-00007y-3p; Fri, 23 Aug 2019 19:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603722; x=1598139722;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mcb2lfn1YX7evWQUTehGcJy+nBgKj5L443nTWq0/w4I=;
 b=W/dqnB1m0x3vEAqPwxnGVbm5sGbx2wSIRgxnp+mlugPEyNb+XfMbvtS5
 2nvaiTs6wnnqVYwd56gjX7sjj5GqE4eeYhhrmbqWqJnzqngnQhGAfusXJ
 7DvBUN2jY+Fc9STRrRqtqpZrlRKeyogZb5ZhGuU4czpKK4GuVNj1woBTm
 XAnqziZYlyz4KXmWZlnYYBpYLpEFM+k3ahckjlceT4CJdVfYFGgHoCHJS
 WB9KcvpyWG4/7/QTREm7p2tH4RCytJQDMdERiVTyxWqRpZ+W56aYat9uE
 0GHvB/18+dxlYzXfPb5NaO5df0/Rx3s3hbLQmGmvE0p0fo42fnXWQqOrp Q==;
IronPort-SDR: wOiKCjpTYACzaOHJBNGVfotuOXBU0C5m5hrtYNG5dfCeQEDq/uybtpvX1cnQgfYws2KocfnPpW
 HyXdjcBTmJO1ok/KqzFVptyrmZQdeW4ZcO3i+376qDmZ85CysDvnDSXstfYcO45wkRtdSWHCOt
 RG4AacvdtuQEmsAau9jBdQpb4K1UmvWr/0ymr8/jPfLPfAUaDMo3Dq64DeHWYZigPd7bcyTddN
 i9qQyc3pTfNoqfHahbfS8DPpnerwxWgrhFOCFN+6AN4/oF4eugQUoDb2n2+jK6V6ZqG0UEyoyS
 ciw=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="118154426"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:02 +0800
IronPort-SDR: K1Zx/nEn0eHlZoXgIKgyyddacfP4fD7MyVpJlnj2iVG/Vd2uCee8+H2eLe5xvke8O4cR8tMU66
 ue9rOuaQIfAIIOcGCH1OagoDMILjkj3+bbfLWBvpKfQ4ksgAU4bSlq2WV7HPe5KtUa0i3WpQL9
 EkDUeuo6ZH/C52xAojvOh6T3/HTjxktDmPLbxnNI/nLfykW1YsFM37SdRzFDTP2SOEetWlwdbl
 MWnGyOCLONOrTW97yMx3Puw/JdV384qsWbKlrYRxT2ZaLUjp24FvvPRK9elAtofFJOABibZLgg
 bm+J8ODkSgMu4K95hYrY+xl0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:19 -0700
IronPort-SDR: NmoCdXcQax7LIh6NMOwivIgko4mZztxZad2BxDM6EbTgaQ/QZnjtoBFHRVPiHAlESspV/m0Wfq
 uHrZJiB+3LYiFfxKYHXHdG+1/2Kz+vxy6jWScYoo4/fJm2GWB45uqBbM3kQpiZG0eIAA/t097B
 b2u6sy8CVYBWD9Jz8yPKfZhpjunJMpfwWqouG6f0IIzeSCCL1gqHbhatOcd9d0AAXBLgZY6dGd
 x8LNMbczEOYNmOIBWIWEG2HQ9xUlPNBKFy8A/qpNxkfr5Zlua2KWCeMICP6BJRGTrVF/Tkg6hG
 8HM=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:21 -0700
Message-Id: <f28c9a322755ce12e1102c4e79c5f290f0cab628.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 12/28] target/riscv: Add support for virtual
 interrupt setting
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
 target/riscv/cpu_helper.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 41d4368128..afb3e8579e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -38,12 +38,27 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
-    target_ulong pending = atomic_read(env->mip) & *env->mie;
-    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
-    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong vsstatus_sie = get_field(env->mstatus_novirt, MSTATUS_SIE);
+
+    target_ulong pending = atomic_read(&env->mip) & *env->mie;
+    target_ulong hspending = atomic_read(&env->mip_novirt) & env->mie_novirt;
+
+    target_ulong mie  = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
+    target_ulong sie  = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong vsie = env->priv < PRV_S || (env->priv == PRV_S && vsstatus_sie);
+
     target_ulong irqs = (pending & ~env->mideleg & -mie) |
                         (pending &  env->mideleg & -sie);
 
+    if (riscv_cpu_virt_enabled(env)) {
+        target_ulong pending_hs_irq = hspending & -vsie;
+
+        if (pending_hs_irq) {
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+            return ctz64(pending_hs_irq);
+        }
+    }
+
     if (irqs) {
         return ctz64(irqs); /* since non-zero */
     } else {
-- 
2.22.0


