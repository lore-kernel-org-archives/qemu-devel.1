Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C389C22243
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C389C22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUNj4-00027b-NM
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 01:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNaU-0003xz-K0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 01:20:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNaS-0005Cj-PK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 01:20:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id q21so5313775pgi.13
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 22:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VcX5b0rIH1CAwWo8IR5Ccs4kmN3tFttlmfq40I1XE5k=;
 b=VYL428QAzUmr3JVV8t4hLoN7sSA6u6eM564UDVqSlIfd+66NceMcBTgVoFvaNu69Sw
 7QSFZg+sVlZN6O9C8f/VRCOaZW0GHFIw3z2BOaLP7HBfbvWqLeJEBkoe6frasM2M+lWi
 LgnkRRRqpWTAHoe6IeR8crKv/Hkbyx+XwflwHlmKfZITaxNVRjal1oZnQ3XpqduHZqug
 kv8Do/+61gs62x1aHpPwj2HBdoORQiE8T/ssJYXGRYQ4/0zSjMOie1bn4EsBttekClzn
 mnLqZceryMt6DUjRotsXbCKkImXgZ1A0P7e4URAgKvz1yXpfu5EYfT15i1uTgJR9JsfA
 JIIQ==
X-Gm-Message-State: AOAM533ieprpmgW7GLIel0Dc+Rn/yggUVpeXiocs1CM7AkB07gGFXJqi
 qJV31tTTRAW6dyR6gNCx3y3LXrFlite4RQ==
X-Google-Smtp-Source: ABdhPJzqiPkSE6fRqUGHmC+Ve9AXn5jD0eQRv0MeX5Ow5A5Eu/Mw+Pul6Aj8fSz5/aI5IXtE2heFlg==
X-Received: by 2002:a62:1b02:0:b029:154:fdbe:4d2a with SMTP id
 b2-20020a621b020000b0290154fdbe4d2amr15239881pfb.27.1603084797723; 
 Sun, 18 Oct 2020 22:19:57 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.253])
 by smtp.gmail.com with ESMTPSA id p6sm10673904pjd.1.2020.10.18.22.19.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 22:19:57 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 2/9] configure: cross-compiling without cross_prefix
Date: Sun, 18 Oct 2020 22:19:46 -0700
Message-Id: <20201019051953.90107-3-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019051953.90107-1-j@getutm.app>
References: <20201019051953.90107-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.195;
 envelope-from=osy86github@gmail.com; helo=mail-pg1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:19:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: osy <osy86@users.noreply.github.com>

The iOS toolchain does not use the host prefix naming convention. We add a
new option `--enable-cross-compile` that forces cross-compile even without
a cross_prefix.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index ea1753c117..ced6d2e961 100755
--- a/configure
+++ b/configure
@@ -234,6 +234,7 @@ cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
 static="no"
+cross_compile="no"
 cross_prefix=""
 audio_drv_list=""
 block_drv_rw_whitelist=""
@@ -457,6 +458,11 @@ for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
   --cross-prefix=*) cross_prefix="$optarg"
+                    cross_compile="yes"
+  ;;
+  --enable-cross-compile) cross_compile="yes"
+  ;;
+  --disable-cross-compile) cross_compile="no"
   ;;
   --cc=*) CC="$optarg"
   ;;
@@ -879,6 +885,10 @@ for opt do
   ;;
   --cross-prefix=*)
   ;;
+  --enable-cross-compile)
+  ;;
+  --disable-cross-compile)
+  ;;
   --cc=*)
   ;;
   --host-cc=*) host_cc="$optarg"
@@ -1688,6 +1698,7 @@ Advanced options (experts only):
   --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
   --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir/docdir [$qemu_suffix]
   --with-pkgversion=VERS   use specified string as sub-version of the package
+  --enable-cross-compile   enable cross compiling (set automatically if $cross_prefix is set)
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
   --enable-tsan            enable thread sanitizer
@@ -7023,7 +7034,7 @@ if has $sdl2_config; then
 fi
 echo "strip = [$(meson_quote $strip)]" >> $cross
 echo "windres = [$(meson_quote $windres)]" >> $cross
-if test -n "$cross_prefix"; then
+if test "$cross_compile" = "yes"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
     if test "$mingw32" = "yes" ; then
-- 
2.24.3 (Apple Git-128)


