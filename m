Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B66C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BA320679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAyJzZXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BA320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKj8-0002mg-7m
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKgB-00081Q-5a
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKg8-0001TT-1O
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:49:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKg5-0001Rr-VA; Mon, 10 Jun 2019 09:49:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id v9so3371015pgr.13;
 Mon, 10 Jun 2019 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mam4w+9UfKu9WdJoSPIimpAQV6LGmM+7szCVVJxwAcM=;
 b=rAyJzZXLMoLscx/+WqDhRXde1jlZfQUtvzjNhz6q8M5Zzz3cYvTlwiGfDHAwjQ8FqB
 P7vVAE4He0zTj1F8VRBQStZMRsDMhket2DkjwdX9TvRlZiv+kEKK6m7g7p0hiww1VvWi
 5Xg/RpzC5sU6882tChR4yLyfQeO1SQHIwyTKD+ZKOGSuVgKn2xqkX/RwJtyy193uzTBV
 0b1Ga7XwCS0t44k62zrr8DQ1UAxgWLZCOoIBgdW5saZn/YFSrad9LGrVVvqwxDJcL0rY
 NgCxC45xV0zda0M2g3YtiozMMCwU9sKObtdN5XQrJ5yZt2/uZyVckEJ0yhCHUvn5Jlbf
 /8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mam4w+9UfKu9WdJoSPIimpAQV6LGmM+7szCVVJxwAcM=;
 b=DSPgZHIM/qRHNKCnaYjIk2r29zVxCFaYpyymGcHXQLV5Fdlz+4UnPBRasb774lA/cq
 gs0fknBIA+avI/FaEQIKQpH7uvnITReR28Vefk+4au9XF0X8dY/ZSLycwc26Yle1nGjD
 2/HnHlsfYlaViBeVn6HGhY79LT93b/Q3nOXTEkfYiSsPjZw1G7/PAROb64FKXq+XGNyZ
 mf9cZj9nx8NJbqLima6iFs0B2ppqtPWqTKmPIl/SE36rFKRiGMdDE/3HHNMvTa4WGKv5
 Dwgmd6WKZHv5L+rhs8tmBk7IoCpVxStl7NOcfARzFi19EM6IlK3PwmwBn8kZrwDIPYmT
 wHMw==
X-Gm-Message-State: APjAAAWYYVP/emxBs5YJlwm7JoCk7+hUcA7iMw12/3BHHjHjv4xoYEd7
 OW/pzCllEPFG03OUdpIPDX8WkFwQCD8Q0w==
X-Google-Smtp-Source: APXvYqzlwwDBVvxUXKs8PNom0I8YERpFY023OEfEX0xJmW50/Yh8kAEs665qkLOVSjL80mzATva3IQ==
X-Received: by 2002:a62:d45d:: with SMTP id u29mr10207136pfl.135.1560174576330; 
 Mon, 10 Jun 2019 06:49:36 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.49.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:49:35 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:18:54 +0530
Message-Id: <20190610134905.22294-2-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v5 01/12] configure: permit use of io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
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
index b091b82cb3..7aa18d308d 100755
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
@@ -6874,6 +6896,11 @@ fi
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


