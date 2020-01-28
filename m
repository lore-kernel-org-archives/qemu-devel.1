Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B364BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879B620716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASeJhvfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879B620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVV1-0000vL-Bb
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV60-00012s-5H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5y-0003qW-Sy
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5y-0003jZ-Jw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:14 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z7so17065518wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HLGQqBx6fLlWfWZuyth3NtzuTTN+bT5hdXLPOIhSR9A=;
 b=ASeJhvfw9khrqo7KfRD/u64FzchLDx4RDiQAinyj2Rp0Gp6PspanGKfxL3P1ulxZ+5
 cTMXCcr5sUdhoydfJWTtbBSa3k4g8emrs3ctgYz0DASz7Qv0xn/NORdOSU63LNpDv4Xv
 uS9rXcIzyGqtOAc35dWMlzg2RN6Bd/drDNMHmXFNNLJOw3u+mbJNFTn8K/qmWMUq9uV8
 qTgSwN5AR8DwhPEHOQfILqdKWuydrzwFAioNwTTFSkgbZzv+tTANcFAhGNSyCj3j7T5t
 U34aaBaCf8Zt/21FUSIV9i/mLazkxDY7igMXT8kazYjHOlMXE8VkMmktIoCDzNmbKHwG
 MyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HLGQqBx6fLlWfWZuyth3NtzuTTN+bT5hdXLPOIhSR9A=;
 b=qSow5GD2BxwA5nJRzs7xqgrZaUQl4bibuqOFd8IASoegqjeOpQ/B/BaJ9d2hblozX6
 DoSZGCWi8C9WPAIbhF09DqxKxl6wBSfXzCqt7Yli8R29TzNxft0kZA4L0Ak21nAy0OBa
 ttNgCUV+HokXgDKe1JzmbWzBDcNMB/0pbF9A5Q4E7OYSOEnDO0PZroVd4TVvEIms4N2T
 IMqHXLXFKtY2bjSydbgYiWyI/dpx6jBeSqy/xRWBOhRiX7cx1yT9Or2tdN/JRWlCvT1f
 gluB3+bh1SpBSu/mYrx4XlWdHm1y4YV3rDv52HGGxRGIgGEd15Mao8LEcFIMCdY+5hwi
 +pGQ==
X-Gm-Message-State: APjAAAWOZnnk3+SEW+hYQaBuvid9XS7rZoJ88UlQH5oN6mQTH/VU38K4
 t8Hk8R2nZzUiq5jafO6kAar3u77u
X-Google-Smtp-Source: APXvYqybIhgkwVfRyYJsuTnQ0QqEQw3lk8QIX/RuugiJUav5KhMqjJmde02zXRO+PIUfNBanaERBdQ==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr28490709wrq.232.1580234171213; 
 Tue, 28 Jan 2020 09:56:11 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 060/142] meson: convert monitor directory to Meson
Date: Tue, 28 Jan 2020 18:52:20 +0100
Message-Id: <20200128175342.9066-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         | 3 +--
 Makefile.target       | 1 -
 meson.build           | 2 ++
 monitor/Makefile.objs | 3 ---
 monitor/meson.build   | 9 +++++++++
 5 files changed, 12 insertions(+), 6 deletions(-)
 delete mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 6a99d750f6..c4cea8d046 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = monitor/
-common-obj-y += net/
+common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
diff --git a/Makefile.target b/Makefile.target
index 06a5744f4a..d8afffbce5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -156,7 +156,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y += qtest.o
 obj-y += hw/
-obj-y += monitor/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
diff --git a/meson.build b/meson.build
index 1ecc46d280..0532ab3101 100644
--- a/meson.build
+++ b/meson.build
@@ -600,6 +600,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('monitor')
+
 mods = []
 block_mods = []
 softmmu_mods = []
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
deleted file mode 100644
index e91a8581cd..0000000000
--- a/monitor/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += misc.o
-common-obj-y += monitor.o qmp.o hmp.o
-common-obj-y += qmp-cmds.o hmp-cmds.o
diff --git a/monitor/meson.build b/monitor/meson.build
new file mode 100644
index 0000000000..1eabfd5bac
--- /dev/null
+++ b/monitor/meson.build
@@ -0,0 +1,9 @@
+softmmu_ss.add(files(
+  'hmp-cmds.c',
+  'hmp.c',
+  'monitor.c',
+  'qmp-cmds.c',
+  'qmp.c',
+))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('misc.c'))
-- 
2.21.0



