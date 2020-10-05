Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA157C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020212078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpovbuLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020212078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLvv-0001AA-QP
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmo-0007yF-KO
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007J6-A3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id n18so657587wrs.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uMBmCSkgRhANx9m0+W5bbNKpkAyzCZqBpC1vDQvgP6I=;
 b=MpovbuLgKbXxKhiRPMPiGOLsjZz7WMV1ZFPENEFgyebgMHOh2tzUi9cciWcl1IDvkz
 bss1mKgTADzoHmOGoGNNd7fFu03DRIE0rt/WSaznSrIDNkI94HKt2h66Z1SaOgmX/ihA
 YcQMgmeZROKfRTxcrUH8R38j8g4Sj7FTR1DqqU11vlqa+9+IlaSrQrtqd3soGCQVB/bw
 UOUWApNHxK/CkdQwojDk9pNj/lV0y4qhKa7QVNKBlmBBhBjg3CR1tGXTKlT04rd9k36x
 +2aNRtgg+xI1uB+RFDRGovm6o/W76rRqN4rjlQu01VTAZNyxSNouwPGujAy/j6o20uVv
 d9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uMBmCSkgRhANx9m0+W5bbNKpkAyzCZqBpC1vDQvgP6I=;
 b=h3ZYcUXEQCiGXwZ7+qjKtOlLSl5iQSqmaS2O+oJoNrktA7OhY01pETA2eZQJtdGOk1
 4y5cvFaWD8zS4V1OQchXS67WmB0eEnmfJu2V4Sd839afPaisXbX8xe1ZFlgxqbAVNNb7
 4Q72qgtaAxnUbIlHHT4kU7Ha5X4T3xxL4Bxuy/+INB5y593gKvmKFk0I5l6TJPo5oNAS
 IhTvZywKVpD/nDiz0GZLRhhwroHhIVqQKpbcjwJ6B8UHjCuXf8Pgeb/dAwoLR2IWiD4/
 EP16McMwZNNCL7yiPMDWheY9oJIjaVAr0AHx7sAub//0d0Qj7HwKmP/dIs/F/yZI0FaP
 v4tg==
X-Gm-Message-State: AOAM531MdYUO2cjlglGBrVpLtw7gLPehWyUx7Gmmcu4Ppe1l8uXSfsZV
 lKLKn4P4u/yIBwIQP58eIEeAx2F6iX0=
X-Google-Smtp-Source: ABdhPJyR7XK3WQ55hwXWT85OMzhnkMV9I9diHeWay8w+a28ohm6N0BsNKglrDwB/NnX4BbgK89HmEw==
X-Received: by 2002:adf:e989:: with SMTP id h9mr17358541wrm.38.1601886231984; 
 Mon, 05 Oct 2020 01:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/19] configure: rewrite accelerator defaults as tests
Date: Mon,  5 Oct 2020 10:23:34 +0200
Message-Id: <20201005082349.354095-5-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prepare to process "auto" in meson rather than configure: standardize the
shape of the code that changes "auto" to enabled/disabled, to ease the review
when it will be moved to meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 58 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 5cbfab9968..9dec87e186 100755
--- a/configure
+++ b/configure
@@ -428,10 +428,10 @@ vhost_scsi=""
 vhost_vsock=""
 vhost_user=""
 vhost_user_fs=""
-kvm="disabled"
-hax="disabled"
-hvf="disabled"
-whpx="disabled"
+kvm="auto"
+hax="auto"
+hvf="auto"
+whpx="auto"
 rdma=""
 pvrdma=""
 gprof="no"
@@ -817,8 +817,6 @@ HOST_VARIANT_DIR=""
 case $targetos in
 MINGW32*)
   mingw32="yes"
-  hax="enabled"
-  whpx="auto"
   vhost_user="no"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
@@ -852,7 +850,6 @@ DragonFly)
 ;;
 NetBSD)
   bsd="yes"
-  hax="enabled"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
@@ -869,8 +866,6 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
-  hax="enabled"
-  hvf="auto"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
@@ -906,7 +901,6 @@ Linux)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-  kvm="enabled"
   QEMU_INCLUDES="-isystem ${source_path}/linux-headers -Ilinux-headers $QEMU_INCLUDES"
 ;;
 esac
@@ -2665,6 +2659,29 @@ if test "$seccomp" != "no" ; then
         seccomp="no"
     fi
 fi
+
+##########################################
+# simple accelerator probes
+
+if test "$kvm" != "disabled" ; then
+  if test "$linux" = yes ; then
+    kvm=enabled
+  else
+    if test "$kvm" = "enabled" ; then
+      feature_not_found "kvm" "KVM is only available on Linux"
+    fi
+    kvm=disabled
+  fi
+fi
+
+if test "$hax" = "auto" ; then
+  if test "$mingw" = yes || test "$darwin" = yes || test "$targetos" = NetBSD; then
+    hax=enabled
+  else
+    hax=disabled
+  fi
+fi
+
 ##########################################
 # xen probe
 
@@ -2985,14 +3002,15 @@ fi
 
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" = "enabled" && test "$ARCH" != "x86_64"; then
-  error_exit "WHPX requires 64-bit host"
-fi
-if test "$whpx" != "disabled" && test "$ARCH" = "x86_64"; then
-    if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
-        whpx="yes"
+if test "$whpx" != "disabled"; then
+    if test "$mingw32" = yes && test "$ARCH" = "x86_64" &&
+            check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
+        whpx="enabled"
     else
-        if test "$whpx" = "auto"; then
+        if test "$whpx" = "enabled"; then
+            if test "$ARCH" != "x86_64"; then
+                error_exit "WHPX requires 64-bit host"
+            fi
             feature_not_found "WinHvPlatform" "WinHvEmulation is not installed"
         fi
         whpx="disabled"
@@ -5828,13 +5846,13 @@ if [ "$hvf" != "disabled" ] ; then
 #include <Hypervisor/hv.h>
 int main() { return 0;}
 EOF
-  if ! compile_object ""; then
+  if test "$darwin" = yes && compile_object ""; then
+    hvf='enabled'
+  else
     if test "$hvf" = "enabled"; then
 	error_exit "Hypervisor.framework not available"
     fi
     hvf='disabled'
-  else
-    hvf='enabled'
   fi
 fi
 
-- 
2.26.2



