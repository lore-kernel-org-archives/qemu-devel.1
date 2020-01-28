Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0BCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0DF207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otYfhksO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0DF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVgV-0001vX-FE
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5G-0008Er-L3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5D-00023N-V2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:30 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5D-0001ye-Ng
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id g17so17089975wro.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VvB3WRAgwL5yPLB9c3GF0RgQDT7qHJdukwYTjB5TZ+g=;
 b=otYfhksOV2OdOmE5wsetnxnL1t4ovXHLHjqjHgUtzd/rLWVK++SCPyLc3j1oxxCHsZ
 Vd2PC/E6SSpUnZHFSQfAlRh0o5RW9mA04H0SX3GkBHnvtfXuoqFfqcFrJ+JBe3KK1fQ1
 a+MxPDbdll+LiqLiecrz2GwtA7VNlO/62HUUYilvNJrzBn1axYpyoB9LJbv9iGFZNRva
 ssBHRibosbvskxVaIeNdW8Cj5CvflFWqCU9zAZ5IHKB74B3ebxMI+TlhMlBlY6Z4Mjy/
 wlmNdOq+qIMWthwVStI2tuDeik8k27pSSa1qxl8STPKKGtYKKvivsJkcFT+QFICiah0F
 TLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VvB3WRAgwL5yPLB9c3GF0RgQDT7qHJdukwYTjB5TZ+g=;
 b=QWp30xX1zOBa46I7spFjpwIicV7TIkJyeG1Gl3s+eyBVV5B5ArMnPbFVfoKBXU4wGF
 TGFjWLn8hSvL9ptz6JNYM05HKiaUEQaZHVrLh5GBLuY8Sj695mYZ00G+0eKoi4CcMWaj
 G7LdH84lHa88AzoC//MTzUl3DutxLv5P4OdYvkabaFZDYzkE6fV8nhrh2majAiTEXZrg
 tRBePT+TAopJVcqGSl6XmFCCLWBFWe0RrR40tsPd1uDdffY/aOTf1fe/DQgcYuz8FX+x
 xdgh7FF2TQZE+uldMc4Rcou7itAJI+qtzVBA2xbvanmrn+WC/5D8kJgkBNy7P1wJXGMU
 yzdg==
X-Gm-Message-State: APjAAAXvRejdpOYCpxCKwq0xcj/gmR7llDGMYoxEjOnYhzrfs9705rbh
 wqhQ4yQdUNYcqqa+7hykOJiA1/Xy
X-Google-Smtp-Source: APXvYqzQ4xWUzzxWNHXGOF5JlGpFn17sMasQ4EFFsvzLKnePe7rOIT7mtxVOrDdRxSV+r9X4wxsMhw==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr31426437wrv.302.1580234125374; 
 Tue, 28 Jan 2020 09:55:25 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 041/142] meson: convert crypto directory to Meson
Date: Tue, 28 Jan 2020 18:52:01 +0100
Message-Id: <20200128175342.9066-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 Makefile             |  1 -
 Makefile.objs        |  7 ++-----
 Makefile.target      |  2 +-
 crypto/Makefile.objs | 34 -------------------------------
 crypto/meson.build   | 48 ++++++++++++++++++++++++++++++++++++++++++++
 meson.build          |  4 ++--
 qom/meson.build      |  2 +-
 7 files changed, 54 insertions(+), 44 deletions(-)
 delete mode 100644 crypto/Makefile.objs

diff --git a/Makefile b/Makefile
index 64c7430951..4d5db51869 100644
--- a/Makefile
+++ b/Makefile
@@ -223,7 +223,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
-                crypto-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
diff --git a/Makefile.objs b/Makefile.objs
index bbeb87ec82..7c9156313b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -13,17 +13,14 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
-#######################################################################
-# crypto-obj-y is code used by both qemu system emulation and qemu-img
-
-crypto-obj-y = crypto/
-
 #######################################################################
 # libraries built entirely from meson
 
 authz-obj-y = authz/libauthz.fa
 authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
+crypto-obj-y = crypto/libcrypto.fa
+
 qom-obj-y = qom/libqom.fa
 
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index a9f5cac98a..f9e79492aa 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -180,12 +180,12 @@ all-obj-y := $(obj-y)
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
               authz-obj-y \
+              crypto-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
-               crypto-obj-y \
                io-obj-y \
                common-obj-y \
                common-obj-m)
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
deleted file mode 100644
index fe8b2eadf7..0000000000
--- a/crypto/Makefile.objs
+++ /dev/null
@@ -1,34 +0,0 @@
-crypto-obj-y = init.o
-crypto-obj-y += hash.o
-crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
-crypto-obj-y += hmac.o
-crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
-crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
-crypto-obj-y += aes.o
-crypto-obj-y += desrfb.o
-crypto-obj-y += cipher.o
-crypto-obj-$(CONFIG_AF_ALG) += afalg.o
-crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
-crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
-crypto-obj-y += tlscreds.o
-crypto-obj-y += tlscredsanon.o
-crypto-obj-y += tlscredspsk.o
-crypto-obj-y += tlscredsx509.o
-crypto-obj-y += tlssession.o
-crypto-obj-y += secret.o
-crypto-obj-y += pbkdf.o
-crypto-obj-$(CONFIG_NETTLE) += pbkdf-nettle.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += pbkdf-gcrypt.o
-crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += pbkdf-stub.o
-crypto-obj-y += ivgen.o
-crypto-obj-y += ivgen-essiv.o
-crypto-obj-y += ivgen-plain.o
-crypto-obj-y += ivgen-plain64.o
-crypto-obj-y += afsplit.o
-crypto-obj-$(CONFIG_QEMU_PRIVATE_XTS) += xts.o
-crypto-obj-y += block.o
-crypto-obj-y += block-qcow.o
-crypto-obj-y += block-luks.o
diff --git a/crypto/meson.build b/crypto/meson.build
index 7250ffc9ca..d11b34f61e 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -1,3 +1,51 @@
+crypto_ss = ss.source_set()
+crypto_ss.add(genh)
+crypto_ss.add(files(
+  'afsplit.c',
+  'block-luks.c',
+  'block-qcow.c',
+  'block.c',
+  'cipher.c',
+  'desrfb.c',
+  'hash.c',
+  'hmac.c',
+  'ivgen-essiv.c',
+  'ivgen-plain.c',
+  'ivgen-plain64.c',
+  'ivgen.c',
+  'pbkdf.c',
+  'secret.c',
+  'tlscreds.c',
+  'tlscredsanon.c',
+  'tlscredspsk.c',
+  'tlscredsx509.c',
+  'tlssession.c',
+))
+
+if 'CONFIG_GCRYPT' in config_host
+  wo_nettle = files('hash-gcrypt.c', 'pbkdf-gcrypt.c')
+else
+  wo_nettle = files('hash-glib.c', 'pbkdf-stub.c')
+endif
+if 'CONFIG_GCRYPT_HMAC' not in config_host
+  wo_nettle += files('hmac-glib.c')
+endif
+crypto_ss.add(when: [nettle, 'CONFIG_NETTLE'],
+             if_true: files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'),
+             if_false: wo_nettle)
+
+crypto_ss.add(when: 'CONFIG_QEMU_PRIVATE_XTS', if_true: files('xts.c'))
+crypto_ss.add(when: 'CONFIG_GCRYPT_HMAC', if_true: files('hmac-gcrypt.c'))
+crypto_ss.add(when: 'CONFIG_AF_ALG', if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
+
+crypto_ss = crypto_ss.apply(config_host, strict: false)
+libcrypto = static_library('crypto', crypto_ss.sources(),
+                           dependencies: [crypto_ss.dependencies()],
+                           name_suffix: 'fa',
+                           build_by_default: false)
+
+crypto = declare_dependency(link_whole: libcrypto)
+
 util_ss.add(files('aes.c'))
 util_ss.add(files('init.c'))
 if 'CONFIG_GCRYPT' in config_host
diff --git a/meson.build b/meson.build
index 218c495063..f11c474302 100644
--- a/meson.build
+++ b/meson.build
@@ -276,6 +276,8 @@ subdir('qobject')
 subdir('stubs')
 subdir('trace')
 subdir('util')
+subdir('qom')
+subdir('authz')
 subdir('crypto')
 subdir('ui')
 
@@ -291,8 +293,6 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
-subdir('qom')
-subdir('authz')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/meson.build b/qom/meson.build
index 3c41ed37e4..4af044d858 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -1,4 +1,5 @@
 qom_ss = ss.source_set()
+qom_ss.add(genh)
 qom_ss.add(files(
   'container.c',
   'object.c',
@@ -9,7 +10,6 @@ qom_ss.add(files(
 qom_ss = qom_ss.apply(config_host, strict: false)
 libqom = static_library('qom', qom_ss.sources(),
                         dependencies: [qom_ss.dependencies()],
-                        link_with: [libqemuutil],
                         name_suffix: 'fa')
 
 qom = declare_dependency(link_whole: libqom)
-- 
2.21.0



