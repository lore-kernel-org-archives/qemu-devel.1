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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF64C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF58215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piSh5Kbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF58215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2r0-00017Q-K2
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kc-0000Tn-9c; Wed, 09 Sep 2020 12:15:14 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kZ-0006Xv-Eq; Wed, 09 Sep 2020 12:15:14 -0400
Received: by mail-pg1-x544.google.com with SMTP id t14so2397178pgl.10;
 Wed, 09 Sep 2020 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=54KjmFONhFVNbISF0ZvZ1gRQPHqntcxYT0Rta8IUzTM=;
 b=piSh5KbpD1x2J1DkSczYFo4OMWi56M4GcQDTUrDNSo9O0A5t3ga4ca+LhMGJw8nTQJ
 Ke+hvwy8f2EiakyOVsj1QeIdVYVYtJBWF61Yv59KS79k2svWbZPgDP+0Q88crw13rlOD
 ZfTSY1IHbyI08JKzvGc0+r2bx/iyVtx11d88TBqNw09SWyu4JNJh9vy+hBxLzIahzH1r
 vIVA4UmLf1fGyrxhSOzy8PbRII5qmSgwe6sRcghgV2LO8PTylRDNC9QzJSKL+9Uf4hrJ
 tn9ozOom4xoq1CeCmFl1XNqCl8NRSM7hYBRgCpjs7SE0rTdz7Ausj53nnJPuGeec4s7u
 IuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=54KjmFONhFVNbISF0ZvZ1gRQPHqntcxYT0Rta8IUzTM=;
 b=nG0t0eG9kE6z6/ckItW6v1rZl3b3jv/p7bvoqJl9h3ecl+8T8lScjOjneURcAUEbOr
 CTQgWS/m57NViTgCOHYABnKxi+HGkCvZ7XNWqV8+88ERG4FJKLgVUGBOLWkcwEpR0mNC
 hYZkBw3/18WzOUQvagLuqdF7kyGfS0Cb2T/Om/vIUA42aawI8NEkDqphjClRAZQiwTm2
 QKonVZFORrYr8vOWGOUSFp/ybpVWI+rk2lSP+X5Ve8gVO9Ck6aT/uqD6bRVuOw/6W97r
 OvzQ3Bv5Rr0LKWi6F4GDybi3vk+LMuNFWkcsb0aQFWARnnbwa60v4McLBLC4PuFkVqhp
 fc7Q==
X-Gm-Message-State: AOAM5321ZVnBlBEJbJoYNuCTXqpLjSYzQ8K12oxDsFvLpiJzR3b/Y+Lw
 z06nwX7WOlHU3dyfcqYhZ1LGSf/gJ3/G/Qtk
X-Google-Smtp-Source: ABdhPJwC0CVLbnsJ5Hz5iWcbUBnnJKeLskm+xwuc9Xv0BTTZscty7FlfP0a6PqCHlbrwfdC9U7k4Zw==
X-Received: by 2002:a62:7ad0:0:b029:13e:d13d:a08f with SMTP id
 v199-20020a627ad00000b029013ed13da08fmr1521357pfc.38.1599668109376; 
 Wed, 09 Sep 2020 09:15:09 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/24] win32: Simplify gmtime_r detection direct base on
 _POSIX_THREAD_SAFE_FUNCTIONS.
Date: Thu, 10 Sep 2020 00:14:25 +0800
Message-Id: <20200909161430.1789-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
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
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First, this reduce the size of configure, configure are tending to removal in future,
and this didn't introduce any new feature or remove any exist feature.
Second, the current localtime_r detection are conflict with ncursesw detection in
mingw, when ncursesw detected, it will provide the following compile flags
pkg-config --cflags ncursesw
-D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw
And the compile flag _POSIX_C_SOURCE will always cause _POSIX_THREAD_SAFE_FUNCTIONS to
be defined, in new version of mingw, that's will cause localtime_r to be defined.
But the configure script didn't provide _POSIX_C_SOURCE macro, and that's will result
localtime_r not detected because localtime_r are defined in forceinline manner.

And finally cause conflict between QEMU defined localtime_r
struct tm *localtime_r(const time_t *timep, struct tm *result);
with mingw defined localtime_r

```
#if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
#define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
#endif

#ifdef _POSIX_THREAD_SAFE_FUNCTIONS
__forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
  return localtime_s(_Tm, _Time) ? NULL : _Tm;
}
__forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
  return gmtime_s(_Tm, _Time) ? NULL : _Tm;
}
__forceinline char *__CRTDECL ctime_r(const time_t *_Time, char *_Str) {
  return ctime_s(_Str, 0x7fffffff, _Time) ? NULL : _Str;
}
__forceinline char *__CRTDECL asctime_r(const struct tm *_Tm, char * _Str) {
  return asctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;
}
#endif
```

So I suggest remove this configure script, and restrict msys2/mingw version to easy to maintain.
And use _POSIX_THREAD_SAFE_FUNCTIONS to guard the localtime_r and counterpart functions

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure                 | 34 ----------------------------------
 include/sysemu/os-win32.h |  4 ++--
 util/oslib-win32.c        |  2 +-
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/configure b/configure
index b21843fdb9..af86ba1db3 100755
--- a/configure
+++ b/configure
@@ -2495,37 +2495,6 @@ if test "$vhost_net" = ""; then
   test "$vhost_kernel" = "yes" && vhost_net=yes
 fi
 
-##########################################
-# MinGW / Mingw-w64 localtime_r/gmtime_r check
-
-if test "$mingw32" = "yes"; then
-    # Some versions of MinGW / Mingw-w64 lack localtime_r
-    # and gmtime_r entirely.
-    #
-    # Some versions of Mingw-w64 define a macro for
-    # localtime_r/gmtime_r.
-    #
-    # Some versions of Mingw-w64 will define functions
-    # for localtime_r/gmtime_r, but only if you have
-    # _POSIX_THREAD_SAFE_FUNCTIONS defined. For fun
-    # though, unistd.h and pthread.h both define
-    # that for you.
-    #
-    # So this #undef localtime_r and #include <unistd.h>
-    # are not in fact redundant.
-cat > $TMPC << EOF
-#include <unistd.h>
-#include <time.h>
-#undef localtime_r
-int main(void) { localtime_r(NULL, NULL); return 0; }
-EOF
-    if compile_prog "" "" ; then
-        localtime_r="yes"
-    else
-        localtime_r="no"
-    fi
-fi
-
 ##########################################
 # pkg-config probe
 
@@ -7087,9 +7056,6 @@ if [ "$bsd" = "yes" ] ; then
   echo "CONFIG_BSD=y" >> $config_host_mak
 fi
 
-if test "$localtime_r" = "yes" ; then
-  echo "CONFIG_LOCALTIME_R=y" >> $config_host_mak
-fi
 if test "$qom_cast_debug" = "yes" ; then
   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
 fi
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index d8978e28c0..3ac8a53bac 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -48,12 +48,12 @@
 #define siglongjmp(env, val) longjmp(env, val)
 
 /* Missing POSIX functions. Don't use MinGW-w64 macros. */
-#ifndef CONFIG_LOCALTIME_R
+#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
 #undef gmtime_r
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 #undef localtime_r
 struct tm *localtime_r(const time_t *timep, struct tm *result);
-#endif /* CONFIG_LOCALTIME_R */
+#endif
 
 static inline void os_setup_signal_handling(void) {}
 static inline void os_daemonize(void) {}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c654dafd93..f2fa9a3549 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -106,7 +106,7 @@ void qemu_anon_ram_free(void *ptr, size_t size)
     }
 }
 
-#ifndef CONFIG_LOCALTIME_R
+#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
 /* FIXME: add proper locking */
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
-- 
2.28.0.windows.1


