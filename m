Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3753FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071FA214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqL/hsf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071FA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVMA-00062p-6x
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4M-0006fC-Ha
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4L-0008SW-C4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:34 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4L-0008Rg-2O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:33 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so3574733wma.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0aGg9Yz9DeZQOFtWCPtMk5o81vJvnxbOPUerWKfM88=;
 b=SqL/hsf1JWiNOkjwaK/yGM3VZe6KEHij+LDZ93sjQlGumbICeNz1P0ti+FILqRgC4d
 U9u3rVyMkq6NMNUuFRF1pElEt0ulbcF5AP7i3ml1B/kMHLGwF3kU1M/7IBZY9NTKufrN
 wjGOTqeHlpVAdxPRAXMgeTS4cNxvlXnS3WCSry/dS9fctZHM3lnsaHEoQFCvI/kvd75J
 8dTNggYlH/fRXLTSYfmsM8XhUn0RzDSrahzsRwSfnF8O5EL31692Wh/ZCufur5dwhr25
 vu2sEVXf4k0cfB5M/lclNbISY75L1Xrik6PRCBEtiVWSSdkMkLvziZTedRNAy+JFkxRE
 jASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O0aGg9Yz9DeZQOFtWCPtMk5o81vJvnxbOPUerWKfM88=;
 b=WGSDGBBesdZ6WWNS+uA5G4FrSMB3UdG8zb6z1DemGr9Z7SG8f+OvW3BIScqgftm5VM
 WSTCWb7SbixPVfWZrtnmTNCSNZFnH3mWtw75DRV6FmlvvgWHr8aYfyL9SuLSgqXvNHQs
 eSUTVvsinjvRzvHznRx7vvJaGRKS1mswsgVDs/Iux4flp4DpUnssqndPzzVNikY8DuVY
 8WNSoiUO49vSO9ixXT4Y2Ng3iOrvKpGTCV8FASbb25UfOf/fMu3WbTZgfG3V9Qrgs6qi
 kz5+bF9zsnWAsotEwBDYYKy6n5fKXfUgWIkarZT9lejr8GhFI1G8wokT6Zc2weKxR6sF
 zjKA==
X-Gm-Message-State: APjAAAXW6rsfvPlQWmJgAK0nBRIzrYjocfN86nqg6dz0Ja9AoG/rxLRK
 uRr1f2N4WGznn+jtGodvQCKVhY2w
X-Google-Smtp-Source: APXvYqxqLLlf2tT75tlyCZ1JsQYcX3sIwCRfqQuTCnWdPS8FHeCp0FBeDdGhNJazNMzzYMPwK24Dmw==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr6223260wmf.93.1580234071772; 
 Tue, 28 Jan 2020 09:54:31 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 018/142] contrib/vhost-user-scsi: convert to Meson
Date: Tue, 28 Jan 2020 18:51:38 +0100
Message-Id: <20200128175342.9066-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

The libiscsi pkg-config information is extracted from config-host.mak and
used to link vhost-user-blk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                              | 3 ---
 Makefile.objs                         | 3 ---
 contrib/vhost-user-scsi/Makefile.objs | 1 -
 contrib/vhost-user-scsi/meson.build   | 5 +++++
 meson.build                           | 6 ++++++
 5 files changed, 11 insertions(+), 7 deletions(-)
 delete mode 100644 contrib/vhost-user-scsi/Makefile.objs
 create mode 100644 contrib/vhost-user-scsi/meson.build

diff --git a/Makefile b/Makefile
index 8c88288d6d..2272d834cc 100644
--- a/Makefile
+++ b/Makefile
@@ -290,7 +290,6 @@ dummy := $(call unnest-vars,, \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
                 rdmacm-mux-obj-y \
-                vhost-user-scsi-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
@@ -499,8 +498,6 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
-vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
-	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 04c424bfa6..02cee554ad 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -108,9 +108,6 @@ qga-vss-dll-obj-y = qga/
 elf2dmp-obj-y = contrib/elf2dmp/
 ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
-vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
-vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
-vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-scsi/Makefile.objs b/contrib/vhost-user-scsi/Makefile.objs
deleted file mode 100644
index e83a38a85b..0000000000
--- a/contrib/vhost-user-scsi/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-vhost-user-scsi-obj-y = vhost-user-scsi.o
diff --git a/contrib/vhost-user-scsi/meson.build b/contrib/vhost-user-scsi/meson.build
new file mode 100644
index 0000000000..0bdd5a51cd
--- /dev/null
+++ b/contrib/vhost-user-scsi/meson.build
@@ -0,0 +1,5 @@
+if 'CONFIG_LIBISCSI' in config_host
+  executable('vhost-user-scsi', files('vhost-user-scsi.c'),
+             link_with: libvhost_user,
+             dependencies: [qemuutil, libiscsi])
+endif
diff --git a/meson.build b/meson.build
index c95fc7c8f3..fd5a7aa2e8 100644
--- a/meson.build
+++ b/meson.build
@@ -52,6 +52,11 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
+libiscsi = declare_dependency()
+if 'CONFIG_LIBISCSI' in config_host
+  libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
+                                link_args: config_host['LIBISCSI_LIBS'].split())
+endif
 
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
@@ -194,5 +199,6 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-scsi')
   endif
 endif
-- 
2.21.0



