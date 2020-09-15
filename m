Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF0C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AFC20731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSqmYusz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AFC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAA5-0008K2-TI
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qS-0000b3-NU; Tue, 15 Sep 2020 08:14:02 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:56016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qQ-0008AD-Nm; Tue, 15 Sep 2020 08:14:00 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q4so1668671pjh.5;
 Tue, 15 Sep 2020 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lgYFFisioEl97r43OtBikET9wKvUFSMqnEjDRJxGeJs=;
 b=DSqmYuszXxPS5LG1pe5A6JX7lTPMlpa49EH+xIihxSHnBnCnO/82Tdz68pWEXIChL5
 kfQXWCLA5x5V2HAQ5cxq/VsHPhuUyfPMkBOUnZsNuAWiQLC1K/hV0b4dkN10QWRydjVo
 OBQjPTKrsEOGxrhZVawDjUV4v5YqoA+NIDQ+LD+n9EKZFXRXmizskXtDeIJ2aKI+USnT
 O4r32pFBJdBQYhsnXYfGiuhHcQOishSUr3bdAtW7lS7nagN/WbuPdtQ8fH/Csii1Za6+
 a8tgyVHIp0+peCgvnatbamPN0L1M3wDddR8p0y868PO3N7n06TajY8Af0rl9Er+NXC1H
 R0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lgYFFisioEl97r43OtBikET9wKvUFSMqnEjDRJxGeJs=;
 b=hjnsG8TIaPtOxmA+B01RsldySZe+fqld+Glc95YguXg3k1/2IK7/L/VTyfzaoE8kkt
 rb9PRZTQBkm++QPFwVN+GVQV4XrRtZLNsCJvUS3BN7JnKvqR1Ot1jti+JTv+M83DMJBK
 jxPV4tv39QOQmnAb07vcpSimVowfipXBqYrtR2FzixSVSNWWUUA9G9uLbOxgoJ51tyzV
 FXvsrZJz80qYa++uQ3/yDuXABuYMiNV4PK3zWPFwvTPJS9Ucj/mNyf0c9P6DZIy9mLOx
 Aea2c1dUl8OCAbU166LNcsP00lneR7jcm1UUOPBjoFzN1tQO3W8nLrWavdzTAMzKgr06
 KT8A==
X-Gm-Message-State: AOAM533wSdx3Qd2jDPiz8JqGnfSewOMvh9ho3ekCWGPXUp2oxpRBcoZZ
 qD5JsWCWMiBNDOUf1X59L6Fij5PxYMCMq/GlxBI=
X-Google-Smtp-Source: ABdhPJzeoF8zMjcgl4UnoLgbJmK4WTcNahNp9a+LhUuY3heEySjnNWGPaVmKTVKvFT9YWLst7UnQ0w==
X-Received: by 2002:a17:90b:1245:: with SMTP id
 gx5mr3696887pjb.193.1600172035259; 
 Tue, 15 Sep 2020 05:13:55 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:13:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 04/26] win32: Simplify gmtime_r detection direct base on
 _POSIX_THREAD_SAFE_FUNCTIONS.
Date: Tue, 15 Sep 2020 20:12:56 +0800
Message-Id: <20200915121318.247-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
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
index dc4b7a2e55..bac48b5b49 100755
--- a/configure
+++ b/configure
@@ -2496,37 +2496,6 @@ if test "$vhost_net" = ""; then
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
 
@@ -7088,9 +7057,6 @@ if [ "$bsd" = "yes" ] ; then
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


