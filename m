Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D57C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043242072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArCDdoeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043242072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY75-0003Jm-H0
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2f-0005vl-KD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2e-0007pX-90
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2d-0007kr-T8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id p17so1617332wma.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ievJYPkFEpwy+miP6JKeICVpFi5b+iJvMsgIGat87Fg=;
 b=ArCDdoeIkfi05KhsYAFuItNji8W/U6OpTzqtI86JGgWUzgncSEmbv01UBEy4Sv60Nd
 xNMd6JNFPLHU81Un5GCzmBfAHPHQjmDOzv1GMFZwsjLcVrlyFNfBU/zpLl4DtaCWCdKO
 2/kfEFaICnjhhPoxzfFBtXzkwrLxao7ZcIu6WCDlV9iOuBpPVdPvZ10UXT0EjCMX4sKe
 5LmPFy6F3YRDDv/iUox4LxoyqDWFWg6pMzTt0RrJQTpsKFDhI7mxZeDu71qChQcqmqgF
 3ir2E6Re0RsTJcosBFUIaU9RktDOSmHv9V95tUDaRcqU7NApMmtGFbEGi3qD7pswAz85
 AhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ievJYPkFEpwy+miP6JKeICVpFi5b+iJvMsgIGat87Fg=;
 b=qiZIfXxt/+0W+Qmnn5J8M6ve3Kiiu4s4zm7vcWj6z7RujmLnkqF4Q1G6iKCE1FvQtH
 WnRqXuRK7AJ2l+gGIEBq1PCV6xUuo2KqxvaFAdWacoXAkmp5ho+SRNL7GUibfGBVWeAz
 dnkKN75NS+WKPMRZf27j/a4xXOY2WXnv8a8cjFhpNqY1ZEZoNJy1AI7JJrgg2LaQi8TK
 p7YJjZPAHJFU6bvqx/9ZmVlIbMHk2H1npWQFVXEwvLSAPxXwijKIa1DH9adQie/9RF7R
 ZYDN/5TDpCvhlx6eo4S5pUxD4mUHcA81xZwWVi6UoZkqcsVnzVUm2KKuRThnTgG8URhb
 Z6aA==
X-Gm-Message-State: APjAAAW/bzy72A9o0slsd3Cy8kTwZz3iNFhQR37LuyBRB5faZ172FNDR
 ndaSAoNBpZJ4zIZTeehXgcm5i9UE
X-Google-Smtp-Source: APXvYqw0Whx9Y3w5YJoDKCSkav07LFoCV4bDGRSeBBpzSQzTPp54ZwI+SwI/vR+Ql8aKyViFt8omLg==
X-Received: by 2002:a05:600c:246:: with SMTP id
 6mr2639177wmj.122.1576670578547; 
 Wed, 18 Dec 2019 04:02:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.02.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:02:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/87] migration-test: Move hide_stderr to common commandline
Date: Wed, 18 Dec 2019 13:01:29 +0100
Message-Id: <1576670573-48048-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index fbddcf2..0c01ed3 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -558,6 +558,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 {
     gchar *cmd_src, *cmd_dst;
     gchar *cmd_source, *cmd_target;
+    const gchar *ignore_stderr;
     char *bootpath = NULL;
     char *extra_opts = NULL;
     char *shmem_path = NULL;
@@ -661,24 +662,19 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_free(extra_opts);
 
     if (hide_stderr) {
-        gchar *tmp;
-        tmp = g_strdup_printf("%s 2>/dev/null", cmd_src);
-        g_free(cmd_src);
-        cmd_src = tmp;
-
-        tmp = g_strdup_printf("%s 2>/dev/null", cmd_dst);
-        g_free(cmd_dst);
-        cmd_dst = tmp;
+        ignore_stderr = "2>/dev/null";
+    } else {
+        ignore_stderr = "";
     }
 
-    cmd_source = g_strdup_printf("%s %s",
-                                 cmd_src, opts_src);
+    cmd_source = g_strdup_printf("%s %s %s",
+                                 cmd_src, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
-    cmd_target = g_strdup_printf("%s %s",
-                                 cmd_dst, opts_dst);
+    cmd_target = g_strdup_printf("%s %s %s",
+                                 cmd_dst, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
     g_free(cmd_target);
-- 
1.8.3.1



