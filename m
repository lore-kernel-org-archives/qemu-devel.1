Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF4C072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E18216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNjvQEzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E18216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32821 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEeL-0007BI-1a
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 19:58:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcI-0005iQ-4L
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEZ9-0001tW-Sx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:53:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEZ7-0001rk-Vs; Tue, 21 May 2019 19:53:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id g9so118152plm.6;
	Tue, 21 May 2019 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=UfXYBbV0s+nS162Op6TlJ/0zXxxvGFZzaHozLXuLUbw=;
	b=GNjvQEzu0ShaumXDqu9+Ax4jI+mLHyxGbomG3LFH4WPDfRuwQIlOjDfS8kAFG2MWXo
	fc5eWTLfE9EOCB/7hnHBRVQHhc+ig9DOgjyHvHuP0gPfj0THWepyv7FkTVChEP4jhVXR
	StUZzDpgeiakKai6P4YXYRR22KpedVYJO0tQjw4n3b3rCQ5yOOmjfiLcT3TYfS1V/tII
	AW5phh5rChFpU8XiaNWmWnBpdc4spiNUcek0e/fc8o1WzBPI+Jcx8MqFM/kE40SZoMtP
	jjqdJ0nNZMtgeq6aI66Wl5pDLPVi0SegiP7dkvYfvMBNa5eOqNGZBEHn59BQqymoD/P7
	YlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=UfXYBbV0s+nS162Op6TlJ/0zXxxvGFZzaHozLXuLUbw=;
	b=IU2IN4NhZSwnsqLk2oyasxFqCFJvm9zTY6N/C2XL4KYDaT0KXqQrO5QqcUhBFmupff
	WzLCh2FSWKzBhzxN5qAUCqcR7+JPJGJj7OejRFCmqt+bQjSxBhGMEEkNrIcp7pZf7qwT
	nnB6sdKIYnd6kcIkC+BNEbykFVGBuBiJsa5dSS6yjoWM2mQWwdyOakicAl1+bn8J4ALS
	78+kz/ZOA196EzUInR+CCXEVjnJDe8YBHZ9qidPMnWF/lM0Cndaj7Y7E6tcLrtXsmWry
	h7h6xGK2X5jN7/up8FeSNMUvG8GpCxSxuMpMy2DLV0WL5JTXCZJDGMMiVN2426q4dcMs
	fC5A==
X-Gm-Message-State: APjAAAXhyn4j0mWXMHi+b0cgqIC8n8FYwzCYz9o+LA+hBGSnmrL0QlOa
	iY0YxWkXsCvZJv0dJknFrpF5BfLwKXnMbw==
X-Google-Smtp-Source: APXvYqxgyjVj4iQnjK1eW6bSc/j0CqkgqGPOHP3OVJ0+JWjtCoU0xkTHHWgn7AkFLz2jrPQvY7VO5w==
X-Received: by 2002:a17:902:7082:: with SMTP id
	z2mr63502540plk.176.1558482783536; 
	Tue, 21 May 2019 16:53:03 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.53.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:53:02 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:15 +0530
Message-Id: <20190521235215.31341-10-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [RFC PATCH 9/9] configure: permits use of io_uring
 with probe
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index d2fc346302..25eb150cb5 100755
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
@@ -3949,6 +3955,23 @@ EOF
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
@@ -6351,6 +6374,7 @@ echo "PIE               $pie"
 echo "vde support       $vde"
 echo "netmap support    $netmap"
 echo "Linux AIO support $linux_aio"
+echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
@@ -6831,6 +6855,9 @@ fi
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

