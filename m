Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C703C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178B82467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHnEj13F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178B82467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW3J-0003g6-53
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5w-0000vL-PB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5u-0003ea-Hl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5u-0003ce-AF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:10 -0500
Received: by mail-wm1-x32e.google.com with SMTP id a9so3569673wmj.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dwvuFVVrkbo9Wc98gZC3wbI0ZbeUVor6//1tXy84EAY=;
 b=WHnEj13Fp24ZR6n2RVtIjb/FBqNnF2fFaZiCq0DdW8/7HIWZMvL2a6eCtjPspeU77Z
 3zw+Sz7ROK3Zpgkm0kfDExzvsNyT6JD6IdbGaeftMEkU1NoFTCd6LTj9mnUTpL8zgZvg
 FcqES26mJLVoFEKcsW+2s4LRUq7GWE9khR/UgbD6PCXB3QwpWYr9y9oDFY9AbcGaxqHg
 636Jy3gKfXXeETMH9cxyhY+bM10p+CGxiBx6fIUdZccM86gPFdWeQkEmVcX7VUisaDa+
 KvnQRbAGxSaSDGy4hCbLiKNwTliX8mDHVBD0jEjETrX+b80DI999bGGUz9ADfVW1MhkO
 ih9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dwvuFVVrkbo9Wc98gZC3wbI0ZbeUVor6//1tXy84EAY=;
 b=Gn2Zk1pj26hrwMnFR9kUIUymoFdjh5gMGwRlQMrSyHsv5qnp9A5LD9cwLAYYkuPIX/
 aHF47WC3iN+hVV9ViKwA2dxFCyK2HenpKVJvJvAhVyKx1Q+p1PYNVL07FxKMToQJoYv6
 QnlO6r4wCfRap3x8z0afHnhyMaP5aedOXvdnyDCAcI6vwz6520AWqsGnHbvNdl90JJic
 42gEWszLV0kaWr5lQCT2MBhTEKsrQXSk4ZDVk381eYAtCRbxC4Ej8ytzcb7ePJGmzIDq
 Xx3Y+B2ImrYLXyQTnJTcRLRDYS6R0kRHqLXM5aVd6mbNfBbG1g3AriJQQ6BlIGxe8ICf
 uIZA==
X-Gm-Message-State: APjAAAWvh2wEJlNIqHkBmIjY+CASxuq2TJnvTKUf+ep5F8BJkayMhVXo
 lJhZV4dphBYUWE6j/aMDdL/FJ8VI
X-Google-Smtp-Source: APXvYqx/HYY8vvCt6aBI5YqPwLWKj3IzklXGlYjfoC4vYN7GvX9pLWZm18B7tL0Uc6CyDFlmByY3Uw==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr6161000wmk.131.1580234169114; 
 Tue, 28 Jan 2020 09:56:09 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 059/142] meson: convert dump/
Date: Tue, 28 Jan 2020 18:52:19 +0100
Message-Id: <20200128175342.9066-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
 Makefile.objs      | 3 +--
 Makefile.target    | 1 -
 configure          | 4 ++++
 dump/Makefile.objs | 3 ---
 dump/meson.build   | 4 ++++
 meson.build        | 9 +++++++++
 6 files changed, 18 insertions(+), 6 deletions(-)
 delete mode 100644 dump/Makefile.objs
 create mode 100644 dump/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 56d5e855da..6a99d750f6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = dump/
-common-obj-y += monitor/
+common-obj-y = monitor/
 common-obj-y += net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
diff --git a/Makefile.target b/Makefile.target
index 638e550530..06a5744f4a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -155,7 +155,6 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y += qtest.o
-obj-y += dump/
 obj-y += hw/
 obj-y += monitor/
 obj-y += qapi/
diff --git a/configure b/configure
index 1af0a73e39..3868d60222 100755
--- a/configure
+++ b/configure
@@ -2391,6 +2391,7 @@ int main(void) { lzo_version(); return 0; }
 EOF
     if compile_prog "" "-llzo2" ; then
         libs_softmmu="$libs_softmmu -llzo2"
+        lzo_libs="-llzo2"
         lzo="yes"
     else
         if test "$lzo" = "yes"; then
@@ -2410,6 +2411,7 @@ int main(void) { snappy_max_compressed_length(4096); return 0; }
 EOF
     if compile_prog "" "-lsnappy" ; then
         libs_softmmu="$libs_softmmu -lsnappy"
+        snappy_libs='-lsnappy'
         snappy="yes"
     else
         if test "$snappy" = "yes"; then
@@ -7150,10 +7152,12 @@ fi
 
 if test "$lzo" = "yes" ; then
   echo "CONFIG_LZO=y" >> $config_host_mak
+  echo "LZO_LIBS=$lzo_libs" >> $config_host_mak
 fi
 
 if test "$snappy" = "yes" ; then
   echo "CONFIG_SNAPPY=y" >> $config_host_mak
+  echo "SNAPPY_LIBS=$snappy_libs" >> $config_host_mak
 fi
 
 if test "$bzip2" = "yes" ; then
diff --git a/dump/Makefile.objs b/dump/Makefile.objs
deleted file mode 100644
index d2a5db3b81..0000000000
--- a/dump/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += dump.o
-common-obj-y += dump-hmp-cmds.o
-obj-$(TARGET_X86_64) += win_dump.o
diff --git a/dump/meson.build b/dump/meson.build
new file mode 100644
index 0000000000..2eff29c3ea
--- /dev/null
+++ b/dump/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(files('dump-hmp-cmds.c'))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('dump.c'), snappy, lzo])
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'TARGET_X86_64'], if_true: files('win_dump.c'))
diff --git a/meson.build b/meson.build
index cac9c894f4..1ecc46d280 100644
--- a/meson.build
+++ b/meson.build
@@ -264,6 +264,14 @@ if 'CONFIG_FDT' in config_host
   fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
                            link_args: config_host['FDT_LIBS'].split())
 endif
+snappy = declare_dependency()
+if 'CONFIG_SNAPPY' in config_host
+  snappy = declare_dependency(link_args: config_host['SNAPPY_LIBS'].split())
+endif
+lzo = declare_dependency()
+if 'CONFIG_LZO' in config_host
+  lzo = declare_dependency(link_args: config_host['LZO_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -558,6 +566,7 @@ subdir('io')
 subdir('chardev')
 subdir('fsdev')
 subdir('target')
+subdir('dump')
 
 block_ss.add(files(
   'block.c',
-- 
2.21.0



