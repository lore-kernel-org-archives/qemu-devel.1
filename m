Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F43C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E514E20789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPzrHESn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E514E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gSg-00013g-3b
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGs-00043Y-Ac
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGq-00065M-GN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id a15so15233286wrh.10
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sX3v+t9MCcWKD8VmZAcSmOKmtyBCwIHz9lD/cY7kqX4=;
 b=iPzrHESnFFC+w2IOEPiWZcOVBdHA7zkVCCAppkB5zLvZflLISIEYavg9o32YTvUdrA
 DVxo/iSCVByFvtwUDR/w2XiNAeqtxSRpLE9PDtXRMFhM/hEjHEB8pjl3JBstK0qVk8jd
 6KJJkMNpWucEqF/DtUUkBrDutHFCkUkY69Fxp1M/Fh2y/DMVtXXi/v9IzI9dIgeb7Y8N
 GDHoRfT5BOyKHO2SsZXl9tak5SrISFitVvhD1lyAG6EePYbU92XnDIA6VG47Rx6PcWlb
 Qv3T9MYrdJOJVd09JTA9KwTRds2SEOybZZ+/c+qMQTCIr5y7WoGxqfsWs9k81pvZZ+8p
 v1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sX3v+t9MCcWKD8VmZAcSmOKmtyBCwIHz9lD/cY7kqX4=;
 b=TR5f25ZRK+t21J4bav0YQkQOlHk8+9mgHH0SDB8+tTYHc6zHr5p8bYZwePQXoQ/75s
 4Bv6KkDC19sFj0VqfcUgTanQYrR3efsRD4V0J6W1dtMm8opaEZoAsggRwMH6Gf4eNoxf
 9P7/CUOpviutjCYG9qiR5VXIp7Ujbge/8+nF8KvlkSdAwoiCfCDS09LL2I8+K0UTlK2Q
 WR2eBEtmFke/bX1FxmmFONLxGvts8nBLrybU0WME9uu1rwPOsm95JS017NkWgnaqPAgQ
 +tjm0zNvv9tlo9WhBIn82BSD9RaDgZjhjYTGTrBejNsD2nlTFnCLKZZiFsGzQ6PLKcvD
 CYxw==
X-Gm-Message-State: AOAM532/svhO5xIWLhrZRKdDZzLhKFEftw47lTTqeYt99hEMeTDIXaRI
 218fubn08FPXB4n7EF72WgJ48Q4fMVA=
X-Google-Smtp-Source: ABdhPJzRRPK9y2FFOhXLvbGRiXTvMA/KStXdMWbaGyKdk7c6ycuiPcDxO6eAyV+tv8E65fMm6AXRYQ==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr16624228wrw.360.1597675074881; 
 Mon, 17 Aug 2020 07:37:54 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.54 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 028/150] tools/virtiofsd: convert to Meson
Date: Mon, 17 Aug 2020 16:35:21 +0200
Message-Id: <20200817143723.343284-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                                      | 12 ------------
 Makefile.objs                                 |  1 -
 configure                                     |  1 +
 meson.build                                   | 11 +++++++++++
 tools/meson.build                             | 10 ++++++++++
 tools/virtiofsd/Makefile.objs                 | 12 ------------
 tools/virtiofsd/meson.build                   | 19 +++++++++++++++++++
 tools/virtiofsd/passthrough_ll.c              |  2 +-
 .../{seccomp.c => passthrough_seccomp.c}      |  2 +-
 .../{seccomp.h => passthrough_seccomp.h}      |  0
 10 files changed, 43 insertions(+), 27 deletions(-)
 create mode 100644 tools/meson.build
 delete mode 100644 tools/virtiofsd/Makefile.objs
 create mode 100644 tools/virtiofsd/meson.build
 rename tools/virtiofsd/{seccomp.c => passthrough_seccomp.c} (99%)
 rename tools/virtiofsd/{seccomp.h => passthrough_seccomp.h} (100%)

diff --git a/Makefile b/Makefile
index 2dee3e89a4..3bb2cd7c73 100644
--- a/Makefile
+++ b/Makefile
@@ -194,11 +194,6 @@ HELPERS-y += vhost-user-gpu$(EXESUF)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
 
-ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyyy)
-HELPERS-y += virtiofsd$(EXESUF)
-vhost-user-json-y += tools/virtiofsd/50-qemu-virtiofsd.json
-endif
-
 # Sphinx does not allow building manuals into the same directory as
 # the source files, so if we're doing an in-tree QEMU build we must
 # build the manuals into a subdirectory (and then install them from
@@ -305,7 +300,6 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
-                virtiofsd-obj-y \
                 rdmacm-mux-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
@@ -538,12 +532,6 @@ rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
-# relies on Linux-specific syscalls
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-virtiofsd$(EXESUF): $(virtiofsd-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
-endif
-
 vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index 9489864967..fee0f71372 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -113,6 +113,5 @@ vhost-user-blk-obj-y = contrib/vhost-user-blk/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
-virtiofsd-obj-y = tools/virtiofsd/
 
 ######################################################################
diff --git a/configure b/configure
index ca87955a65..9582ecdf02 100755
--- a/configure
+++ b/configure
@@ -6998,6 +6998,7 @@ if test "$gprof" = "yes" ; then
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
+  echo "LIBCAP_NG_LIBS=$cap_libs" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/meson.build b/meson.build
index 00a519edc6..d56cd0dd27 100644
--- a/meson.build
+++ b/meson.build
@@ -79,6 +79,15 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+seccomp = not_found
+if 'CONFIG_SECCOMP' in config_host
+  seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
+                               link_args: config_host['SECCOMP_LIBS'].split())
+endif
+libcap_ng = not_found
+if 'CONFIG_LIBCAP_NG' in config_host
+  libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -247,6 +256,8 @@ if have_tools
   endif
 endif
 
+subdir('tools')
+
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
 summary_info += {'BIOS directory':    config_host['qemu_datadir']}
diff --git a/tools/meson.build b/tools/meson.build
new file mode 100644
index 0000000000..513bd2ff4f
--- /dev/null
+++ b/tools/meson.build
@@ -0,0 +1,10 @@
+have_virtiofsd = (have_system and
+    have_tools and
+    'CONFIG_LINUX' in config_host and 
+    'CONFIG_SECCOMP' in config_host and
+    'CONFIG_LIBCAP_NG' in config_host and
+    'CONFIG_VHOST_USER' in config_host)
+
+if have_virtiofsd
+  subdir('virtiofsd')
+endif
diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.objs
deleted file mode 100644
index 076f667e46..0000000000
--- a/tools/virtiofsd/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-virtiofsd-obj-y = buffer.o \
-                  fuse_opt.o \
-                  fuse_log.o \
-                  fuse_lowlevel.o \
-                  fuse_signals.o \
-                  fuse_virtio.o \
-                  helper.o \
-                  passthrough_ll.o \
-                  seccomp.o
-
-seccomp.o-cflags := $(SECCOMP_CFLAGS)
-seccomp.o-libs := $(SECCOMP_LIBS)
diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
new file mode 100644
index 0000000000..d1e23c5760
--- /dev/null
+++ b/tools/virtiofsd/meson.build
@@ -0,0 +1,19 @@
+executable('virtiofsd', files(
+  'buffer.c',
+  'fuse_opt.c',
+  'fuse_log.c',
+  'fuse_lowlevel.c',
+  'fuse_signals.c',
+  'fuse_virtio.c',
+  'helper.c',
+  'passthrough_ll.c',
+  'passthrough_seccomp.c'),
+  link_with: libvhost_user,
+  dependencies: [seccomp, qemuutil, libcap_ng],
+  install: true,
+  install_dir: get_option('libexecdir'))
+
+configure_file(input: '50-qemu-virtiofsd.json.in',
+               output: '50-qemu-virtiofsd.json',
+               configuration: config_host,
+               install_dir: config_host['qemu_datadir'] / 'vhost-user')
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 94e0de2d2b..63d1d00565 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -65,7 +65,7 @@
 #include <unistd.h>
 
 #include "passthrough_helpers.h"
-#include "seccomp.h"
+#include "passthrough_seccomp.h"
 
 /* Keep track of inode posix locks for each owner. */
 struct lo_inode_plock {
diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
similarity index 99%
rename from tools/virtiofsd/seccomp.c
rename to tools/virtiofsd/passthrough_seccomp.c
index 3b1522acdd..19fee60011 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/passthrough_seccomp.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "seccomp.h"
+#include "passthrough_seccomp.h"
 #include "fuse_i.h"
 #include "fuse_log.h"
 #include <errno.h>
diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/passthrough_seccomp.h
similarity index 100%
rename from tools/virtiofsd/seccomp.h
rename to tools/virtiofsd/passthrough_seccomp.h
-- 
2.26.2



