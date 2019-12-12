Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83136C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5175C21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6vGaU0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifONu-0001QD-2u
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyJ-0003RB-Fd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyI-0006dm-1M
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyH-0006bs-QD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:33 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so2582748wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B5rFER0Twiseid0Ne5IXMB6XuEkYuqlRZvYswOTpzXY=;
 b=A6vGaU0a0SxiJDQics8YOWuSvqRdILwyfteVt974BZ/OYwUWZNE/tEyqC7LkZIgkbc
 RkEW4WLb2BOxZpdJrRS7nPOYAYcodF2IMm/PjKa2dNt3F3oT/fK5iTps/YsG4mvXjJDU
 t29GeVOWRkU0wH2WilqAorrpVS9z2XL9wyihLymYMzgRgd50jI24CI1a/nnHhuiYPtvT
 BmzxwnT1KodMLM6QVRl3+hCRNscgCl9+TNhQcotDB8tlwihf/5J68g12K5WQmSUBxuvq
 DK6rqrUbQir4U0VLCD/b3+NUwtfGkkpSJpt+vptsjeMqxoOrXhwWJ17xX1CNeIST03u0
 bvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B5rFER0Twiseid0Ne5IXMB6XuEkYuqlRZvYswOTpzXY=;
 b=uoFqQqdsk4ZzA3ajNj6KT5dp2SEFUNieOUTie5VYojuDXByDJa9YmU+eUMgKuyhBjK
 EVsBaPHu0XOyc+iQUqhMIjCtP/bylVrtYv9psYBo003HCBW+UdaWx19eX+OowkQmBhJK
 XTAfCyjE5oXatThcrE3XTV95x52IAR7TT50GjITV1NrgeOSkECgfu8PYzlxtOUloTo2L
 DDcRSy+OPcXrMxgxpPrXE2+/0iQ+wAu0axcPjwDwsDFzjgJRcJ/QsghoRSVshbbHJNBj
 KthFHLK+lzx45LbPCcUteof0QBIs4IdO+8WIKdwReL6K8niFOFC7o2pcS0/lRxWDZReh
 smww==
X-Gm-Message-State: APjAAAVojGkcfOap7kM+Krd66n1iUOv7/Efk5h7wKd2nAWtY+v5+isTc
 /sSJ5rVGikL8JywhPCt7mqo39+Z/
X-Google-Smtp-Source: APXvYqwVncLt2onOpGUgN1qgMcVDUbLU2HuwhX/FK2B+WIkO1njdtfxPpbsPn8JG7xKgr/igAjij8w==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr5995319wrt.208.1576155212589; 
 Thu, 12 Dec 2019 04:53:32 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 035/132] meson: convert authz directory to Meson
Date: Thu, 12 Dec 2019 13:51:19 +0100
Message-Id: <1576155176-2464-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Makefile            |  1 -
 Makefile.objs       |  8 +++-----
 Makefile.target     |  2 +-
 authz/Makefile.objs |  7 -------
 authz/meson.build   | 20 ++++++++++++++++++++
 meson.build         |  5 +++++
 6 files changed, 29 insertions(+), 14 deletions(-)
 delete mode 100644 authz/Makefile.objs
 create mode 100644 authz/meson.build

diff --git a/Makefile b/Makefile
index 9e9b2cf..4da605e 100644
--- a/Makefile
+++ b/Makefile
@@ -197,7 +197,6 @@ include $(SRC_PATH)/Makefile.objs
 endif
 
 dummy := $(call unnest-vars,, \
-                authz-obj-y \
                 chardev-obj-y \
                 block-obj-y \
                 block-obj-m \
diff --git a/Makefile.objs b/Makefile.objs
index b695319..9201eca 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -3,11 +3,6 @@
 chardev-obj-y = chardev/
 
 #######################################################################
-# authz-obj-y is code used by both qemu system emulation and qemu-img
-
-authz-obj-y = authz/
-
-#######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
 block-obj-y = nbd/
@@ -26,6 +21,9 @@ crypto-obj-y = crypto/
 #######################################################################
 # libraries built entirely from meson
 
+authz-obj-y = authz/libauthz.fa
+authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
+
 qom-obj-y = qom/libqom.fa
 
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index df3b14a..d243e52 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -177,9 +177,9 @@ all-obj-y := $(obj-y)
 
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call fix-paths,../,, \
+              authz-obj-y \
               qom-obj-y)
 dummy := $(call unnest-vars,.., \
-               authz-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
deleted file mode 100644
index ed7b273..0000000
--- a/authz/Makefile.objs
+++ /dev/null
@@ -1,7 +0,0 @@
-authz-obj-y += base.o
-authz-obj-y += simple.o
-authz-obj-y += list.o
-authz-obj-y += listfile.o
-authz-obj-$(CONFIG_AUTH_PAM) += pamacct.o
-
-pamacct.o-libs = -lpam
diff --git a/authz/meson.build b/authz/meson.build
new file mode 100644
index 0000000..a3de3d0
--- /dev/null
+++ b/authz/meson.build
@@ -0,0 +1,20 @@
+authz_ss = ss.source_set()
+authz_ss.add(genh)
+authz_ss.add(files(
+  'base.c',
+  'list.c',
+  'listfile.c',
+  'simple.c',
+))
+
+authz_ss.add(when: ['CONFIG_AUTH_PAM', pam], if_true: files('pamacct.c'))
+
+authz_ss = authz_ss.apply(config_host, strict: false)
+libauthz = static_library('authz', authz_ss.sources(),
+                          dependencies: [qom, authz_ss.dependencies()],
+                          name_suffix: 'fa',
+                          build_by_default: false)
+
+authz = declare_dependency(link_whole: libauthz)
+
+softmmu_ss.add(authz)
diff --git a/meson.build b/meson.build
index 36094fe..9ae2699 100644
--- a/meson.build
+++ b/meson.build
@@ -66,6 +66,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+pam = declare_dependency()
+if 'CONFIG_AUTH_PAM' in config_host
+  pam = cc.find_library('pam')
+endif
 libattr = declare_dependency()
 if 'CONFIG_ATTR' in config_host
   libattr = declare_dependency(link_args: config_host['LIBATTR_LIBS'].split())
@@ -272,6 +276,7 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
 subdir('qom')
+subdir('authz')
 subdir('fsdev')
 
 # Other build targets
-- 
1.8.3.1



