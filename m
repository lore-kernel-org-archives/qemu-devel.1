Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE1EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645E120879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0nP2Dog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645E120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAr5-0005I9-Hj
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:07:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoR-0003TT-IV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoP-0002sY-1w
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:47 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAoN-0002nD-4M; Fri, 24 May 2019 10:04:44 -0400
Received: by mail-pl1-x641.google.com with SMTP id g21so4248170plq.0;
	Fri, 24 May 2019 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mXSPb6nljQ3a7CRCQcFUnmtz50HC0QCQI3eoM4YTe0A=;
	b=P0nP2DogfxS5wY12rUxQWWz3RGjT4JdvKAbWC1/SknUminwjmvB6o5KbqV/6SCZibu
	WgzOVrk2tgw+NX0KvOCUwqY416wLuJWTwRJ3tqP12UoEH+dOqk3AX+J1nGREP02C95CR
	x5uT6iIjlo0t3ge3vgtc2g8/SoPWzB77dx1ifTMUt0Yti+9WtRs4pDl1tALvfsSk23wc
	mZ4mQ7bFxJb4YzZZyFUo+amZEGJklxwx2NQpFkLAKwjqJC/mIVPrK1g/UC3CV/rNBhT+
	tyWpFlKSoisRZcsePk8iZPVVJjRIjkaZH3WouCQDHfekDjsT99PyBdse3Gd4zl0sJb+2
	xLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mXSPb6nljQ3a7CRCQcFUnmtz50HC0QCQI3eoM4YTe0A=;
	b=scWgOB1xFlXXFxeQRVKbKl8LzFt6uxW/UntBTsB/a7ZWuSFMxkSA5IaqXkMADO9FJH
	xT7odSUzSiL+Pxax7Z49SpHhSeZmkIY0d2vy5r7/iwHZ8XLxp+3slq0PtKXukIwY47if
	WkUTflDUtDC2Uf89qBGrOuUXJCw21aaBMU1hQ8oGIm6PHo/btUBnrxlLJIayy5QT7lKz
	oq6sPptNBOoHMJRy8prUE3Wrh1/8jGz3y9Ge0ccasfJ5pae2Gyu5nL+cLnbYxm+phjPH
	DCbrvdP6om7eJ8Byb4ocNS/HJF/O4xFV5PE73q/OazKb1pbu0ADKklhthtFDMlxp4qda
	lGSg==
X-Gm-Message-State: APjAAAX9lpsJb46U1LHmB6Bv7M+cmO58ooW9Fs5ugv2wS2IF2zI0NvyR
	IAy2vPpqaqMX+am1GvkOJBngAE3MrEw+wA==
X-Google-Smtp-Source: APXvYqz+uEgCOuj5OWmzqFp83Bm3XQTh9XCt8zY2DbjkXp8WE5g41uS68yMCdvVAlQihd83rGSnSWg==
X-Received: by 2002:a17:902:ac90:: with SMTP id
	h16mr42558597plr.162.1558706675701; 
	Fri, 24 May 2019 07:04:35 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.04.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:35 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:37 +0530
Message-Id: <20190524140337.13415-10-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [RFC PATCH v2 9/9] configure: permit use of io_uring
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
	saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 528b9ff705..86383dc0b3 100755
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
@@ -3962,6 +3968,23 @@ EOF
     linux_aio=no
   fi
 fi
+##########################################
+# linux-io-uring probe
+
+if test "$linux_io_uring" != "no" ; then
+  cat > $TMPC <<EOF
+#include <liburing.h>
+int main(void) { io_uring_queue_init(0, NULL, 0); io_uring_submit(NULL); return 0; }
+EOF
+  if compile_prog "" "-luring" ; then
+    linux_io_uring=yes
+  else
+    if test "$linux_io_uring" = "yes" ; then
+      feature_not_found "linux io_uring" "Install liburing"
+    fi
+    linux_io_uring=no
+  fi
+fi

 ##########################################
 # TPM emulation is only on POSIX
@@ -6378,6 +6401,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6858,6 +6882,9 @@ fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
 fi
+if test "$linux_io_uring" = "yes" ; then
+  echo "CONFIG_LINUX_IO_URING=y" >> $config_host_mak
+fi
 if test "$attr" = "yes" ; then
   echo "CONFIG_ATTR=y" >> $config_host_mak
 fi
--
2.17.1

