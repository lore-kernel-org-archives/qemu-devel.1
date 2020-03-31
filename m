Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DABAC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DE82073B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DE82073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCBs-0005RT-9H
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jJCAZ-0003hN-Tc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jJCAY-0001Ht-07
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:22:47 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2593)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jJCAW-0001GY-Rl
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:22:45 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e82fdbcc33-25d0a;
 Tue, 31 Mar 2020 16:22:20 +0800 (CST)
X-RM-TRANSID: 2ee35e82fdbcc33-25d0a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e82fdb5ba9-276a2;
 Tue, 31 Mar 2020 16:22:19 +0800 (CST)
X-RM-TRANSID: 2ee55e82fdb5ba9-276a2
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] migration/migration: improve error reporting for
 migrate parameters
Date: Tue, 31 Mar 2020 16:22:05 +0800
Message-Id: <4ce71da4a5f98ad6ead0806ec71043473dcb4c07.1585641083.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
In-Reply-To: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.79
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

use QERR_INVALID_PARAMETER_VALUE instead of
"Parameter '%s' expects" for consistency.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 migration/migration.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2b7b5bccfa..5a6436d035 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1202,16 +1202,19 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
     }
 
     if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
-        error_setg(errp, "Parameter 'max_bandwidth' expects an integer in the"
-                         " range of 0 to %zu bytes/second", SIZE_MAX);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "max_bandwidth",
+                   "an integer in the range of 0 to "stringify(SIZE_MAX)
+                   " bytes/second");
         return false;
     }
 
     if (params->has_downtime_limit &&
         (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
-        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
-                         "the range of 0 to %d milliseconds",
-                         MAX_MIGRATE_DOWNTIME);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "downtime_limit",
+                   "an integer in the range of 0 to "
+                    stringify(MAX_MIGRATE_DOWNTIME)" milliseconds");
         return false;
     }
 
@@ -2108,9 +2111,10 @@ void qmp_migrate_set_speed(int64_t value, Error **errp)
 void qmp_migrate_set_downtime(double value, Error **errp)
 {
     if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
-        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
-                         "the range of 0 to %d seconds",
-                         MAX_MIGRATE_DOWNTIME_SECONDS);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "downtime_limit",
+                   "an integer in the range of 0 to "
+                    stringify(MAX_MIGRATE_DOWNTIME_SECONDS)" seconds");
         return;
     }
 
-- 
2.17.1




