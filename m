Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B42D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk/xtgUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B42D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVly-0001Gv-56
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5f-0000VR-3u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5Z-0002wO-QQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5Z-0002to-H9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id t2so17098422wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zDmIwaKlWZsl6QkOsoCqq80Ldhoa/IZ0IWc4dKgKCeY=;
 b=Zk/xtgUzj1JLh7bAZysarEwypiYZ2wtS/GFW2cdAa6sERev0pAgPs4ljwKuI5Ji16y
 R9QIcDezLUwj23gWh2fXdsEkJpN06TTN5W7L1CNG3d+hkh0JF+84VXd7yv+HW/mtLQMb
 mtdZ84fAiREP5T3MfZcWOrhpsB5dR43QPNb+ELd14ZYXGZY/g6bnyOlvaTxBxD/oMEum
 BdUh/YE1fQgtQ6mt+WTvi7W+Khz635fitEYoQjQ/rO2/ClMQKeP5dBsyMY0EteXAUgx3
 fj9OYk0uXAroRZYeRAheOl2DwxmtfPYhuCu3t4eDUuzT8niQtv99+u6GE9uQhLmqlhFT
 /r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zDmIwaKlWZsl6QkOsoCqq80Ldhoa/IZ0IWc4dKgKCeY=;
 b=SE378HXwyl2jfd0yonLKdg8cVQnvaxtDMQS7kCXaKFcXvzq9lHEuuRFJKk/FEVFaoA
 yQBJ40aSXVmAs9ObgjQ3fAiFCeHqgiHB1wA7rY4nY4u7tQ2jGgGeKxLmnJABeBQ5bfTe
 2t8wnqm6gchmgSJBrbgpSJO2K0tnDSyhiGT+pFqPJUim6QszO2m4pjY5M0ICggnNSjhz
 2P4Lbw25SmRN8lZAJvo+vtWiB8chDt88SpP4bxQqXC/FFGCZI3Wnjo6d2YD2C50oySRd
 Nqnh1IzOX5EVkxfK25/HJSSD4IGk1qcdO3xEbl9JblvqOVHsz1wEepR3zMidjzWUePnO
 gxHQ==
X-Gm-Message-State: APjAAAXcOMgjoNODAPfV9ZnHvlDoyTo6xCKEHmfpXdVkfIbPlXZIDugo
 IRceJYdLk4y0vsW5Cv32YfGtfbQS
X-Google-Smtp-Source: APXvYqze60vTWoKf0FOPTxShf4GXkHvWiIJoB//rAWT5h62K+ZVfvU/Fh6fiVQb0C/+JCQPITNRwAg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id
 i3mr29590177wrx.244.1580234148335; 
 Tue, 28 Jan 2020 09:55:48 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 050/142] meson: qemu-pr-helper
Date: Tue, 28 Jan 2020 18:52:10 +0100
Message-Id: <20200128175342.9066-51-pbonzini@redhat.com>
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    |  5 -----
 configure   |  1 -
 meson.build | 10 ++++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index a9454f6ff1..ee79c2dbfa 100644
--- a/Makefile
+++ b/Makefile
@@ -257,11 +257,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-ifdef CONFIG_MPATH
-scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
-endif
-
 clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
diff --git a/configure b/configure
index 6fbc9e0ad8..11586bfc20 100755
--- a/configure
+++ b/configure
@@ -6222,7 +6222,6 @@ if test "$softmmu" = yes ; then
       fi
       mpath=no
     fi
-    tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
   else
     if test "$virtfs" = yes; then
       error_exit "VirtFS is supported only on Linux"
diff --git a/meson.build b/meson.build
index 215c123a1f..d4f4ccbee7 100644
--- a/meson.build
+++ b/meson.build
@@ -112,6 +112,10 @@ if 'CONFIG_XKBCOMMON' in config_host
                                  link_args: config_host['XKBCOMMON_LIBS'].split())
 endif
 rt = cc.find_library('rt', required: false)
+libmpathpersist = declare_dependency()
+if config_host.has_key('CONFIG_MPATH')
+  libmpathpersist = cc.find_library('mpathpersist')
+endif
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
   libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
@@ -582,6 +586,7 @@ foreach target : target_dirs
 endforeach
 
 # Other build targets
+
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
@@ -622,6 +627,11 @@ if have_tools
                dependencies: [qemuutil, libcap_ng],
                install: true,
                install_dir: get_option('libexecdir'))
+
+    executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
+               dependencies: [authz, crypto, io, qom, qemuutil,
+                              libcap_ng, libudev, libmpathpersist],
+               install: true)
   endif
 
   if 'CONFIG_IVSHMEM' in config_host
-- 
2.21.0



