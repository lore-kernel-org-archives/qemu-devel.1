Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DBEC2D0E7
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 05:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE9B20733
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 05:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE9B20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIQ6K-0000Vs-Sh
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 01:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jIQ5P-00086Y-42
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 01:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jIQ5O-0005Ww-4K
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 01:02:15 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:10348)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jIQ5N-000597-Gt
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 01:02:14 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e802bb9ab4-f3939;
 Sun, 29 Mar 2020 13:01:47 +0800 (CST)
X-RM-TRANSID: 2ee65e802bb9ab4-f3939
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.localdomain (unknown[117.136.46.37])
 by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65e802baee64-267d2;
 Sun, 29 Mar 2020 13:01:46 +0800 (CST)
X-RM-TRANSID: 2ee65e802baee64-267d2
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] migration: move the units of migrate parameters from
 milliseconds to ms.
Date: Sun, 29 Mar 2020 13:01:31 +0800
Message-Id: <20200329050131.26864-4-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329050131.26864-1-maozhongyi@cmss.chinamobile.com>
References: <20200329050131.26864-1-maozhongyi@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.80
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
Cc: dgilbert@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 +-
 monitor/hmp-cmds.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e0223f3b15..d014da388a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1212,7 +1212,7 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "downtime_limit",
-                   "an integer in the range of 0 to 2000000 milliseconds");
+                   "an integer in the range of 0 to 2000000 ms");
         return false;
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 63097ddcc8..c5de8af1ee 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -231,18 +231,18 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "\n");
         }
 
-        monitor_printf(mon, "total time: %" PRIu64 " milliseconds\n",
+        monitor_printf(mon, "total time: %" PRIu64 " ms\n",
                        info->total_time);
         if (info->has_expected_downtime) {
-            monitor_printf(mon, "expected downtime: %" PRIu64 " milliseconds\n",
+            monitor_printf(mon, "expected downtime: %" PRIu64 " ms\n",
                            info->expected_downtime);
         }
         if (info->has_downtime) {
-            monitor_printf(mon, "downtime: %" PRIu64 " milliseconds\n",
+            monitor_printf(mon, "downtime: %" PRIu64 " ms\n",
                            info->downtime);
         }
         if (info->has_setup_time) {
-            monitor_printf(mon, "setup: %" PRIu64 " milliseconds\n",
+            monitor_printf(mon, "setup: %" PRIu64 " ms\n",
                            info->setup_time);
         }
     }
-- 
2.17.1




