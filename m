Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D66BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 23:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F87C21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 23:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F87C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPF6G-0007lD-GH
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 19:38:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hPF5W-0007U2-MK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hPF5V-0004ff-M7
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:38:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:9166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hPF5V-0004e1-Ea
	for qemu-devel@nongnu.org; Fri, 10 May 2019 19:38:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 May 2019 16:37:59 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 10 May 2019 16:37:58 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Sat, 11 May 2019 07:37:29 +0800
Message-Id: <20190510233729.15554-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH] migration/ram.c: fix typos in comments
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1def8122e9..720c2b73ca 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -888,7 +888,7 @@ struct {
  *    - to make easier to know what to free at the end of migration
  *
  * This way we always know who is the owner of each "pages" struct,
- * and we don't need any loocking.  It belongs to the migration thread
+ * and we don't need any locking.  It belongs to the migration thread
  * or to the channel thread.  Switching is safe because the migration
  * thread is using the channel mutex when changing it, and the channel
  * have to had finish with its own, otherwise pending_job can't be
@@ -1594,7 +1594,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
  *
  * Called with rcu_read_lock() to protect migration_bitmap
  *
- * Returns the byte offset within memory region of the start of a dirty page
+ * Returns the page offset within memory region of the start of a dirty page
  *
  * @rs: current RAM state
  * @rb: RAMBlock where to search for dirty pages
@@ -2108,7 +2108,7 @@ retry:
  * find_dirty_block: find the next dirty page and update any state
  * associated with the search process.
  *
- * Returns if a page is found
+ * Returns true if a page is found
  *
  * @rs: current RAM state
  * @pss: data about the state of the current dirty page scan
@@ -2204,7 +2204,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
  *
  * Skips pages that are already sent (!dirty)
  *
- * Returns if a queued page is found
+ * Returns true if a queued page is found
  *
  * @rs: current RAM state
  * @pss: data about the state of the current dirty page scan
@@ -3411,7 +3411,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
         /* we want to check in the 1st loop, just in case it was the 1st time
            and we had to sync the dirty bitmap.
-           qemu_get_clock_ns() is a bit expensive, so we only check each some
+           qemu_clock_get_ns() is a bit expensive, so we only check each some
            iterations
         */
         if ((i & 63) == 0) {
-- 
2.19.1


