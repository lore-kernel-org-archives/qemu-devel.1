Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4CCC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902E02133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902E02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFF1l-0002Z8-Eb
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFEzq-0001Nt-Ol
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFEzo-00061n-Kf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:03:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:10068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iFEzn-00060e-TP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:03:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 03:03:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; d="scan'208";a="195599665"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga006.jf.intel.com with ESMTP; 01 Oct 2019 03:02:59 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 1/3] migration/postcopy: rename postcopy_ram_enable_notify to
 postcopy_ram_incoming_setup
Date: Tue,  1 Oct 2019 18:01:20 +0800
Message-Id: <20191001100122.17730-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001100122.17730-1-richardw.yang@linux.intel.com>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Function postcopy_ram_incoming_setup and postcopy_ram_incoming_cleanup
is a pair. Rename to make it clear for audience.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/postcopy-ram.c | 4 ++--
 migration/postcopy-ram.h | 2 +-
 migration/savevm.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1f63e65ed7..b24c4a10c2 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1094,7 +1094,7 @@ retry:
     return NULL;
 }
 
-int postcopy_ram_enable_notify(MigrationIncomingState *mis)
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 {
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
@@ -1321,7 +1321,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     return -1;
 }
 
-int postcopy_ram_enable_notify(MigrationIncomingState *mis)
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
 {
     assert(0);
     return -1;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 9c8bd2bae0..d2668cc820 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -20,7 +20,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
  * Make all of RAM sensitive to accesses to areas that haven't yet been written
  * and wire up anything necessary to deal with it.
  */
-int postcopy_ram_enable_notify(MigrationIncomingState *mis);
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
 
 /*
  * Initialise postcopy-ram, setting the RAM to a state where we can go into
diff --git a/migration/savevm.c b/migration/savevm.c
index adad938f57..f3292eb003 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1865,7 +1865,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
      * shouldn't be doing anything yet so don't actually expect requests
      */
     if (migrate_postcopy_ram()) {
-        if (postcopy_ram_enable_notify(mis)) {
+        if (postcopy_ram_incoming_setup(mis)) {
             postcopy_ram_incoming_cleanup(mis);
             return -1;
         }
-- 
2.17.1


