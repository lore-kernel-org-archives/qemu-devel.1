Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF3C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D402242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D402242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbqL-0006Ch-47
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbns-0003iV-I8; Tue, 27 Oct 2020 23:07:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnq-0006gU-D4; Tue, 27 Oct 2020 23:07:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id p17so40331pli.13;
 Tue, 27 Oct 2020 20:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bB3P4E1QnUB61642KGjjlF4nIL/mJBmxJiEctt/oBV0=;
 b=tvrpOocTzp5DshS5UO4oMhffBS/985F6tdYTgEsISf3ED7dPXodC5ChjfHMrZtDYcf
 NV8bOeuBxgzgke+j8oi9ZuJrXeDbGNBJD4Zd/droFCZuJfrbxAy5aOCNwhLHk1EwXuAM
 0A5dryi7Cf3nyYVPguBFSpCLCqvykBxHXXC18JXsqQu7pscrgJkd6KqZK2srRGG+aiNM
 Utnbz9HFyvk6/n4Y3R4VPyxfBJyQhA0ViJnRQCkYFxJdo3LyksUdKjdJj5KtywKFFQdz
 H9EZCUbc/ctPXwDGd4sraWW3VUuCFNQJR3zRmzMofQ1emOOZRB1caFG3Oe/PwcexWcYB
 c6AQ==
X-Gm-Message-State: AOAM532F5VeOe2ITzS1w6l6U2+luNZfDmGg0YpubNdXW023+ouJamJjY
 /Cu6145zMA4J+M7UsWKUokCtQZLPYps=
X-Google-Smtp-Source: ABdhPJw63cIQu9gKAYn1j4Ps/8rIbow2bUIwb5heY+TmDpSYQzSgtw0EWj/v8LpYKOAQRuJy2fCZhQ==
X-Received: by 2002:a17:902:8eca:b029:d2:4276:1b2d with SMTP id
 x10-20020a1709028ecab02900d242761b2dmr5265696plo.17.1603854427943; 
 Tue, 27 Oct 2020 20:07:07 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.93])
 by smtp.gmail.com with ESMTPSA id n6sm3407219pjj.34.2020.10.27.20.07.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 20:07:07 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] qemu: add support for iOS host
Date: Tue, 27 Oct 2020 20:06:57 -0700
Message-Id: <20201028030701.14086-4-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028030701.14086-1-j@getutm.app>
References: <20201028030701.14086-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.193;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 23:07:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marek Vasut <marex@denx.de>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, Joelle van Dyne <j@getutm.app>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces support for building for iOS hosts. When the correct Xcode
toolchain is used, iOS host will be detected automatically.

block: disable features not supported by iOS sandbox
slirp: disable SMB features for iOS
target: disable system() calls for iOS
tcg: use sys_icache_invalidate() instead of GCC builtin for iOS
tests: disable tests on iOS which uses system()
Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure                      | 43 +++++++++++++++++++++++++++++++++-
 meson.build                    |  2 +-
 tcg/aarch64/tcg-target.h       |  7 ++++++
 block.c                        |  2 +-
 block/file-posix.c             | 31 ++++++++++++++----------
 net/slirp.c                    | 16 ++++++-------
 qga/commands-posix.c           |  6 +++++
 target/arm/arm-semi.c          |  2 ++
 target/m68k/m68k-semi.c        |  2 ++
 target/nios2/nios2-semi.c      |  2 ++
 tests/qtest/libqos/virtio-9p.c |  8 +++++++
 tests/qtest/meson.build        |  7 +++---
 12 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/configure b/configure
index e211d11971..7fbaefc255 100755
--- a/configure
+++ b/configure
@@ -557,6 +557,19 @@ EOF
   compile_object
 }
 
+check_ios() {
+  cat > $TMPC <<EOF
+#ifdef __APPLE__
+#import "TargetConditionals.h"
+#if !TARGET_OS_IPHONE
+#error TARGET_OS_IPHONE not true
+#endif
+#endif
+int main(void) { return 0; }
+EOF
+  compile_object
+}
+
 check_include() {
 cat > $TMPC <<EOF
 #include <$1>
@@ -599,7 +612,11 @@ elif check_define __DragonFly__ ; then
 elif check_define __NetBSD__; then
   targetos='NetBSD'
 elif check_define __APPLE__; then
-  targetos='Darwin'
+  if check_ios ; then
+    targetos='iOS'
+  else
+    targetos='Darwin'
+  fi
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
@@ -776,6 +793,22 @@ Darwin)
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
 ;;
+iOS)
+  bsd="yes"
+  darwin="yes"
+  ios="yes"
+  if [ "$cpu" = "x86_64" ] ; then
+    QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
+    QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
+  fi
+  host_block_device_support="no"
+  audio_drv_list=""
+  audio_possible_drivers=""
+  QEMU_LDFLAGS="-framework CoreFoundation $QEMU_LDFLAGS"
+  # Disable attempts to use ObjectiveC features in os/object.h since they
+  # won't work when we're compiling with gcc as a C compiler.
+  QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
+;;
 SunOS)
   solaris="yes"
   make="${MAKE-gmake}"
@@ -5956,6 +5989,10 @@ if test "$darwin" = "yes" ; then
   echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
 
+if test "$ios" = "yes" ; then
+  echo "CONFIG_IOS=y" >> $config_host_mak
+fi
+
 if test "$solaris" = "yes" ; then
   echo "CONFIG_SOLARIS=y" >> $config_host_mak
 fi
@@ -6924,6 +6961,7 @@ echo "cpp_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
 echo "[binaries]" >> $cross
 echo "c = [$(meson_quote $cc)]" >> $cross
 test -n "$cxx" && echo "cpp = [$(meson_quote $cxx)]" >> $cross
+test -n "$objcc" && echo "objc = [$(meson_quote $objcc)]" >> $cross
 echo "ar = [$(meson_quote $ar)]" >> $cross
 echo "nm = [$(meson_quote $nm)]" >> $cross
 echo "pkgconfig = [$(meson_quote $pkg_config_exe)]" >> $cross
@@ -6942,6 +6980,9 @@ if test "$cross_compile" = "yes"; then
     if test "$linux" = "yes" ; then
         echo "system = 'linux'" >> $cross
     fi
+    if test "$darwin" = "yes" ; then
+        echo "system = 'darwin'" >> $cross
+    fi
     case "$ARCH" in
         i386|x86_64)
             echo "cpu_family = 'x86'" >> $cross
diff --git a/meson.build b/meson.build
index e880274b7c..48c95150fe 100644
--- a/meson.build
+++ b/meson.build
@@ -176,7 +176,7 @@ if targetos == 'windows'
                                       include_directories: include_directories('.'))
 elif targetos == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
-  iokit = dependency('appleframeworks', modules: 'IOKit')
+  iokit = dependency('appleframeworks', modules: 'IOKit', required: 'CONFIG_IOS' not in config_host)
   cocoa = dependency('appleframeworks', modules: 'Cocoa', required: get_option('cocoa'))
 elif targetos == 'sunos'
   socket = [cc.find_library('socket'),
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index f605257ed5..6b5b3216fa 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -149,12 +149,19 @@ typedef enum {
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
 #if defined(__APPLE__)
+void sys_icache_invalidate(void *start, size_t len);
 void sys_dcache_flush(void *start, size_t len);
 #endif
 
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
+#if defined(__APPLE__)
+    sys_icache_invalidate((char *)start, stop - start);
+#elif defined(__GNUC__)
     __builtin___clear_cache((char *)start, (char *)stop);
+#else
+#error "Missing builtin to flush instruction cache"
+#endif
 }
 
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
diff --git a/block.c b/block.c
index 430edf79bb..5d49869d02 100644
--- a/block.c
+++ b/block.c
@@ -53,7 +53,7 @@
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
 #include <sys/queue.h>
-#ifndef __DragonFly__
+#if !defined(__DragonFly__) && !defined(CONFIG_IOS)
 #include <sys/disk.h>
 #endif
 #endif
diff --git a/block/file-posix.c b/block/file-posix.c
index 52f7c20525..5560fd20ac 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -181,7 +181,17 @@ typedef struct BDRVRawReopenState {
     bool check_cache_dropped;
 } BDRVRawReopenState;
 
-static int fd_open(BlockDriverState *bs);
+static int fd_open(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+
+    /* this is just to ensure s->fd is sane (its called by io ops) */
+    if (s->fd >= 0) {
+        return 0;
+    }
+    return -EIO;
+}
+
 static int64_t raw_getlength(BlockDriverState *bs);
 
 typedef struct RawPosixAIOData {
@@ -252,6 +262,12 @@ static int raw_normalize_devicepath(const char **filename, Error **errp)
 }
 #endif
 
+#if defined(CONFIG_IOS)
+static int probe_logical_blocksize(int fd, unsigned int *sector_size_p)
+{
+    return -ENOTSUP; /* not supported on iOS */
+}
+#else /* CONFIG_IOS */
 /*
  * Get logical block size via ioctl. On success store it in @sector_size_p.
  */
@@ -284,6 +300,7 @@ static int probe_logical_blocksize(int fd, unsigned int *sector_size_p)
 
     return success ? 0 : -errno;
 }
+#endif /* !CONFIG_IOS */
 
 /**
  * Get physical block size of @fd.
@@ -2306,7 +2323,7 @@ again:
         }
         if (size == 0)
 #endif
-#if defined(__APPLE__) && defined(__MACH__)
+#if !defined(CONFIG_IOS) && defined(__APPLE__) && defined(__MACH__)
         {
             uint64_t sectors = 0;
             uint32_t sector_size = 0;
@@ -3541,16 +3558,6 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 }
 #endif /* linux */
 
-static int fd_open(BlockDriverState *bs)
-{
-    BDRVRawState *s = bs->opaque;
-
-    /* this is just to ensure s->fd is sane (its called by io ops) */
-    if (s->fd >= 0)
-        return 0;
-    return -EIO;
-}
-
 static coroutine_fn int
 hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 {
diff --git a/net/slirp.c b/net/slirp.c
index 77042e6df7..8413042c09 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -27,7 +27,7 @@
 #include "net/slirp.h"
 
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
 #include <pwd.h>
 #include <sys/wait.h>
 #endif
@@ -90,7 +90,7 @@ typedef struct SlirpState {
     Slirp *slirp;
     Notifier poll_notifier;
     Notifier exit_notifier;
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
     gchar *smb_dir;
 #endif
     GSList *fwd;
@@ -103,7 +103,7 @@ static QTAILQ_HEAD(, SlirpState) slirp_stacks =
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp);
 static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp);
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
 static int slirp_smb(SlirpState *s, const char *exported_dir,
                      struct in_addr vserver_addr, Error **errp);
 static void slirp_smb_cleanup(SlirpState *s);
@@ -368,7 +368,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
     struct in6_addr ip6_prefix;
     struct in6_addr ip6_host;
     struct in6_addr ip6_dns;
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
     struct in_addr smbsrv = { .s_addr = 0 };
 #endif
     NetClientState *nc;
@@ -478,7 +478,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         return -1;
     }
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
     if (vsmbserver && !inet_aton(vsmbserver, &smbsrv)) {
         error_setg(errp, "Failed to parse SMB address");
         return -1;
@@ -593,7 +593,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
             }
         }
     }
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
     if (smb_export) {
         if (slirp_smb(s, smb_export, smbsrv, errp) < 0) {
             goto error;
@@ -785,7 +785,7 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
 
 }
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_IOS)
 
 /* automatic user mode samba server configuration */
 static void slirp_smb_cleanup(SlirpState *s)
@@ -900,7 +900,7 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
     return 0;
 }
 
-#endif /* !defined(_WIN32) */
+#endif /* !defined(_WIN32) && !defined(CONFIG_IOS) */
 
 static int guestfwd_can_read(void *opaque)
 {
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3bffee99d4..ebb63b2188 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -34,6 +34,12 @@
 
 #ifndef CONFIG_HAS_ENVIRON
 #ifdef __APPLE__
+#include "TargetConditionals.h"
+#if !TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
+#define APPLE_USE_CRT_EXTERNS
+#endif
+#endif
+#ifdef APPLE_USE_CRT_EXTERNS
 #include <crt_externs.h>
 #define environ (*_NSGetEnviron())
 #else
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 8718fd0194..3704f19df6 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -891,6 +891,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         return clock() / (CLOCKS_PER_SEC / 100);
     case TARGET_SYS_TIME:
         return set_swi_errno(env, time(NULL));
+#if !defined(CONFIG_IOS) /* iOS does not have system() */
     case TARGET_SYS_SYSTEM:
         GET_ARG(0);
         GET_ARG(1);
@@ -907,6 +908,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             unlock_user(s, arg0, 0);
             return ret;
         }
+#endif /* CONFIG_IOS */
     case TARGET_SYS_ERRNO:
         return get_swi_errno(env);
     case TARGET_SYS_GET_CMDLINE:
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 8e5fbfc8fa..6b8941839e 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -402,6 +402,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
             result = isatty(arg0);
         }
         break;
+#if !defined(CONFIG_IOS) /* iOS does not have system() */
     case HOSTED_SYSTEM:
         GET_ARG(0);
         GET_ARG(1);
@@ -420,6 +421,7 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
             }
         }
         break;
+#endif /* CONFIG_IOS */
     case HOSTED_INIT_SIM:
 #if defined(CONFIG_USER_ONLY)
         {
diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index d7a80dd303..bb029070d3 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -426,6 +426,7 @@ void do_nios2_semihosting(CPUNios2State *env)
             result = isatty(arg0);
         }
         break;
+#if !defined(CONFIG_IOS) /* iOS does not have system() */
     case HOSTED_SYSTEM:
         GET_ARG(0);
         GET_ARG(1);
@@ -444,6 +445,7 @@ void do_nios2_semihosting(CPUNios2State *env)
             }
         }
         break;
+#endif
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: unsupported "
                       "semihosting syscall %d\n", nr);
diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index d43647b3b7..cc7fb1bbbf 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -54,6 +54,7 @@ static void create_local_test_dir(void)
 }
 
 /* Deletes directory previously created by create_local_test_dir(). */
+#if !defined(CONFIG_IOS) /* iOS does not have system() */
 static void remove_local_test_dir(void)
 {
     g_assert(local_test_path != NULL);
@@ -64,6 +65,13 @@ static void remove_local_test_dir(void)
     }
     g_free(cmd);
 }
+#else
+static void remove_local_test_dir(void)
+{
+    fprintf(stderr, "Test not implemented for iOS\n");
+    g_assert(0);
+}
+#endif
 
 char *virtio_9p_test_path(const char *path)
 {
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ba8ebeead6..20bfbb69c2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -46,12 +46,11 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-swtpm-test'] : []) +        \
   (config_all_devices.has_key('CONFIG_RTL8139_PCI') ? ['rtl8139-test'] : []) +              \
+  (not config_host.has_key('CONFIG_IOS') ? ['bios-tables-test', 'hd-geo-test'] : []) +      \
   qtests_pci +                                                                              \
   ['fdc-test',
    'ide-test',
-   'hd-geo-test',
    'boot-order-test',
-   'bios-tables-test',
    'rtc-test',
    'i440fx-test',
    'fuzz-test',
@@ -144,9 +143,9 @@ qtests_arm = \
    'boot-serial-test',
    'hexloader-test']
 
-# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
+# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional (except on iOS)
 qtests_aarch64 = \
-  (cpu != 'arm' ? ['bios-tables-test'] : []) +                                                  \
+  (cpu != 'arm' and not config_host.has_key('CONFIG_IOS') ? ['bios-tables-test'] : []) +        \
   (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-test'] : []) +        \
   (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-swtpm-test'] : []) +  \
   ['arm-cpu-features',
-- 
2.28.0


