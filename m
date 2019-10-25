Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B334421D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XM9c9t5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B334421D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9Ci-00042A-Iz
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91E-0005Gh-Kc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91D-0004bD-Fy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91D-0004CY-6v; Fri, 25 Oct 2019 19:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046159; x=1603582159;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bGS+WLrBxBJ4IcdBPApTmWaBLjpm/TSDxEQpVVZJbFo=;
 b=XM9c9t5EZ4FH83oEpP175mOZhFQnzm6W4rowKZ9GO0uQujImvpaH/ZmI
 g/NiWf1Bwpfjumy2SIp8cbK1iaXZJlV+evkLlLNM9q4VCla5aU0fRyQDL
 4SJAPrI3U4poWOLcl7igK7O1frVrA4nO2IreeUEghpmcL84mYvO4Z9NJc
 MKl9FpwOio1USAiWaY5aJm0LqTRQJBOJEimoF913vHYjv694XgQtbClIs
 IpZhMZuEnF7Volrisx2YYl74g5oPVXLRsj/QqcjSWqrmZnxtuF9iRJD4v
 kGAXF2dSjD2XwvvhOtmRZH+xHgRaGTltuFXxGUEJhCAFjbT38SwoaZiSY Q==;
IronPort-SDR: sl2WcILtyUzJhUO2eYGhDv31rV31pol1yHtQCQFYhlAKqweqV0Hfld+fmayyu9W5KrKucz2nYP
 /6wNogRXqItT23QUvDQDMWEFV+CQJkkykUpQ60vxdwJwRYPXeKHNWv+Jl7Twtcs+gKED2YaHG3
 pR0zc2m65Z2eyJpnsOfStL5OERP4pV68o5nYkNVKmgH5/0t908KHmgR0irXbGlexFAJGM+W56l
 Lqx7tgX/IhEQhH++TXQKL4PWzo8fuxl4a1I5LdFcxfnSSGK7P2xFe5ddJBg8eIfln/H5zqiXIF
 W4E=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520408"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:49 +0800
IronPort-SDR: +CwP8r8quQ6Ww6lpi6LnMsQcngbdmK5TYuCGvG9zReYn7gFIE98AuzQk8nihsyNYcRSHV/0btt
 eZu2QJ4IiLCeI+8Z2zgvSOx4mG/pF/zrkX5hwC3CixGtKvQBnKFV0u/1QpdR+FNZBEEmzA5reE
 DXi0AUgVw00LJ71g3IQqxpGs2e5lDrP+J82kUcw389R1fTdQbYMqZYZB+Qtah2ewxoXIWF01us
 ufrvJoF2PTkWYUB3Ir5oPcdrIH/CESNXnBqrKofMCyNCUMRaZqJYCkW4b66LjobYeNXNQRVF3e
 q02H1lRnHn+bUGD/Uk21t13u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:15 -0700
IronPort-SDR: SUzIfgQCbCQ71fTnCm5fmlJWP7EjZAYr/yNB6iwOxs2KNWJmBXV5cKKuEYuWkXN5boSmUaFw4P
 If8t84r8Pe19IhTdeRUNbIoEctnUsA0di/efmicSljwFaLfiYFgeBEZmzPT/WHdGxT4B/uQUSh
 rtJPpSUJdBVBSQMcMksJ7Sq1V7KSX2iWGrN68PdXJJdsuaB9I9+Bf+XNqOaXSaIJExjJ2/krlU
 lMER8HVdEBmQrfyxj9ZZSax+eqTHMoWCtMvy252zvWbelInwcDccVmsfFPwEsgzSXT5hmZ3TV1
 Af4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 13/27] target/riscv: Add support for virtual interrupt
 setting
Date: Fri, 25 Oct 2019 16:23:54 -0700
Message-Id: <6b2128ecb939eb059cc69f358de3de4e760c3e03.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 12a10e8679..bb4557df16 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -39,12 +39,27 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
+    target_ulong vsstatus_sie = get_field(env->mstatus_novirt, MSTATUS_SIE);
+
     target_ulong pending = env->mip & *env->mie;
-    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
-    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong hspending = env->mip_novirt & env->mie_novirt;
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
2.23.0


