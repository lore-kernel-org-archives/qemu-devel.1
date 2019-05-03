Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A73C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD832085A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="InYR1Op7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD832085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMM0m-0004QK-Pd
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:25:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMM03-000493-60
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMM02-00037G-5E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:24:27 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:37925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMM01-00035u-Sl
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556843060;
	bh=qZ9rLgsGWHtP85ggUAkc/jYOZeYPylxBMw1r5H65aLQ=;
	h=From:To:Subject:Date:Message-Id;
	b=InYR1Op7s/BBUUfpb5pnTRx5q1Ph0BXGc8xYG2a+CcJ7T8RJrydpEz6+Fe1zfqVJM
	FfuzJzopcTPEIY7dW7XSJbAY5ypZTh++pRQvnLthxtqdsgjzTqGfIsLZFpJuIFnT/l
	MfRMFdCIZUPfaiQYP5+yIYDy2NO2Yh+uVYIcS0ZE=
X-QQ-mid: esmtp4t1556843059te546ey7c
Received: from localhost (unknown [183.63.119.3])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 03 May 2019 08:24:19 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: c3lHb38CcZ8mv9vz9tFWAtYlwNRLFwNMzEcdAQjv4Y6yViHlP0fetKEaomc71
	z9Dht2buLInK1kBVhcwXsWXP2NZQEI8HjE18kMN2tcUrHfkDav30HOKRS6+wyX+9fy/pGo9
	ckkWcYUJhymeuv5u3g6u/QPIbGnryPVLESf5eWc3h0h/nhtN3Tq7cLtruUL6Xc92j1sXUrY
	0A51VkipagMKvdtHH7pkan3Z7DUiVQpq8UTfQgvty82XpuFOPSq+tePC/LirFgLtDwxZrF6
	M18NZcDwTLs2yZHfbbkni0la79MBB6XWfmcGSw6w0SIFWu
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: mdroth@linux.vnet.ibm.com
Date: Fri,  3 May 2019 08:23:51 +0800
Message-Id: <20190503002351.9890-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503002258.9799-1-driver1998@foxmail.com>
References: <20190503002258.9799-1-driver1998@foxmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 52.59.177.22
Subject: [Qemu-devel] [PATCH v3 1/4] QEMU_PACKED: Remove gcc_struct
 attribute in Windows non x86 targets
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
Cc: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503002351.y5JZRE6WKUIk43_3iv6pYmU9X1N66g1ladyEV5AnQbs@z>

gcc_struct is for x86 only, and it generates an warning on ARM64 Clang/MinGW targets.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 contrib/libvhost-user/libvhost-user.h | 2 +-
 include/qemu/compiler.h               | 2 +-
 scripts/cocci-macro-file.h            | 7 ++++++-
 slirp/src/util.h                      | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 414ceb0a2f..78b33306e8 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -148,7 +148,7 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
-#if defined(_WIN32)
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
 # define VU_PACKED __attribute__((packed))
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 296b2fd572..09fc44cca4 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -28,7 +28,7 @@
 
 #define QEMU_SENTINEL __attribute__((sentinel))
 
-#if defined(_WIN32)
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
 # define QEMU_PACKED __attribute__((packed))
diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
index e485cdccae..c6bbc05ba3 100644
--- a/scripts/cocci-macro-file.h
+++ b/scripts/cocci-macro-file.h
@@ -23,7 +23,12 @@
 #define QEMU_NORETURN __attribute__ ((__noreturn__))
 #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
 #define QEMU_SENTINEL __attribute__((sentinel))
-#define QEMU_PACKED __attribute__((gcc_struct, packed))
+
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
+# define QEMU_PACKED __attribute__((gcc_struct, packed))
+#else
+# define QEMU_PACKED __attribute__((packed))
+#endif
 
 #define cat(x,y) x ## y
 #define cat2(x,y) cat(x,y)
diff --git a/slirp/src/util.h b/slirp/src/util.h
index 01f1e0e068..278828fe3f 100644
--- a/slirp/src/util.h
+++ b/slirp/src/util.h
@@ -43,7 +43,7 @@
 #include <netinet/in.h>
 #endif
 
-#if defined(_WIN32)
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define SLIRP_PACKED __attribute__((gcc_struct, packed))
 #else
 # define SLIRP_PACKED __attribute__((packed))
-- 
2.17.1




