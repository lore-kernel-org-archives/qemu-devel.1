Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A220C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FFF2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FFF2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYxb-0001Eb-QI
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYor-0007gK-Rf; Wed, 30 Sep 2020 05:54:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49750 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYoh-0004Pn-74; Wed, 30 Sep 2020 05:54:41 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BF9E5B24852456841869;
 Wed, 30 Sep 2020 17:54:28 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:18 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 09/14] sh4/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:16 +0800
Message-ID: <20200930095321.2006-10-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/sh4.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/sh4/cpu.h       | 2 +-
 target/sh4/op_helper.c | 2 +-
 target/sh4/translate.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index dbe58c7..91fa949 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -160,7 +160,7 @@ typedef struct CPUSH4State {
     uint32_t pteh;		/* page table entry high register */
     uint32_t ptel;		/* page table entry low register */
     uint32_t ptea;		/* page table entry assistance register */
-    uint32_t ttb;		/* tranlation table base register */
+    uint32_t ttb;		/* translation table base register */
     uint32_t tea;		/* TLB exception address register */
     uint32_t tra;		/* TRAPA exception register */
     uint32_t expevt;		/* exception event register */
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 14c3db0..9de4152 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -400,7 +400,7 @@ float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
     t0 = float32_div(float32_one, t0, &env->fp_status);
     /* Since this is supposed to be an approximation, an imprecision
        exception is required.  One supposes this also follows the usual
-       IEEE rule that other exceptions take precidence.  */
+       IEEE rule that other exceptions take precedence.  */
     if (get_float_exception_flags(&env->fp_status) == 0) {
         set_float_exception_flags(float_flag_inexact, &env->fp_status);
     }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 60c863d..c57218e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1959,7 +1959,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     NEXT_INSN;
     switch (ctx->opcode & 0xf00f) {
     case 0x6003: /* mov Rm,Rn */
-        /* Here we want to recognize ld_dst being saved for later consumtion,
+        /* Here we want to recognize ld_dst being saved for later consumption,
            or for another input register being copied so that ld_dst need not
            be clobbered during the operation.  */
         op_dst = B11_8;
-- 
2.26.2.windows.1


