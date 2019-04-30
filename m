Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429B7C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4A320854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ll9+hB5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4A320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXFI-0000jf-6r
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:12:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXDB-0007ZW-RI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXDA-0005BL-C5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:10:37 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:50419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hLXD9-00056a-JP
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556647827;
	bh=elsID+L6NSJJoduRa7RHPrXwUkf2HhHlPBFKhzEZcX0=;
	h=From:To:Subject:Date:Message-Id;
	b=Ll9+hB5f24ukaD81GT+e2vGsUNhC63hGKt17hG2XtKkAFVJj0g04LP8LNoPVlJHzO
	R6M9muZk/A7UfRMHRR1ihH2Sd8qMt0ugqS+0S+ITEJhQeXEFFbI90AXzQTdijPFx9N
	r+CPisnuzMJK81L8jHPxn7TKKROGaPt5dok02Jyo=
X-QQ-mid: esmtp3t1556647825to3efq6fe
Received: from localhost (unknown [183.63.119.27])
	by esmtp4.qq.com (ESMTP) with 
	id ; Wed, 01 May 2019 02:10:24 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: +oIWmpEafD+ivI7ek+RcMjGBRslXbo1g9OUv7BSht0rPTShakCxnsaD8q4E/b
	hq9pB/w7IZciMWURREHUSUpsgpbGLApZSgDBfG+JUrm58XwfWzAQpg5emU984YvbIYkOy9p
	QD5WCUbV+gXZDvfiV/N1I2GnG5Ru+A/zcVy6bUHmEcvnCQmsfMMRfJVC+n/+F/HdB93geA5
	WCl5rm1yUjgM2XFxgS7TCNCaa/lnVOcQzN+f8GxEajeo6ODldgC6B9MCop24YZMwsCM0ixO
	4cvnmx4u5kQC9lJnECC6ozK5Vj/dDPlSe5ZqCoAXvtTmXDCxg7qhTh30E=
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: samuel.thibault@ens-lyon.org,
	mst@redhat.com
Date: Wed,  1 May 2019 02:10:09 +0800
Message-Id: <20190430181009.1066-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 184.105.206.29
Subject: [Qemu-devel] [PATCH v2 1/4] Initial Windows on ARM (AArch64 64-Bit)
 host support
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
Message-ID: <20190430181009.Q5_BLmEiGOz78b10SWpq1rbVxFHai7Gmni0QGSuK-Ws@z>

This series of patches is for initial support of Windows 10 on ARM as a QEMU host.
Currently only TCG intepreter is working correctly, it crashes when TCG JIT is enabled.
For now we assume it is built using the clang aarch64-w64-mingw32 toolchain, you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mingw.

QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets
This attribute is for x86 only, and it generates an warning on ARM64 Clang/MinGW targets.

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




