Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7EC35263
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB105221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB105221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIowY-00005C-Q2
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIohW-0004mk-0J; Thu, 17 Sep 2020 03:51:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4757 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIohQ-0005Mg-P5; Thu, 17 Sep 2020 03:51:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 02BB2642F1F42872FD83;
 Thu, 17 Sep 2020 15:51:21 +0800 (CST)
Received: from localhost (10.174.187.87) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 15:51:12 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V3 05/10] util/: fix some comment spelling errors
Date: Thu, 17 Sep 2020 15:50:24 +0800
Message-ID: <20200917075029.313-6-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200917075029.313-1-zhaolichang@huawei.com>
References: <20200917075029.313-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.87]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:37:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>, Alex Bennee <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the util folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
---
 util/osdep.c             | 2 +-
 util/qemu-progress.c     | 2 +-
 util/qemu-sockets.c      | 2 +-
 util/qemu-thread-win32.c | 2 +-
 util/qht.c               | 2 +-
 util/trace-events        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 4829c07ff6..e50dc2214e 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -392,7 +392,7 @@ int qemu_unlink(const char *name)
  * Set errno if fewer than `count' bytes are written.
  *
  * This function don't work with non-blocking fd's.
- * Any of the possibilities with non-bloking fd's is bad:
+ * Any of the possibilities with non-blocking fd's is bad:
  *   - return a short write (then name is wrong)
  *   - busy wait adding (errno == EAGAIN) to the loop
  */
diff --git a/util/qemu-progress.c b/util/qemu-progress.c
index 3c2223c1a2..20d51f8c12 100644
--- a/util/qemu-progress.c
+++ b/util/qemu-progress.c
@@ -131,7 +131,7 @@ void qemu_progress_end(void)
 /*
  * Report progress.
  * @delta is how much progress we made.
- * If @max is zero, @delta is an absolut value of the total job done.
+ * If @max is zero, @delta is an absolute value of the total job done.
  * Else, @delta is a progress delta since the last call, as a fraction
  * of @max.  I.e. the delta is @delta * @max / 100. This allows
  * relative accounting of functions which may be a different fraction of
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b37d288866..99ce2fd5e6 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -416,7 +416,7 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
 
     /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
      * then don't implement it in their getaddrinfo(). Detect
-     * this and retry without the flag since that's preferrable
+     * this and retry without the flag since that's preferable
      * to a fatal error
      */
     if (rc == EAI_BADFLAGS &&
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 56a83333da..d207b0cb58 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -289,7 +289,7 @@ void qemu_event_wait(QemuEvent *ev)
             ResetEvent(ev->event);
 
             /* Tell qemu_event_set that there are waiters.  No need to retry
-             * because there cannot be a concurent busy->free transition.
+             * because there cannot be a concurrent busy->free transition.
              * After the CAS, the event will be either set or busy.
              */
             if (atomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
diff --git a/util/qht.c b/util/qht.c
index 67e5d5b916..b2e020c398 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -49,7 +49,7 @@
  * it anymore.
  *
  * Writers check for concurrent resizes by comparing ht->map before and after
- * acquiring their bucket lock. If they don't match, a resize has occured
+ * acquiring their bucket lock. If they don't match, a resize has occurred
  * while the bucket spinlock was being acquired.
  *
  * Related Work:
diff --git a/util/trace-events b/util/trace-events
index 4e894aa9c3..24c31803b0 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -28,7 +28,7 @@ qemu_file_monitor_add_watch(void *mon, const char *dirpath, const char *filename
 qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int64_t id) "File monitor %p remove watch dir='%s' id=%" PRId64
 qemu_file_monitor_new(void *mon, int fd) "File monitor %p created fd=%d"
 qemu_file_monitor_enable_watch(void *mon, const char *dirpath, int id) "File monitor %p enable watch dir='%s' id=%u"
-qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) "Fle monitor %p disable watch dir='%s' id=%u"
+qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) "File monitor %p disable watch dir='%s' id=%u"
 qemu_file_monitor_event(void *mon, const char *dirpath, const char *filename, int mask, unsigned int id) "File monitor %p event dir='%s' file='%s' mask=0x%x id=%u"
 qemu_file_monitor_dispatch(void *mon, const char *dirpath, const char *filename, int ev, void *cb, void *opaque, int64_t id) "File monitor %p dispatch dir='%s' file='%s' ev=%d cb=%p opaque=%p id=%" PRId64
 
-- 
2.26.2.windows.1


