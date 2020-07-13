Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07AFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909AE2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909AE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuPs-0008Uu-S6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1juuMH-00026v-Qg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:02:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:28924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1juuMG-0003BC-42
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:02:45 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id D2F97D8C1C52B13CF5B2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:02:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id 06D92eTO038061
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:02:40 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020071317024567-4267750 ;
 Mon, 13 Jul 2020 17:02:45 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] target/cris: Remove superfluous breaks
Date: Mon, 13 Jul 2020 17:05:50 +0800
Message-Id: <1594631150-36801-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-07-13 17:02:45,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-13 17:02:42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse-fl2.zte.com.cn 06D92eTO038061
Received-SPF: pass client-ip=63.217.80.70; envelope-from=wang.yi59@zte.com.cn;
 helo=mxhk.zte.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:59:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/cris/translate.c         | 7 +++----
 target/cris/translate=5Fv10.inc.c | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index aaa46b5..64a478b 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1178,12 +1178,11 @@ static inline void t=5Fgen=5Fzext(TCGv d, TCGv s, i=
nt size)
 static char memsize=5Fchar(int size)
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
diff --git a/target/cris/translate=5Fv10.inc.c b/target/cris/translate=5Fv1=
0.inc.c
index ae34a0d..7f38fd2 100644
--- a/target/cris/translate=5Fv10.inc.c
+++ b/target/cris/translate=5Fv10.inc.c
@@ -1026,10 +1026,8 @@ static unsigned int dec10=5Find(CPUCRISState *env, D=
isasContext *dc)
         switch (dc->opcode) {
             case CRISV10=5FIND=5FMOVE=5FM=5FR:
                 return dec10=5Find=5Fmove=5Fm=5Fr(env, dc, size);
-                break;
             case CRISV10=5FIND=5FMOVE=5FR=5FM:
                 return dec10=5Find=5Fmove=5Fr=5Fm(dc, size);
-                break;
             case CRISV10=5FIND=5FCMP:
                 LOG=5FDIS("cmp size=3D%d op=3D%d %d\n",  size, dc->src, dc=
->dst);
                 cris=5Fcc=5Fmask(dc, CC=5FMASK=5FNZVC);
--=20
2.9.5


