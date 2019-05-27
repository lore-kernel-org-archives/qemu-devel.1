Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A765BC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E292070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+XQL79t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E292070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAdX-0008Ut-I2
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:05:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAbr-0007Wt-95
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAbq-0001VF-7I
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:03:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAbq-0001Ux-2Q; Mon, 27 May 2019 04:03:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id a5so6735699pls.12;
	Mon, 27 May 2019 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qVBNipnG6rsnaNkm/763xu7zNt/J2OahkNzsU67wdcA=;
	b=e+XQL79tdrGQnheHAzlSbkIfDZzmcqSzZMPo4KDiXhsp250SY0rXYiaDYGI0x1RGt5
	5bbJqzvBi6FbdSgl9CsXt/U/wZAamM4pZydg2LnmcFQWK5WOqbhm1tRpp214rv/MClJb
	4RQ2RloAnzk43CSREAu541yYj+vP1o5XOQjFnAtQ82WM4kKMGc4yqOlZFyD2zggcAOTL
	v7dzPs5Ej1DkZ5geQk27fslVqGHufoBHIp9C0ZR8kKdq75qycJuqzWngREr9cm/rMLoz
	AAf52PVooUGKbGrYGKobnekhYJE6bJ2QdZJNcQh76I5jAzWadIZUHvVQlKfqASLCLZTr
	eEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qVBNipnG6rsnaNkm/763xu7zNt/J2OahkNzsU67wdcA=;
	b=iBwKrd3U2tNMQTFI1bCILn2djOsJczSps1XU3wNiGbo2V9pLwFemH9izdWuCvJ/hgU
	lp77Xm3D1bLK0DYxTD6OUhLHE+rJD09+Q8SIUOOKAeeh7bxPT+lBxYI5jkDCGAGjE92T
	1HjutF+mDtc2JVcg078RrzoL5CrvV8s90YEClmdw7qAgDpXx7qTRVxaMHNW+3KQhrHWh
	ShZPTZzq5Vx7VLJflVkFpzcan4+umgfnYZVukWCXrJsbR/QBTfT2zVWBIyZYlVAsqqhW
	kfm7URQQCc0WrDt2ZqFrD/bMXYswXFRPqOTPnJ9IIyhhj/iOpnI2sS8P8UI39tsQD2kF
	Glwg==
X-Gm-Message-State: APjAAAUXnjb7/FSmQNbzHSz/+L8UFCMzspwKGXs0q5QnIzRdiKVFT1DN
	Ji9CE9YtiQ3cviS5GxpGIIz/sBWvEB1CXA==
X-Google-Smtp-Source: APXvYqz6S1a8Nv3ZC6oVz/kOhQF23mnvsVy9vfre3UGsKjTFhgBt5e9f1cWXjw5inlEDlos7hR/QGw==
X-Received: by 2002:a17:902:ab90:: with SMTP id
	f16mr16883401plr.262.1558944232751; 
	Mon, 27 May 2019 01:03:52 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.03.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:03:52 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:20 +0530
Message-Id: <20190527080327.10780-2-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 1/8] configure: permit use of io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 528b9ff705..acbdf04168 100755
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
@@ -1255,6 +1256,10 @@ for opt do
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
@@ -1773,6 +1778,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
+  linux-io-uring  Linux io_uring support
   cap-ng          libcap-ng support
   attr            attr and xattr support
   vhost-net       vhost-net kernel acceleration support
@@ -3962,6 +3968,21 @@ EOF
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
@@ -6378,6 +6399,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6858,6 +6880,11 @@ fi
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


