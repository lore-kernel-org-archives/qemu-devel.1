Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC114C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDB820716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyDcpvJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDB820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVWy-0004WH-Uh
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4m-0007Sn-99
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4j-0000vS-46
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4i-0000u0-TK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id t23so3523017wmi.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PrREOzGlC8UTQY/8R3lPzuUNWu2GYWSoDDy9DYpF2l4=;
 b=VyDcpvJ9WJmr96btdcukNT6lmgvuYZybYUVOJxMC4ttlHf5BkfbgWRLPR2171yCaMg
 R7ZptyTmzVzzQi2IU7XRenrQOyC9UI17fhTWMHV6oxX0gxn/QWnPJpUaiZdQK6UEJP7U
 KU6NWt0ha31tzE10+ZrDKyGH3sgEKLYOEjNTE6qaoe6eqC9u7jqdoDVf2RJIfcSgGYBc
 msytnscB8JkpBYQKjnjn1I31BX7xhMEnjmDUU6Add4wwl/lPORz38irTgng9lgOMu6Uy
 OJ8ZUfbk22mKDcTumQ2E37E5Rt2dy+JLDKSpi9Ekq4e7u4xoEKCKpO9mljQKrxkFRMru
 rFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PrREOzGlC8UTQY/8R3lPzuUNWu2GYWSoDDy9DYpF2l4=;
 b=IVbGYZxjqsCBZi61dhGSIyZtk6U7xRwymv3nFNj/QFbDjK22JO/fmHcXxmyJU7lAaX
 uyJcmPHIf8UYqZi6AKMg9Oz5aG9+ffhzwncGxNPymuhznc8165sZ/aYVepuILNO2FrYP
 W5k4tF56aAWX9ADB4OLfroEaa5QVAqwTqusC/V5Ls3htqOFaiJFJ8uewnaKTG8ZxcX3P
 O9hX0rsWqt0obUOtEEtnfmf0FKiMMN3W3rbgA1GMV7Xd2etIs8qimWK6LQHkC2SHIX+k
 7xOzQXeU117oB0Cdby7Pghf9HjzCdNybQo9zyWF+YW9be57Q+Z1n7x9MUzwnq5Hx5UPY
 UrdA==
X-Gm-Message-State: APjAAAWn45HjN7RgptfwMGi6tyxnDSsqKzXnC/L7Z3v6WsLpKRdBgPlH
 i+ta5IeMfc2sdSRuQSFhzi35ie9A
X-Google-Smtp-Source: APXvYqzZUrBcg46cGJTQJ37Ua2sBRemOTBjbmi1z3sXrQsbvlTsY1nuRxrQKwBlggIaGQLFBPgtL+A==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr5982741wmg.147.1580234095819; 
 Tue, 28 Jan 2020 09:54:55 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 028/142] meson: add qemu-bridge-helper
Date: Tue, 28 Jan 2020 18:51:48 +0100
Message-Id: <20200128175342.9066-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 Makefile    |  4 ----
 configure   |  1 +
 meson.build | 12 +++++++++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index b37312f2fb..69105cdfac 100644
--- a/Makefile
+++ b/Makefile
@@ -183,8 +183,6 @@ LIBS+=-lz $(LIBS_TOOLS)
 vhost-user-json-y =
 HELPERS-y =
 
-HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
-
 ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
 vhost-user-json-y += contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
@@ -403,8 +401,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
-
 qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 
 qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
diff --git a/configure b/configure
index 78cc3451ad..5a78782c25 100755
--- a/configure
+++ b/configure
@@ -6757,6 +6757,7 @@ if test "$l2tpv3" = "yes" ; then
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
+  echo "LIBCAP_NG_LIBS=$cap_libs" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/meson.build b/meson.build
index 8709847493..79919df761 100644
--- a/meson.build
+++ b/meson.build
@@ -56,6 +56,10 @@ if 'CONFIG_GNUTLS' in config_host
 endif
 pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
                             link_args: config_host['PIXMAN_LIBS'].split())
+libcap_ng = declare_dependency()
+if 'CONFIG_LIBCAP_NG' in config_host
+  libcap_ng = declare_dependency(link_args: config_host['LIBCAP_NG_LIBS'].split())
+endif
 rt = cc.find_library('rt', required: false)
 libiscsi = declare_dependency()
 if 'CONFIG_LIBISCSI' in config_host
@@ -228,7 +232,6 @@ qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: version_res)
 
 # Other build targets
-
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
 endif
@@ -247,6 +250,13 @@ if have_tools
     subdir('contrib/vhost-user-scsi')
   endif
 
+  if host_machine.system() == 'linux'
+    executable('qemu-bridge-helper', files('qemu-bridge-helper.c'),
+               dependencies: [qemuutil, libcap_ng],
+               install: true,
+               install_dir: get_option('libexecdir'))
+  endif
+
   if 'CONFIG_IVSHMEM' in config_host
     subdir('contrib/ivshmem-client')
     subdir('contrib/ivshmem-server')
-- 
2.21.0



