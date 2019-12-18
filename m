Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAF6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470FA2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHW1zUV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470FA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYkF-0000ij-Pg
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3i-00078N-Ce
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3h-0002ka-1I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3g-0002g5-PA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:04 -0500
Received: by mail-wr1-x443.google.com with SMTP id w15so2020313wru.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nb2hZFwKzalXfmKpcbYjmUeCAEo1SDTH5IqQlmfU414=;
 b=fHW1zUV2NBhZZyFNuIowLz4r8UhpwuyCtZXruINma5lD1n7f+nKSTyOfk3bPgoZ5pk
 bR7GlCt4BT/NWeAjq5HZk9MyAQ99qCwJSxSltvzEbSa7NqWe03WgXlcEA8mC10QdJARz
 jhWBNH6Rp5LM3Bgeu2tAUCwdadi0d5Oh1gJiakMRHysVA6kNoHTie6an6uJ03ZRjgAgW
 B9nweCRRNqmM40I4eFMD/tIrouVMsifL7aiy9nnujLyvQVlpp+Zy2+BzXh3PIJNhaPhX
 z0fhayWkC1ZrAvUCdR9VdlSJ2vHegItofBEXTWL6DRJHGH/nzRkUYFwTLdfAuEGUbZCK
 nmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=nb2hZFwKzalXfmKpcbYjmUeCAEo1SDTH5IqQlmfU414=;
 b=ApMRytfk7Bg/9h/zX/f7y1kK+ZyC78mOPb09jydzuFdGzo7jDN5+yCI6o4IWaYZCyZ
 Mssrlk6MO52pI/OAisp7EdxzrK6MBJjicP0eWgF1uaLfKeTFFL56ZkyD/CYvCSLbLQRd
 PXrskJtTQhrMJVSc9ITclZxhjkQMa/VOf5tqTY1esAcvhn1AMTrzjrlmR1XWBoxszk6z
 7S6vr9by3v/XsdtwsIjn+e9qir89VhIkks9jS5ZGrx5XEaZZ9jfq1TQcTn0+z9pGfEbJ
 ZoGP1m91Y3w9IMx7xDaphRl94mvZWN0jOa3miRZ1HF/XoB52GSGCxxWYK7nI+d6jIj/Z
 NI2A==
X-Gm-Message-State: APjAAAXtTQhLflGHJUPSOM+BWijExybYfkipaSCtpCpBqK1+fvnW4hlS
 66Ne5gapR3ARtkwuE1Kc56DNclMZ
X-Google-Smtp-Source: APXvYqwJR0ocuhTVEdjWJrsWVGEGaynZQ5wMNX7bUGXbRwVxH7U/givIl86J91O296mNrm031sfRfQ==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr2333089wru.94.1576670643458;
 Wed, 18 Dec 2019 04:04:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 60/87] qsp: Use WITH_RCU_READ_LOCK_GUARD
Date: Wed, 18 Dec 2019 13:02:26 +0100
Message-Id: <1576670573-48048-61-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The automatic rcu read lock maintenance works quite
nicely in this case where it previously relied on a comment to
delimit the lifetime and now has a block.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qsp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/util/qsp.c b/util/qsp.c
index 6226541..7d5147f 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -598,7 +598,6 @@ static void qsp_ht_delete(void *p, uint32_t h, void *htp)
 
 static void qsp_mktree(GTree *tree, bool callsite_coalesce)
 {
-    QSPSnapshot *snap;
     struct qht ht, coalesce_ht;
     struct qht *htp;
 
@@ -610,20 +609,19 @@ static void qsp_mktree(GTree *tree, bool callsite_coalesce)
      * We must remain in an RCU read-side critical section until we're done
      * with the snapshot.
      */
-    rcu_read_lock();
-    snap = atomic_rcu_read(&qsp_snapshot);
+    WITH_RCU_READ_LOCK_GUARD() {
+        QSPSnapshot *snap = atomic_rcu_read(&qsp_snapshot);
 
-    /* Aggregate all results from the global hash table into a local one */
-    qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
-             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
-    qht_iter(&qsp_ht, qsp_aggregate, &ht);
+        /* Aggregate all results from the global hash table into a local one */
+        qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
+                 QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+        qht_iter(&qsp_ht, qsp_aggregate, &ht);
 
-    /* compute the difference wrt the snapshot, if any */
-    if (snap) {
-        qsp_diff(&snap->ht, &ht);
+        /* compute the difference wrt the snapshot, if any */
+        if (snap) {
+            qsp_diff(&snap->ht, &ht);
+        }
     }
-    /* done with the snapshot; RCU can reclaim it */
-    rcu_read_unlock();
 
     htp = &ht;
     if (callsite_coalesce) {
-- 
1.8.3.1



