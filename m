Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45DC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607CC23888
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD0IKkuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607CC23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJ0w-0006TV-E5
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIr0-0001OZ-5H; Fri, 18 Sep 2020 12:03:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIqx-00020X-Uy; Fri, 18 Sep 2020 12:03:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id w7so3731508pfi.4;
 Fri, 18 Sep 2020 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38P1i5JkQS7ofb/RLUKRo29Ks91Vqq7zgVYwAGpHkHw=;
 b=AD0IKkuDUTEYayFd/69tJ/nPVITto6e2Ci0F2xQArsYLkVOpZX1Is6tDJNSzntnPup
 /pRKpREQxPusYQIn1dwsnJadShLQU3YDQahQu+m+rgcGBN7mwSO4MIkNiR+kj+42IiIM
 LAJpF9SmTfpcxP+ACkCA7XNC3p4qLYDlWCy2FPh70Pr8MiYIzgkfEiOzDIhqjMUT9HWK
 TBsePQC+dNhMsPyIvkFy3BBuJbeXuq/PoVfOd5hU/fEEveh5z32gxBqA+LONJHdpRQdj
 t1wayClZ4udPbTMsLmYBmKg479uZIqHjY+8wERVkPzaqMQPsXqYCTPlul0F3jpC3Btbi
 lQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38P1i5JkQS7ofb/RLUKRo29Ks91Vqq7zgVYwAGpHkHw=;
 b=jraMdzCJ9Hhj3s76FeNkiK3uKvu3LvuHIr4QCLQm8fB7zy1nZnLVYaHaaIVrZDc+/J
 703QQ11I0E1dsQcE6oGiaOm6HXO6vJzq0vKXhMkfeymhyRyxCVSEjCThDtINPYJJVdGc
 eDKStAJfwUuSYuYIWOp6vZtZwo2KSzsb4joDs+E9cpoh+oMizz2XP2p/QCBWSH2lwzWz
 Rez7JxWn0wktOHiU2vy1eWAATI5cVSRMyZ5euVqypQnkFeZaGSq32FOgI2xPZYWyIIu/
 ynhBccVxybqaK/lHAZEhgYzNts4+d82PpkpcZksctjhgx3c+wKxdMTzqZ+bYISUyCiDK
 sR+Q==
X-Gm-Message-State: AOAM533ldNx7kbkWrW8Lv3Myv7kdLys2eh2INTQM9P9fj1NiBONb72f9
 bN7W3WBoEJleOSC2Tl2gSwabd+0pXoHCfQ==
X-Google-Smtp-Source: ABdhPJx8+4qj8ijLvEY1oZRvZngjc7oqp5cpo/BxFwtqxLH4tw8V+nQSx4sfwNnTx1L/ttli88tAPg==
X-Received: by 2002:a62:7511:0:b029:142:2501:35da with SMTP id
 q17-20020a6275110000b0290142250135damr16466544pfc.58.1600444992827; 
 Fri, 18 Sep 2020 09:03:12 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z22sm16889012pjq.2.2020.09.18.09.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:03:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/4] curses: Fixes compiler error that complain don't have
 langinfo.h on msys2/mingw
Date: Sat, 19 Sep 2020 00:02:47 +0800
Message-Id: <20200918160250.1141-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200918160250.1141-1-luoyonggang@gmail.com>
References: <20200918160250.1141-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

msys2/mingw lacks the POSIX-required langinfo.h.

gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
test.c:4:10: fatal error: langinfo.h: No such file or directory
    4 | #include <langinfo.h>
      |          ^~~~~~~~~~~~
compilation terminated.

So we using g_get_codeset instead of nl_langinfo(CODESET)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/curses.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ui/curses.c b/ui/curses.c
index a59b23a9cf..12bc682cf9 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -30,7 +30,6 @@
 #endif
 #include <locale.h>
 #include <wchar.h>
-#include <langinfo.h>
 #include <iconv.h>
 
 #include "qapi/error.h"
@@ -526,6 +525,7 @@ static void font_setup(void)
     iconv_t nativecharset_to_ucs2;
     iconv_t font_conv;
     int i;
+    g_autofree gchar *local_codeset = g_get_codeset();
 
     /*
      * Control characters are normally non-printable, but VGA does have
@@ -566,14 +566,14 @@ static void font_setup(void)
       0x25bc
     };
 
-    ucs2_to_nativecharset = iconv_open(nl_langinfo(CODESET), "UCS-2");
+    ucs2_to_nativecharset = iconv_open(local_codeset, "UCS-2");
     if (ucs2_to_nativecharset == (iconv_t) -1) {
         fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s'\n",
                         strerror(errno));
         exit(1);
     }
 
-    nativecharset_to_ucs2 = iconv_open("UCS-2", nl_langinfo(CODESET));
+    nativecharset_to_ucs2 = iconv_open("UCS-2", local_codeset);
     if (nativecharset_to_ucs2 == (iconv_t) -1) {
         iconv_close(ucs2_to_nativecharset);
         fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n",
@@ -581,7 +581,7 @@ static void font_setup(void)
         exit(1);
     }
 
-    font_conv = iconv_open(nl_langinfo(CODESET), font_charset);
+    font_conv = iconv_open(local_codeset, font_charset);
     if (font_conv == (iconv_t) -1) {
         iconv_close(ucs2_to_nativecharset);
         iconv_close(nativecharset_to_ucs2);
@@ -602,7 +602,7 @@ static void font_setup(void)
     /* DEL */
     convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
 
-    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
+    if (strcmp(local_codeset, "UTF-8")) {
         /* Non-Unicode capable, use termcap equivalents for those available */
         for (i = 0; i <= 0xFF; i++) {
             wchar_t wch[CCHARW_MAX];
-- 
2.28.0.windows.1


