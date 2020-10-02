Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26106C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CC120795
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTz7ZFHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CC120795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPVY-00044a-El
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPUP-0003Cb-Ml; Fri, 02 Oct 2020 14:09:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPUM-0006y0-N2; Fri, 02 Oct 2020 14:09:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id h6so613167pgk.4;
 Fri, 02 Oct 2020 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pyQe3QliGsbANVKJqHrgEfduPuoNbLBsGXyFeS9wl1I=;
 b=LTz7ZFHMR/+xaVM4hgN1WnqXth/ItPWhU/v8wc9GGSeWVANwDqvW4AQmV7tV7v0G8Q
 Z7ol77wBC44bRQRhqMsIlamvQ1zd65H1n3KhzHNxd6zkauyqGuchJWRQsLKZjYY1CIwi
 qhRjAHoDc/47PFRBsZWM8lJUEzsGWoaJkPDaAAQKi/3lDD1wILmqZsd4qjTJpBUWpZPV
 eh3vsDolNrtXgRaavO2Qw848VjFX4rOgNOIycfnWlbXmbuaHdBFxEmlBRTNo1t65EqNM
 d+7q7CG8yxTJRfeO8pR+mMkiSbxXFSzSFgpc1/85PjNBNPaGvUduxE0NNivp+MxJ6zf3
 FL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pyQe3QliGsbANVKJqHrgEfduPuoNbLBsGXyFeS9wl1I=;
 b=B+3XJ+0RVTPnDImamFaW/BLjWU/UBoVEtLB016kpl91Vim3/CQBZSeX/QklZ0FMmLi
 rkW0zMHn90PMfewQd5uEMJx+aLFNf1WEYnEIBU4AbLLcHJSPMJ+GC2m8RHdMNS9k5S/y
 MAt7WFNf+cF2dqtQHc38kdmXtKNzeAa0+KFHey6NM6LEToDLSP/EykaCRaDT0dNE+TxW
 TU9VXtsA5XM5NduWeVBjKLay6chDW6+NNuvYodydUjcd9j1oYdNvaHxcU64oxtSeMdNA
 3wuSxLw1yefaSVY/Eq0Qmvcrg+Z20tbLyqXzPNTmg82PTJFsYc3MivQ3CyMjTF/idv+9
 uMMA==
X-Gm-Message-State: AOAM531yBaqf4CrosfGCI4rf1ijzbdp/oL6/PWDDwvbjWGLq/px3W2tp
 lTT2b8Xldtk1noeCr+RZxVmzXTPIsVHTvmLd
X-Google-Smtp-Source: ABdhPJyy+P2cXo8vfByc5pK/ZspHCfxrrIo7t24DDYQTVLfGqlxqpv/wRxBOKeBoNpYN42WkXkT6pA==
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id
 1-20020aa792010000b029013ed13da10cmr3882449pfo.40.1601662138970; 
 Fri, 02 Oct 2020 11:08:58 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id o23sm2166567pjw.32.2020.10.02.11.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 11:08:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/4] curses: Fixes compiler error that complain don't have
 langinfo.h on msys2/mingw
Date: Sat,  3 Oct 2020 02:08:38 +0800
Message-Id: <20201002180838.2047-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201002180838.2047-1-luoyonggang@gmail.com>
References: <20201002180838.2047-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
 configure   |  5 +----
 ui/curses.c | 10 +++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 8f7bdbfdd3..fa53bd5c43 100755
--- a/configure
+++ b/configure
@@ -3672,17 +3672,14 @@ if test "$curses" != "no" ; then
 #include <locale.h>
 #include <curses.h>
 #include <wchar.h>
-#include <langinfo.h>
 int main(void) {
-  const char *codeset;
   wchar_t wch = L'w';
   setlocale(LC_ALL, "");
   resize_term(0, 0);
   addwstr(L"wide chars\n");
   addnwstr(&wch, 1);
   add_wch(WACS_DEGREE);
-  codeset = nl_langinfo(CODESET);
-  return codeset != 0;
+  return 0;
 }
 EOF
   IFS=:
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


