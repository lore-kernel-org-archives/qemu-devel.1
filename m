Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63A0C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AE12081E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD4lcCRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AE12081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXfO-0000ye-4H
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5C-0003s1-8D
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5B-0005GD-8S
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:30 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:43232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX5B-0005Fy-4z; Mon, 06 Jan 2020 13:26:29 -0500
Received: by mail-qv1-xf42.google.com with SMTP id p2so19408978qvo.10;
 Mon, 06 Jan 2020 10:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JQxTRPnPlhXn/y/TL9t8metwExxAfIfNbs5Qew1wUwQ=;
 b=tD4lcCRN/yapUlr0QvtqVHeZ6aifJvSjso4C98TRGStU6v5qr34PW2eVaHPgO+DXdK
 Q4sDCoimJ3eLNhiSpplK8TKYuubQRE35M7vOTPI1MWLGlmh4hhlGmDZ9sf8MJd5BXISC
 usm62KGtedERfjrr7Q3gXRrm4iiiMyZhAgj05V+BkjAp6u07HHgF8+/G5Qt+z/pV+WtD
 ailQ3yyxCzdzTX3Bv5yfZhHVr6JEA7Kk3Lh19Y+Bsusu8Pf5uka+l6KhGk7u2Z62XZjx
 N6lBJJwXEAPjjH8GRlYkRmogKphX3dw88lA1pGng5TdWlktmwTOXRAaYWW6Exw+ZZ5AG
 T75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JQxTRPnPlhXn/y/TL9t8metwExxAfIfNbs5Qew1wUwQ=;
 b=XfWTX5fo1/1nLJsUxu1OXS/aOEioJMb/m0YUZnMJGBcsbd0rgPYpqCr88ZpLmAu32u
 Vzqe4s/1F/BDeeTu+finyaKXFdNv5N4Z2A3FXbibS7gVugotBcIprbjBc22uHwzCx+jM
 5oEPEnrstlSD89ayzuwz/leWn0i3WTJ//zemjRWYWSeQ7D8xXPipw9GLvv2FPETsRKTE
 Yyhyrvi+V9Dm7iVv/yocVHj7L6PmdmQLQQxycaLvfl/MoCm9UGaS7Zk+DmRl7ouNSMKk
 UnKsWrhrijfOjkT0Z04dnh3dE3QrsZs0/NjrmyO2QZ77Gc3vdi5O7pDQTCFqgpI9XDRM
 IDiA==
X-Gm-Message-State: APjAAAXV34tFwZYEQpg0VUii+x9JTXlhdxJI0xL5V/7Nukzk4XlU6qkP
 4dvClbPUvANCXHQ+EeUlxZV0/5g1
X-Google-Smtp-Source: APXvYqwxzpST7Aq/bU8yDjkptRfPj1gmygJph2a1ZL8w3deaE1bHYZ89DjZ8XuKU8V4IXlaKzZap7Q==
X-Received: by 2002:a0c:ed32:: with SMTP id u18mr81340466qvq.2.1578335188543; 
 Mon, 06 Jan 2020 10:26:28 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:28 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 54/59] ivshmem-server/main.c: remove unneeded label in
 main()
Date: Mon,  6 Jan 2020 15:24:20 -0300
Message-Id: <20200106182425.20312-55-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'err' can be replaced by 'return 1'.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 contrib/ivshmem-server/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index e4cd35f74c..b491e8237f 100644
--- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -217,7 +217,7 @@ main(int argc, char *argv[])
     if (sigemptyset(&sa.sa_mask) == -1 ||
         sigaction(SIGPIPE, &sa, 0) == -1) {
         perror("failed to ignore SIGPIPE; sigaction");
-        goto err;
+        return 1;
     }
 
     sa_quit.sa_handler = ivshmem_server_quit_cb;
@@ -226,7 +226,7 @@ main(int argc, char *argv[])
         sigaction(SIGTERM, &sa_quit, 0) == -1 ||
         sigaction(SIGINT, &sa_quit, 0) == -1) {
         perror("failed to add signal handler; sigaction");
-        goto err;
+        return 1;
     }
 
     /* init the ivshms structure */
@@ -234,13 +234,13 @@ main(int argc, char *argv[])
                             args.shm_path, args.use_shm_open,
                             args.shm_size, args.n_vectors, args.verbose) < 0) {
         fprintf(stderr, "cannot init server\n");
-        goto err;
+        return 1;
     }
 
     /* start the ivshmem server (open shm & unix socket) */
     if (ivshmem_server_start(&server) < 0) {
         fprintf(stderr, "cannot bind\n");
-        goto err;
+        return 1;
     }
 
     /* daemonize if asked to */
@@ -269,6 +269,5 @@ main(int argc, char *argv[])
 
 err_close:
     ivshmem_server_close(&server);
-err:
     return ret;
 }
-- 
2.24.1


