Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48125C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C614B27F39
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5zU45Lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C614B27F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmVm-0007ak-Qk
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:56:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKz-0007F5-8u
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmEi-0006fZ-4E
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:38:49 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmEh-0006dJ-U6; Mon, 03 Jun 2019 08:38:48 -0400
Received: by mail-pf1-x443.google.com with SMTP id u17so10554613pfn.7;
	Mon, 03 Jun 2019 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oqhNazyySRIYrazXPTmYq2UuxaK7vSiSAxrOSw+gi18=;
	b=X5zU45LkjQ1Ga143ma3aoN7U20HmsbW/2kKh9+4R0rbAHRbnonp4OVOv0OGsgy4S0q
	wdDxCbPGdZ6LT+J9MJ1BoChgqlYepuZ8tkGXzmG2GTXSSwbyKYZI/TAQxgXo1KEhDto1
	uD8l66qORzJuL3F+fcsLdkToC5GX1E99dVBIqu5EbTfIvyLaKlZ6lFWU6BURBF6VLycF
	jJ0zwe8CwIsGEZSDACa1UjrDJ/OxjJrg9ngai5LzdHxAEHZKXTg3IDCiM32NJAx+PaIv
	9oZYgzMGKDroRK+uNPxNqnIJ6bvJoSBh7Ni3FgDmUbhfFpvThfYP0jqbpwmqH4EpygwE
	z0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oqhNazyySRIYrazXPTmYq2UuxaK7vSiSAxrOSw+gi18=;
	b=mRK4/EM3iTvcfhG0DtHJ379LvqveuENioNobNjWUbGdIZc1LpxdfKmRxUQWI6n5QCx
	uyv/Hs0LsycLXw54ywMyesCVDa/g2nyuc0+a44xiC3jEHl/RSvCRuHQOcq5LC9GtAr8j
	zzWGIKt3+PBZP895LYsU9KjyaPLwmg2/AuMbRjHuqXjZoQcLzkhP3/kudQ9fmV189aBx
	SXVZbnvEoSjvnkpBBoQhdczyoyIL1SB72WU4TtsLlSOBcTXM2qANvHSC1Dagx6jrCQGH
	OgOgTMV93QKBUbFn84SQMPiSXUkhsqTdeBZzVQ5bNcdy0YL3dVohTZwBofNiCmyJNgOP
	7KGQ==
X-Gm-Message-State: APjAAAVrcttFCDgRFv31I53isl+z5RL0bUKeb/LbNsl5bS5l6uxOLqTG
	JfkzTRB1H+achftrzCgI0U/mNwtc2hyP2w==
X-Google-Smtp-Source: APXvYqwVrX5NKCCiwYQBLkeR4n8TGYYjFuVKRa2YBenJ8q8wOn80zybnckBdgHgmBR0wPF8xIiDQpA==
X-Received: by 2002:a65:620d:: with SMTP id d13mr28332716pgv.109.1559565526565;
	Mon, 03 Jun 2019 05:38:46 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.38.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:38:45 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:15 +0530
Message-Id: <20190603123823.32661-2-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 1/9] configure: permit use of io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 6cdcfb2dc3..cb49ef0fcc 100755
--- a/configure
+++ b/configure
@@ -365,6 +365,7 @@ xen=""
 xen_ctrl_version=""
 xen_pci_passthrough=""
 linux_aio=""
+linux_io_uring=""
 cap_ng=""
 attr=""
 libattr=""
@@ -1266,6 +1267,10 @@ for opt do
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
@@ -1784,6 +1789,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
+  linux-io-uring  Linux io_uring support
   cap-ng          libcap-ng support
   attr            attr and xattr support
   vhost-net       vhost-net kernel acceleration support
@@ -3973,6 +3979,21 @@ EOF
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
@@ -6396,6 +6417,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6876,6 +6898,11 @@ fi
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
2.17.1


