Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F83CC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D4820754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBVaoiI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D4820754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3EP-0006Fb-JK
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2S2-0004ky-Um; Thu, 01 Oct 2020 13:33:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2Rz-0005EC-0z; Thu, 01 Oct 2020 13:33:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id y14so4542755pgf.12;
 Thu, 01 Oct 2020 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RL47DD7jczS4ueH47GPQF+C3dft0LjdpTt4m7Cc68+Y=;
 b=MBVaoiI+/YlTjj/Ue5bLeFkL4gKvwfuiYOIb7vAFJXA2r7BiIIvoDL7JmQ6Xy42r28
 m3ZVanfSjA2kGaF5qQ5HvUjDSjmazZWXrdRr4QeJnE8Zg/4BkUR7wVGUxGy1jHi7K81u
 /3eLyiwFILzEL0OHPzO8hGQUHFgR6abhjdBdRjzRVv5m6RvcTfmmo2sEqERTSVK0qLB8
 +mUMpb49D/mKC7E1Nua8p8Gl3aVoBqjfBvsbRWDcaN1LFRk3AoFOwqy5wg23mH9ds3sn
 Gp+cbVrrtPdSFIAoTFjZ4eDJ5hShMJ6+Uj42YrTp6GHG2Du5eKimAqqtF1OfO/hPXW9B
 V5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RL47DD7jczS4ueH47GPQF+C3dft0LjdpTt4m7Cc68+Y=;
 b=n7uJ3h2UEztP9fOEkRKV17JnzKQ0fx+AgPmpD7ZxPbij5h3ctkt1tXr7Xr/msGmozz
 Cc+LtXU7KZLDluXzl2f9RAisx0hC9xs5k/albXhQP+XXvLR9YJrIUyMs0hQMylYfDnoR
 NGbiizrm+yu9DaaSBl3xkUKhahLGine/dJYD4vnzXfL1NoLgDa4bQsoCk4aYXmR84+6e
 UX4NuRprQwAL4YQ0NWuxYSWnI8a/5NEp/v3mV3q1SHCTQNbySas3DpuBhbl2CYwdxSvC
 s6GgfPjna15SPSHjhfByzvxz/obhQ20NTt9hhlwhRU34swM/xkS6oCM8TI5/JUPxTR2b
 4esw==
X-Gm-Message-State: AOAM531wUJupvnKILH11+vBV2AUD0Iy/IHBE5BP4aGa89I/KBI6tJuwm
 rC/aIvC8u/gjjMbYgr/RV4+NqrPBtAUZFw==
X-Google-Smtp-Source: ABdhPJwvicv5NhXw8lS6X/ZM4YMCOJi5+XqEJoii8mMx/X2/YoxpT3VVBHofO0cFeKixIibHUrnDWA==
X-Received: by 2002:a05:6a00:14cb:b029:142:2501:34eb with SMTP id
 w11-20020a056a0014cbb0290142250134ebmr8046038pfu.68.1601573580733; 
 Thu, 01 Oct 2020 10:33:00 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id b20sm7253767pfb.198.2020.10.01.10.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:32:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/4] win32: Simplify gmtime_r detection not depends on if
 _POSIX_C_SOURCE are defined on msys2/mingw
Date: Fri,  2 Oct 2020 01:32:30 +0800
Message-Id: <20201001173230.829-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001173230.829-1-luoyonggang@gmail.com>
References: <20201001173230.829-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x543.google.com
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
index 8f7bdbfdd3..d6dd147235 100755
--- a/configure
+++ b/configure
@@ -2500,37 +2500,6 @@ if test "$vhost_net" = ""; then
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
 
@@ -6937,9 +6906,6 @@ if [ "$bsd" = "yes" ] ; then
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


