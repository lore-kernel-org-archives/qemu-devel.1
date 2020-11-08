Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B31C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA07F217A0
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA07F217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdFz-0003vq-SA
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDT-0001Rp-R5; Sun, 08 Nov 2020 00:26:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDR-0004uz-Nf; Sun, 08 Nov 2020 00:26:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id x23so2945828plr.6;
 Sat, 07 Nov 2020 21:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cM7lsRAmlkTbvOM+j4lORMBpE+S8g7GDEIfq9+p1rSs=;
 b=nBC458PTVgs6s124koLFEpsg8wo2NG1t8l4zo4tXdx3H8aCx0qG/B1w8tx5hOnufkb
 lXhqkVdFVMoGTP5/K1pTetZAwqxz/oxLqOv42D2bxxYjwy6GiMUtQp09jKbKBKE+E6US
 4cQzsQ5bNC7b5KdwzB+58vHsKa3IsurzETIy3TnbK7MXn6lDgHr+UykfBjQ1quJnR1+U
 aqHqBWPAq1U6jdYUN22/w1itaJtocChEIj8Z7Q296a6FLOZTvtBgeJ+odUTFmwVL/nKm
 4/jJcfvE/wVD8/847DIOy28T5SHNdEw8dFrnapvfhctUxHPVVrThG7eSBUaSm9ea4xFv
 jQFg==
X-Gm-Message-State: AOAM533RIJ4wqjXi2SShenrRQ0v4npv0vyJPU2bGOG+8DeQu69dEgLmH
 sIOuI4OjyFVVzdTEmSsArr9amv2HgdU=
X-Google-Smtp-Source: ABdhPJxOZUW+zmV7bhIiMdniFBbUxyjKcNDt1Y/NnrsYOxaTq4judaAXT20D2BLZJ9gOaSYsnanXZw==
X-Received: by 2002:a17:90a:5882:: with SMTP id
 j2mr6708123pji.177.1604813171825; 
 Sat, 07 Nov 2020 21:26:11 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:11 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/7] qemu: add support for iOS host
Date: Sat,  7 Nov 2020 21:26:01 -0800
Message-Id: <20201108052605.45840-4-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108052605.45840-1-j@getutm.app>
References: <20201108052605.45840-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.193;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Joelle van Dyne <j@getutm.app>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces support for building for iOS hosts. When the correct Xcode
toolchain is used, iOS host will be detected automatically.

* block: disable features not supported by iOS sandbox
* slirp: disable SMB features for iOS
* osdep: disable system() calls for iOS

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 docs/devel/index.rst    |  1 +
 docs/devel/ios.rst      | 28 +++++++++++++++++++++++++++
 configure               | 43 ++++++++++++++++++++++++++++++++++++++++-
 meson.build             |  2 +-
 include/qemu/osdep.h    | 11 +++++++++++
 block.c                 |  2 +-
 block/file-posix.c      | 31 +++++++++++++++++------------
 net/slirp.c             | 16 +++++++--------
 qga/commands-posix.c    |  6 ++++++
 MAINTAINERS             |  7 +++++++
 tests/qtest/meson.build |  7 +++----
 11 files changed, 127 insertions(+), 27 deletions(-)
 create mode 100644 docs/devel/ios.rst

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 77baae5c77..a46740929f 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -34,3 +34,4 @@ Contents:
    clocks
    qom
    block-coroutine-wrapper
+   ios
diff --git a/docs/devel/ios.rst b/docs/devel/ios.rst
new file mode 100644
index 0000000000..b4ab11bec1
--- /dev/null
+++ b/docs/devel/ios.rst
@@ -0,0 +1,28 @@
+===========
+iOS Support
+===========
+
+To run qemu on the iOS platform, some modifications were required. Most of the
+modifications are conditioned on the ``CONFIG_IOS`` and configuration variable.
+
+Build support
+-------------
+
+For the code to compile, certain changes in the block driver and the slirp
+driver had to be made. There is no ``system()`` call, so it has been replaced
+with an assertion error. There should be no code path that call system() from
+iOS.
+
+``ucontext`` support is broken on iOS. The implementation from ``libucontext``
+is used instead.
+
+JIT support
+-----------
+
+On iOS, allocating RWX pages require special entitlements not usually granted to
+apps. However, it is possible to use `bulletproof JIT`_ with a development
+certificate. This means that we need to allocate one chunk of memory with RX
+permissions and then mirror map the same memory with RW permissions. We generate
+code to the mirror mapping and execute the original mapping.
+
+.. _bulletproof JIT: https://www.blackhat.com/docs/us-16/materials/us-16-Krstic.pdf
diff --git a/configure b/configure
index fda7a875f7..2a6db88a46 100755
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
@@ -777,6 +794,22 @@ Darwin)
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
@@ -5962,6 +5995,10 @@ if test "$darwin" = "yes" ; then
   echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
 
+if test "$ios" = "yes" ; then
+  echo "CONFIG_IOS=y" >> $config_host_mak
+fi
+
 if test "$solaris" = "yes" ; then
   echo "CONFIG_SOLARIS=y" >> $config_host_mak
 fi
@@ -6926,6 +6963,7 @@ echo "cpp_link_args = [${LDFLAGS:+$(meson_quote $LDFLAGS)}]" >> $cross
 echo "[binaries]" >> $cross
 echo "c = [$(meson_quote $cc)]" >> $cross
 test -n "$cxx" && echo "cpp = [$(meson_quote $cxx)]" >> $cross
+test -n "$objcc" && echo "objc = [$(meson_quote $objcc)]" >> $cross
 echo "ar = [$(meson_quote $ar)]" >> $cross
 echo "nm = [$(meson_quote $nm)]" >> $cross
 echo "pkgconfig = [$(meson_quote $pkg_config_exe)]" >> $cross
@@ -6944,6 +6982,9 @@ if test "$cross_compile" = "yes"; then
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
index fd822346e7..8894171bd1 100644
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
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f9ec8c84e9..eb8d06cbf5 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -686,4 +686,15 @@ char *qemu_get_host_name(Error **errp);
  */
 size_t qemu_get_host_physmem(void);
 
+/**
+ * iOS does not support system() so we replace it with an assertion failure.
+ */
+#ifdef CONFIG_IOS
+#define system ios_does_not_support_system
+static inline int ios_does_not_support_system(const char *command)
+{
+    assert(0);
+}
+#endif /* CONFIG_IOS */
+
 #endif
diff --git a/block.c b/block.c
index 56bacc9e9f..e99cbf25ee 100644
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
index 3711080d07..66a2f2ac9e 100644
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 63223e1183..1ec4c67a62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -528,6 +528,13 @@ F: include/*/*win32*
 X: qga/*win32*
 F: qemu.nsi
 
+IOS
+M: Joelle van Dyne <j@getutm.app>
+S: Maintained
+K: ^Subject:.*(?i)iOS
+F: docs/devel/ios.rst
+F: include/tcg/tcg-apple-jit.h
+
 Alpha Machines
 --------------
 M: Richard Henderson <rth@twiddle.net>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c19f1c8503..8a151ee2da 100644
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
@@ -148,9 +147,9 @@ qtests_arm = \
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


