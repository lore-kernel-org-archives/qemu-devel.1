Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A6C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 02:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9214D2080C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 02:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9214D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htMzO-0008TQ-IY
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 22:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1htMyu-0007y0-OP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 22:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1htMyt-0008D1-LK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 22:07:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:28713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1htMyt-00088O-An
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 22:07:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Aug 2019 19:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,336,1559545200"; d="scan'208";a="191756988"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2019 19:07:39 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 10:07:16 +0800
Message-Id: <20190802020716.11985-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH] hmp/info_migration: formatting migration
 capability output
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
Cc: dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current we put all migration capability in one line, which make it hard
to read them and someone them are missed due to terminal width.

This patch formats it to print 4 in one line, which looks like this now:

capabilities:
              xbzrle: off         rdma-pin-all: off        auto-converge: off          zero-blocks: off
            compress:  on               events: off         postcopy-ram: off               x-colo: off
         release-ram: off                block: off          return-path: off pause-before-switchover: off
             multifd: off        dirty-bitmaps: off   postcopy-blocktime: off  late-block-activate: off
     x-ignore-shared: off

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 monitor/hmp-cmds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5ca3ebe942..29ce5b73e4 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -229,9 +229,13 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 
     /* do not display parameters during setup */
     if (info->has_status && caps) {
+        int index = 0;
         monitor_printf(mon, "capabilities: ");
-        for (cap = caps; cap; cap = cap->next) {
-            monitor_printf(mon, "%s: %s ",
+        for (cap = caps; cap; cap = cap->next, index++) {
+            if (!(index % 4)) {
+                monitor_printf(mon, "\n");
+            }
+            monitor_printf(mon, "%20s: %3s ",
                            MigrationCapability_str(cap->value->capability),
                            cap->value->state ? "on" : "off");
         }
-- 
2.17.1


