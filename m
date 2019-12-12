Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5103C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A32B20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1lVWJW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A32B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOQE-0004vt-0u
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyL-0003U0-By
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyJ-0006hj-T5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyJ-0006g3-L3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:35 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t2so2644748wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jNzhakuXNcL2ED9Y1t+KNZMGJfF6taioPx2OOiXLQc8=;
 b=D1lVWJW1SGxPX70tQ0TQa87CK++QYLMw3WNPF2c3U8aM8NFOD/VZyoqE3Ymy2zkgig
 BQ6NgOoEsfJ+YDWSN6JA9K6oK9wZ5nwT4pn7+akFf4RKYL1ENtcJROPnCmoOOoM6NwDw
 /BE6VlvPCXrNz1X+c2BC3xAuBKZsGciqErAT1+f24IQKErzDipdwt4bw0uJxoKP9+7B9
 qacRzPrPY8OxNB2BWmCFCAL/RCayG8YV9ugSqRgvQJ5iF85hby29pIGmB52hxd0Pynr7
 06b0n/t4lWRGCNFpH4E0NMp159Tl/Z/Mq4ybnuEl+UgefqnaMbMtV+58/soTKvKsSBh2
 Lt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jNzhakuXNcL2ED9Y1t+KNZMGJfF6taioPx2OOiXLQc8=;
 b=BFIJZMV1qbSiUYMMGCGB2EEh2CK7Ax2upYs0JVaJisAUo4ukXWjMPRTb/MDFwB0wjC
 xtkmbV+bT4v1S1LabEAyO/o602O3xVUBTGu06JXcusujTXOUPCYJ5rPe6NSObfnku7L+
 If8i1fdG4P2FxA9p6i0RqUVd7sJH0lDFwx+mnCYz7pArDa+v/VzfuaeJGwlP3Qyv3Cz9
 1AEAKIteIqJJGhU1lC4rZ3Fk2ubwfCmHszoynrXGn36ttqdSfyhVhHVggb4ISz20zZJt
 2icoUKnUHtNamQlUyviNmg/9fFeHdgscgHbUFzNksrfxIOD6Gi3ZONit4R/+6zktuohu
 jT5Q==
X-Gm-Message-State: APjAAAWiK16TZ5w8e+B9EUVbzvpCtaivod3C4Hi/2Hck5vXk2MBqq3/W
 Ctus5dNfrL9fU8Nuucg8nbGU+PUK
X-Google-Smtp-Source: APXvYqxa/czJrp+Ssu02hNnEJToTz76wK1OlZo+YpGb4xQtFBQ6FQxCT0qcbid/+89vSxxgFeLXYLg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr6018155wrm.324.1576155214463; 
 Thu, 12 Dec 2019 04:53:34 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 037/132] meson: convert io directory to Meson
Date: Thu, 12 Dec 2019 13:51:21 +0100
Message-Id: <1576155176-2464-38-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile         |  1 -
 Makefile.objs    |  7 ++-----
 Makefile.target  |  2 +-
 io/Makefile.objs | 12 ------------
 io/meson.build   | 25 +++++++++++++++++++++++++
 meson.build      |  1 +
 6 files changed, 29 insertions(+), 19 deletions(-)
 delete mode 100644 io/Makefile.objs
 create mode 100644 io/meson.build

diff --git a/Makefile b/Makefile
index d070335..77ac1ea 100644
--- a/Makefile
+++ b/Makefile
@@ -200,7 +200,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
-                io-obj-y \
                 common-obj-y \
                 common-obj-m)
 
diff --git a/Makefile.objs b/Makefile.objs
index a5dd228..75d4355c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,12 +21,9 @@ authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
 crypto-obj-y = crypto/libcrypto.fa
 
-qom-obj-y = qom/libqom.fa
-
-#######################################################################
-# io-obj-y is code used by both qemu system emulation and qemu-img
+io-obj-y = io/libio.fa
 
-io-obj-y = io/
+qom-obj-y = qom/libqom.fa
 
 ######################################################################
 # Target independent part of system emulation. The long term path is to
diff --git a/Makefile.target b/Makefile.target
index d8a6491..f912ba0 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -179,12 +179,12 @@ include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
               crypto-obj-y \
+              io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
-               io-obj-y \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/io/Makefile.objs b/io/Makefile.objs
deleted file mode 100644
index 9a20fce..0000000
--- a/io/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-io-obj-y = channel.o
-io-obj-y += channel-buffer.o
-io-obj-y += channel-command.o
-io-obj-y += channel-file.o
-io-obj-y += channel-socket.o
-io-obj-y += channel-tls.o
-io-obj-y += channel-watch.o
-io-obj-y += channel-websock.o
-io-obj-y += channel-util.o
-io-obj-y += dns-resolver.o
-io-obj-y += net-listener.o
-io-obj-y += task.o
diff --git a/io/meson.build b/io/meson.build
new file mode 100644
index 0000000..5737709
--- /dev/null
+++ b/io/meson.build
@@ -0,0 +1,25 @@
+io_ss = ss.source_set()
+io_ss.add(genh)
+io_ss.add(files(
+  'channel-buffer.c',
+  'channel-command.c',
+  'channel-file.c',
+  'channel-socket.c',
+  'channel-tls.c',
+  'channel-util.c',
+  'channel-watch.c',
+  'channel-websock.c',
+  'channel.c',
+  'dns-resolver.c',
+  'net-listener.c',
+  'task.c',
+))
+
+io_ss = io_ss.apply(config_host, strict: false)
+libio = static_library('io', io_ss.sources(),
+                       dependencies: [crypto, qom, io_ss.dependencies()],
+                       link_with: libqemuutil,
+                       name_suffix: 'fa',
+                       build_by_default: false)
+
+io = declare_dependency(link_whole: libio)
diff --git a/meson.build b/meson.build
index e8bd526..bdc2f3e 100644
--- a/meson.build
+++ b/meson.build
@@ -277,6 +277,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('io')
 subdir('fsdev')
 
 # Other build targets
-- 
1.8.3.1



