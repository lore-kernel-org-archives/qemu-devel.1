Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CDD2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiJgDRh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CDD2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW53-0006bX-M7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV82-0004BW-0G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV80-0000A7-TB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:21 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7z-00006X-SJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:20 -0500
Received: by mail-wm1-x344.google.com with SMTP id s10so3525762wmh.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i76w+t9B1oPmwkSkSk0YuyoRnJ4nJrrRU+Nru66pFgs=;
 b=DiJgDRh1A5JOXMFjLe+It2ts8eNNnsmRJqNu9ypDdb5B+mAXbe3W0X3wldg2iMGvu5
 8qUmQL5DBs7QxoqLDQWi7t+vLpBCDoGmUvnAll+85lcPWtPZyL6Azpa777l97ajjtb11
 AO++jcqW84kPE6KBBVxq8w0IpAEU5RhBSOhVQvH/Ua0Cg40bkb3TGRWq2Yux85e6IF4J
 Go4/nHBjzDSkHp+DL4weuO6u2VMIQ3aznWgOZi3tOkiFvcasV9I+iSsZtRPhxdhS38eU
 rURG2MZiqLTC3RyjonaXd2qbOucPtKDhfSl5IWoh3cM9bLsglXrAGmzQ7uCIfCI2+JT3
 o6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i76w+t9B1oPmwkSkSk0YuyoRnJ4nJrrRU+Nru66pFgs=;
 b=SXJaweqDLy9LL4vIUWs8fpP+bH7ReC4CSQholmbHDI7FswiZg78U+bPELsqNdgSI+M
 JsNYMUWgblOiqLEkJJ8WntyGSpC/95RfnjOWj9I1jOdBZenBuaUnuEtPEkUQ0PwX/zRR
 t+9Gz2oTdyBe/AqPxCMY4orRZdDX7kvCyFE9liLPfE0i4c5ynyKGP5FN1Cf9vL47zg9P
 GVYTpEDrc4N/ouvEOT3YDIWiPCNDY+gfUv5RQpEfPyv+MH5iH5bhhtdQKxNP4PgblmLb
 lu5z+tBU6Tv9OSzuF5B/o88zijJQPzLYPU5+2BWJ77dt59apPev4fM44l4WnEjKuXGVG
 RMxg==
X-Gm-Message-State: APjAAAUW2FNvdHCc2dy0BqEjMgIZnVkpseXP3kEnwE2mHV2Yzn7pgMlg
 NqAtkdQphJHcA7AqSBNOcQQAZb8G
X-Google-Smtp-Source: APXvYqyP4f2tAujZQEN5glk6MWn/gDMcJFODNC82DU9m0H8+9I/3kjR3Lho0f+nLl7GH5A/3rpG5Cg==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr6555294wmb.155.1580234298641; 
 Tue, 28 Jan 2020 09:58:18 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 115/142] meson: bsd-user
Date: Tue, 28 Jan 2020 18:53:15 +0100
Message-Id: <20200128175342.9066-116-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Makefile.target        |  3 ---
 bsd-user/Makefile.objs |  2 --
 bsd-user/meson.build   | 10 ++++++++++
 meson.build            |  4 ++++
 4 files changed, 14 insertions(+), 5 deletions(-)
 delete mode 100644 bsd-user/Makefile.objs
 create mode 100644 bsd-user/meson.build

diff --git a/Makefile.target b/Makefile.target
index 8c3f838ec6..3671c29f97 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -140,9 +140,6 @@ ifdef CONFIG_BSD_USER
 QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
 			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
 
-obj-y += bsd-user/
-obj-y += gdbstub.o
-
 endif #CONFIG_BSD_USER
 
 #########################################################
diff --git a/bsd-user/Makefile.objs b/bsd-user/Makefile.objs
deleted file mode 100644
index 5e77f57782..0000000000
--- a/bsd-user/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y = main.o bsdload.o elfload.o mmap.o signal.o strace.o syscall.o \
-	        uaccess.o
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
new file mode 100644
index 0000000000..0369549340
--- /dev/null
+++ b/bsd-user/meson.build
@@ -0,0 +1,10 @@
+bsd_user_ss.add(files(
+  'bsdload.c',
+  'elfload.c',
+  'main.c',
+  'mmap.c',
+  'signal.c',
+  'strace.c',
+  'syscall.c',
+  'uaccess.c',
+))
diff --git a/meson.build b/meson.build
index 07d97d452c..a96c54ceb1 100644
--- a/meson.build
+++ b/meson.build
@@ -655,8 +655,12 @@ subdir('net')
 subdir('replay')
 subdir('hw')
 subdir('accel')
+subdir('bsd-user')
 subdir('linux-user')
 
+bsd_user_ss.add(files('gdbstub.c'))
+specific_ss.add_all(when: 'CONFIG_BSD_USER', if_true: bsd_user_ss)
+
 linux_user_ss.add(files('gdbstub.c', 'thunk.c'))
 specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
 
-- 
2.21.0



