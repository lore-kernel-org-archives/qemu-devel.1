Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8145DC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AE620874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AE620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhzN-0005lz-0J
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrs-0006Pq-RS; Sat, 19 Sep 2020 14:45:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhra-0001SW-BM; Sat, 19 Sep 2020 14:45:49 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MidPj-1kw3QF3cff-00fmoJ; Sat, 19 Sep 2020 20:45:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] util/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:47 +0200
Message-Id: <20200919184451.2129349-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ehfi+oTY16DeI5q/etW01GO+5fC510ZRrlSNTH42fayL5cZjRix
 lKScQ9KKLVWiWK7CGPuUxZu6/4KbPcvPt68tkQUc9nzCrKMGTGV/ZaTZqBUaWgsRuwXDteT
 3qo1NVyumoxp/cnlIT9ko090ERgkEGg1oIHEYHQv56FwhwaRybXIU/im5QaSMptvFZhjJST
 zww4f7hNt8utIfYfGIKUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WXcGPbfjAeA=:F/jG5bojOVhXBhSx3gewrX
 ViTQUC5MwKQxe4QF6vCvm/WlllY8Wn8BudpKV3/g4oiCCTTL2eOCd+C+j1G1pHXxQY+80njka
 fTXOPWFvn1xP4n+uqdGgVNCOAfmff0va29VOEdp7mw6F4MqOX0mhDWE+yjKfC5q4URSbiT99b
 h+VsvJ7DOgIShTMo5pWvWhNKBEAdU60jojdFglxrpmHiIelCbIjMJ2lxEjJZfItCO97M2yblb
 AVLrmanB/rCtYuzS9XHDA1y+JOFBWCPNH1G1e6Yt5P6ZV+34hxx69dbNSQk00Tf+qGBKmYNPs
 lsdDU/MYiGR/1vY9snbkS3wp1L2wMkqJuVhogjSkrrXIvEVNRexyeAiHE7x3fR7sfRbm436Gm
 Ajjf0tfBV38UQYDcX0jeTUY+we1hoF4XchpzjZMGACIy55OURwxFt7XLQjtfeufS4sJ4oAbgR
 d8+u9UeD9qkFxbB3BsPb/Q1oM3XXH8anHeQmmKqqbxSJoKymB2AjC5vy+llk4KIbOSm5EgNb9
 pAf0QR4mSFgrS3ozkLAS8vDq43qoGbPHk9e+k01kjDr07TczZjOazfG+frlseSlbrpe8s+tM0
 b9GVvdyqPjHSUz6NTY6iQT/W4iJMbnlAFzUPxH+JmxvRtcqo7obsXp3+o2d+m9Joydu8iSWyP
 Elfjp/GzhhPQbZxUVqnVgSzG/Y3dDZdGPVyT3vzI5KsLfX34lhhjqoS1djlDd00Xft9IPw+63
 QdA3HbKgMPl8NQeUNdCvULcaKXvx1pXUsOA0mbzi3xZ3BLScjcVk1RgxxSVIl3lgp7El4WWPF
 XU7OslDrfv+8CM/mPy1zqNUZyqOiqHy8E5Jt7f1lOjQQR3SPdL5Vjq4VmV2ag7f9shWCtrT
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Alex Bennee <alex.bennee@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the util folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
Message-Id: <20200917075029.313-6-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/osdep.c             | 2 +-
 util/qemu-progress.c     | 2 +-
 util/qemu-sockets.c      | 2 +-
 util/qemu-thread-win32.c | 2 +-
 util/qht.c               | 2 +-
 util/trace-events        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 4829c07ff6ed..e50dc2214e36 100644
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
index 3c2223c1a21c..20d51f8c128b 100644
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
index b37d288866c5..99ce2fd5e61e 100644
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
index 56a83333da6d..d207b0cb5885 100644
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
index 67e5d5b9163f..b2e020c398d0 100644
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
index 4e894aa9c38b..24c31803b014 100644
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
2.26.2


