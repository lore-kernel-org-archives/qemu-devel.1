Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7397ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3897F21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5qECsBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3897F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeA5-0003Dp-DA
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdih-0006x8-RV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdig-0007d5-JT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdif-0007c4-Ou
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id q70so3010998wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iL8S6iR4ZZdsmfsAcUJx7cMaYd8Hzxazv3RVTVkKUIU=;
 b=r5qECsBzMoHnH9oYTdqnwSkwxzMAcjqDHgOrOENov38N4SKCao4pyClT42QpKYifIx
 SZIUAJw3EL+zNKVP9N9KG7cS79k/tGMej1nPTKIQYeGXMNQG8wMobEQbhXcMYqoliLRP
 6oCVCrSaVmUoUECfmTCHroDpy/+wvYUGKAwnkzxz3YpgPePlTv/RRxJWLWfVTe/KFkgr
 /AVxYOc6QbrO22odbMy/JkKZfWx5B9upbvVf7ma4WyH5OuI5t06BtKr1gjRm4xEeQVIb
 32Jdm7a52ejFoo7VJq2JtXg14/GHXZw6kzu2+ijHfHrY/1sHc9eHSSVYm6oJ8MSoRL8g
 WrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=iL8S6iR4ZZdsmfsAcUJx7cMaYd8Hzxazv3RVTVkKUIU=;
 b=QNp+1/qgS9Yc+3xUHDLxH18LSBUdiLgN0/5gfSuuPKJgdUJGe9WkbxRJbCDd4hTpzC
 p6PVbYpOeIYdH3oTrzPH3vDgMidpcjBtKlQK9bTcZoQL1RbqzC2W23+GgZcd/WC6+6cN
 V6y/AWA/o5ZMad6at6Eo9miItQhZmPngWg6Gaut2FhxGjsHfHkJ4NEHI1sih77/0r53e
 IPZhUqMUk/O7K/4RavfJieNLWATP5P7nVDkAsgj+Q9yK2RvMXwfsiRC+/upIjcpsd+PV
 uoif9QilS3lSnRr8grSQ3m4dl5fbWLX9AU1VxnqP2hO0f5jjqFtTAwwsXZLhjnyPWahy
 93Kg==
X-Gm-Message-State: APjAAAXF8sMU4kfS6rf4Dnm9Ll+g6g/+jaXcCE6AYCild+sJ4xXDx93A
 esNqfDul6UBvoTGJQMnPXYgVgAs8
X-Google-Smtp-Source: APXvYqx06gt8bV4kHJTdwiiTMWl8QalRrQ3caQB2z6aONCWr0QBxGt5XsfAj8EXyKTgjO1/8MqY9ag==
X-Received: by 2002:a1c:7913:: with SMTP id l19mr5391774wme.26.1571925843125; 
 Thu, 24 Oct 2019 07:04:03 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/39] Do not use %m in common code to print error messages
Date: Thu, 24 Oct 2019 16:03:21 +0200
Message-Id: <1571925835-31930-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The %m format specifier is an extension from glibc - and when compiling
QEMU for NetBSD, the compiler correctly complains, e.g.:

/home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c: In function 'sigfd_handler':
/home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c:64:13: warning: %m is only
 allowed in syslog(3) like functions [-Wformat=]
             printf("read from sigfd returned %zd: %m\n", len);
             ^
Let's use g_strerror() here instead, which is an easy-to-use wrapper
around the thread-safe strerror_r() function.

While we're at it, also convert the "printf()" in main-loop.c into
the preferred "error_report()".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191018130716.25438-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/tmp421.c | 4 ++--
 util/main-loop.c | 3 ++-
 util/systemd.c   | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 9f04470..c0bc150 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -120,7 +120,7 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
     int tempid;
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg(errp, "error reading %s: %m", name);
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
         return;
     }
 
@@ -160,7 +160,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     }
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
-        error_setg(errp, "error reading %s: %m", name);
+        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
         return;
     }
 
diff --git a/util/main-loop.c b/util/main-loop.c
index e3eaa55..eda63fe 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -61,7 +61,8 @@ static void sigfd_handler(void *opaque)
         }
 
         if (len != sizeof(info)) {
-            printf("read from sigfd returned %zd: %m\n", len);
+            error_report("read from sigfd returned %zd: %s", len,
+                         g_strerror(errno));
             return;
         }
 
diff --git a/util/systemd.c b/util/systemd.c
index d22e86c..1dd0367 100644
--- a/util/systemd.c
+++ b/util/systemd.c
@@ -60,8 +60,8 @@ unsigned int check_socket_activation(void)
              * and we should exit.
              */
             error_report("Socket activation failed: "
-                         "invalid file descriptor fd = %d: %m",
-                         fd);
+                         "invalid file descriptor fd = %d: %s",
+                         fd, g_strerror(errno));
             exit(EXIT_FAILURE);
         }
     }
-- 
1.8.3.1



