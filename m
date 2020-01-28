Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36306C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322820716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYzkVFBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVdL-0005jg-2k
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5U-0000Jt-O7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5T-0002f4-Ar
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:44 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5T-0002Zy-4K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so17106112wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0WZuivSgNMWl4zupYiqbOPHdPqehhCbji+b8xFoXYew=;
 b=WYzkVFBAO+8nAYhwphEgUwnB2a1AcUxO+qko2g393oyxhZ79NuMA8SbkcXN8HDbKMr
 TeDAF2vAb+WVtPU8Nq0Pz8Mnaq32byZrY0sCY3psg/8h3rlWF9VAVJLV0GA2eOA8Ijrn
 ZQMogTeqpo0ZA0cG6FcXawJbE/jrEXpzuCO8kvkVvuqK0yOwoyav/swegNdNqG6l8eeT
 wqkNFmYpgbWRpe2hUlLcHeacxYe5CtiPhEpVatuF6VKFdWqkdv0CikxhW7irioGUQqqN
 F2/bvEMGBTyuigVEJD+coemqzz2nXHSlarYj5BtAOmtXtzI5GivPMpC8JiX8Yn99CrsT
 /6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0WZuivSgNMWl4zupYiqbOPHdPqehhCbji+b8xFoXYew=;
 b=B05X0Syw6yRfchSl60jZnaWqvPkTN01kryOhxhQMCQhWpnr3/SIzKpmhhmAeanQ9l0
 drPVLOWnJqBkzCecsSKEYcwYvTu6tKinZ5XbSKD71ZjlOw2M3ZzwKPO6Stga7XZJrhu8
 fcqebGAVaVcRs/NHxV1Zz7zvMmFw3XJ0W0JaQ+TtcRmWNu3PJG1ugsGjBExWq8Yem+L6
 iSNd1/+XEhCuYvsiPWaYjkL7BYmnEz39Cy4qGpH41lrj/BjaeLCJLbxNJyXmo6PrHMk8
 b0UrXvcSLrJJNlv0s0Xu2Vcl0n7qyuMgpUANKcBw7BdamWEyM0kCsu2xSsCF2RUHW81H
 /Fjw==
X-Gm-Message-State: APjAAAU4Hh2zQ956EhbkTVSETDfjk8fcA+x4eag2pUB1i8cRbXte6zGW
 eQm3MVi7nANyZW+XIHvhdoQyDJ/b
X-Google-Smtp-Source: APXvYqxudE9x4FVupW+GHe8/jx6Qo817uCFsoKGv5HnZ3IqTqYMsr+I1igI/n0ahR6kCtEiQBY6B3g==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr29896992wru.297.1580234139985; 
 Tue, 28 Jan 2020 09:55:39 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 047/142] meson: convert chardev directory to Meson (tools part)
Date: Tue, 28 Jan 2020 18:52:07 +0100
Message-Id: <20200128175342.9066-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
 Makefile              |  1 -
 Makefile.objs         |  6 ++----
 Makefile.target       |  2 +-
 chardev/Makefile.objs | 19 -------------------
 chardev/meson.build   | 32 ++++++++++++++++++++++++++++++++
 meson.build           |  1 +
 6 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100644 chardev/meson.build

diff --git a/Makefile b/Makefile
index 0152a2b397..3a83b178fc 100644
--- a/Makefile
+++ b/Makefile
@@ -161,7 +161,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
                 common-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 407e14daaa..bc317060d7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -1,7 +1,3 @@
-#######################################################################
-# chardev-obj-y is code used by both qemu system emulation and some tests
-chardev-obj-y = chardev/
-
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
@@ -19,6 +15,8 @@ block-obj-m = block/
 authz-obj-y = authz/libauthz.fa
 authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
+chardev-obj-y = chardev/libchardev.fa
+
 crypto-obj-y = crypto/libcrypto.fa
 
 io-obj-y = io/libio.fa
diff --git a/Makefile.target b/Makefile.target
index acde7778f0..68ec8fd83e 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -186,13 +186,13 @@ all-obj-y := $(obj-y)
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
+              chardev-obj-y \
               crypto-obj-y \
               io-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
-               chardev-obj-y \
                common-obj-y \
                common-obj-m)
 all-obj-y += $(common-obj-y)
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e1347f9..8049d82077 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,22 +1,3 @@
-chardev-obj-y += char.o
-chardev-obj-$(CONFIG_WIN32) += char-console.o
-chardev-obj-$(CONFIG_POSIX) += char-fd.o
-chardev-obj-y += char-fe.o
-chardev-obj-y += char-file.o
-chardev-obj-y += char-io.o
-chardev-obj-y += char-mux.o
-chardev-obj-y += char-null.o
-chardev-obj-$(CONFIG_POSIX) += char-parallel.o
-chardev-obj-y += char-pipe.o
-chardev-obj-$(CONFIG_POSIX) += char-pty.o
-chardev-obj-y += char-ringbuf.o
-chardev-obj-y += char-serial.o
-chardev-obj-y += char-socket.o
-chardev-obj-y += char-stdio.o
-chardev-obj-y += char-udp.o
-chardev-obj-$(CONFIG_WIN32) += char-win.o
-chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
-
 common-obj-y += msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) += baum.o
 baum.o-cflags := $(SDL_CFLAGS)
diff --git a/chardev/meson.build b/chardev/meson.build
new file mode 100644
index 0000000000..a2e671ddfc
--- /dev/null
+++ b/chardev/meson.build
@@ -0,0 +1,32 @@
+chardev_ss = ss.source_set()
+chardev_ss.add(files(
+  'char-fe.c',
+  'char-file.c',
+  'char-io.c',
+  'char-mux.c',
+  'char-null.c',
+  'char-pipe.c',
+  'char-ringbuf.c',
+  'char-serial.c',
+  'char-socket.c',
+  'char-stdio.c',
+  'char-udp.c',
+  'char.c',
+))
+chardev_ss.add(when: 'CONFIG_POSIX', if_true: files(
+  'char-fd.c',
+  'char-parallel.c',
+  'char-pty.c',
+))
+chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
+  'char-console.c',
+  'char-win-stdio.c',
+  'char-win.c',
+))
+
+chardev_ss = chardev_ss.apply(config_host, strict: false)
+libchardev = static_library('chardev', chardev_ss.sources(),
+                            name_suffix: 'fa',
+                            build_by_default: false)
+
+chardev = declare_dependency(link_whole: libchardev)
diff --git a/meson.build b/meson.build
index 1702133989..2406cc72eb 100644
--- a/meson.build
+++ b/meson.build
@@ -411,6 +411,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
 subdir('io')
+subdir('chardev')
 subdir('fsdev')
 subdir('target')
 
-- 
2.21.0



