Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47537204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBIdc6tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47537204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ghh-0000Is-EI
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHR-000575-66
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHN-0006Cl-Ed
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id a5so15259329wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K2Dcd9CsBr5fcSFFLkGoisbUpaXJzuV79F8xm2sV7iE=;
 b=fBIdc6tg82tbyumZLQ7wG2kOuwppGSMI0JMFFP8mIy4eYbNjVexK0dwHhjddRHBZ1H
 TnCUyXSgs+DtMGzUn4GUej2nL5PKOciBOK4F/VyNruIDd66QyKXxkHadprvJ10ffXRuI
 VAb0h370OiJQXtDNw9CzyxJw+kyPe0ZPa8SV80xZzCB3HvmfqJGdpxZAY9lR3XW18pit
 KmhVUw7qkR0fv7+AT+8D1hjo9Y8yyD5CWFdh/JQWhJSRqoK6MOQ6iKaJt4B85YiGundf
 U7OGA/lC0AsI0r5oWO3ZEUxva0DMcvFYTDaedm+de+sxv0qd7zd+OQiAnrS9WdBHS+8n
 GioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K2Dcd9CsBr5fcSFFLkGoisbUpaXJzuV79F8xm2sV7iE=;
 b=UjRHhv5FVa0CShx0qfyUJf6PnexW434yiXC4oLSxImRAwQrQoo4pZPvxG6onNw2iuc
 lS6DE99pZLDszzekIBA335P66S/PLY1NLL98YQGIBe40OH5DJOVjf0iA78ZganzbnBqc
 sum99loc72NeoT2mCQiY3BzrPoYspfhWyd02rp4PpsyzBhKc1hGVFTe6VUcf/LFQkFFo
 xoIQ42+W6NmDomPkhTCK6/0Yrgx5DkUvr1zS9HIBYs4wVPYieE9sKYyOiDwSSCtCDOBT
 Dvkx0A7R/y22XcrnY1/5rDfYoHtuWbjusVHvPWJluDUixLx2uP3ZfMRIB7jMjDKEbwNM
 l9Xg==
X-Gm-Message-State: AOAM532cYsK2JP/MjwgbJyIf7fcCB3mmoyNaCG4xZ1Ei8szaGm3ovULW
 N3qvxxI9aSvhNsl07lCvEUCvnv16nYg=
X-Google-Smtp-Source: ABdhPJyB7UoVnuKQuCZu23h6fKmHc3J1g7rDsfXRIrLI/CdxPNe2+uRQxEZa2XqcZJh86bbGjagBbQ==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr16626433wrw.360.1597675107245; 
 Mon, 17 Aug 2020 07:38:27 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 062/150] meson: convert chardev directory to Meson (tools part)
Date: Mon, 17 Aug 2020 16:35:55 +0200
Message-Id: <20200817143723.343284-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  1 -
 Makefile.objs         |  4 ++--
 Makefile.target       |  2 +-
 chardev/Makefile.objs | 19 -------------------
 chardev/meson.build   | 32 ++++++++++++++++++++++++++++++++
 meson.build           |  1 +
 6 files changed, 36 insertions(+), 23 deletions(-)
 create mode 100644 chardev/meson.build

diff --git a/Makefile b/Makefile
index 8b55440e50..fec8be6dff 100644
--- a/Makefile
+++ b/Makefile
@@ -171,7 +171,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
                 storage-daemon-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 0920cdb40c..297bd5beeb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -7,8 +7,6 @@ qom-obj-y = qom/libqom.fa
 
 ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
 
-chardev-obj-y = chardev/
-
 authz-obj-y = authz/libauthz.fa
 authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
@@ -19,6 +17,8 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
+chardev-obj-y = chardev/libchardev.fa
+
 crypto-obj-y = crypto/libcrypto.fa
 
 io-obj-y = io/libio.fa
diff --git a/Makefile.target b/Makefile.target
index d1d8906b4d..6b9de09df5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -199,13 +199,13 @@ common-obj-m :=
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
index 3783dadc4c..6662d0df41 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,23 +1,4 @@
-chardev-obj-y += char.o
 chardev-obj-$(CONFIG_SOFTMMU) += chardev-sysemu.o
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
 common-obj-$(CONFIG_SOFTMMU) += msmouse.o wctablet.o testdev.o
 
 ifeq ($(CONFIG_BRLAPI),y)
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
index ec2b0bdd73..3e9a28ba05 100644
--- a/meson.build
+++ b/meson.build
@@ -450,6 +450,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
 subdir('io')
+subdir('chardev')
 subdir('fsdev')
 subdir('target')
 
-- 
2.26.2



