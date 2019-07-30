Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991CC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82372087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac7f/SCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82372087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW6A-00038M-Vw
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35519)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW1x-0003Xk-7j
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW1w-0008Ol-7G
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:21 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW1w-0008OQ-1H; Tue, 30 Jul 2019 13:35:20 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so30201299pfa.4;
 Tue, 30 Jul 2019 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dbXKSdV5tn5FcTOHM2GayIdaoxtdtsUeiXsLP0/PfEA=;
 b=ac7f/SCaAIkJICvNjagIShZ3Ql1yUbJST57mHrbSzq+mB2+3ZZvWqJ3Ejzm7L0VED6
 3dC/6RUcU58HNU0ZEEETXGSCQxzzvGkKhPlr0qvj9BizNFixzYTopaaTH0SvCNC6cFRO
 Gkqp2RyvzjsU/1hB50WJ2B1jiPzvQ8qzx1jyskGUpGaJ0dDAKgKiN5wtqEPkGaEkTahM
 f3VoDlfNc1sVERWHdOSwoIEGUFWRjB6AdFklGPemEfBbHpIdET2SRNQmE7auwLHLul74
 J8GyXU6uRiiCDwwF6L/dgV/qrHWYdpwYNnBD6Lz3hroKxMSWEdWVZ/6SKwhte9b29CJM
 vRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dbXKSdV5tn5FcTOHM2GayIdaoxtdtsUeiXsLP0/PfEA=;
 b=HEsnOe7d6mmHFnHD5dYEOql2k6yIjiHieBkydw06apHDUGv1wJFC1vUI0Yuchjby/h
 Fg7T2zLt9hkcJ/yFqMFDuWURcws4VNem0tWGGL4rGDvLUvFdF71MhenD3VjDAP2kDHkS
 cFFXpSFVCoaIjWmlkaozMOGLo6qYXnJ3jx8CYvoHrF7ZNczIClQLS90hMQ5OdrMndhfm
 hc0amKkLR8a7J1Cc/88EvvLieChbDNvnTf5lF4mDy/Js/sBvMmc597eYn4FVxqcEn2ec
 KeHUHjX+cjkk4js3LFoyydjLZ09BzNjtQ1sAdxeGKOzRGpzzAWnSb5AmDgMUn8FPFxUr
 TacQ==
X-Gm-Message-State: APjAAAWsRAE9sNLLM7mNpeHnJUKoDn4nS6QGy+OrEYliefjzthhHwOzS
 Z2gKwNX1M6ANGjG6p/RdPDSlTlzL8fF+4g==
X-Google-Smtp-Source: APXvYqwwi3kJDv3s/f/uqT2nQ/DMA5NxB4gS4X7/aniZEb1ZhBIb9NBRRB+0fj73eKsOIF0VUH2BZA==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr44186152pfa.90.1564508118709; 
 Tue, 30 Jul 2019 10:35:18 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.35.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:35:18 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:26 +0530
Message-Id: <20190730173441.26486-2-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v8 01/16] configure: permit use of io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 714e7fb6a1..493dbc2ec5 100755
--- a/configure
+++ b/configure
@@ -371,6 +371,7 @@ xen=""
 xen_ctrl_version=""
 xen_pci_passthrough=""
 linux_aio=""
+linux_io_uring=""
 cap_ng=""
 attr=""
 libattr=""
@@ -1272,6 +1273,10 @@ for opt do
   ;;
   --enable-linux-aio) linux_aio="yes"
   ;;
+  --disable-linux-io-uring) linux_io_uring="no"
+  ;;
+  --enable-linux-io-uring) linux_io_uring="yes"
+  ;;
   --disable-attr) attr="no"
   ;;
   --enable-attr) attr="yes"
@@ -1790,6 +1795,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
+  linux-io-uring  Linux io_uring support
   cap-ng          libcap-ng support
   attr            attr and xattr support
   vhost-net       vhost-net kernel acceleration support
@@ -3975,6 +3981,21 @@ EOF
     linux_aio=no
   fi
 fi
+##########################################
+# linux-io-uring probe
+
+if test "$linux_io_uring" != "no" ; then
+  if $pkg_config liburing; then
+    linux_io_uring_cflags=$($pkg_config --cflags liburing)
+    linux_io_uring_libs=$($pkg_config --libs liburing)
+    linux_io_uring=yes
+  else
+    if test "$linux_io_uring" = "yes" ; then
+      feature_not_found "linux io_uring" "Install liburing devel"
+    fi
+    linux_io_uring=no
+  fi
+fi
 
 ##########################################
 # TPM emulation is only on POSIX
@@ -6398,6 +6419,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6885,6 +6907,11 @@ fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
 fi
+if test "$linux_io_uring" = "yes" ; then
+  echo "CONFIG_LINUX_IO_URING=y" >> $config_host_mak
+  echo "LINUX_IO_URING_CFLAGS=$linux_io_uring_cflags" >> $config_host_mak
+  echo "LINUX_IO_URING_LIBS=$linux_io_uring_libs" >> $config_host_mak
+fi
 if test "$attr" = "yes" ; then
   echo "CONFIG_ATTR=y" >> $config_host_mak
 fi
-- 
2.21.0


