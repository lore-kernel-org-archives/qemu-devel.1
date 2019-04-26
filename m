Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24139C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA87520675
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 09:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJwwR-0007Go-5m
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 05:14:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtL-0005Cr-6o
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtK-0003Ot-FG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:13449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJwtK-0003Nl-78
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 02:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; d="scan'208";a="340969574"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by fmsmga005.fm.intel.com with ESMTP; 26 Apr 2019 02:11:32 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Laurent Vivier <laurent@vivier.eu>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Date: Fri, 26 Apr 2019 17:07:29 +0800
Message-Id: <20190426090730.2691-3-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <20190426090730.2691-1-chen.zhang@intel.com>
References: <20190426090730.2691-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH 2/3] migration/colo.h: Remove obsolete codes
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
Message-ID: <20190426090729.FF02JIhdMBDlczZeG_hV6SXsxZN05VdkGv3vVPbz3v0@z>

From: Zhang Chen <chen.zhang@intel.com>

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 include/migration/colo.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index ddebe0ad27..f6fbe23ec9 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -22,8 +22,6 @@ enum colo_event {
     COLO_EVENT_FAILOVER,
 };
 
-void colo_info_init(void);
-
 void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
-- 
2.17.GIT


