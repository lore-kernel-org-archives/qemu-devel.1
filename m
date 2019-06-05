Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2495EC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0128C206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPFm-0007cG-6G
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:18:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPER-0006zZ-Ma
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPEQ-0006iE-8L
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1hYPEK-0006GI-3u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:01 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MCsLu-1hPdip18Ou-008vbp; Wed, 05 Jun 2019 08:11:43 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 08:11:24 +0200
Message-Id: <20190605061126.10244-4-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190605061126.10244-1-david.brenken@efs-auto.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:huaG837WSCb22Y4/6E1lul7xCo+dvvB8JL1tT5vABgwUQ+71Tze
	rsgSwLnH7t0/4lk7dm9czrVTfIzG61F3U4X4Uvbf8jWtgODBckDfs2QAPcRtZkLyI6x0Bpo
	5tI010x0/7bxTrwyY9G8crXY5qAO4kEufrPwjTxzbH37Gx7+0RvDbk9ZloGHAVc2KPggwQb
	XNZ1axU2OCzMpfrag3WXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6YL3AWet40=:CAOq1fNK2wE/bpwQOJz9vZ
	2g9+WA/uXX2F3y5med8NKVujW9nyoXEMHkNEd1bF1t7jgvepnIddelcaP0G8qeZ1brJcmfDD1
	lGuzpuyS+EiBTu/HlN3ZOn0gitRn4GuMczef2/o+hZu2Khy6pKOjGxECPJ0+KcvoiFcGiadID
	5kw2zbeKzn6SBjnS6PPh/S2nV9M+rafe29FNkSocLXP/IGDpNCxehoYCe42oOxZB4nTrW8bpS
	rhBOu1JvOFdNnNYGpsoc98MhYmpILCaeHBsGzy+Pg+7GZC0qlkisoUoz0wsFPM+lvacQv6Ggw
	H4HBFLh6rqwUKrVAz845UQX+S1ZKSYzgo7Pr+XSavZbmYIM5idlxiVhJo9BvT24DqmRoBUfaV
	xcTH3sUEb+9wDZQ45cUXPPs3yQOLLLq1NeW4oZ98mGpWbnd9ihNacBnVTof4j0e3AgOL7cxN/
	+97XolNN5cTU9LWozOtLOM4cjrP2crPndCnxKgx+dCV79CPXq9joo3nzQGyQa7VNpwHe3wBfL
	QHpQa19o6FiBBuifmI1V0Kv1FTiKi4HLkBTScYwYSDXj3QMg/tF/J0YKlLLDbYrBZI+joXGNF
	ajl2EsqVfiPIket8qXj5kD4Sy05dEq1siyPt9e6Te5tYpMDvcMXeyuj1R60JEq+AUTcfaxMOB
	W2oQAKdMWgD3aCAD0/Py3Q7osw3D1+hMI3mEDNEyE92qJNoAQoGazIS7qWTPgGG1NQDmbNe+H
	SseM5nE6gHCpzM2s5bpKGuU68Ud/jwfIng9VCM9q8jHKdMX/FwkrjANEYmI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kbastian@mail.uni-paderborn.de,
	Lars Biermanski <lars.biermanski@efs-auto.de>,
	Georg Hofstetter <georg.hofstetter@efs-auto.de>,
	David Brenken <david.brenken@efs-auto.de>,
	Robert Rasche <robert.rasche@efs-auto.de>,
	Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>

---
 target/tricore/translate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index a8b4de647a..19d8db7a46 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7004,6 +7004,7 @@ static void decode_rrpw_extract_insert(CPUTriCoreState *env, DisasContext *ctx)
     uint32_t op2;
     int r1, r2, r3;
     int32_t pos, width;
+    TCGv temp1, temp2;
 
     op2 = MASK_OP_RRPW_OP2(ctx->opcode);
     r1 = MASK_OP_RRPW_S1(ctx->opcode);
@@ -7042,9 +7043,13 @@ static void decode_rrpw_extract_insert(CPUTriCoreState *env, DisasContext *ctx)
         }
         break;
     case OPC2_32_RRPW_INSERT:
-        if (pos + width <= 31) {
-            tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
-                               width, pos);
+        if (pos + width <= 32) {
+            temp1 = tcg_const_i32(pos);   /* pos */
+            temp2 = tcg_const_i32(width); /* width */
+            gen_insert(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
+                       temp1, temp2);
+            tcg_temp_free(temp1);
+            tcg_temp_free(temp2);
         }
         break;
     default:
-- 
2.17.1


