Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9331C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9477A206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dop9sJpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9477A206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKqN-0004pP-Tf
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiz-00083B-8W
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiy-00041x-5A
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:43:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKiu-0003xq-6k; Thu, 01 Aug 2019 19:43:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id m30so34966476pff.8;
 Thu, 01 Aug 2019 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SGET1+BaXv2xF+ZaaIzchQNPmiaNzqs+vIMzu3BZllk=;
 b=Dop9sJpGk0rej4dqIPkKgIeYWb5+cQsQ9cwnjy91yPZ5P8xuHDUQeIHLOrTxnIZs3P
 J7JapdHfhCl5v0BdOzVlqh5jIktZ+LSiXrnOLduNDelXb++bYY2fuBaj16fPnIS8HsSm
 p/aBimOih24v1pwqysZjzTjgWxKzBwbFhxcdd1qhmyWhUGQ7dIb9rkfz7oRpLm9fafDZ
 t8WwVGG+Yzzuaw0HiD+uY/1kTsfgIXVs6kasYEPv88iUm/aTHcaJUi2ZarZCM2VdlwBd
 YjWJiskUkK4JCjXawYkgVJzLKriKiZ3prjW0zysRd9QOXmEfw6dASvhIwdWulbgDiJsT
 N0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SGET1+BaXv2xF+ZaaIzchQNPmiaNzqs+vIMzu3BZllk=;
 b=L6m+FsBhih6NUiEtUEWJqpKZB7zOVjMtXNPP6WPTUJnnCQ+m22Lr+L75NnkzuAEuf6
 A3PgTzqR+/z9RxYOKRPqRh1otM4s9PTARgiW3ldaD893fqkiR02FVwDoo1f9jDiKtWpv
 O2WtesbrnWfeiQnvGOceNp+d4JGibwfW5FN59nCvCTJckvjH5xk10tVxQDX3xb3R/01l
 52Mn+Br+KrhzxZOCXG8DhESE13IJ1vyCrjlskPFhPC66FVLUDzV+b5D2oDHOiL+xDRgW
 v//R5DgtgpT7+6oXpdIjP1iQk+Ls0q6bDiSTtk1/mmog5R0MlP4XOWc1UIWEFLTg40s/
 Ggyg==
X-Gm-Message-State: APjAAAWUpnCM3hr98qt//yH7fRxNRF1FVorMhD8lSzkSe52mg8Pv3z/I
 DtmstvFu3ZTPb5xrJMJQgAmbiCA1q/+6kQ==
X-Google-Smtp-Source: APXvYqxfPUnKHr7puIEXDDmluibt2ZKV+yxlgoiXaqu56BSvlkbkRLpdEyfes7hen9ChDBGaUAkL+w==
X-Received: by 2002:a17:90a:fa07:: with SMTP id
 cm7mr1320581pjb.115.1564702981638; 
 Thu, 01 Aug 2019 16:43:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.42.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:43:01 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:31 +0530
Message-Id: <20190801234031.29561-18-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v9 17/17] block/io_uring: enable kernel
 submission polling
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/io_uring.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 1553cd2e58..2a1d79704a 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -288,6 +288,17 @@ static int ioq_submit(LuringState *s)
             *sqes = luringcb->sqeq;
             QSIMPLEQ_REMOVE_HEAD(&s->io_q.submit_queue, next);
         }
+        /*
+         * io_uring_submit() returns sqes in ring for kernel side
+         * submission polling and sets wakeup flag if needed.
+         *
+         * It is not possible for any sqes to have already been
+         * submitted by the sq_poll as the writes are only made visible
+         * to the kernel in this function.
+         *
+         * For normal I/O, it returns the actual submitted requests
+         * from io_uring_enter()
+         */
         ret = io_uring_submit(&s->ring);
         trace_luring_io_uring_submit(s, ret);
         /* Prevent infinite loop if submission is refused */
@@ -525,7 +536,11 @@ LuringState *luring_init(Error **errp)
     s = g_new0(LuringState, 1);
     trace_luring_init_state(s, sizeof(*s));
     struct io_uring *ring = &s->ring;
-    rc = io_uring_queue_init(MAX_EVENTS, ring, 0);
+
+    rc = io_uring_queue_init(MAX_EVENTS, ring, IORING_SETUP_SQPOLL);
+    if (rc == -EOPNOTSUPP) {
+            rc = io_uring_queue_init(MAX_EVENTS, ring, 0);
+    }
     if (rc < 0) {
         error_setg_errno(errp, errno, "failed to init linux io_uring ring");
         g_free(s);
-- 
2.21.0


