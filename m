Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660802467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko2Id6n4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660802467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW2T-0002nS-LA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7z-00047G-SX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7y-0008W2-9g
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:19 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7y-0008TI-1P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:18 -0500
Received: by mail-wr1-x443.google.com with SMTP id q10so17104297wrm.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BDWglfYgMOtl659xP+q/5QhfEoszYG7S7GJUoVLsayU=;
 b=ko2Id6n4YpLrrmGSJvTQC2VYEys8LEzfQtFwruleVJQ9xSRmzpNDjrcVeqGv7/zmE9
 DV3pDbS8xP/ygxQpEAc5gG3+hxU9LYINMojH1G6/YMZPzKgeVdUAGarAlSAns5N3Y10u
 CAmTkTXZNrcChIx/mEWJQvDptg00IAZo4KZjGa9nw8M44W9zwpucuQd++qdM8RrEBVAg
 +fgLNsjy783Xp4XJKcSr1Wuo4w5UgFUfyV0eW8vkB24xhfOdHFcdhnnLFr92Doss48vd
 ZQp5pRBAipKiqPqlrEw1ZJ4dmXLiGKZqmagrUdqRBUxeRkbbit+fDSv1zlW6a0CY5Ltu
 9g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BDWglfYgMOtl659xP+q/5QhfEoszYG7S7GJUoVLsayU=;
 b=nu4EU5K7eUkXgvfGiaz25AMJ/4MS/iNnj0Ni8oilrpylVhBcNc/r8BP9Yj3gXN6TNx
 TZK+sfbOxUj/yjqxo6FxgM1QLlL0VF2DgpbSsgAi72N0onSZaI12tdvWiA9pEfTC+/jF
 PAw2wWGyFEdimTUGnfQzh/zEvzG6E0MzYXVGbPxjYuATYiw9Depp2atH0FfYKTxHRuIb
 lWhK2ilqd2QRHjtN1P881KJVKOOcRbm9C/QV1n51yq0FI2/LmwISpRHI6Y1fY3CDoRrx
 I60SGyQtwz0BfAHzGH49APTRz0zoPZ5WWiieGU9fRMawmz1sVlUYj/ZM0JV0GnkS2aV2
 KzJQ==
X-Gm-Message-State: APjAAAXa3ECkZuT0kRyWoKFk0VY+L9SN1DTFQuUHvWuQy3N1tRdPhPDN
 0CTpykKNJ0uuZYXrUGSxKZpd62ls
X-Google-Smtp-Source: APXvYqx1cxNwdW/zUqfqLzfSGttYQ3AboO0X3fX8x2ZC5fGO64uYwooS8U14uZZ+nn61k0KHBYZZEA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr31856493wrm.210.1580234296720; 
 Tue, 28 Jan 2020 09:58:16 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 114/142] meson: linux-user
Date: Tue, 28 Jan 2020 18:53:14 +0100
Message-Id: <20200128175342.9066-115-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
---
 Makefile.target                    |  3 ---
 linux-user/Makefile.objs           | 10 ----------
 linux-user/arm/nwfpe/Makefile.objs |  2 --
 linux-user/arm/nwfpe/meson.build   | 10 ++++++++++
 linux-user/meson.build             | 22 ++++++++++++++++++++++
 meson.build                        |  9 +++++++++
 6 files changed, 41 insertions(+), 15 deletions(-)
 delete mode 100644 linux-user/Makefile.objs
 delete mode 100644 linux-user/arm/nwfpe/Makefile.objs
 create mode 100644 linux-user/arm/nwfpe/meson.build
 create mode 100644 linux-user/meson.build

diff --git a/Makefile.target b/Makefile.target
index 3aec144e82..8c3f838ec6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -130,9 +130,6 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/linux-user/host/$(ARCH) \
              -I$(SRC_PATH)/linux-user
 
-obj-y += linux-user/
-obj-y += gdbstub.o thunk.o
-
 endif #CONFIG_LINUX_USER
 
 #########################################################
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
deleted file mode 100644
index d2f33beb5e..0000000000
--- a/linux-user/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-obj-y = main.o syscall.o strace.o mmap.o signal.o \
-	elfload.o linuxload.o uaccess.o uname.o \
-	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
-
-obj-$(TARGET_HAS_BFLT) += flatload.o
-obj-$(TARGET_I386) += vm86.o
-obj-$(TARGET_ARM) += arm/nwfpe/
-obj-$(TARGET_ARM) += arm/semihost.o
-obj-$(TARGET_AARCH64) += arm/semihost.o
diff --git a/linux-user/arm/nwfpe/Makefile.objs b/linux-user/arm/nwfpe/Makefile.objs
deleted file mode 100644
index 51b0c32c2a..0000000000
--- a/linux-user/arm/nwfpe/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y = fpa11.o fpa11_cpdo.o fpa11_cpdt.o fpa11_cprt.o fpopcode.o
-obj-y += single_cpdo.o double_cpdo.o extended_cpdo.o
diff --git a/linux-user/arm/nwfpe/meson.build b/linux-user/arm/nwfpe/meson.build
new file mode 100644
index 0000000000..1c27e55f2a
--- /dev/null
+++ b/linux-user/arm/nwfpe/meson.build
@@ -0,0 +1,10 @@
+linux_user_ss.add(when: 'TARGET_ARM', if_true: files(
+  'double_cpdo.c',
+  'extended_cpdo.c',
+  'fpa11.c',
+  'fpa11_cpdo.c',
+  'fpa11_cpdt.c',
+  'fpa11_cprt.c',
+  'fpopcode.c',
+  'single_cpdo.c',
+))
diff --git a/linux-user/meson.build b/linux-user/meson.build
new file mode 100644
index 0000000000..b5711d9b78
--- /dev/null
+++ b/linux-user/meson.build
@@ -0,0 +1,22 @@
+linux_user_ss.add(files(
+  'elfload.c',
+  'exit.c',
+  'fd-trans.c',
+  'linuxload.c',
+  'main.c',
+  'mmap.c',
+  'safe-syscall.S',
+  'signal.c',
+  'strace.c',
+  'syscall.c',
+  'uaccess.c',
+  'uname.c',
+))
+linux_user_ss.add(rt)
+
+linux_user_ss.add(when: 'TARGET_AARCH64', if_true: files('arm/semihost.c'))
+linux_user_ss.add(when: 'TARGET_ARM', if_true: files('arm/semihost.c'))
+linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
+linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
+
+subdir('arm/nwfpe')
diff --git a/meson.build b/meson.build
index bd0067ba5b..07d97d452c 100644
--- a/meson.build
+++ b/meson.build
@@ -655,6 +655,10 @@ subdir('net')
 subdir('replay')
 subdir('hw')
 subdir('accel')
+subdir('linux-user')
+
+linux_user_ss.add(files('gdbstub.c', 'thunk.c'))
+specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
 
 mods = []
 block_mods = []
@@ -751,6 +755,11 @@ foreach target : target_dirs
       base_dir,
       base_dir / config_target['TARGET_ABI_DIR'],
     )
+    if 'CONFIG_LINUX_USER' in config_target
+      dir = base_dir / config_target['TARGET_ABI_DIR']
+      target_inc += include_directories(base_dir / 'host' / config_target['ARCH'])
+      arch_srcs += files(dir / 'signal.c', dir / 'cpu_loop.c')
+    endif
   endif
 
   t = target_arch[arch].apply(config_target, strict: false)
-- 
2.21.0



