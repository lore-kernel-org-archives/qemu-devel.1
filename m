Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04041C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB2E20738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNxNX3ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB2E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLWK-0004Dl-Gi
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLVR-0003GT-50; Mon, 07 Sep 2020 14:04:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLVP-0002K5-AP; Mon, 07 Sep 2020 14:04:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id w186so8322638pgb.8;
 Mon, 07 Sep 2020 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vYVNcO+j3y5vx77lLAsjhQ4Ubiy/GtT4uVJMQ/0BKPY=;
 b=WNxNX3zeMMtG2N9EDBROskg+R3ugjzfp6Me6pMJlg53S+a6WkyQYRBFERaEEfChYcz
 z112VJnTX6HHT5tm75zFuYYzP4ZM5T5+l6rth2QgaAmil3aintjc1O9uftG8MLGt80uJ
 Thd+k0ovvwD2azxmJAohAuoXotY14v4BBIfoZ2qou8Ho5wLyL12evBbfbxrvVBm/tukL
 Q4cJyPkKZ+YMlbLoTM3rt8atrX3ZoPyte1JkpBZ3f8YDqbNoFo/FVSSZvWKfHLSFk44i
 Mpscc8dRMSTCs9SciwhEqw1v/tawV6HtpgfY2Po3ioY2tre/8Knd4TMGqMHoIuK2OP4T
 dOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vYVNcO+j3y5vx77lLAsjhQ4Ubiy/GtT4uVJMQ/0BKPY=;
 b=aPygwrE2T4zhlRECJrGj7+XHSerAAx2prSXCGCF7XgMezDTkBUwiMM1KA+zdKW1VR7
 C62Z3yPWnCcZwfiMzKGtyL34+7rf1NVVcbB3ybRbzdlq1DTa5N2WjWB07uijhB+qWFvN
 pAmOgGvVnCAHiYq8EnZBhS2Cl/O7eLpZ778aDFbEo9UZMFjrv4AcaVq1j2PK+3T2OyqG
 jGCeVfORHvIslk0yov27lZSaZbGll2oxChr0+HTzzOA0udVvX42RO1ZauJa9Gulj/fXA
 Id88bVDT9LvYzTx0fkgrhgQtk4MBS4AnIXGBX9gx4msEijZsVHmmhY0/HWxvsOliCZHn
 uvXw==
X-Gm-Message-State: AOAM533ufOFoz+TtGrPwVyzRq1BvZApYFv6IHxm5OHD1OJd09/Ts8frZ
 VtMudmvK7hCQRDxKn7ze/whle73LyV+bniVc
X-Google-Smtp-Source: ABdhPJwxuUyEIBFPLQhMaDr1g/SEpuhcXSFXtt59UPVIa/T0CNOANtrFV8vhIzxaTyMAPPfByScGAA==
X-Received: by 2002:a63:4503:: with SMTP id s3mr17646213pga.119.1599501877162; 
 Mon, 07 Sep 2020 11:04:37 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id z22sm16906110pjq.2.2020.09.07.11.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:04:36 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] configure: Fixes ncursesw detection under msys2/mingw and
 enable curses
Date: Tue,  8 Sep 2020 02:04:22 +0800
Message-Id: <20200907180422.1955-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
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
 Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
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

MINGW doesn't have langinfo.h, only exist in glic and musl

gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
test.c:4:10: fatal error: langinfo.h: No such file or directory
    4 | #include <langinfo.h>
      |          ^~~~~~~~~~~~
compilation terminated.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure   |  9 +++------
 ui/curses.c | 10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 1c634c8468..8ff5f9bc22 100755
--- a/configure
+++ b/configure
@@ -3638,8 +3638,8 @@ if test "$iconv" = "no" ; then
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
@@ -3649,17 +3649,14 @@ if test "$curses" != "no" ; then
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


