Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC26C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E38C20716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaKcZkm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E38C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVVr-0002Wn-Nu
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4i-0007OS-Ls
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4f-0000mL-VG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4f-0000go-NW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:53 -0500
Received: by mail-wr1-x432.google.com with SMTP id k11so2417337wrd.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cKZ7iCBoD4ASrJyoMF6X0ZYunMkDAxdntngC0RA+3Os=;
 b=ZaKcZkm2+bMHc9u5artT9AZP1wH5kMi/lT5osF4jBrhu8o0x+KDg3HpXmQSW/bXtzr
 yuWkIPM5EP/MdVCb9Rwc5GaZszmCZ5qAxLvY7vsR93+P9Uecy9VHn+hfaK2noWHqdqIS
 6YtDT6xGgQad8EyXZj2nQR63k/59lOaM2hMI5g1kLvV94wu+YNNErf5PGNspWzsz83HM
 1vyUNwHJkV0qSXy5KaSKMDN60sLlpC/drJ+IlUNWPshgZmLab7c815NqeSajcJAfEClJ
 hcXCZ+vUoGx6RR/8N72D/EOX7DuScWZhnl2xZs3PfVArq9JRlbQnhA+UhH98CkdYzTbb
 ATAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cKZ7iCBoD4ASrJyoMF6X0ZYunMkDAxdntngC0RA+3Os=;
 b=ufCKcmVQWttEvTRNqwYthTOI76DS8bwRoYZHPS5m/4Iuwe2n5xtD4N72QlQvhjfSO+
 xvLXpW7zqnw8gB05Q8gp9rtR4Vw904Bpk82lnpIVnhPqeE0hgfysdbGXlkPA1m7hJban
 woZjh35cq1pToBELmHvU7UnKeIrnPpKnmt6pBw1tsu8M+WTyxy3uV0tWTa/XOVdCWUo9
 7lfXsV5o7S4vMrh5aQ4aY5etOnXztUphkxRdDxmioT6f7OOHesWx8IOCXRnqDCtbKShj
 Hz8avjTFdy2hjnhGdqQLnlDNWpJBLfb6mdaIob3IDxcGqY3vwGgSgir6tglnO2gNzpTL
 Y+lw==
X-Gm-Message-State: APjAAAWFRy2iGpRIQAP4QxExxbb2B0kB2MrJLS/vbrmVdQ4wpoeozvmr
 0IY3GHt9g0L5jo5g4atbgPfC1tOR
X-Google-Smtp-Source: APXvYqwfXB8lhYWkwSWpnqsNYiqiATURITdUCBX1c2GrnKf0AgRebcNiNCplv5I3xo9UVblXZYq2wg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id
 i3mr29586527wrx.244.1580234091403; 
 Tue, 28 Jan 2020 09:54:51 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 026/142] meson: add msi generation
Date: Tue, 28 Jan 2020 18:51:46 +0100
Message-Id: <20200128175342.9066-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
 Makefile                  | 18 ------------------
 qga/meson.build           | 25 +++++++++++++++++++++++++
 qga/vss-win32/meson.build |  2 +-
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 5ddec3a5da..8d1028ed99 100644
--- a/Makefile
+++ b/Makefile
@@ -422,23 +422,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-ifdef QEMU_GA_MSI_ENABLED
-QEMU_GA_MSI=qemu-ga-$(ARCH).msi
-
-msi: $(QEMU_GA_MSI)
-
-$(QEMU_GA_MSI): qga/qemu-ga.exe $(QGA_VSS_PROVIDER)
-
-$(QEMU_GA_MSI): config-host.mak
-
-$(QEMU_GA_MSI):  $(SRC_PATH)/qga/installer/qemu-ga.wxs
-	$(call quiet-command,QEMU_GA_VERSION="$(QEMU_GA_VERSION)" QEMU_GA_MANUFACTURER="$(QEMU_GA_MANUFACTURER)" QEMU_GA_DISTRO="$(QEMU_GA_DISTRO)" BUILD_DIR="$(BUILD_DIR)" \
-	wixl -o $@ $(QEMU_GA_MSI_ARCH) $(QEMU_GA_MSI_WITH_VSS) $(QEMU_GA_MSI_MINGW_DLL_PATH) $<,"WIXL","$@")
-else
-msi:
-	@echo "MSI build not configured or dependency resolution failed (reconfigure with --enable-guest-agent-msi option)"
-endif
-
 ifneq ($(EXESUF),)
 .PHONY: qga/qemu-ga
 qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
@@ -453,7 +436,6 @@ clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	rm -f qemu-options.def
-	rm -f *.msi
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
diff --git a/qga/meson.build b/qga/meson.build
index f0ec8cf0d8..e0e5344feb 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -45,5 +45,30 @@ qga = executable('qemu-ga', qga_ss.sources(),
 if host_machine.system() == 'windows'
   if 'CONFIG_QGA_VSS' in config_host
     subdir('vss-win32')
+  else
+    gen_tlb = []
+  endif
+
+  wixl = find_program('wixl', required: false)
+  if wixl.found()
+    deps = [gen_tlb, qga]
+    if 'QEMU_GA_MSI_WITH_VSS' in config_host
+      deps += qga_vss
+    endif
+    qga_msi = custom_target('QGA MSI',
+                            input: files('installer/qemu-ga.wxs'),
+                            output: 'qemu-ga-@0@.msi'.format(config_host['ARCH']),
+                            depends: deps,
+                            command: [
+                              'QEMU_GA_VERSION=' + config_host['QEMU_GA_VERSION'],
+                              'QEMU_GA_MANUFACTURER=' + config_host['QEMU_GA_MANUFACTURER'],
+                              'QEMU_GA_DISTRO=' + config_host['QEMU_GA_DISTRO'],
+                              'BUILD_DIR=' + meson.build_root(),
+                              wixl, '-o', '@OUTPUT0@', '@INPUT0@',
+                              config_host['QEMU_GA_MSI_ARCH'].split(),
+                              config_host['QEMU_GA_MSI_WITH_VSS'].split(),
+                              config_host['QEMU_GA_MSI_MINGW_DLL_PATH'].split(),
+                            ])
+    alias_target('msi', qga_msi)
   endif
 endif
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index a7c865ffde..147a680d1f 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -2,7 +2,7 @@ if add_languages('cpp', required: false)
   glib_static = dependency('glib-2.0', static: true)
   link_args = cc.get_supported_link_arguments(['-fstack-protector-all', '-fstack-protector-strong', '-Wl,--add-stdcall-alias', '-Wl,--enable-stdcall-fixup'])
 
-  shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
+  qga_vss = shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
                 name_prefix: '',
                 cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
                 link_args: link_args,
-- 
2.21.0



