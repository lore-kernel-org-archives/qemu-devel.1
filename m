Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A9EC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13B22070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13B22070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFHHn-0004ZC-1i
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFHGu-00049G-52
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFHGs-0008L9-Pq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:01:07 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:9344)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFHGs-0008Hg-5b
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:01:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e74be6a32b-450a0;
 Fri, 20 Mar 2020 21:00:26 +0800 (CST)
X-RM-TRANSID: 2ee65e74be6a32b-450a0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.mshome.net (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e74be6208f-f8bef;
 Fri, 20 Mar 2020 21:00:26 +0800 (CST)
X-RM-TRANSID: 2ee75e74be6208f-f8bef
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] monitor/hmp-cmds: fix bad indentation in 'info
 migrate_parameters' cmd output
Date: Fri, 20 Mar 2020 21:00:13 +0800
Message-Id: <20200320130013.418557-1-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
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
Cc: dgilbert@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

run:
(qemu) info migrate_parameters
announce-initial: 50 ms
...
announce-max: 550 ms
multifd-compression: none
xbzrle-cache-size: 4194304
max-postcopy-bandwidth: 0
 tls-authz: '(null)'

The last line seems a bit out of place, fix it.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..f8be6bbb16 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -459,7 +459,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
             params->max_postcopy_bandwidth);
-        monitor_printf(mon, " %s: '%s'\n",
+        monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->has_tls_authz ? params->tls_authz : "");
     }
-- 
2.17.1




