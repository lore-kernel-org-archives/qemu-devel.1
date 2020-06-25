Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C85C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4705207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXt9wr8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4705207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWl0-0007hS-6E
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joWkM-00075N-2u; Thu, 25 Jun 2020 14:37:14 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:38525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joWkK-000610-Bv; Thu, 25 Jun 2020 14:37:13 -0400
Received: by mail-ej1-x62a.google.com with SMTP id w16so6936679ejj.5;
 Thu, 25 Jun 2020 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=GKkAJhwha8cKYDehreDnh5CcXHSeneMe9sSYaVsY27w=;
 b=YXt9wr8mI5EGf8hHXvAWlhZWUhQ2u9L9nxvm5ZYLe6foyh2ebXGxikhlMN80AAHxoh
 ldfj+uD0yOcoo1WQ6gmtN7KdNgUtyPTMlZlHQ2GKK++LRmeRsktrIpkYR5QYFAinGRYO
 tjhVbS1b7atB1SSC8JB3oaoGbbW3lWcIfFJrEF/kkiHrwyrYRIZ13NtkYDj6KWIc3fhW
 hRTl6sVdooIoD1DO+yD7w2gHR91QAYXqeHbzdHV5c7XQY6fxVnlTtI9BHT64HQ0SIFkR
 HQPi3JWdKLUPRViFzFOFIEeUZvxULpza6IOA3eshsqkuO1K3mDe7hQcBqRZy1CEE5J/J
 Y18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=GKkAJhwha8cKYDehreDnh5CcXHSeneMe9sSYaVsY27w=;
 b=VWk7I4uEf+twa6kYqW2kkqY7KpvYLljWzLhFwRuihKaNuY+DwDYnKtaJ/A9ETiW6hF
 /YexPkG+tTOmVyUaQ24Bt8p8Ow+0PY6ihKKnXoYU5gcr+U9IHAouI+2J0Mveqtg3gJqZ
 orqwSMYKf93rpHo9CUk+4GyeJhSkI7WuiS2oRwdlNk0XCkejS+vqwcUmudEoDgBNbrUV
 VeWEWpfawiGOawtY6AgTFthmpaJHiZag66ImlNXrPuEkpdSsKaRqK/ngRxx97r87DS+q
 7onNgjxAiOUvmrhfbeQwoy0+naY+BkQePvYx2xo3Q+h0weMI1RsVWsUTHnuP6AmvNxZp
 7EFA==
X-Gm-Message-State: AOAM533hQsuKauDfOf5vqKPQOPYNWP/gXvQMTIr3yXE9eIhu3LojCjxs
 PtSf+5A1ztoZZE0a85wJs8/WfK+SsVm/GPHrUN0Q7RbVurQ=
X-Google-Smtp-Source: ABdhPJz0W3kJBS2XDZvoXTFb7xuAqW3LOh2L9+PfrRe+E02WpgVX+xtUcbmXKouFxNpXCXWpF+n3Ec3GHOI0/NlHBqA=
X-Received: by 2002:a17:906:58c:: with SMTP id
 12mr25576173ejn.311.1593110229870; 
 Thu, 25 Jun 2020 11:37:09 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 25 Jun 2020 19:36:59 +0100
Message-ID: <CA+XhMqyTLP5_Jf=t8OCsMifrme0DgimM8-D=Y0RRR+779052Bg@mail.gmail.com>
Subject: build: haiky system build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 25adbdcdc17ef51a41759f16576901338ed8a469 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Thu, 25 Jun 2020 19:32:42 +0000
Subject: [PATCH] build: haiku system build fix

Most of missing features resides in the bsd library.
Also defining constant equivalence.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure            |  4 ++--
 include/qemu/bswap.h |  2 ++
 os-posix.c           |  4 ++++
 util/compatfd.c      |  2 ++
 util/drm.c           |  2 ++
 util/main-loop.c     |  3 +++
 util/oslib-posix.c   | 20 ++++++++++++++++++++
 util/qemu-openpty.c  |  2 +-
 8 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index ba88fd1824..3732ad4e35 100755
--- a/configure
+++ b/configure
@@ -901,8 +901,8 @@ SunOS)
 ;;
 Haiku)
   haiku="yes"
-  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
-  LIBS="-lposix_error_mapper -lnetwork $LIBS"
+  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -D_BSD_SOURCE $QEMU_CFLAGS"
+  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
 ;;
 Linux)
   audio_drv_list="try-pa oss"
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783..1d3e4c24e4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,6 +8,8 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
+#elif defined(__HAIKU__)
+# include <endian.h>
 #elif defined(CONFIG_BYTESWAP_H)
 # include <byteswap.h>

diff --git a/os-posix.c b/os-posix.c
index 3cd52e1e70..ca07b7702d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -42,6 +42,8 @@
 #include <sys/prctl.h>
 #endif

+#include <sys/mman.h>
+
 /*
  * Must set all three of these at once.
  * Legal combinations are              unset   by name   by uid
@@ -339,10 +341,12 @@ int os_mlock(void)
 {
     int ret = 0;

+#if !defined(__HAIKU__)
     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
     if (ret < 0) {
         error_report("mlockall: %s", strerror(errno));
     }

+#endif
     return ret;
 }
diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d14..ee47dd8089 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,7 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"

+#if defined(CONFIG_SIGNALFD)
 #include <sys/syscall.h>
+#endif

 struct sigfd_compat_info
 {
diff --git a/util/drm.c b/util/drm.c
index a23ff24538..8540578c09 100644
--- a/util/drm.c
+++ b/util/drm.c
@@ -38,9 +38,11 @@ int qemu_drm_rendernode_open(const char *rendernode)

     fd = -1;
     while ((e = readdir(dir))) {
+#if !defined(__HAIKU__)
         if (e->d_type != DT_CHR) {
             continue;
         }
+#endif

         if (strncmp(e->d_name, "renderD", 7)) {
             continue;
diff --git a/util/main-loop.c b/util/main-loop.c
index eda63fe4e0..1ce3081ced 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -85,6 +85,9 @@ static int qemu_signal_init(Error **errp)
      * by sigwait() in the signal thread. Otherwise, the cpu thread will
      * not catch it reliably.
      */
+#ifndef SIGIO
+#define SIGIO SIGPOLL
+#endif
     sigemptyset(&set);
     sigaddset(&set, SIG_IPI);
     sigaddset(&set, SIGIO);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 39ddc77c85..a18d90a68a 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -38,7 +38,12 @@
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
 #include <libgen.h>
+#if !defined(__HAIKU__)
 #include <sys/signal.h>
+#else
+#include <kernel/image.h>
+#include <signal.h>
+#endif
 #include "qemu/cutils.h"

 #ifdef CONFIG_LINUX
@@ -390,6 +395,21 @@ void qemu_init_exec_dir(const char *argv0)
             }
         }
     }
+#elif defined(__HAIKU__)
+    {
+        image_info ii;
+        int32_t c = 0;
+
+    *buf = '\0';
+    while (get_next_image_info(0, &c, &ii) == B_OK) {
+            if (ii.type == B_APP_IMAGE) {
+                strncpy(buf, ii.name, sizeof(buf));
+            buf[sizeof(buf) - 1] = '\0';
+        p = buf;
+                break;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..c29fc2cbf9 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -35,7 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"

-#if defined(__GLIBC__)
+#if defined(__GLIBC__) || defined(__HAIKU__)
 # include <pty.h>
 #elif defined CONFIG_BSD
 # include <termios.h>
-- 
2.26.0

