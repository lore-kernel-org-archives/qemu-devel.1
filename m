Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2621C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA542173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHmmM7oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA542173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVjX-0005wN-U1
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5H-0008E9-E7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5F-000279-3e
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5E-000246-Pl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:29 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t2so17097098wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U2/YP4T0L71aVDml7sBsYZxuSLUTam2gDokB7c3Vy8I=;
 b=gHmmM7oBOurD7njNISQpPIslROvYpU9eLqK3FDRpvXtBdL/NoiPSKNvGEl3i8OoQeM
 syhlmC0Fg1CRgzoaqYce855zx8+zF6q9qsGWIdtlvH87M54fchdUrkn6AjPwuvV9WUfx
 lh5SMWJzcnzPgGa06Dah6+PRDuJlbQKBQkLKGVcX+eSq+IWvcWgUFRDB//9FhKkYZ5Us
 /a0heAel9IYsS9XBdU6VmUj9YEwaGgPXD1gSBMUd1NI0yTBg+xzUAZiwe6P5rbhCwkhb
 oABEzNnxwjABQm5h1isvXusHihcBKYoYQUDaGdOnS+WlQ9Pehni3L2MFivEJQ3cpIHIe
 bdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U2/YP4T0L71aVDml7sBsYZxuSLUTam2gDokB7c3Vy8I=;
 b=hcPhtzGoETAFHlQFKOg6U0yIQS6vI9Q11LwCPyVnxOLu1benBDld1+g2U91hG5s5ox
 0kWI+ZtpOQ5Ru2qDkJRmNFHSb8FfhDLdRrztptm/lNBzPIhmfi1CvAZgwJBjl6JvioQ6
 1z2I2qf/+z/h0g+mf2kfZZRY3agQuVIcsIOki0/RJ0KaAel7wne6bwXjZ17v1TX82TNx
 Rib5hZExkrIiAaOhUvgYxxQXA05HgVVEYqPKo1Lf0l9As5Q5h3NRZrkj6BdFMEz5FK//
 9rLI/TDtKC23FHw2qs9HqZoreYcIgBhK1S7PG2hmzQ3UHG1m9txnURgGXa+pMlOjrK9U
 eyTA==
X-Gm-Message-State: APjAAAU5KbLQagsiQ71RmIZow0hrPl2OhXycRCZcKffDRH8B9T5WFQPK
 ZWPcFPbR9MwgMGQVWN0d+i8DBHxT
X-Google-Smtp-Source: APXvYqzm2Y5CYF7ihgoWaxED4nGkF4Ega/zFGllETkbS5MtK17cykN84iGY8PW3bs/hoDzWW8Hac3Q==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr31198526wrw.255.1580234127540; 
 Tue, 28 Jan 2020 09:55:27 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 042/142] meson: convert io directory to Meson
Date: Tue, 28 Jan 2020 18:52:02 +0100
Message-Id: <20200128175342.9066-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
index 4d5db51869..73d70fcef9 100644
--- a/Makefile
+++ b/Makefile
@@ -223,7 +223,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
-                io-obj-y \
                 common-obj-y \
                 common-obj-m)
 
diff --git a/Makefile.objs b/Makefile.objs
index 7c9156313b..407e14daaa 100644
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
index f9e79492aa..5537f3897b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -181,12 +181,12 @@ include $(SRC_PATH)/Makefile.objs
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
index 9a20fce4ed..0000000000
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
index 0000000000..97487e278c
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
+                       dependencies: [io_ss.dependencies()],
+                       link_with: libqemuutil,
+                       name_suffix: 'fa',
+                       build_by_default: false)
+
+io = declare_dependency(link_whole: libio)
diff --git a/meson.build b/meson.build
index f11c474302..23d39363cf 100644
--- a/meson.build
+++ b/meson.build
@@ -293,6 +293,7 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
+subdir('io')
 subdir('fsdev')
 
 # Other build targets
-- 
2.21.0



