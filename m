Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EEDC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 02:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB944206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 02:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB944206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJqKD-0007KC-2E
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 22:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJqJQ-0006yE-Rz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJqJO-0005ou-Qk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:10:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:22753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJqJN-0005i8-4k
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 22:10:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 19:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; d="scan'208";a="165183624"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2019 19:09:57 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:09:27 +0800
Message-Id: <20190426020927.25470-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] [PATCH] memory: correct the comment to
 DIRTY_MEMORY_MIGRATION
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
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426020927.N-ifUZfJ5Ek1LvKNZ3qvKuTshT5bShbCdLoxsnITinw@z>

The dirty bit is DIRTY_MEMORY_MIGRATION. Correct the comment.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index e49369d85d..9d015bfe4c 100644
--- a/memory.c
+++ b/memory.c
@@ -2576,7 +2576,7 @@ void memory_global_dirty_log_start(void)
 
     MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
 
-    /* Refresh DIRTY_LOG_MIGRATION bit.  */
+    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
     memory_region_transaction_begin();
     memory_region_update_pending = true;
     memory_region_transaction_commit();
@@ -2586,7 +2586,7 @@ static void memory_global_dirty_log_do_stop(void)
 {
     global_dirty_log = false;
 
-    /* Refresh DIRTY_LOG_MIGRATION bit.  */
+    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
     memory_region_transaction_begin();
     memory_region_update_pending = true;
     memory_region_transaction_commit();
-- 
2.19.1


