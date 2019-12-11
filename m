Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB18C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2765520836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLnIGARi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2765520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if30z-0004OH-SA
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2ty-0005Qa-2D
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tw-0003GG-3N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:41 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2tv-0003E4-Kx; Wed, 11 Dec 2019 09:23:39 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so7177817wmf.2;
 Wed, 11 Dec 2019 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KN9etHlviUCG+vbW1yGc2GU/5pE4ak3K4nMaIwbbgzo=;
 b=pLnIGARi5BmE/p1ouE8fQ+i99DJA6bSr0I5aKD+VjiD/xNbZqL7f5iEcvB2fUhipjM
 2HyWrbeZtub/BRAjgPwyZOQ+HBBctgwSATArGnWZ2KXLJkekY0GqXvm71IPHmt1JZLA0
 lz88/4WmtA8bvfMklZMScak95lf5/pJe5ju8njQF5QX/GsaX+nhMs2uEkAlIx4icH+R+
 kjMKYH85GcPfLkJ0OaiuTm+st84ff2VJ0IqoDzI+yLL5PvyKl5nI9HfbLFlb4O2OpX//
 7DROM9a4B9wvtvDmaCHuNko7YF7T8mQ+6EK4Ifwc2ZbSobPbKegiUbO5WwzHAfZucSjA
 KkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KN9etHlviUCG+vbW1yGc2GU/5pE4ak3K4nMaIwbbgzo=;
 b=U/zMB2wbvaEmi9jOQzsCstsaLvVviCJlqDY3lB6PARWIg/leLLL+4ziqvRyrS2GKTq
 DjSMtOx/7V8L32/i9onhVh1s9/m6uUGc0Iyms60d1qBupM5xVVYDXbfio4hDsk/ESkXl
 PF1xbJi5C4c0YNaPsMV5t5z7SiF53ZN4uxLp9DYnUGcP5HSE558sG69YtAU3pstGiQX5
 t2WtluU0Ua5qdOslCesNZdenOK2cAjU/5ww9+cJ0ehdCuLt3GksAQzFEEoD6vEm5aX05
 3Uxo6HEyeKURAPfPS5KGOQKFjPWiNI21YHd+szHGI9N5GofVHEo1K0y/GY7XoUxD00pm
 HFrQ==
X-Gm-Message-State: APjAAAU1XqU7N4035MmZvo5wcBUWK3w1BZZWuh3dREEtqCROAHYsPDYi
 pLZR5wdMSHb7C4RR882KG4qOI1TZ
X-Google-Smtp-Source: APXvYqwfq/vrAT43jWS9/sgvgllG0n04BBZPwQcLnXRQXHIaie2AaCYOkTbLlPiYifMs5qLCP+F2yw==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr49725wmg.170.1576074218369;
 Wed, 11 Dec 2019 06:23:38 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g23sm2503783wmk.14.2019.12.11.06.23.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:23:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] glib: use portable g_setenv()
Date: Wed, 11 Dec 2019 15:23:28 +0100
Message-Id: <1576074210-52834-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

We have a setenv() wrapper in os-win32.c that no one is actually using.
Drop it and change to g_setenv() uniformly.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/os-win32.h        |  2 --
 os-win32.c                       | 22 ----------------------
 tests/libqtest.c                 |  2 +-
 tests/test-crypto-tlscredsx509.c |  2 +-
 tests/test-crypto-tlssession.c   |  2 +-
 tests/test-io-channel-tls.c      |  2 +-
 tests/test-vmstate.c             |  2 +-
 ui/sdl2.c                        |  2 +-
 8 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index ff18b23..d8978e2 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -67,8 +67,6 @@ int getpagesize(void);
 # define EPROTONOSUPPORT EINVAL
 #endif
 
-int setenv(const char *name, const char *value, int overwrite);
-
 typedef struct {
     long tv_sec;
     long tv_usec;
diff --git a/os-win32.c b/os-win32.c
index 1336cd3..6b86e02 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -30,28 +30,6 @@
 #include "qemu-options.h"
 #include "sysemu/runstate.h"
 
-/***********************************************************/
-/* Functions missing in mingw */
-
-int setenv(const char *name, const char *value, int overwrite)
-{
-    int result = 0;
-    if (overwrite || !getenv(name)) {
-        size_t length = strlen(name) + strlen(value) + 2;
-        char *string = g_malloc(length);
-        snprintf(string, length, "%s=%s", name, value);
-        result = putenv(string);
-
-        /* Windows takes a copy and does not continue to use our string.
-         * Therefore it can be safely freed on this platform.  POSIX code
-         * typically has to leak the string because according to the spec it
-         * becomes part of the environment.
-         */
-        g_free(string);
-    }
-    return result;
-}
-
 static BOOL WINAPI qemu_ctrl_handler(DWORD type)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_SIGNAL);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 91e9cb2..f36e30a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -254,7 +254,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     s->expected_status = 0;
     s->qemu_pid = fork();
     if (s->qemu_pid == 0) {
-        setenv("QEMU_AUDIO_DRV", "none", true);
+        g_setenv("QEMU_AUDIO_DRV", "none", true);
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
     }
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx509.c
index a27efb7..f487349 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
-    setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
+    g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
     mkdir(WORKDIR, 0700);
 
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 6560d71..8b2453f 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -398,7 +398,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
-    setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
+    g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
     mkdir(WORKDIR, 0700);
 
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 3c9ef6f..ad7554c 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -273,7 +273,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     g_test_init(&argc, &argv, NULL);
-    setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
+    g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
 
     mkdir(WORKDIR, 0700);
 
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 1e5be1d..8f184f3 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -1325,7 +1325,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
 
-    setenv("QTEST_SILENT_ERRORS", "1", 1);
+    g_setenv("QTEST_SILENT_ERRORS", "1", 1);
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/vmstate/simple/primitive", test_simple_primitive);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4e736..9030f1c 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -772,7 +772,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
      * This is a bit hackish but saves us from bigger problem.
      * Maybe it's a good idea to fix this in SDL instead.
      */
-    setenv("SDL_VIDEODRIVER", "x11", 0);
+    g_setenv("SDL_VIDEODRIVER", "x11", 0);
 #endif
 
     if (SDL_Init(SDL_INIT_VIDEO)) {
-- 
1.8.3.1


