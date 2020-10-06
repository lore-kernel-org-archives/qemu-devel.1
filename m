Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DDFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D9B20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tihx61qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D9B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhot-0001kI-3a
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQF-0002oN-64
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQC-0001SE-ST
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 13so1845356wmf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rkEQInELIm4l3kHrX4stDT4Egsv9I700XbmiV5BB840=;
 b=Tihx61qXjFgqK13p4Zknhe22kShtn+Xuts2sgqE07qqoHBrQVBJRiNeQmt/9MEbi32
 8ibfKCCoa9wtiaRugWShKsVZ32s9CMTjEyZIO9i+iKBaP3qd5gkWTP8KHy6B/3ZlbZXm
 /gcIwGOz4pVOZUgAKU8fHkDe54tT3gU2sp16iPgWHOfsK3YPoP+qaGKVNYOc4VVldEQY
 UjA5Vhwrjd0IPKw3nc4N1JFK4Tns+fHdLQLvTuPTCqWY988P8A47yyDkh0uLtpxglViQ
 FIDXYhYNYDVP9Gcju2MsydS4tAlJ4A2xDvK5k2HQGCqgqxIci6vpuQ2p/8yq09rH4ZUR
 D3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rkEQInELIm4l3kHrX4stDT4Egsv9I700XbmiV5BB840=;
 b=ZBfPKPe2+0rGjJm3GHDCGvaf/+V3jiOCV8kp4MMDqPrh5vCxVsLzMeg0kjgKlaItNK
 HG4eQDtbVZmEutldHcZUCznfWNiCKulSnYOK4Ac5Lvnmvkh0aI69aX+iobBusH+0BPm1
 x+XUa9SLJr5z7ZZins9zBXBfMwAOPDNGd61CapDrkWk4BCHIG1fWn0uCkSVSkWEtk+Sl
 yYeoduVlSrCzwxbgKr2DwXkjQNUW6Aq4ZNeMQd6xRNiE/fAymOdKwWZkb12wExnHAtFO
 z/hIi62kAlgpnpfm80woOv3nGanSfqm0MuRw0aWUtimkRmhtvbuARr1R4sHLiDGA4cru
 dLCQ==
X-Gm-Message-State: AOAM533B0fiUgfQWcfOtxODl0InJdJpGcIlIL8/ZxY53h24SjaiVmFdy
 8TadEGM69V9F89YkNJk1Awq80WInLS4=
X-Google-Smtp-Source: ABdhPJzF12Po0vOAg0ZzewV5PQYyJtCzbKMAqXjds8S38jbEaTvNMWhczEdH3TWO/VPiGiey3l5kSQ==
X-Received: by 2002:a1c:4856:: with SMTP id v83mr3395732wma.118.1601969403057; 
 Tue, 06 Oct 2020 00:30:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/37] slirp: Convert Makefile bits to meson bits
Date: Tue,  6 Oct 2020 09:29:29 +0200
Message-Id: <20201006072947.487729-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SLIRP uses Meson so it could become a subproject in the future,
but our choice of configure options is not yet supported in Meson
(https://github.com/mesonbuild/meson/pull/7740).

For now, build the library via the main meson.build just like for
capstone.

This improves the current state of affairs in that we will re-link
the qemu executables against a changed libslirp.a, which we wouldn't
do before-hand.

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                |  7 +---
 configure               | 68 ++++---------------------------
 meson.build             | 90 +++++++++++++++++++++++++++++++++++++----
 meson_options.txt       |  3 ++
 net/meson.build         |  2 +-
 tests/qtest/meson.build |  6 +--
 6 files changed, 99 insertions(+), 77 deletions(-)

diff --git a/Makefile b/Makefile
index f27bd4b2eb..9d6b7fc8c0 100644
--- a/Makefile
+++ b/Makefile
@@ -163,12 +163,7 @@ dtc/%: .git-submodule-status
 capstone/all:
 
 .PHONY: slirp/all
-slirp/all: .git-submodule-status
-	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
-		BUILD_DIR="$(BUILD_DIR)/slirp" 			\
-		PKG_CONFIG="$(PKG_CONFIG)" 				\
-		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
-		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
+slirp/all:
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
diff --git a/configure b/configure
index 66641099fc..51f4e978be 100755
--- a/configure
+++ b/configure
@@ -349,7 +349,7 @@ modules="no"
 module_upgrades="no"
 prefix="/usr/local"
 qemu_suffix="qemu"
-slirp=""
+slirp="auto"
 oss_lib=""
 bsd="no"
 linux="no"
@@ -1058,9 +1058,9 @@ for opt do
   ;;
   --enable-vnc-png) vnc_png="enabled"
   ;;
-  --disable-slirp) slirp="no"
+  --disable-slirp) slirp="disabled"
   ;;
-  --enable-slirp=git) slirp="git"
+  --enable-slirp=git) slirp="internal"
   ;;
   --enable-slirp=system) slirp="system"
   ;;
@@ -5806,56 +5806,12 @@ fi
 ##########################################
 # check for slirp
 
-# slirp is only required when building softmmu targets
-if test -z "$slirp" -a "$softmmu" != "yes" ; then
-    slirp="no"
-fi
-
 case "$slirp" in
-  "" | yes)
-    if $pkg_config slirp; then
-      slirp=system
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
-      slirp=git
-    elif test -e "${source_path}/slirp/Makefile" ; then
-      slirp=internal
-    elif test -z "$slirp" ; then
-      slirp=no
-    else
-      feature_not_found "slirp" "Install slirp devel or git submodule"
-    fi
-    ;;
-
-  system)
-    if ! $pkg_config slirp; then
-      feature_not_found "slirp" "Install slirp devel"
-    fi
-    ;;
-esac
-
-case "$slirp" in
-  git | internal)
-    if test "$slirp" = git; then
+  auto | enabled | internal)
+    # Simpler to always update submodule, even if not needed.
+    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
       git_submodules="${git_submodules} slirp"
     fi
-    mkdir -p slirp
-    slirp_cflags="-I${source_path}/slirp/src -Islirp/src"
-    slirp_libs="-Lslirp -lslirp"
-    if test "$mingw32" = "yes" ; then
-      slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
-    fi
-    ;;
-
-  system)
-    slirp_version=$($pkg_config --modversion slirp 2>/dev/null)
-    slirp_cflags=$($pkg_config --cflags slirp 2>/dev/null)
-    slirp_libs=$($pkg_config --libs slirp 2>/dev/null)
-    ;;
-
-  no)
-    ;;
-  *)
-    error_exit "Unknown state for slirp: $slirp"
     ;;
 esac
 
@@ -6256,16 +6212,8 @@ fi
 if test "$guest_agent" = "yes" ; then
   echo "CONFIG_GUEST_AGENT=y" >> $config_host_mak
 fi
-if test "$slirp" != "no"; then
-  echo "CONFIG_SLIRP=y" >> $config_host_mak
-  echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
-  echo "SLIRP_CFLAGS=$slirp_cflags" >> $config_host_mak
-  echo "SLIRP_LIBS=$slirp_libs" >> $config_host_mak
-fi
+echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
 subdirs=
-if [ "$slirp" = "git" -o "$slirp" = "internal" ]; then
-  subdirs="$subdirs slirp"
-fi
 if test "$vde" = "yes" ; then
   echo "CONFIG_VDE=y" >> $config_host_mak
   echo "VDE_LIBS=$vde_libs" >> $config_host_mak
@@ -7321,7 +7269,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
-	-Dcapstone=$capstone \
+	-Dcapstone=$capstone -Dslirp=$slirp \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index a02c743794..165716ddad 100644
--- a/meson.build
+++ b/meson.build
@@ -300,11 +300,6 @@ else
   xkbcommon = dependency('xkbcommon', required: get_option('xkbcommon'),
                          method: 'pkg-config', static: enable_static)
 endif
-slirp = not_found
-if config_host.has_key('CONFIG_SLIRP')
-  slirp = declare_dependency(compile_args: config_host['SLIRP_CFLAGS'].split(),
-                             link_args: config_host['SLIRP_LIBS'].split())
-endif
 vde = not_found
 if config_host.has_key('CONFIG_VDE')
   vde = declare_dependency(link_args: config_host['VDE_LIBS'].split())
@@ -978,7 +973,88 @@ if capstone_opt == 'internal'
   capstone = declare_dependency(link_with: libcapstone,
                                 include_directories: 'capstone/include/capstone')
 endif
+
+slirp = not_found
+slirp_opt = 'disabled'
+if have_system
+  slirp_opt = get_option('slirp')
+  if slirp_opt in ['enabled', 'auto', 'system']
+    have_internal = fs.exists(meson.current_source_dir() / 'slirp/meson.build')
+    slirp = dependency('slirp', static: enable_static,
+                       method: 'pkg-config',
+                       required: slirp_opt == 'system' or
+                                 slirp_opt == 'enabled' and not have_internal)
+    if slirp.found()
+      slirp_opt = 'system'
+    elif have_internal
+      slirp_opt = 'internal'
+    else
+      slirp_opt = 'disabled'
+    endif
+  endif
+  if slirp_opt == 'internal'
+    slirp_deps = []
+    if targetos == 'windows'
+      slirp_deps = cc.find_library('iphlpapi')
+    endif
+    slirp_conf = configuration_data()
+    slirp_conf.set('SLIRP_MAJOR_VERSION', meson.project_version().split('.')[0])
+    slirp_conf.set('SLIRP_MINOR_VERSION', meson.project_version().split('.')[1])
+    slirp_conf.set('SLIRP_MICRO_VERSION', meson.project_version().split('.')[2])
+    slirp_conf.set_quoted('SLIRP_VERSION_STRING', meson.project_version())
+    slirp_cargs = ['-DG_LOG_DOMAIN="Slirp"']
+    slirp_files = [
+      'slirp/src/arp_table.c',
+      'slirp/src/bootp.c',
+      'slirp/src/cksum.c',
+      'slirp/src/dhcpv6.c',
+      'slirp/src/dnssearch.c',
+      'slirp/src/if.c',
+      'slirp/src/ip6_icmp.c',
+      'slirp/src/ip6_input.c',
+      'slirp/src/ip6_output.c',
+      'slirp/src/ip_icmp.c',
+      'slirp/src/ip_input.c',
+      'slirp/src/ip_output.c',
+      'slirp/src/mbuf.c',
+      'slirp/src/misc.c',
+      'slirp/src/ncsi.c',
+      'slirp/src/ndp_table.c',
+      'slirp/src/sbuf.c',
+      'slirp/src/slirp.c',
+      'slirp/src/socket.c',
+      'slirp/src/state.c',
+      'slirp/src/stream.c',
+      'slirp/src/tcp_input.c',
+      'slirp/src/tcp_output.c',
+      'slirp/src/tcp_subr.c',
+      'slirp/src/tcp_timer.c',
+      'slirp/src/tftp.c',
+      'slirp/src/udp.c',
+      'slirp/src/udp6.c',
+      'slirp/src/util.c',
+      'slirp/src/version.c',
+      'slirp/src/vmstate.c',
+    ]
+
+    configure_file(
+      input : 'slirp/src/libslirp-version.h.in',
+      output : 'libslirp-version.h',
+      configuration: slirp_conf)
+
+    slirp_inc = include_directories('slirp', 'slirp/src')
+    libslirp = static_library('slirp',
+                              sources: slirp_files,
+                              c_args: slirp_cargs,
+                              include_directories: slirp_inc)
+    slirp = declare_dependency(link_with: libslirp,
+                               dependencies: slirp_deps,
+                               include_directories: slirp_inc)
+  endif
+endif
+
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
+config_host_data.set('CONFIG_SLIRP', slirp.found())
 
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
@@ -1656,8 +1732,8 @@ summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_pa
 summary_info += {'sphinx-build':      config_host['SPHINX_BUILD']}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 # TODO: add back version
-summary_info += {'slirp support':     config_host.has_key('CONFIG_SLIRP')}
-if config_host.has_key('CONFIG_SLIRP')
+summary_info += {'slirp support':     slirp_opt == 'disabled' ? false : slirp_opt}
+if slirp_opt != 'disabled'
   summary_info += {'smbd':            config_host['CONFIG_SMBD_COMMAND']}
 endif
 summary_info += {'module support':    config_host.has_key('CONFIG_MODULES')}
diff --git a/meson_options.txt b/meson_options.txt
index a0455d8a95..8a362fb08d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -52,3 +52,6 @@ option('xkbcommon', type : 'feature', value : 'auto',
 option('capstone', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
        description: 'Whether and how to find the capstone library')
+option('slirp', type: 'combo', value: 'auto',
+       choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
+       description: 'Whether and how to find the slirp library')
diff --git a/net/meson.build b/net/meson.build
index 6c2ec47dd5..1c7e3a3cb9 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -18,7 +18,7 @@ softmmu_ss.add(files(
 ))
 
 softmmu_ss.add(when: 'CONFIG_L2TPV3', if_true: files('l2tpv3.c'))
-softmmu_ss.add(when: ['CONFIG_SLIRP', slirp], if_true: files('slirp.c'))
+softmmu_ss.add(when: slirp, if_true: files('slirp.c'))
 softmmu_ss.add(when: ['CONFIG_VDE', vde], if_true: files('vde.c'))
 softmmu_ss.add(when: 'CONFIG_NETMAP', if_true: files('netmap.c'))
 vhost_user_ss = ss.source_set()
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4f7757ee93..ad33ac311d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -23,7 +23,7 @@ qtests_pci = \
   (config_all_devices.has_key('CONFIG_IVSHMEM_DEVICE') ? ['ivshmem-test'] : [])
 
 qtests_i386 = \
-  (config_host.has_key('CONFIG_SLIRP') ? ['pxe-test', 'test-netfilter'] : []) +             \
+  (slirp.found() ? ['pxe-test', 'test-netfilter'] : []) +             \
   (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                     \
   (have_tools ? ['ahci-test'] : []) +                                                       \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
@@ -117,7 +117,7 @@ qtests_ppc64 = \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
-  (config_host.has_key('CONFIG_SLIRP') ? ['pxe-test', 'test-netfilter'] : []) +              \
+  (slirp.found() ? ['pxe-test', 'test-netfilter'] : []) +              \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +         \
   (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                      \
@@ -151,7 +151,7 @@ qtests_aarch64 = \
    'migration-test']
 
 qtests_s390x = \
-  (config_host.has_key('CONFIG_SLIRP') ? ['pxe-test', 'test-netfilter'] : []) +                 \
+  (slirp.found() ? ['pxe-test', 'test-netfilter'] : []) +                 \
   (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                         \
   (config_host.has_key('CONFIG_POSIX') ? ['test-filter-redirector'] : []) +                     \
   ['boot-serial-test',
-- 
2.26.2



