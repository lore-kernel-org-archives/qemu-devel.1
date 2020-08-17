Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC27C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AD720729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkJLWYgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD720729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gHk-00052s-NV
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGX-00036S-BF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:39223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGV-00061b-OK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id a5so15256260wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tjOVdeZdU8flg52xFPrCav0JQnR66QHJMCvoKZaLbqI=;
 b=lkJLWYgU1ziHjtffDr7WqDFe+CbNvJwvVOoAlvSid9EKhip3MBGzV6+NAD23z0zbvm
 diR1DzRke97tFpHZQSg1yQPx5L8cdp0HOT8aLX6Cq35zT5B4ze+C9uInvR/7VCaRapJg
 AU7zB4MLI990FxTk4Uo7ijsmTmIWpPMGTCiLgVtt7DCwviC1+H1LX6CwCA0V7iBT1rT0
 ARtg9UIU2x7lwS5qgPA3qzrMShiiO4LNpiRjNtfjoeYeMu361FFQZX+PENrJMNsUuIxX
 Ue3uUw/+6RQQbuQk55lBKjZUewgv1CaK9g4DX87NASsRuuJc/FRadzxTViVY4H5Q/BRL
 TvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tjOVdeZdU8flg52xFPrCav0JQnR66QHJMCvoKZaLbqI=;
 b=Va63tZobA2T2/HI9rLm6zjTSOBGY0JGZ1FM2YleF5MpElSei5h9ipKWBSfLH8Jg+px
 Osg3j9FQqPC32Uqq7sKXPWbojrk+vhE6mn8rLKzSCfBftSI2ANY7NFRap8GVBEw4G9dj
 qazoULiDN4pkJ760qktNl/TKmJUYalqN5pgMZRzL/6X3cJAbe5yHcZ718CCigUjIKci+
 lTajj80525EjlLTBig7FzKTSFF0r5EIgUwDLWtIG8KklHkD9TTcp2EzIeTogLAsZTuw2
 ENJvy97aPeQgEuAcgxrErmnJ7PwjjvG3aQ7uVtHBbMLiO01lfIVnVxXq/I+XFVdTgqL2
 weBg==
X-Gm-Message-State: AOAM5307m3gvHaJSx6yGT6UyTNYsoBuiIG0jX1Xe1BKMwdUvjgIhLrz+
 QTJ+3i6mFMZ4elP3Q2kBU9Jmsib8Cf4=
X-Google-Smtp-Source: ABdhPJyxaMvDjLfC4LOMZ6wSyX0n8gnJmxs9OASdbvngYxHZlWYFTRGxIHeI80FfqtgbhvdZpDSQFQ==
X-Received: by 2002:adf:b34a:: with SMTP id k10mr15515332wrd.402.1597675054057; 
 Mon, 17 Aug 2020 07:37:34 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 007/150] tests/vm: do not pollute configure with --efi-aarch64
Date: Mon, 17 Aug 2020 16:35:00 +0200
Message-Id: <20200817143723.343284-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just make EFI_AARCH64 a variable in the makefile that defaults to the efi
firmware included with QEMU.  It can be redefined on the "make" command
line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                 | 19 -------------------
 tests/vm/Makefile.include |  2 ++
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..1c17a0f27f 100755
--- a/configure
+++ b/configure
@@ -418,7 +418,6 @@ prefix="/usr/local"
 mandir="\${prefix}/share/man"
 datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
-efi_aarch64=""
 qemu_docdir="\${prefix}/share/doc/qemu"
 bindir="\${prefix}/bin"
 libdir="\${prefix}/lib"
@@ -1109,8 +1108,6 @@ for opt do
   ;;
   --firmwarepath=*) firmwarepath="$optarg"
   ;;
-  --efi-aarch64=*) efi_aarch64="$optarg"
-  ;;
   --host=*|--build=*|\
   --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
@@ -3650,20 +3647,6 @@ EOF
   fi
 fi
 
-############################################
-# efi-aarch64 probe
-# Check for efi files needed by aarch64 VMs.
-# By default we will use the efi included with QEMU.
-# Allow user to override the path for efi also.
-if ! test -f "$efi_aarch64"; then
-  if test -f $source_path/pc-bios/edk2-aarch64-code.fd.bz2; then
-    # valid after build
-    efi_aarch64=$PWD/pc-bios/edk2-aarch64-code.fd
-  else
-    efi_aarch64=""
-  fi
-fi
-
 ##########################################
 # libcap-ng library probe
 if test "$cap_ng" != "no" ; then
@@ -6861,7 +6844,6 @@ if test "$docs" != "no"; then
     echo "sphinx-build      $sphinx_build"
 fi
 echo "genisoimage       $genisoimage"
-echo "efi_aarch64       $efi_aarch64"
 echo "python_yaml       $python_yaml"
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
@@ -7963,7 +7945,6 @@ echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
-echo "EFI_AARCH64=$efi_aarch64" >> $config_host_mak
 echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f21948c46a..a599d1994d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,6 +2,8 @@
 
 .PHONY: vm-build-all vm-clean-all
 
+EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
+
 IMAGES := freebsd netbsd openbsd centos fedora
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
-- 
2.26.2



