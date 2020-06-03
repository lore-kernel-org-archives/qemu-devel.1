Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDBAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347D82067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347D82067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOU9-0002CL-8V
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1jgOTB-0000Y7-EX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:53 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5969)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jgOT8-0000DT-Lr
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by
 rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95ed75ab43f3-8ab37;
 Wed, 03 Jun 2020 16:09:25 +0800 (CST)
X-RM-TRANSID: 2ee95ed75ab43f3-8ab37
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ed75aae43e-61023;
 Wed, 03 Jun 2020 16:09:25 +0800 (CST)
X-RM-TRANSID: 2ee85ed75aae43e-61023
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] monitor/hmp-cmds: add 'goto end' to reduce duplicate code.
Date: Wed,  3 Jun 2020 16:09:01 +0800
Message-Id: <20200603080904.997083-7-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
Received-SPF: pass client-ip=221.176.66.81;
 envelope-from=maozhongyi@cmss.chinamobile.com; helo=cmccmta3.chinamobile.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:09:37
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 monitor/hmp-cmds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index acdd6baff3..e8cf72eb3a 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1501,8 +1501,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
                                 read_only,
                                 BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &err);
             if (err) {
-                hmp_handle_error(mon, err);
-                return;
+                goto end;
             }
         }
 
@@ -1511,6 +1510,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
                                    &err);
     }
 
+end:
     hmp_handle_error(mon, err);
 }
 
@@ -1629,13 +1629,13 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
 
     opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
     if (err) {
-        hmp_handle_error(mon, err);
-        return;
+        goto end;
     }
 
     obj = user_creatable_add_opts(opts, &err);
     qemu_opts_del(opts);
 
+end:
     hmp_handle_error(mon, err);
 
     if (obj) {
-- 
2.17.1




