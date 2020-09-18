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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD2C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC9020795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+FTvRBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9020795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJ40-0001md-Bz
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIr6-0001Rr-LF; Fri, 18 Sep 2020 12:03:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIr3-00021D-Oj; Fri, 18 Sep 2020 12:03:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id k15so3712125pfc.12;
 Fri, 18 Sep 2020 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ERzHS3mP7/PmR4u4ye15OKBMGVTAoqY1cYC1G2Sq2y0=;
 b=b+FTvRBQgTJ0tQjSU2OZJXxKyigb/MvODregi0FLvqwU9RfXVCCHAK0c3ctknp42Sq
 okwnxcJIegJ2QDmvIwsBgOR3hp3veOOPYUohw5nrJpBzpA2sITH29brGA17fAgEALCF4
 QAva7WZKs20o6H5r5Ks5zQZytNhNfgEMw7xtWNFTf2tQXKcV6pS47zXRPPrOYrrD9iJs
 dKdfn8j8an+2Rrm0V+CdBkh7kUvSnUT3jxcEInD2iS8iZEAwu5q9QSvcCXeXea5u9/Iu
 ZcAne+q8+DW3jFKW2f8+fFqCdAXYzB5Pg7yWC5T55VQJLPbxb+rsEmdCCvD78kksV3Ky
 jdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ERzHS3mP7/PmR4u4ye15OKBMGVTAoqY1cYC1G2Sq2y0=;
 b=XHVlqvo9RAkuLLUwzGXZvsvReHiSPv58hUov/YnfSrr7Mz2GYnxCRUywDH/ojxuoAr
 43tklguBHQCh1e7Vx/7AF4r3Gq3HEJhHPoTmA+tYervOZstR+s+sJVnXt/7c5nJNIV+g
 GRxh4xQcby6CjknrNv3pz/iT4bofUc4cJfovna+hs1ERGoA7poY/kAtJqSiOLCidHW6j
 A/zUiecRZNPbbRgF5QQpZrjuG84JG0/A3wUxqTlnQXAKWlQ4f80QBrmzFyf7jQ0/+1f2
 6EltQxuLt2PlIgLX9wU27ej12kecT11xBvpzMoHy0U9EwcwzVUVLzLTxIi56P91Bvfw8
 dc1A==
X-Gm-Message-State: AOAM533ryYoCqw4+vxwP8qhtt3s/fnm7Chx2ydvkZzUlZXwKXeqx1Urr
 DY4NRdQU9T2I/PBzbU2qJ6ERLrmLUioihw==
X-Google-Smtp-Source: ABdhPJy0qL5bVvNOkUOkE27hvxCExB4iCKxBaYrJKt7pR2gg0mXVseVurRYGZX3TNR/A9lVNU52aYw==
X-Received: by 2002:a63:4902:: with SMTP id w2mr27815218pga.311.1600444999334; 
 Fri, 18 Sep 2020 09:03:19 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z22sm16889012pjq.2.2020.09.18.09.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:03:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/4] win32: Simplify gmtime_r detection not depends on if
 _POSIX_C_SOURCE are defined on msys2/mingw
Date: Sat, 19 Sep 2020 00:02:49 +0800
Message-Id: <20200918160250.1141-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200918160250.1141-1-luoyonggang@gmail.com>
References: <20200918160250.1141-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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

We remove the CONFIG_LOCALTIME_R detection option in configure, and move the check
existence of gmtime_r from configure into C header and source directly by using macro
`_POSIX_THREAD_SAFE_FUNCTIONS`.
Before this patch, the configure script are always assume the compiler doesn't define
_POSIX_C_SOURCE macro at all, but that's not true, because thirdparty library such
as ncursesw may define -D_POSIX_C_SOURCE in it's pkg-config file. And that C Flags will
added -D_POSIX_C_SOURCE into each QEMU_CFLAGS. And that's causing the following compiling error:
n file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../softmmu/main.c:25:
C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
   53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../softmmu/main.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
  284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../softmmu/main.c:25:
C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
   55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../softmmu/main.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
  281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~~~~
Compiling C object libcommon.fa.p/hw_gpio_zaurus.c.obj
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../hw/i2c/smbus_slave.c:16:
C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
   53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../hw/i2c/smbus_slave.c:16:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
  284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../hw/i2c/smbus_slave.c:16:
C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
   55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../hw/i2c/smbus_slave.c:16:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
  281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~~~~
Compiling C object libcommon.fa.p/hw_dma_xilinx_axidma.c.obj

After this patch, whenever ncursesw or other thirdparty libraries tried to define or not
define  _POSIX_C_SOURCE, the source will building properly. Because now, we don't make any
assumption if _POSIX_C_SOURCE are defined. We solely relied on if the macro `_POSIX_THREAD_SAFE_FUNCTIONS`
are defined in msys2/mingw header.

The _POSIX_THREAD_SAFE_FUNCTIONS are defined in mingw header like this:

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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure                 | 34 ----------------------------------
 include/sysemu/os-win32.h |  4 ++--
 util/oslib-win32.c        |  4 ++--
 3 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/configure b/configure
index 422b1ef2a3..21c010140c 100755
--- a/configure
+++ b/configure
@@ -2499,37 +2499,6 @@ if test "$vhost_net" = ""; then
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
 
@@ -6943,9 +6912,6 @@ if [ "$bsd" = "yes" ] ; then
   echo "CONFIG_BSD=y" >> $config_host_mak
 fi
 
-if test "$localtime_r" = "yes" ; then
-  echo "CONFIG_LOCALTIME_R=y" >> $config_host_mak
-fi
 if test "$qom_cast_debug" = "yes" ; then
   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
 fi
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index d8978e28c0..5346d51e89 100644
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
+#endif /* _POSIX_THREAD_SAFE_FUNCTIONS */
 
 static inline void os_setup_signal_handling(void) {}
 static inline void os_daemonize(void) {}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 051afb217b..e99debfb8d 100644
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
@@ -130,7 +130,7 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
     }
     return p;
 }
-#endif /* CONFIG_LOCALTIME_R */
+#endif /* _POSIX_THREAD_SAFE_FUNCTIONS */
 
 static int socket_error(void)
 {
-- 
2.28.0.windows.1


