Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F92C2078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/ndwdIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F92C2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLyj-0004ZV-AU
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmp-00080O-Hn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:59 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmm-0007JI-BQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:23:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id z1so8470588wrt.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DMTJUbty636ef+0yg6Cin0EV1LmcAFncNPEW7pOZLIc=;
 b=M/ndwdIcZcmytcAc3EIiK2aWFi0SyCSeneHZMBR0mldX8Z+4sRPAb3jSP8wiGTDiq2
 qWe6ofLxVc8kZ+1chD1cvVLT5sIrN3ndMJcteWBEXZ4RSA34F1l+LbHPI/wwteWweduV
 YzzsyKEFDuXYIvLSeHqfdKM/TdEdZOSdywQ0FHQQDjmZlgAkKT5b7l8mq6HY190y8Y0W
 XY+w1J0BX6pazwFb3g2E2fT+/NcbUD98HezEXjiF+WqfAcLi+JblFGge+M/MxU25ZEBI
 YYU47qzqHwizon8yv+EpNX7hfPOz6gVNbKqFxNkvwRjIgTHSaYMEcrCfFw6P8oXGaoBZ
 /6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DMTJUbty636ef+0yg6Cin0EV1LmcAFncNPEW7pOZLIc=;
 b=BV7UTGAF+t0Lop+xmcEmc4zklh/cZOsCRjycIdZTzWkTHCupcPOoigyMfVxxPalpY+
 xdZif518c1DLtam1RZqjzI4A1i/WxhIC1GlvJj8gi7v5ypFrjArPxFjJdZi9O8jPBvoZ
 fHviMkLjxR1qAJouG/fCAeZsB77ptR06utOyqg9+dmgL25xU1tKfPJNwlEvjGkTYwuMI
 LUn/qgTFzX/bcCHShLaRukTevSYauJ4VMM2nvLNbFt3CRyrOEgrUZGOplgHD7rwbaiY9
 DJULgyWQNw+NrXwpT3lSfrol8YW2mMiELFFLZK8JtcR7eYs1EmBIDYvh4ptjdg25Rlbl
 kaZQ==
X-Gm-Message-State: AOAM533ILlaV9fJUzIb1yKjAY9kVQIRKhIGDLIFN+XcrgKhRaYMftcL2
 reAkI0uafGmw1770tp7KYxqG8cdHkwc=
X-Google-Smtp-Source: ABdhPJynvlZOxm3MtvT4rmAM4ZfmmeUGdrc+dZbC065WK8IXwvgMTUoGIhdtWNfLu0rGeap0rLXipw==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr9878419wro.69.1601886233545; 
 Mon, 05 Oct 2020 01:23:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] configure: remove dead variable
Date: Mon,  5 Oct 2020 10:23:36 +0200
Message-Id: <20201005082349.354095-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/configure b/configure
index 9224ac47e6..2133239593 100755
--- a/configure
+++ b/configure
@@ -811,9 +811,6 @@ fi
 
 # OS specific
 
-# host *BSD for user mode
-HOST_VARIANT_DIR=""
-
 case $targetos in
 MINGW32*)
   mingw32="yes"
@@ -839,14 +836,12 @@ FreeBSD)
   audio_possible_drivers="oss sdl pa"
   # needed for kinfo_getvmmap(3) in libutil.h
   netmap=""  # enable netmap autodetect
-  HOST_VARIANT_DIR="freebsd"
 ;;
 DragonFly)
   bsd="yes"
   make="${MAKE-gmake}"
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl pa"
-  HOST_VARIANT_DIR="dragonfly"
 ;;
 NetBSD)
   bsd="yes"
@@ -854,14 +849,12 @@ NetBSD)
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl"
   oss_lib="-lossaudio"
-  HOST_VARIANT_DIR="netbsd"
 ;;
 OpenBSD)
   bsd="yes"
   make="${MAKE-gmake}"
   audio_drv_list="try-sdl"
   audio_possible_drivers="sdl"
-  HOST_VARIANT_DIR="openbsd"
 ;;
 Darwin)
   bsd="yes"
@@ -877,7 +870,6 @@ Darwin)
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
   QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
-  HOST_VARIANT_DIR="darwin"
 ;;
 SunOS)
   solaris="yes"
@@ -7613,9 +7605,6 @@ if [ "$TARGET_ABI_DIR" = "" ]; then
   TARGET_ABI_DIR=$TARGET_ARCH
 fi
 echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
-if [ "$HOST_VARIANT_DIR" != "" ]; then
-    echo "HOST_VARIANT_DIR=$HOST_VARIANT_DIR" >> $config_target_mak
-fi
 if [ "$TARGET_SYSTBL_ABI" != "" ]; then
     echo "TARGET_SYSTBL_ABI=$TARGET_SYSTBL_ABI" >> $config_target_mak
     echo "TARGET_SYSTBL=$TARGET_SYSTBL" >> $config_target_mak
-- 
2.26.2



