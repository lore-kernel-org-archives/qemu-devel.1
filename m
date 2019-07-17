Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DFC76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0577220818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF1E10oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0577220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZnH-00018C-7U
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlV-0001eb-DF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlU-0006K8-9r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlU-0006JX-42
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:56 -0400
Received: by mail-pl1-x641.google.com with SMTP id a93so11102121pla.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zYeWHhuJyr6C57qu/O6Tfde/UDD5ubrHcW5il7tqHN0=;
 b=jF1E10oAX2REYrHcFCGzd/yfpWFDc0GP8R9N6kKgp39rBfc2rEzrH0CI9ISXzVE/yp
 Xmuw094VToo7TtbcQnNqjOd4DmV/2Fe/H0PYqR4g7Gj7Y6m3Yvo8PWZXVZl0Lpou6NiK
 SUquIM/mgOImmi1kbfgZqBqSGGEwmo66ujCwlIOxP8yLgCwsob/zwmAmPCcqdGO+TFKW
 tz0FcPEDJ6QH3ewr96KshaGNrp1jYrseFHJNhOjAEgAlIYYFhanVVHDCfYtKpSAF/xRC
 5SwbMHYUpH18CLdmvm7FbwEBL0so40VAXpYsggjISpucKJcGhlMjo55NnqxkiLKQ45mJ
 RNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zYeWHhuJyr6C57qu/O6Tfde/UDD5ubrHcW5il7tqHN0=;
 b=V3RnDMUx0QKtwO0dhIkIGvtfdNx6YRBPWDOOH3B17Ecgkd6LMLPjQ9XDWPsoGIOmNB
 TUoQSuWQm2efDLmkqLCW77lLQYr6kihShYv+C4OLuubpoLyYgt8PEEO6x+3d5gFuCKmT
 TO263S/9QCL6QZk3wy/Qm36NGzyd8th8uKRPosl3p06s2/tVZZIp2D8RtgnBSq4HgvUx
 zDwTVTStEAGsh3lq2d4JiEb5GgrR9Rp7PrJFC/kn3g9Q9M13mTx7A/XVDXG0KDoafnGz
 p1f+QFaqbtpykfRsP+iai2DSE6aglbqyx9EQj9MmsqDRXCdyltw7RJ5XjU5k8lRS57I0
 G8WA==
X-Gm-Message-State: APjAAAVEx4hH3q642ImUyfP+lYIKi0iAMZMj9/zipmWH26LcauPnd9so
 8AwrVotFoxiQdD8R9mvXwvwTQWjG
X-Google-Smtp-Source: APXvYqzfHE4Veq5xUBRVaH3akALkmxIX2GRgX7A1PlM86NtrsKBeCBFKoSy/8tDVFZgEcoilAQL0hw==
X-Received: by 2002:a17:902:2d01:: with SMTP id
 o1mr40535538plb.105.1563330834806; 
 Tue, 16 Jul 2019 19:33:54 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:53 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:07 +0800
Message-Id: <20190717023310.197246-9-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v14 08/11] qemu_thread: supplement error
 handling for qemu_signalfd_compat
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set errno, do some cleanup, and return -1 to replace the temporary
&error_abort when failing to create sigwait_compat.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Fei Li <shirley17fei@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 util/compatfd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/util/compatfd.c b/util/compatfd.c
index caad10ae56..bd15464586 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -70,6 +70,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     struct sigfd_compat_info *info;
     QemuThread thread;
     int fds[2];
+    int ret;
 
     info = malloc(sizeof(*info));
     if (info == NULL) {
@@ -88,9 +89,15 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     memcpy(&info->mask, mask, sizeof(*mask));
     info->fd = fds[1];
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
-                       info, QEMU_THREAD_DETACHED, &error_abort);
+    ret = qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
+                             info, QEMU_THREAD_DETACHED, NULL);
+    if (ret < 0) {
+        close(fds[0]);
+        close(fds[1]);
+        free(info);
+        errno = -ret;
+        return -1;
+    }
 
     return fds[0];
 }
-- 
2.11.0


