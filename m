Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC1DC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 03:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F83B206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 03:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F83B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJrnm-0007Lw-Ty
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 23:45:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJrml-0006fg-Hj
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 23:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJrmk-0007a3-LH
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 23:44:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:32062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJrmk-0007WO-Bz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 23:44:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 20:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; d="scan'208";a="340905318"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2019 20:44:14 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Laurent Vivier <laurent@vivier.eu>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	qemu-dev <qemu-devel@nongnu.org>
Date: Fri, 26 Apr 2019 11:40:15 +0800
Message-Id: <20190426034015.4696-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] [PATCH] migration/colo.c: Remove redundant input
 parameter
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426034015.2DHPk9s8G2SmOK-uhX-sNn7Fkq64MbJ2-OKhpPfqpcE@z>

From: Zhang Chen <chen.zhang@intel.com>

The colo_do_failover no need the input parameter.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 include/migration/colo.h  | 2 +-
 migration/colo-failover.c | 2 +-
 migration/colo.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 99ce17aca7..ddebe0ad27 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -37,7 +37,7 @@ bool migration_incoming_in_colo_state(void);
 COLOMode get_colo_mode(void);
 
 /* failover */
-void colo_do_failover(MigrationState *s);
+void colo_do_failover(void);
 
 void colo_checkpoint_notify(void *opaque);
 #endif
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index 4854a96c92..e9ca0b4774 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -39,7 +39,7 @@ static void colo_failover_bh(void *opaque)
         return;
     }
 
-    colo_do_failover(NULL);
+    colo_do_failover();
 }
 
 void failover_request_active(Error **errp)
diff --git a/migration/colo.c b/migration/colo.c
index 238a6d62c7..8c1644091f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -193,7 +193,7 @@ COLOMode get_colo_mode(void)
     }
 }
 
-void colo_do_failover(MigrationState *s)
+void colo_do_failover(void)
 {
     /* Make sure VM stopped while failover happened. */
     if (!colo_runstate_is_stopped()) {
-- 
2.17.GIT


