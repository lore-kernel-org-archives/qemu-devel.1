Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BF0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C9A2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C9A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFMz-0001HC-P5
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1iNFKb-0008OF-FG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1iNFKa-0004Nk-1x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:01:37 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1iNFKZ-0004NM-S2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:01:36 -0400
Received: by mail-wr1-f45.google.com with SMTP id p4so21790375wrm.8
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 05:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pZk0MZLQdMzXbJMr9doDgj8waKfXrWSNV2vK14XQpRw=;
 b=je3a15RwBOn5qa0e2N/2JALpp3bm3z6YyNIEovfyswTtiENRkOJ3LGn4ODr7v2adbW
 aFVhhOhyNZdQUjO3jNZVGLl3v1zTM8M8zOnzkw2EEWbvt3amMA/o8Z13qzKbjQBLZxbU
 4Gy54fl5mcqmEMrMLunoVBCmMvaK0EVg9UaPykMbpPpOOBmXOW/8LRrzEaFGzeuS0sqv
 DgeBVGewHBme7BpgqKp4+TAQ8L1wmoH2x8L2WuVAn9pcMeQyvDyHOYj/MVztYHO/XbZQ
 sx8p4ga8O8I2AA5gs9EOdA5SDJc5/iflBrdGqWaA1VOrBOs4ELounxFoftkJqUeWe9OI
 09Dw==
X-Gm-Message-State: APjAAAUvTSrIjGkkqjHKd8Y0VC+ZjMoKdzg/Rr9R3y3CW0Lwl+I9Q7N5
 uOQ55rU4yREahS7pSEt4UPPXGuhE
X-Google-Smtp-Source: APXvYqwDyLhvXFCGuPBTuAMYlGSte/svhmdQBz7xp6052u0Pm9N5yNbqS1MFnV8uuSaLfShZQYA4iQ==
X-Received: by 2002:adf:ec0b:: with SMTP id x11mr7764858wrn.107.1571832093633; 
 Wed, 23 Oct 2019 05:01:33 -0700 (PDT)
Received: from thl530.redhat.com (nat-pool-str-u.redhat.com. [149.14.88.107])
 by smtp.gmail.com with ESMTPSA id
 p7sm19621115wma.34.2019.10.23.05.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 05:01:32 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-options: Rework the help text of the '-display' option
Date: Wed, 23 Oct 2019 14:01:28 +0200
Message-Id: <20191023120129.13721-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.45
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve the help text of the "-display" option:

- Only print the options that we have enabled in the binary
  (similar to what we do for other options like -netdev already)

- The "frame=on|off" from "-display sdl" has been removed in commit
  09bd7ba9f5f7 ("Remove deprecated -no-frame option"), so we should
  not show this in the help text anymore

- The "-display egl-headless" line was missing a "\n" at the end

- Indent the default display text in a nicer way

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 qemu-options.hx | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 996b6fba74..917c54b302 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1526,26 +1526,38 @@ STEXI
 ETEXI
 
 DEF("display", HAS_ARG, QEMU_OPTION_display,
+#if defined(CONFIG_SPICE)
     "-display spice-app[,gl=on|off]\n"
-    "-display sdl[,frame=on|off][,alt_grab=on|off][,ctrl_grab=on|off]\n"
+#endif
+#if defined(CONFIG_SDL)
+    "-display sdl[,alt_grab=on|off][,ctrl_grab=on|off]\n"
     "            [,window_close=on|off][,gl=on|core|es|off]\n"
+#endif
+#if defined(CONFIG_GTK)
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
+#endif
+#if defined(CONFIG_VNC)
     "-display vnc=<display>[,<optargs>]\n"
+#endif
+#if defined(CONFIG_CURSES)
     "-display curses[,charset=<encoding>]\n"
+#endif
+#if defined(CONFIG_OPENGL)
+    "-display egl-headless[,rendernode=<file>]\n"
+#endif
     "-display none\n"
-    "-display egl-headless[,rendernode=<file>]"
-    "                select display type\n"
-    "The default display is equivalent to\n"
+    "                select display backend type\n"
+    "                The default display is equivalent to\n                "
 #if defined(CONFIG_GTK)
-            "\t\"-display gtk\"\n"
+            "\"-display gtk\"\n"
 #elif defined(CONFIG_SDL)
-            "\t\"-display sdl\"\n"
+            "\"-display sdl\"\n"
 #elif defined(CONFIG_COCOA)
-            "\t\"-display cocoa\"\n"
+            "\"-display cocoa\"\n"
 #elif defined(CONFIG_VNC)
-            "\t\"-vnc localhost:0,to=99,id=default\"\n"
+            "\"-vnc localhost:0,to=99,id=default\"\n"
 #else
-            "\t\"-display none\"\n"
+            "\"-display none\"\n"
 #endif
     , QEMU_ARCH_ALL)
 STEXI
-- 
2.21.0


