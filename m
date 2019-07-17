Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A8C76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94E220818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYVN4SO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94E220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZn4-0008Jz-PS
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZld-0002BS-7m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlb-0006R0-23
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:05 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:44911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZla-0006QA-Ro
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id i18so10366199pgl.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7FY9rArmeN2qGXWCSOPhl+5ILUXBgNadzkrqAFbuET0=;
 b=hYVN4SO+5XIW8q5ZNzatit06yB/L3Df29sQAdSUzh4H1LNzPS1fmWMVqwKm8HvI8h5
 nXm+ANWcEM+ihA8dbv+D8q6qA3ProkB5xiFnQc91rPkg9AMKEpGXq1gg3okqcm972cYL
 QI2tiLvixPOMKOBW+jhOwiRVXWzz9HeeOdGYGsmjdm093P/7AFHTk1ndPomA9MkqSqxo
 NNLvyVKPVsaTSM/9nrGNS0emhuXx9xbz3vwxAnlqo4OcZzGq9BUs54tHc+WQOZuTWSAD
 CIQIknszFEGiz0GVdBFMgpYmoo8Ea8O7JP363Dryb9ag37BJ+HSO5WukwFuxd/V+YKEr
 y8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7FY9rArmeN2qGXWCSOPhl+5ILUXBgNadzkrqAFbuET0=;
 b=ptZmKFMoL3zQMDwmdswNO/laZ/RXvslSjAyx8AskXBOYXLmVQbDftT9pp3O9mqe1SM
 uJkAS7WfQyG+mSFkArqeKGnRjBMPKofcJpv0J6hLFJ/QTrC/n5XYpzxHJ6FCbUAUeQeF
 n1J7bHm2kavPeAx+jJrGGy2cAwf/I5kwq0P1D2EyAfGdo8jAubDV9TM/DcbkGENItyIQ
 rp8skSRrUuCy5h4poupob2AhK+fA6+83CBeQIS0Whq4wvIUjVeEfV+CsFMiIzc87QvTD
 BcSlAFPCp75tbHjxGXCYHHsUEnjIYPj02ZjRN555px/ruOHcJwFpep8MAd+9KTN1ari/
 4v3g==
X-Gm-Message-State: APjAAAUQFfEOxxtw5aBKfjbSYrgBW69kwxwY3DxecOfY3iYpMIRNBiUI
 L7PuP8camm6C4h6+nVB9Enq+xBE9
X-Google-Smtp-Source: APXvYqyWNDrH5M/VgXOWJDavXmS1N67P/ZH1ErPedS5rC3efCszrmwBAzWP0dPrQYZ+X98G68easwQ==
X-Received: by 2002:a63:d23:: with SMTP id c35mr37568550pgl.376.1563330841443; 
 Tue, 16 Jul 2019 19:34:01 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:34:00 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:09 +0800
Message-Id: <20190717023310.197246-11-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
Subject: [Qemu-devel] [PATCH v14 10/11] qemu_thread: supplement error
 handling for vnc_start_worker_thread
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Supplement the error handling for vnc_thread_worker_thread: add
an Error parameter for it to propagate the error to its caller to
handle in case it fails, and make it return a Boolean to indicate
whether it succeeds.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 ui/vnc-jobs.c | 17 +++++++++++------
 ui/vnc-jobs.h |  2 +-
 ui/vnc.c      |  4 +++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 5712f1f501..1371895513 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -332,16 +332,21 @@ static bool vnc_worker_thread_running(void)
     return queue; /* Check global queue */
 }
 
-void vnc_start_worker_thread(void)
+bool vnc_start_worker_thread(Error **errp)
 {
     VncJobQueue *q;
 
-    if (vnc_worker_thread_running())
-        return ;
+    if (vnc_worker_thread_running()) {
+        return true;
+    }
 
     q = vnc_queue_init();
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
-                       q, QEMU_THREAD_DETACHED, &error_abort);
+    if (qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
+                           q, QEMU_THREAD_DETACHED, errp) < 0) {
+        vnc_queue_clear(q);
+        return false;
+    }
     queue = q; /* Set global queue */
+
+    return true;
 }
diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
index 59f66bcc35..14640593db 100644
--- a/ui/vnc-jobs.h
+++ b/ui/vnc-jobs.h
@@ -37,7 +37,7 @@ void vnc_job_push(VncJob *job);
 void vnc_jobs_join(VncState *vs);
 
 void vnc_jobs_consume_buffer(VncState *vs);
-void vnc_start_worker_thread(void);
+bool vnc_start_worker_thread(Error **errp);
 
 /* Locks */
 static inline int vnc_trylock_display(VncDisplay *vd)
diff --git a/ui/vnc.c b/ui/vnc.c
index 38f92bfca3..561fcb9a29 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3196,7 +3196,9 @@ void vnc_display_init(const char *id, Error **errp)
     vd->connections_limit = 32;
 
     qemu_mutex_init(&vd->mutex);
-    vnc_start_worker_thread();
+    if (!vnc_start_worker_thread(errp)) {
+        return;
+    }
 
     vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
-- 
2.11.0


