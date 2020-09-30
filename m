Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E698C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233AC2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233AC2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYy4-00027a-4w
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYoo-0007Wm-6G; Wed, 30 Sep 2020 05:54:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49652 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYod-0004PE-7R; Wed, 30 Sep 2020 05:54:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BDD339ECDDA296FC7901;
 Wed, 30 Sep 2020 17:54:23 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:13 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 06/14] mips/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:13 +0800
Message-ID: <20200930095321.2006-7-zhaolichang@huawei.com>
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

I found that there are many spelling errors in the comments of qemu/target/mips.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/mips/internal.h           |  2 +-
 target/mips/translate.c          | 10 +++++-----
 target/mips/translate_init.c.inc |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7f159a9..b811f54 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -188,7 +188,7 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
         /*
          * A MIPS configured with a vectorizing external interrupt controller
          * will feed a vector into the Cause pending lines. The core treats
-         * the status lines as a vector level, not as indiviual masks.
+         * the status lines as a vector level, not as individual masks.
          */
         r = pending > status;
     } else {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf7..b4d0090 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3718,7 +3718,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
 
     t0 = tcg_temp_new();
     addr = tcg_temp_new();
-    /* compare the address against that of the preceeding LL */
+    /* compare the address against that of the preceding LL */
     gen_base_offset_addr(ctx, addr, base, offset);
     tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
     tcg_temp_free(addr);
@@ -25597,7 +25597,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         }
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
-        /* finaly update the destination */
+        /* finally update the destination */
         tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
 
         tcg_temp_free(t1);
@@ -25633,7 +25633,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         }
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
-        /* finaly update the destination */
+        /* finally update the destination */
         tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
 
         tcg_temp_free(t1);
@@ -25702,7 +25702,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
             }
             /* return resulting byte to its original position */
             tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
-            /* finaly update the destination */
+            /* finally update the destination */
             tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
         }
 
@@ -25742,7 +25742,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
             }
             /* return resulting byte to its original position */
             tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
-            /* finaly update the destination */
+            /* finally update the destination */
             tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
         }
 
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637cacc..c735b2b 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -995,7 +995,7 @@ static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
 
     /* MVPConf1 implemented, TLB sharable, no gating storage support,
        programmable cache partitioning implemented, number of allocatable
-       and sharable TLB entries, MVP has allocatable TCs, 2 VPEs
+       and shareable TLB entries, MVP has allocatable TCs, 2 VPEs
        implemented, 5 TCs implemented. */
     env->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
                              (0 << CP0MVPC0_GS) | (1 << CP0MVPC0_PCP) |
-- 
2.26.2.windows.1


