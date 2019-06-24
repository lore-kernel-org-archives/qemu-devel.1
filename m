Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22EAC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746B3205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746B3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfJ4q-0006HX-Ji
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 03:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48978)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ1N-0003bL-FG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ1M-0002yA-Ek
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:04:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hfJ1M-0002vD-0S
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:04:08 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNss4-1hucx71jqK-00OHAy; Mon, 24 Jun 2019 09:04:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 09:03:38 +0200
Message-Id: <20190624070339.4408-5-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190624070339.4408-1-david.brenken@efs-auto.org>
References: <20190624070339.4408-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:FVHxqoyPRibZk3XOHiKt8ezdG1NbrIzZylsBo8rHEtpGeUdzxA3
 u4OcezaZB4vfXJL30p8Q6MwVQw9SOcVux3xRhqMDhAc98/M+v11fppR2h06vGH3ehrVzY96
 jIFR31qSqxr6tY87d6Dd1VWhqn5K/uFdeOR5QqmoQUZoYXpFRpvqhbhXeRYt+vqOvvx/1qf
 A3zydaysq+RiS/1AhvktQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IQmxHDgft00=:T5yyQ1PbCBHm65Mi9vtfn/
 k+LvZoo7nDELvbAUQwc8jogP6AHd32GehMuJ1cDDFTy2BcFFcrrYCiHSLEOaNFGvId4Z5oHbd
 Bo7UFDKICwflp6SqJ10ZCdS6PiO9s9rOW7Mp2nvQ+Pk0JvPr49dvsAsc4mGGeIedcr/k/F41e
 YkDvjwTUPOM4DXQBUdifwyi2IWiXfbPOIegkeC/iZHijcnNyioi4hR//USjfRnJZ7mNn0Y0yE
 KHg6eMlFXXIIw+yQIFGTy1MSr34gmAJkk650BRSRhT5ubCeVDfGvOpi4SOcnZwb3vnmbkMozF
 Xw5syZKJ6UO54QPjH7QJ5U3469rPVuvfLeHYoejtUAsEEfyW83Nshuhdlm+JK9t2TtVhss+Fr
 0Y6w6ch4dqhANFp8Pr/M4g/G7tntfkAiHbe+fG3HcDmbxo/AGlnrNb1HpGR2JiviXwHGcQFQK
 6BQp5d6bXl5SfLaP7gZ+4yzLY9Vs8IMnPaEyyoKWidbfUMA/yTttJ1UGvKjSVBSlCCuqc64+B
 NxQMxvbch8hdy2kxbcZRtHym60jIStaWQ+X7qu/VIiH4MjhdRcMeZnYlLJqsH3P2XU5dTUgp2
 elA76dyTMJliS3LPfZvTMHO/mfAnaPI21N6hja/t4gz6w9B2b2dfmyO6lrVelr0uxr2iMEltv
 YvFbw1P3+E+C04CRwe6rMIt0ctaf8EvpBPFt6ATSQWe2xZlfx2ZE7yX6o/fCLb4or/OAuA2Ld
 dIybsLVSGj+ZzNItnXOHiXT4B1zoeNvRxS8wQwjJERB1s+ENf4GslDpqC8I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PATCH v3 4/5] tricore: sync ctx.hflags with tb->flags
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Georg Hofstetter <georg.hofstetter@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
---
 target/tricore/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5d4febf1c0..c79566e56a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8810,6 +8810,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     ctx.singlestep_enabled = cs->singlestep_enabled;
     ctx.bstate = BS_NONE;
     ctx.mem_idx = cpu_mmu_index(env, false);
+    ctx.hflags = (uint32_t)tb->flags;
 
     tcg_clear_temp_count();
     gen_tb_start(tb);
-- 
2.22.0.windows.1


