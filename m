Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A219AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712B620716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOu4R78j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712B620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVWr-0004In-KN
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4i-0007OR-Hk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4h-0000r2-HC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4h-0000ko-AE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id g1so3494205wmh.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dpSAi521z8YHNBXKWiBmHfLRxFov0f4gbou1uTaVM70=;
 b=eOu4R78j8VFR/t+vJsyys8F/B3nWN4P/4LFjPgkrHG4OCJ/ge7zayWS4+UqJ5+t22Z
 0onWYf7vqIV/ogielBIGFNuClZui7DGS/8XBw8ijp8Pgv/J1xZZTZBVBVoxR6t691iy3
 W1w7VY4vCYDFujpXwgFNHBhB+GJMhERGKWhB0QmOscoqVkkFswmG68HBTslljRQfCAbC
 h+C3Mxxwb+EdVT2SlNfhtuzwphN5CFioRStAPcdr2KtlKWbzUtQzNzET13axyc5emJxl
 Q/R/EJkG3PMXFn+mpCyE8tRU2uQTfHWhL2Uw/viMNuYgs7Q6CdH9kQ3P+cC1eMPzDZGC
 XaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dpSAi521z8YHNBXKWiBmHfLRxFov0f4gbou1uTaVM70=;
 b=WjoxZByA2xXMvd3XKtOxgt6opQYJTUWcy96A8HJ6sU3m1CdHLHuKeMudfhOyxSwp3G
 e0YltAXWNX2ckopZD3BsGe9hPtxGwnLTJFV+olQeq9AZrSuxc1vPyn3+UixYvBgkUG8Z
 wBv+rK0vdGj0hVzek3qt0Yc36RSSwusX0fHjr1diLepdQbzL09ocm2nYpB64vX9JzZ21
 yufnTrSW/SSe8BvVmu2GFHf0NAS5DxhATUkuSNhZ67VzKE5t9aprMLr3q/wHg3qmdnuL
 OepohQilj7p7zuofFQ5m/iCVN2qSKUZJc2STu+ZzaxpAxdIm+3w6/fI+BnRLrMRi8m41
 dUYg==
X-Gm-Message-State: APjAAAVXpu5HZD+o3qDrprnDzAa8KYdIpg0ojf5lVjKqO8LBBaB1iyi0
 noEFbWrK6gvKtlB/Oqy10/c0Nrc7
X-Google-Smtp-Source: APXvYqxPHxpTFoXytmQFmKqNUde1fjWC0E7oUbvxAqMvCFTTuPag2fK8ApsLh+PPYeYZGY50LRMC/A==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr6186259wme.53.1580234093070; 
 Tue, 28 Jan 2020 09:54:53 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 027/142] meson: convert dummy Windows qga/qemu-ga target
Date: Tue, 28 Jan 2020 18:51:47 +0100
Message-Id: <20200128175342.9066-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                  | 5 -----
 qga/meson.build           | 4 ++++
 qga/vss-win32/meson.build | 1 +
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8d1028ed99..b37312f2fb 100644
--- a/Makefile
+++ b/Makefile
@@ -422,11 +422,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-ifneq ($(EXESUF),)
-.PHONY: qga/qemu-ga
-qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/qga/meson.build b/qga/meson.build
index e0e5344feb..f5f2dbd879 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -41,6 +41,7 @@ qga_ss = qga_ss.apply(config_host, strict: false)
 qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
                  dependencies: [qemuutil, libudev])
+all_qga = [qga]
 
 if host_machine.system() == 'windows'
   if 'CONFIG_QGA_VSS' in config_host
@@ -69,6 +70,9 @@ if host_machine.system() == 'windows'
                               config_host['QEMU_GA_MSI_WITH_VSS'].split(),
                               config_host['QEMU_GA_MSI_MINGW_DLL_PATH'].split(),
                             ])
+    all_qga += [qga-msi]
     alias_target('msi', qga_msi)
   endif
+
+  alias_target('qga/qemu-ga', all_qga)
 endif
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index 147a680d1f..f08001f338 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -8,6 +8,7 @@ if add_languages('cpp', required: false)
                 link_args: link_args,
                 vs_module_defs: 'qga-vss.def',
                 dependencies: glib_static)
+  all_qga += qga_vss
 endif
 
 # rules to build qga-vss.tlb
-- 
2.21.0



