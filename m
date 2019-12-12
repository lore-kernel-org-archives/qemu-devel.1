Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1175C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6922C21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+xCY67z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6922C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOIS-0002Bv-Tl
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyK-0003SX-Aq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyI-0006fl-Ui
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:36 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyI-0006dx-ML
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id z7so2568152wrl.13
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A5otGqkyi8y7l7sbXLP+BCvpARxLg62OQnpw8ufGbb0=;
 b=W+xCY67zPwj7iA723++cTKN84pUSMVt1UXR76AyghXlQya3c6Om7B5JnldmNFjRh+7
 QIM2UVoeYkOHSJhWmbY5wwkj9Jy+ByufbnTkEkNvjM35N7PTyQQQczv57tfZScJT1nLu
 BACoHAAcZ/DsiuZnNRV6mBnxZ3SG4IMPzGUemKaUacK1qcsalftBYXfxiCKE9TPJqtdi
 fEuG2BB5bfo0PIhrA5dq07ClaKdiYpxIicsfveUCUiZFDjYiSTJOUT9qwcKb5P+kkNRX
 mpkbdUmfWlMbO9WG5Lq2DZz1I9pE2YAztHMNBe7teIgpP42wwWtTDllUeP/Z+VMwwIxa
 AzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=A5otGqkyi8y7l7sbXLP+BCvpARxLg62OQnpw8ufGbb0=;
 b=XgtRCuO8mAeISKc94ijADa0pCjhb67CAGVsDDSa9omagFNoaFWj3kbpCbQuHDOfGKf
 GPapH86XsbdVEdJ5wvTIcLfG+0uaC8muJ082XDL84JUDj5ktjORudiS9JhmconRThlRm
 6M213LbfCFqJXVR/chCNHTFnh6IlVHqGo5QYFtvQRVIqWdJV13rpdLh/Ln6xpkOp1gOi
 FojjT4tW9+VFDz87KFRiGpecNHLykBAbEoLhHPpj96CYCtGk+8Es7mfFikoRlxfhcxHu
 0Tl7dl1/d9qU84hAXBu4R1fnjItvlK71CXhMX6rSd+UZJREF//DWhLMkm1K/xixN2yPn
 zuxg==
X-Gm-Message-State: APjAAAUrWHnu8rf0CmQaENPIqW1pgdKQRlvoekNA5hFd/jhCM8JHG/Mw
 zHS72qWf7hfx28mp52e0qPU9BhIr
X-Google-Smtp-Source: APXvYqw6PA5Vsv6HA7wIjLR3QgIqDq1KSM9+nPX3/ghJ3j0JrNsys1wGyJATimKqpekhRZQ8OXZCvg==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr6441261wrs.143.1576155213411; 
 Thu, 12 Dec 2019 04:53:33 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 036/132] meson: convert crypto directory to Meson
Date: Thu, 12 Dec 2019 13:51:20 +0100
Message-Id: <1576155176-2464-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  1 -
 Makefile.objs        |  7 ++-----
 Makefile.target      |  2 +-
 crypto/Makefile.objs | 34 ----------------------------------
 crypto/meson.build   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 meson.build          |  4 ++--
 qom/meson.build      |  2 +-
 7 files changed, 55 insertions(+), 44 deletions(-)
 delete mode 100644 crypto/Makefile.objs

diff --git a/Makefile b/Makefile
index 4da605e..d070335 100644
--- a/Makefile
+++ b/Makefile
@@ -200,7 +200,6 @@ dummy := $(call unnest-vars,, \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
-                crypto-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
diff --git a/Makefile.objs b/Makefile.objs
index 9201eca..a5dd228 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -14,16 +14,13 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 block-obj-m = block/
 
 #######################################################################
-# crypto-obj-y is code used by both qemu system emulation and qemu-img
-
-crypto-obj-y = crypto/
-
-#######################################################################
 # libraries built entirely from meson
 
 authz-obj-y = authz/libauthz.fa
 authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
 
+crypto-obj-y = crypto/libcrypto.fa
+
 qom-obj-y = qom/libqom.fa
 
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index d243e52..d8a6491 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -178,12 +178,12 @@ all-obj-y := $(obj-y)
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
index 3587f41..0000000
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
-crypto-obj-y += xts.o
-crypto-obj-y += block.o
-crypto-obj-y += block-qcow.o
-crypto-obj-y += block-luks.o
diff --git a/crypto/meson.build b/crypto/meson.build
index 7250ffc..1310195 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -1,3 +1,52 @@
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
+  'xts.c',
+))
+crypto_ss.add(authz)
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
index 9ae2699..e8bd526 100644
--- a/meson.build
+++ b/meson.build
@@ -260,6 +260,8 @@ subdir('qobject')
 subdir('stubs')
 subdir('trace')
 subdir('util')
+subdir('qom')
+subdir('authz')
 subdir('crypto')
 subdir('ui')
 
@@ -275,8 +277,6 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
-subdir('qom')
-subdir('authz')
 subdir('fsdev')
 
 # Other build targets
diff --git a/qom/meson.build b/qom/meson.build
index 3c41ed3..4af044d 100644
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
1.8.3.1



