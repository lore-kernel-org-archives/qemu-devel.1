Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A711C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB78214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8o5I7Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB78214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEJv-0008Qv-43
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEGd-00032m-FQ; Sat, 12 Sep 2020 18:45:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEGa-0004F8-V9; Sat, 12 Sep 2020 18:45:11 -0400
Received: by mail-pf1-x444.google.com with SMTP id l126so9684066pfd.5;
 Sat, 12 Sep 2020 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TsNOy56cT/aZuPzlGfi9G8/JBTKitoxne2lgskAEKvc=;
 b=l8o5I7UcyUJB/X7Q2MEcBOVqIWC0OO605C2avtZPFYECDi5bUyQemGUnUDSkp8HPwl
 YJhOwm5d2UOYN8jzNnPqfpQ4wMchaa1/IShObTiZm93lhrzdAhfmiZNx1XXKpTfeREag
 2wYjNnQfSrQ65rjjFIvXsLLKZCyJfhN97771LsEa8yS2BibJPzB0ES1jF++rBNTQS1O2
 dYtInvnqZOVW+k/K5GB/Uw5fUyjElUw7mcBKdTVWAFFNcPB6wwod4KUiVck6ZJ64nWvq
 UTnf/pJyiYu6b6CLWdXUqgjtreOdO7kCe3V5AZsGaoUDjRGc8xgnt0qQjAD7qneMnTSY
 mayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TsNOy56cT/aZuPzlGfi9G8/JBTKitoxne2lgskAEKvc=;
 b=uayrXCflV6EMZMN4lx47Wd2M5Kit37V1d+QuvYxi+GzdL0GWhi7syjoEqMj65NhFso
 IHd9RRhmwE0tC0PQB6geu7rlxi3NUj99ub8PdIp37JrDlQhuNpx5L9yi1/50HztD/Xy9
 /8RpIo1E6WwctdIgWj+cyT9Nd/t3uqoV6ZbvSU/x8unm3JYYf2TfoIlUuABjDt4AMDd1
 61Zz8gqsdTnLm6S7Kfqb7uaUSgm59LCEyU1LfkdHEdVg/Txo29NSah/dkfzIG2Lz0lFY
 HdreSW6FeQ0HLEigWfEZOqmAlPsLKWA2hxHaSaYX9tPu70H/ZSKnMe43zTffdq674459
 EXQA==
X-Gm-Message-State: AOAM531tGQSq2u66MQG2clzJ/5+hPDEd+YFv46bw8pTxmvpaUG3Re10Q
 bONJEOdDAJG3EcINcMz3w1cyqhTaigGxtdoYxZg=
X-Google-Smtp-Source: ABdhPJx0BKO5Vzsde3xqLHj845g2p80aeYlDo0LUdRPBKfM1WqR/TNjJxX20etnEAz5oZV+zP0SPBw==
X-Received: by 2002:aa7:911a:0:b029:13e:d13d:a13d with SMTP id
 26-20020aa7911a0000b029013ed13da13dmr7834104pfh.37.1599950706742; 
 Sat, 12 Sep 2020 15:45:06 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:45:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/27] configure: Fixes ncursesw detection under
 msys2/mingw and enable curses
Date: Sun, 13 Sep 2020 06:44:08 +0800
Message-Id: <20200912224431.1428-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mingw pkg-config are showing following absolute path and contains : as the separator,
so we must not use : as path separator. and we know the command line parameter are not likely
contains newline, we could use newline as path command line parameter separator

-D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lncursesw
-DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lcursesw
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
-DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
-DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw

Refer to https://unix.stackexchange.com/a/103011/218958

If your file names are guaranteed not to contain newlines, you can use newlines as the separator. W
hen you expand the variable, first turn off globbing with set -f and set the list of field splitting characters
IFS to contain only a newline.

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
 configure   | 25 +++++++++++++++----------
 ui/curses.c | 10 +++++-----
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index f4f8bc3756..b21843fdb9 100755
--- a/configure
+++ b/configure
@@ -3653,35 +3653,40 @@ if test "$iconv" = "no" ; then
 fi
 if test "$curses" != "no" ; then
   if test "$mingw32" = "yes" ; then
-    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
-    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null):-lpdcurses"
+    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null)
+      $($pkg_config --cflags ncursesw 2>/dev/null)"
+    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null)
+      $($pkg_config --libs ncursesw 2>/dev/null)
+      -lpdcurses"
   else
-    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr/include/ncursesw:"
-    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw:-lcursesw"
+    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null)
+      -I/usr/include/ncursesw:"
+    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null)
+      -lncursesw
+      -lcursesw"
   fi
   curses_found=no
   cat > $TMPC << EOF
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
-  IFS=:
+  IFS='
+'                           # turn off variable value expansion except for splitting at newlines
   for curses_inc in $curses_inc_list; do
     # Make sure we get the wide character prototypes
     curses_inc="-DNCURSES_WIDECHAR $curses_inc"
-    IFS=:
+    IFS='
+'                           # turn off variable value expansion except for splitting at newlines
     for curses_lib in $curses_lib_list; do
       unset IFS
       if compile_prog "$curses_inc" "$curses_lib" ; then
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


