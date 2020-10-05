Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40932078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQlOZgKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40932078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLxy-0003af-DF
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007x3-IX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmi-0007J0-Lc
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so3044135wrp.10
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bu9de6cm0lH2qBcSdIQtYOK10gRljsxlzbM3pPqqQYI=;
 b=SQlOZgKmlmMsXOcvE0YvNbKp+BbjMJfHq9yUybc7WoRq9p5HQxEBC+qX7H96suDFFR
 J99reupOSZ1U0LO2H29EMWrEU7Zw32zV5mzfhTzVHDtI0wAPHnSExSsXuWb3sOopLZRK
 sFH20AKbe76Rs6kJiosktdbXlzIab9XhKM/z+i8XP57UEIGj+qk2tGCbOq2LdEoMNyPS
 rQxeV1F3x2eCY0EY2FkSXl2ABoy4KaUbu82Itpvo29X3JTj7hPEMAM/eG7XPowYTfUWb
 L0ewu23hncDJpptkLd31/3S5QUUGAonYm71jEP9JbQ6HUrAZFtdbWb3vpOX/mymGNOpB
 EhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Bu9de6cm0lH2qBcSdIQtYOK10gRljsxlzbM3pPqqQYI=;
 b=jcMMxa6kZLR9kM1aju2Ttz14dhny8hqjvhT7wE3xh1r2gTBrensvhouEeSIIOsdwZl
 EqAelNPUvXWDQbLA7slDTHn++1XE4ioAOQyEolJI8x9JB/gry4dw8cQgnvwgMXBNkFBm
 ulkggcvLy3BdthyZhEvVhy1T01EqPQJpoe19MOemMGlult9ZMSvTQR+wX/vk7pertOBm
 +clZmWHlsOdG5SgXOYAyx3MQbVGGAD9nIdZ2cpkh1qbdriFsGHTXQ6IaZkFmk4DGR7HV
 S+ita0P9NBYXzu/SFjbddiwow60ZVv5HSHDidGb9tkQ0TuqAQweMQ31yeQ4im23phoov
 b9Pg==
X-Gm-Message-State: AOAM532E1AmIHQnhV9VWFy4JelCPJ/clFgIBnKDw/83ocfix2H5M50+b
 D1yxgSFnGiyKUF9Y+gZP+HyShT/rtgs=
X-Google-Smtp-Source: ABdhPJwTBbCV7xlw5Eqtp7BIaGZgnCT0PeQfOMTvym/sKtUxMfNeChowX3CVPAsJ0aTf6ICdIY/iOw==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr6437535wrn.229.1601886230945; 
 Mon, 05 Oct 2020 01:23:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] configure: convert accelerator variables to meson options
Date: Mon,  5 Oct 2020 10:23:33 +0200
Message-Id: <20201005082349.354095-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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

Prepare for moving the tests to meson.  For now they only have
enabled/disabled as the possible values when meson is invoked,
but "auto" will be a possibility later, when configure will only
parse the command line options.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 132 +++++++++++++++++++++++-----------------------
 meson_options.txt |  15 ++++++
 tests/meson.build |   2 +-
 3 files changed, 83 insertions(+), 66 deletions(-)

diff --git a/configure b/configure
index 1981f58aa9..5cbfab9968 100755
--- a/configure
+++ b/configure
@@ -220,7 +220,7 @@ glob() {
 }
 
 supported_hax_target() {
-    test "$hax" = "yes" || return 1
+    test "$hax" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}" in
         i386|x86_64)
@@ -231,7 +231,7 @@ supported_hax_target() {
 }
 
 supported_kvm_target() {
-    test "$kvm" = "yes" || return 1
+    test "$kvm" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}:$cpu" in
         aarch64:aarch64 | \
@@ -247,7 +247,7 @@ supported_kvm_target() {
 }
 
 supported_xen_target() {
-    test "$xen" = "yes" || return 1
+    test "$xen" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     # Only i386 and x86_64 provide the xenpv machine.
     case "${1%-softmmu}" in
@@ -259,7 +259,7 @@ supported_xen_target() {
 }
 
 supported_hvf_target() {
-    test "$hvf" = "yes" || return 1
+    test "$hvf" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}" in
         x86_64)
@@ -270,7 +270,7 @@ supported_hvf_target() {
 }
 
 supported_whpx_target() {
-    test "$whpx" = "yes" || return 1
+    test "$whpx" = "enabled" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}" in
         i386|x86_64)
@@ -310,7 +310,7 @@ supported_target() {
         add_to deprecated_features $1
     fi
 
-    test "$tcg" = "yes" && return 0
+    test "$tcg" = "enabled" && return 0
     supported_kvm_target "$1" && return 0
     supported_xen_target "$1" && return 0
     supported_hax_target "$1" && return 0
@@ -413,14 +413,14 @@ vnc_png="auto"
 xkbcommon="auto"
 xen=""
 xen_ctrl_version=""
-xen_pci_passthrough=""
+xen_pci_passthrough="auto"
 linux_aio=""
 linux_io_uring=""
 cap_ng=""
 attr=""
 libattr=""
 xfs=""
-tcg="yes"
+tcg="enabled"
 membarrier=""
 vhost_net=""
 vhost_crypto=""
@@ -428,10 +428,10 @@ vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
 vhost_user_fs=""
-kvm="no"
-hax="no"
-hvf="no"
-whpx="no"
+kvm="disabled"
+hax="disabled"
+hvf="disabled"
+whpx="disabled"
 rdma=""
 pvrdma=""
 gprof="no"
@@ -817,8 +817,8 @@ HOST_VARIANT_DIR=""
 case $targetos in
 MINGW32*)
   mingw32="yes"
-  hax="yes"
-  whpx=""
+  hax="enabled"
+  whpx="auto"
   vhost_user="no"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
@@ -852,7 +852,7 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
-  hax="yes"
+  hax="enabled"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
@@ -869,8 +869,8 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
-  hax="yes"
-  hvf=""
+  hax="enabled"
+  hvf="auto"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
@@ -906,7 +906,7 @@ Linux)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-  kvm="yes"
+  kvm="enabled"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
 ;;
 esac
@@ -1188,33 +1188,33 @@ for opt do
   ;;
   --enable-netmap) netmap="yes"
   ;;
-  --disable-xen) xen="no"
+  --disable-xen) xen="disabled"
   ;;
-  --enable-xen) xen="yes"
+  --enable-xen) xen="enabled"
   ;;
-  --disable-xen-pci-passthrough) xen_pci_passthrough="no"
+  --disable-xen-pci-passthrough) xen_pci_passthrough="disabled"
   ;;
-  --enable-xen-pci-passthrough) xen_pci_passthrough="yes"
+  --enable-xen-pci-passthrough) xen_pci_passthrough="enabled"
   ;;
   --disable-brlapi) brlapi="no"
   ;;
   --enable-brlapi) brlapi="yes"
   ;;
-  --disable-kvm) kvm="no"
+  --disable-kvm) kvm="disabled"
   ;;
-  --enable-kvm) kvm="yes"
+  --enable-kvm) kvm="enabled"
   ;;
-  --disable-hax) hax="no"
+  --disable-hax) hax="disabled"
   ;;
-  --enable-hax) hax="yes"
+  --enable-hax) hax="enabled"
   ;;
-  --disable-hvf) hvf="no"
+  --disable-hvf) hvf="disabled"
   ;;
-  --enable-hvf) hvf="yes"
+  --enable-hvf) hvf="enabled"
   ;;
-  --disable-whpx) whpx="no"
+  --disable-whpx) whpx="disabled"
   ;;
-  --enable-whpx) whpx="yes"
+  --enable-whpx) whpx="enabled"
   ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
@@ -1224,9 +1224,9 @@ for opt do
   ;;
   --enable-cap-ng) cap_ng="yes"
   ;;
-  --disable-tcg) tcg="no"
+  --disable-tcg) tcg="disabled"
   ;;
-  --enable-tcg) tcg="yes"
+  --enable-tcg) tcg="enabled"
   ;;
   --disable-malloc-trim) malloc_trim="disabled"
   ;;
@@ -1711,7 +1711,7 @@ if [ "$ARCH" = "unknown" ]; then
 fi
 
 if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
-  tcg="no"
+  tcg="disabled"
 fi
 
 default_target_list=""
@@ -2668,7 +2668,7 @@ fi
 ##########################################
 # xen probe
 
-if test "$xen" != "no" ; then
+if test "$xen" != "disabled" ; then
   # Check whether Xen library path is specified via --extra-ldflags to avoid
   # overriding this setting with pkg-config output. If not, try pkg-config
   # to obtain all needed flags.
@@ -2677,7 +2677,7 @@ if test "$xen" != "no" ; then
      $pkg_config --exists xencontrol ; then
     xen_ctrl_version="$(printf '%d%02d%02d' \
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
-    xen=yes
+    xen=enabled
     xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
     xen_pc="$xen_pc xenevtchn xendevicemodel"
     if $pkg_config --exists xentoolcore; then
@@ -2703,10 +2703,10 @@ int main(void) {
 EOF
     if ! compile_prog "" "$xen_libs" ; then
       # Xen not found
-      if test "$xen" = "yes" ; then
+      if test "$xen" = "enabled" ; then
         feature_not_found "xen" "Install xen devel"
       fi
-      xen=no
+      xen=disabled
 
     # Xen unstable
     elif
@@ -2732,7 +2732,7 @@ EOF
       then
       xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
       xen_ctrl_version=41100
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_MAP_FOREIGN_API
@@ -2752,7 +2752,7 @@ EOF
       then
       xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
       xen_ctrl_version=41000
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
@@ -2771,7 +2771,7 @@ EOF
       then
       xen_stable_libs="-lxendevicemodel $xen_stable_libs"
       xen_ctrl_version=40900
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 /*
@@ -2824,7 +2824,7 @@ EOF
         compile_prog "" "$xen_libs $xen_stable_libs"
       then
       xen_ctrl_version=40800
-      xen=yes
+      xen=enabled
     elif
         cat > $TMPC <<EOF &&
 /*
@@ -2873,7 +2873,7 @@ EOF
         compile_prog "" "$xen_libs $xen_stable_libs"
       then
       xen_ctrl_version=40701
-      xen=yes
+      xen=enabled
 
     # Xen 4.6
     elif
@@ -2901,7 +2901,7 @@ EOF
         compile_prog "" "$xen_libs"
       then
       xen_ctrl_version=40600
-      xen=yes
+      xen=enabled
 
     # Xen 4.5
     elif
@@ -2928,7 +2928,7 @@ EOF
         compile_prog "" "$xen_libs"
       then
       xen_ctrl_version=40500
-      xen=yes
+      xen=enabled
 
     elif
         cat > $TMPC <<EOF &&
@@ -2953,17 +2953,17 @@ EOF
         compile_prog "" "$xen_libs"
       then
       xen_ctrl_version=40200
-      xen=yes
+      xen=enabled
 
     else
-      if test "$xen" = "yes" ; then
+      if test "$xen" = "enabled" ; then
         feature_not_found "xen (unsupported version)" \
                           "Install a supported xen (xen 4.2 or newer)"
       fi
-      xen=no
+      xen=disabled
     fi
 
-    if test "$xen" = yes; then
+    if test "$xen" = enabled; then
       if test $xen_ctrl_version -ge 40701  ; then
         xen_libs="$xen_libs $xen_stable_libs "
       fi
@@ -2971,31 +2971,31 @@ EOF
   fi
 fi
 
-if test "$xen_pci_passthrough" != "no"; then
-  if test "$xen" = "yes" && test "$linux" = "yes"; then
-    xen_pci_passthrough=yes
+if test "$xen_pci_passthrough" != "disabled"; then
+  if test "$xen" = "enabled" && test "$linux" = "yes"; then
+    xen_pci_passthrough=enabled
   else
-    if test "$xen_pci_passthrough" = "yes"; then
+    if test "$xen_pci_passthrough" = "enabled"; then
       error_exit "User requested feature Xen PCI Passthrough" \
           " but this feature requires /sys from Linux"
     fi
-    xen_pci_passthrough=no
+    xen_pci_passthrough=disabled
   fi
 fi
 
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" = "yes" && test "$ARCH" != "x86_64"; then
+if test "$whpx" = "enabled" && test "$ARCH" != "x86_64"; then
   error_exit "WHPX requires 64-bit host"
 fi
-if test "$whpx" != "no" && test "$ARCH" = "x86_64"; then
+if test "$whpx" != "disabled" && test "$ARCH" = "x86_64"; then
     if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
         whpx="yes"
     else
-        if test "$whpx" = "yes"; then
+        if test "$whpx" = "auto"; then
             feature_not_found "WinHvPlatform" "WinHvEmulation is not installed"
         fi
-        whpx="no"
+        whpx="disabled"
     fi
 fi
 
@@ -5823,18 +5823,18 @@ fi
 
 #################################################
 # Check to see if we have the Hypervisor framework
-if [ "$hvf" != "no" ] ; then
+if [ "$hvf" != "disabled" ] ; then
   cat > $TMPC << EOF
 #include <Hypervisor/hv.h>
 int main() { return 0;}
 EOF
   if ! compile_object ""; then
-    if test "$hvf" = "yes"; then
+    if test "$hvf" = "enabled"; then
 	error_exit "Hypervisor.framework not available"
     fi
-    hvf='no'
+    hvf='disabled'
   else
-    hvf='yes'
+    hvf='enabled'
   fi
 fi
 
@@ -6192,7 +6192,7 @@ if test "$mingw32" = "yes" ; then
 fi
 
 # Disable OpenBSD W^X if available
-if test "$tcg" = "yes" && test "$targetos" = "OpenBSD"; then
+if test "$tcg" = "enabled" && test "$targetos" = "OpenBSD"; then
     cat > $TMPC <<EOF
     int main(void) { return 0; }
 EOF
@@ -6743,7 +6743,7 @@ if test "$virglrenderer" = "yes" ; then
   echo "VIRGL_CFLAGS=$virgl_cflags" >> $config_host_mak
   echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
 fi
-if test "$xen" = "yes" ; then
+if test "$xen" = "enabled" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
   echo "XEN_CFLAGS=$xen_cflags" >> $config_host_mak
@@ -6823,7 +6823,7 @@ fi
 if test "$optreset" = "yes" ; then
   echo "HAVE_OPTRESET=y" >> $config_host_mak
 fi
-if test "$tcg" = "yes"; then
+if test "$tcg" = "enabled"; then
   echo "CONFIG_TCG=y" >> $config_host_mak
   if test "$tcg_interpreter" = "yes" ; then
     echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
@@ -7606,7 +7606,7 @@ fi
 
 if supported_xen_target $target; then
     echo "CONFIG_XEN=y" >> $config_target_mak
-    if test "$xen_pci_passthrough" = yes; then
+    if test "$xen_pci_passthrough" = enabled; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
     fi
 fi
@@ -7844,6 +7844,8 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
+	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
 	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
diff --git a/meson_options.txt b/meson_options.txt
index 46ea1d889a..05adc7a179 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -11,6 +11,21 @@ option('malloc_trim', type : 'feature', value : 'auto',
 option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
        value: 'system', description: 'choose memory allocator to use')
 
+option('kvm', type: 'feature', value: 'auto',
+       description: 'KVM acceleration support')
+option('hax', type: 'feature', value: 'auto',
+       description: 'HAX acceleration support')
+option('whpx', type: 'feature', value: 'auto',
+       description: 'WHPX acceleration support')
+option('hvf', type: 'feature', value: 'auto',
+       description: 'HVF acceleration support')
+option('xen', type: 'feature', value: 'auto',
+       description: 'Xen backend support')
+option('xen_pci_passthrough', type: 'feature', value: 'auto',
+       description: 'Xen PCI passthrough support')
+option('tcg', type: 'feature', value: 'auto',
+       description: 'TCG support')
+
 option('cocoa', type : 'feature', value : 'auto',
        description: 'Cocoa user interface (macOS only)')
 option('mpath', type : 'feature', value : 'auto',
diff --git a/tests/meson.build b/tests/meson.build
index 3c2969092d..bf47a38c74 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -269,7 +269,7 @@ test('decodetree', sh,
 
 subdir('fp')
 
-if 'CONFIG_TCG' in config_host
+if not get_option('tcg').disabled()
   if 'CONFIG_PLUGIN' in config_host
     subdir('plugin')
   endif
-- 
2.26.2



