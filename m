Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB2DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486D320760
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT+wSmKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486D320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gc4-0006Wu-GO
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH4-0004JJ-QF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH2-00069R-Ur
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id z18so15241761wrm.12
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qOKJ+Ver4XgMvPbsJwwjCcehhxtmfHeXcEultQ+LU6o=;
 b=lT+wSmKGQtylt7hUnexQEIWXYMHF7+hW5f0UPSYXJCnLtEVtr307t4xjhXpRUQ3yoj
 3oYpZKGG2Wp9TyPz7FCDdBTZA7LVF14rQ6pYqDeqVa8JtPMKGamDKT1Ul7aishUQZsTQ
 /ER6814dovQsDNGRTeDEsuxfr6XuSptZ0xWfnSarK+b4vJOlzuZ5DpFx3NCeSsqwxjgy
 gN//3oEzGU6IaKClu/ZrBUPSLDD4kdKA6NhL+8GTkym+fQcL5pKFavwa1k6HLkjxCTrx
 +cnqpmCplW4Qp2uApMxuFEaRVFiVMbVY29GjT7ObBx3DdX4jWumpZLuJX0I8aLBNv31/
 5RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qOKJ+Ver4XgMvPbsJwwjCcehhxtmfHeXcEultQ+LU6o=;
 b=KGSpjZYnrSdPn4TlssUgYYzLPLpsZTXPONTadbMl46Z8CscwnOOjz7rAkdeJHu1QPH
 RNFiaYVLFM+66YOy2VUef3iZ30U4Ecpa9JkmjBjt/pr47PKHSS/Dzk4oK+Cb8FskRg/H
 Kd9Z7bQcZez90UWR0mO5/Bpk6xKqn6fq58x+zouIGX0EgzDno2whYbf1WW8aq6FKS7HF
 czIH/GpqA2BpzJ+YbavQ0XceM7Gu0Se+nStSmOHDmTZvCDfS46tTTQS0DN6EnsmcCnr4
 N47t6hCIOYGSw3paAKXwXulFz9ENSwBlBsOLCy0kSEvPJMnNt++0WE24cW4BLifMm4E8
 BSOQ==
X-Gm-Message-State: AOAM531TW2ek/C+VSBREE/IgpBb18gF/PMo+tT127PwsI6B6Hy7LQX5r
 8byQRqusEkOu56V3brYwmWeolh0SNd4=
X-Google-Smtp-Source: ABdhPJxTGc1xCE/WybpERzW3frl0AAD0SeMQ4930w57KKhJ3Dn8FzvX35gSFSzaW2CsLfKHN5n0bJQ==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr16077523wrv.317.1597675086539; 
 Mon, 17 Aug 2020 07:38:06 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 041/150] meson: add msi generation
Date: Mon, 17 Aug 2020 16:35:34 +0200
Message-Id: <20200817143723.343284-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x432.google.com
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
 Makefile                  | 18 ------------------
 qga/meson.build           | 25 +++++++++++++++++++++++++
 qga/vss-win32/meson.build |  3 ++-
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 9b35c0d00a..a46b31b907 100644
--- a/Makefile
+++ b/Makefile
@@ -439,23 +439,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
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
@@ -471,7 +454,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	rm -f qemu-options.def
-	rm -f *.msi
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
diff --git a/qga/meson.build b/qga/meson.build
index 948302e06d..2d33c09fe6 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -48,5 +48,30 @@ qga = executable('qemu-ga', qga_ss.sources(),
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
index 42c8d31a3d..1f39e05335 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -2,7 +2,8 @@ if add_languages('cpp', required: false)
   glib_static = dependency('glib-2.0', static: true)
   link_args = cc.get_supported_link_arguments(['-fstack-protector-all', '-fstack-protector-strong',
                                                '-Wl,--add-stdcall-alias', '-Wl,--enable-stdcall-fixup'])
-  shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
+
+  qga_vss = shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
                 name_prefix: '',
                 cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
                 link_args: link_args,
-- 
2.26.2



