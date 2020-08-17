Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EFFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE043204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdj8mXuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE043204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ggW-0005nx-1X
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHI-0004w5-TB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHH-0006Bm-0W
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id y3so15281339wrl.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9j3aoWfTHUgC7jQe0Kp34kUY32UJw7xr9bRlvZsY4oY=;
 b=tdj8mXuqNZ43F+Kj0bNDbTuXWel470q51YNTF6+JchROQ00Wz5unAeSMZPKusTuN0u
 s9xQyBoyqn0tsXjT0V8suIsPl0Tezp2bQXa4sGuD5UYEHK90qeaL1LwpfXQ1EDK62pTJ
 bUMfMEnKY27PhI2Fp2x1H34emETOFvnak9xfCkXo05QmmYbKKIKyUD2RJf5J5oFPA9zp
 7Ekv9PIPCsPtKrkBiKRtleLkDYZBmoMaDsFDo7wlV1aeL8HKfWI7sAJgWheHO+XklyKe
 7jq2qKJRCerksmNVrUCvz9iBfquRxrNJ+qu/4lcnBcO89o5EG9z0CKQtCtjTzQG2Gz8H
 DNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9j3aoWfTHUgC7jQe0Kp34kUY32UJw7xr9bRlvZsY4oY=;
 b=mvKLmtWYvlX/C6/f+c2kMJ05RtKRej6JrvEyGaeaVI/x6ORkk5CgDBO3JFJNxOUUuR
 gPQu3kQWAPjxk1WpHEEYm1wq+HWwmanq2a/5tLEmnE8wyHjOCE4GQeLZUlSFGlj6w73s
 mOQIQMX4D+2tPs4Khm/AJT0wH+/UzI7mOiEZ8anajCJANnLIs6ANC3XiH+luH5t5rDgG
 Vnc2uaXXKFjdCf8emKtiASGu3KRJT7Yu5/hQwhl9GvCFxVO/ZNLhAQQsfdQspcP9zJ6h
 3rtKjvdCm5gFnVBKIsPq6WSSbimoDbQHT9EIofPYe/WZZUddSW5dcpJxBOgq3d2+lTu8
 6Vfg==
X-Gm-Message-State: AOAM531w5H4WwgiA5H35HsZAt0ocUkz7tZ9QONHY4yoTpe8ES/48WT2y
 HW+LNYmEJPcyuQe/aG9jMtpeb7JcsVU=
X-Google-Smtp-Source: ABdhPJySs7d+hoRtGR1XoJ0JnSB1H76mQLZjxfcL5154NaskAVSu8PJWgStzVMFwnDPQ/Ii0NQsPGQ==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr15326192wrn.51.1597675101203; 
 Mon, 17 Aug 2020 07:38:21 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 057/150] meson: convert crypto directory to Meson
Date: Mon, 17 Aug 2020 16:35:50 +0200
Message-Id: <20200817143723.343284-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42f.google.com
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  1 -
 Makefile.objs        |  2 +-
 Makefile.target      |  2 +-
 crypto/Makefile.objs | 37 -------------------------------
 crypto/meson.build   | 52 ++++++++++++++++++++++++++++++++++++++++++++
 meson.build          |  4 ++--
 qom/meson.build      |  2 +-
 7 files changed, 57 insertions(+), 43 deletions(-)
 delete mode 100644 crypto/Makefile.objs

diff --git a/Makefile b/Makefile
index 6051efe766..6995661e40 100644
--- a/Makefile
+++ b/Makefile
@@ -235,7 +235,6 @@ dummy := $(call unnest-vars,, \
                 block-obj-m \
                 storage-daemon-obj-y \
                 storage-daemon-obj-m \
-                crypto-obj-y \
                 io-obj-y \
                 common-obj-y \
                 common-obj-m)
diff --git a/Makefile.objs b/Makefile.objs
index 0bc361d338..018338d2db 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -19,7 +19,7 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
-crypto-obj-y = crypto/
+crypto-obj-y = crypto/libcrypto.fa
 
 io-obj-y = io/
 
diff --git a/Makefile.target b/Makefile.target
index 79b6e02bed..b213955a81 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -193,12 +193,12 @@ common-obj-m :=
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
index a9885919f2..0000000000
--- a/crypto/Makefile.objs
+++ /dev/null
@@ -1,37 +0,0 @@
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
-crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o
-crypto-obj-y += tlscreds.o
-crypto-obj-y += tlscredsanon.o
-crypto-obj-y += tlscredspsk.o
-crypto-obj-y += tlscredsx509.o
-crypto-obj-y += tlssession.o
-crypto-obj-y += secret_common.o
-crypto-obj-y += secret.o
-crypto-obj-$(CONFIG_SECRET_KEYRING) += secret_keyring.o
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
index 1b244315b9..7aab8db9f9 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -1,3 +1,55 @@
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
+  'secret_common.c',
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
+crypto_ss.add(when: 'CONFIG_SECRET_KEYRING', if_true: files('secret_keyring.c'))
+crypto_ss.add(when: 'CONFIG_QEMU_PRIVATE_XTS', if_true: files('xts.c'))
+crypto_ss.add(when: 'CONFIG_GCRYPT_HMAC', if_true: files('hmac-gcrypt.c'))
+crypto_ss.add(when: 'CONFIG_AF_ALG', if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
+crypto_ss.add(when: 'CONFIG_GNUTLS', if_true: files('tls-cipher-suites.c'))
+
+crypto_ss = crypto_ss.apply(config_host, strict: false)
+libcrypto = static_library('crypto', crypto_ss.sources(),
+                           dependencies: [crypto_ss.dependencies()],
+                           name_suffix: 'fa',
+                           build_by_default: false)
+
+crypto = declare_dependency(link_whole: libcrypto,
+                            dependencies: [authz, qom])
+
 util_ss.add(files('aes.c'))
 util_ss.add(files('init.c'))
 if 'CONFIG_GCRYPT' in config_host
diff --git a/meson.build b/meson.build
index e1fc4c2169..6b046f43aa 100644
--- a/meson.build
+++ b/meson.build
@@ -324,6 +324,8 @@ subdir('qobject')
 subdir('stubs')
 subdir('trace')
 subdir('util')
+subdir('qom')
+subdir('authz')
 subdir('crypto')
 subdir('storage-daemon')
 subdir('ui')
@@ -340,8 +342,6 @@ libqemuutil = static_library('qemuutil',
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
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
2.26.2



