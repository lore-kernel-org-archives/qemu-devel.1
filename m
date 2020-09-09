Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571B2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64432078E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvl7gmCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64432078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwkV-0003hi-OL
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgk-0006Ow-Fs; Wed, 09 Sep 2020 05:46:50 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgi-0007ff-Nv; Wed, 09 Sep 2020 05:46:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id t14so1664254pgl.10;
 Wed, 09 Sep 2020 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oe6b7vQEMWi61d/j8MH3WghB3lqxs27bPNlw+G8pAq8=;
 b=Rvl7gmCXbHqcU+ww4RnoqwwpztyCJkGLah3EHmhvdUaJO0E3sDszV4j+KS7edUP78q
 S5HzAQJPK8QV13y0Jiwqp12LsROMIWM+0VN9Hb9MapErDEFtZsGRuJ9jCSVf/Hrmuh0k
 HAvtk4KqubYpRcnGbUHxEtiRvEhc1ktmQZXT74VBPAxvD/x2tZj6CDvi6owe4a0qWFr4
 EG8Dm2emY/JWPE6H9OOV7UVtPhjzNW/KVho5MJjFp3cU26UUltmCIUVUGD8M/DnbM1cl
 S0ynqawGw4FI/Pbj+MDcThbHSJ7/yGpw5Lo3s2nlqN6FO4UKsRPgAAChjF9QHL9Ev7Ub
 EdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Oe6b7vQEMWi61d/j8MH3WghB3lqxs27bPNlw+G8pAq8=;
 b=pWor/mnj+9XT2v17GnZ5LkomxvgkD345X+zQSHJnW67Y0/oDAPKTzQFC0OlCtsqQZF
 /pWUwCIA20TRrItN2PLjDyaw62CNkVtYUAoU+4x3bl0gCSdqKw8RxC79LuTo9iRAlhIc
 SuTzb4nRHGRpcPXks+FNmIapzsgg9AFtTQe7wezDo3eu1GZYV7opO5OA9+T+35ncmSCA
 K05I3V3Eu1WPQ+0nNNkdImRbm5J0BkK4YnFp412Pqo9lzVbpJH0VnPnEDmSYVuKCNk6X
 rtyVHEuIHM4pV1SEyubOwi1CcS3FOG4hn3ApPicmz4M2R7IqJuen4UFCq541JYS29ixQ
 zw3Q==
X-Gm-Message-State: AOAM530NCM/Y9oTAWsIpShU66zbp5i1VAt95HMJV8uJLTIDXTkqt3RfJ
 a6RqV5xh89Z/7OZky1xdOG1zO8PEdQxATfMZ
X-Google-Smtp-Source: ABdhPJyRfYuxAeotsc+/pRRS2a2nKKgHsqbL4Idu0FsV3ZHgqxwZgjJrKmwL8ID6LZNrPpK8fos8YQ==
X-Received: by 2002:a63:1d4c:: with SMTP id d12mr2419173pgm.365.1599644806449; 
 Wed, 09 Sep 2020 02:46:46 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:46:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/21] configure: Fixes ncursesw detection under
 msys2/mingw and enable curses
Date: Wed,  9 Sep 2020 17:45:59 +0800
Message-Id: <20200909094617.1582-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mingw pkg-config are showing following absolute path and contains : as the separator,
so we must handling : properly.

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
 configure   |  9 +++------
 ui/curses.c | 10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index f4f8bc3756..2e6d54e15b 100755
--- a/configure
+++ b/configure
@@ -3653,8 +3653,8 @@ if test "$iconv" = "no" ; then
 fi
 if test "$curses" != "no" ; then
   if test "$mingw32" = "yes" ; then
-    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
-    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null):-lpdcurses"
+    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/${MSYSTEM,,}/include/ncursesw:"
+    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw"
   else
     curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr/include/ncursesw:"
     curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw:-lcursesw"
@@ -3664,17 +3664,14 @@ if test "$curses" != "no" ; then
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


