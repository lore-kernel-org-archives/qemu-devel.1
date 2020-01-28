Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5B4214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myRHrI5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5B4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVPd-0001V2-Vd
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4W-000723-KH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4V-0000Ij-1Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4U-0000Dt-QV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id a9so3565119wmj.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h755r6Ys4Hk7ZRHLjfISHRxt60EtDeGxbGM6erYTA8I=;
 b=myRHrI5E0DPj0NqN4n0XA/JjAZ15VBHSg/UsL3k+dLoSwBW/RuacNHXayO4TKSuS+u
 i1ysZQxolQnVysyMU3C7z3bjjXN5ozTiYcunXDZTWdeVTLPosUsROUaVnd42pKqq4zQl
 SaX+yWhDTbyYlnVqTsHjTUFLudFZPiSCCufQDzqnGDHIE7kWKJhfWG8OZmXDQOKAVNYK
 7vUqoqR3X73WvohhYaja+JBDYNjgzVu8XtJA/gtw/ccllw8yztn37mZ6i1s0Apim4su4
 y5+8gtECZXJ8t2LsalopKIC5EqALWDKM0IuugcSAiCctNaDcxDyvhaT/ZYScZRAHDGhM
 b1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h755r6Ys4Hk7ZRHLjfISHRxt60EtDeGxbGM6erYTA8I=;
 b=FO5vAbnz3W19VUmc7cu6tbzUpKa/kwNnv22vEfu0VZXe2MqHrUgiuzUfo1Pd1fkqFu
 1O6fGkX5HHf8DuO9hvVWV4r1Qzj8gTNdJ1JSloMoswoImmeCRs1riVenZH/3M0AsQxxG
 kTMer9BHsS41AXvUhW3p/EbdoXzNCCWAioG57rp3k2BjjoRpGcPS+BRnnetvV09UkwLh
 uky7U/wy6BZlS0ZfVNcPfrF6LXirBsQbCfCT6eIvGfElTN39QgoLkoje/qp9C2EXe+mc
 /iO83HWh68s3BMeOit31bJ1FBM8rPBR0GhDgLqRqq9vPVWhWzpPYxPe6x6kGSv1LYbll
 0ctg==
X-Gm-Message-State: APjAAAWpz8GGjM8qeCaz6CyBVSMFXxW7FJjHeMiFrmYI0Ofq86dmPy/W
 OvqTLrCU7+6tVHO8O484nzKSNv81
X-Google-Smtp-Source: APXvYqzLZ0l+ONDtb7jR8G/6xmtJRDLMaNVr+03fDpBTVkOq3kMjzL7epFQMA+oL4S7b4DYnN1thcQ==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr6125503wmh.138.1580234080525; 
 Tue, 28 Jan 2020 09:54:40 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 022/142] contrib/ivshmem: convert to meson
Date: Tue, 28 Jan 2020 18:51:42 +0100
Message-Id: <20200128175342.9066-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Makefile                             | 9 ---------
 Makefile.objs                        | 2 --
 configure                            | 3 ---
 contrib/ivshmem-client/Makefile.objs | 1 -
 contrib/ivshmem-client/meson.build   | 3 +++
 contrib/ivshmem-server/Makefile.objs | 1 -
 contrib/ivshmem-server/meson.build   | 3 +++
 meson.build                          | 6 ++++++
 8 files changed, 12 insertions(+), 16 deletions(-)
 delete mode 100644 contrib/ivshmem-client/Makefile.objs
 create mode 100644 contrib/ivshmem-client/meson.build
 delete mode 100644 contrib/ivshmem-server/Makefile.objs
 create mode 100644 contrib/ivshmem-server/meson.build

diff --git a/Makefile b/Makefile
index 5c000b2a2f..c0e62d8053 100644
--- a/Makefile
+++ b/Makefile
@@ -286,8 +286,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 qga-obj-y \
                 elf2dmp-obj-y \
-                ivshmem-client-obj-y \
-                ivshmem-server-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -488,13 +486,6 @@ endif
 elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
-ifdef CONFIG_IVSHMEM
-ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
-	$(call LINK, $^)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/Makefile.objs b/Makefile.objs
index 2f375be444..92dc309fd7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -106,7 +106,5 @@ qga-vss-dll-obj-y = qga/
 ######################################################################
 # contrib
 elf2dmp-obj-y = contrib/elf2dmp/
-ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
-ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 
 ######################################################################
diff --git a/configure b/configure
index a650183ff6..52269b4ca6 100755
--- a/configure
+++ b/configure
@@ -6209,9 +6209,6 @@ if test "$want_tools" = "yes" ; then
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
-  if [ "$ivshmem" = "yes" ]; then
-    tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
-  fi
   if [ "$curl" = "yes" ]; then
       tools="elf2dmp\$(EXESUF) $tools"
   fi
diff --git a/contrib/ivshmem-client/Makefile.objs b/contrib/ivshmem-client/Makefile.objs
deleted file mode 100644
index bfab2d20dd..0000000000
--- a/contrib/ivshmem-client/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-client-obj-y = ivshmem-client.o main.o
diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
new file mode 100644
index 0000000000..92ad844a9c
--- /dev/null
+++ b/contrib/ivshmem-client/meson.build
@@ -0,0 +1,3 @@
+executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
+           dependencies: glib,
+           install: true)
diff --git a/contrib/ivshmem-server/Makefile.objs b/contrib/ivshmem-server/Makefile.objs
deleted file mode 100644
index c060dd3698..0000000000
--- a/contrib/ivshmem-server/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-ivshmem-server-obj-y = ivshmem-server.o main.o
diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
new file mode 100644
index 0000000000..6dbe240df6
--- /dev/null
+++ b/contrib/ivshmem-server/meson.build
@@ -0,0 +1,3 @@
+executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
+           dependencies: [qemuutil, rt],
+           install: true)
diff --git a/meson.build b/meson.build
index 6613eae7e2..53e453026c 100644
--- a/meson.build
+++ b/meson.build
@@ -54,6 +54,7 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+rt = cc.find_library('rt', required: false)
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -219,4 +220,9 @@ if have_tools
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
+
+  if 'CONFIG_IVSHMEM' in config_host
+    subdir('contrib/ivshmem-client')
+    subdir('contrib/ivshmem-server')
+  endif
 endif
-- 
2.21.0



