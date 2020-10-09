Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA3C22245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA3C22245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmGC-0003ZA-SW
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmAS-00064N-2I; Fri, 09 Oct 2020 02:46:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55124 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmAJ-0001JX-Gd; Fri, 09 Oct 2020 02:46:10 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A13BBF941449DCC8CF80;
 Fri,  9 Oct 2020 14:46:03 +0800 (CST)
Received: from localhost (10.174.186.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 14:45:56 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 06/14] mips/: fix some comment spelling errors
Date: Fri, 9 Oct 2020 14:44:41 +0800
Message-ID: <20201009064449.2336-7-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201009064449.2336-1-zhaolichang@huawei.com>
References: <20201009064449.2336-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.238]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:45:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: David
 Edmondson <david.edmondson@oracle.com>, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/mips.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>
---
 target/mips/internal.h           |  2 +-
 target/mips/translate.c          | 10 +++++-----
 target/mips/translate_init.c.inc |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7f159a9230..b811f547f3 100644
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
index 398edf7289..b4d009078e 100644
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
index 637caccd89..c735b2bf66 100644
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


