Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEDC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 00:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AF62067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 00:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AF62067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jumOX-0007m6-6h
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 20:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1jumNB-00060T-Bu
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 20:31:09 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:44468 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1jumN9-0004g1-IF
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 20:31:09 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 652699F837E8566AA980
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:31:05 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id 06D0V394001723
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:31:03 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020071308310534-4262433 ;
 Mon, 13 Jul 2020 08:31:05 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/cris: Remove superfluous breaks
Date: Mon, 13 Jul 2020 08:34:15 +0800
Message-Id: <1594600455-23439-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-07-13 08:31:05,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-13 08:31:04, Serialize complete at 2020-07-13 08:31:04
X-MAIL: mse-fl2.zte.com.cn 06D0V394001723
Received-SPF: pass client-ip=202.103.147.169;
 envelope-from=wang.yi59@zte.com.cn; helo=mxct.zte.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 20:30:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: wang.yi59@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>,
 wang.liang82@zte.com.cn, xue.zhihong@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 target/cris/translate.c         | 7 +++----
 target/cris/translate_v10.inc.c | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index aaa46b5..64a478b 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1178,12 +1178,11 @@ static inline void t_gen_zext(TCGv d, TCGv s, int size)
 static char memsize_char(int size)
 {
     switch (size) {
-    case 1: return 'b';  break;
-    case 2: return 'w';  break;
-    case 4: return 'd';  break;
+    case 1: return 'b';
+    case 2: return 'w';
+    case 4: return 'd';
     default:
         return 'x';
-        break;
     }
 }
 #endif
diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc.c
index ae34a0d..7f38fd2 100644
--- a/target/cris/translate_v10.inc.c
+++ b/target/cris/translate_v10.inc.c
@@ -1026,10 +1026,8 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
         switch (dc->opcode) {
             case CRISV10_IND_MOVE_M_R:
                 return dec10_ind_move_m_r(env, dc, size);
-                break;
             case CRISV10_IND_MOVE_R_M:
                 return dec10_ind_move_r_m(dc, size);
-                break;
             case CRISV10_IND_CMP:
                 LOG_DIS("cmp size=%d op=%d %d\n",  size, dc->src, dc->dst);
                 cris_cc_mask(dc, CC_MASK_NZVC);
-- 
2.9.5


