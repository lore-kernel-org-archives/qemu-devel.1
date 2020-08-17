Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AEEC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2542072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chYGDpdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2542072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gY6-0004gK-ST
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH3-0004IH-6m
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gH1-00069D-B9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id f7so15275713wrw.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=alq3qkQflAS1MVNIYnc6+tQ6ioRrHZq26cXio83N7sg=;
 b=chYGDpdcH1xVDpbdj8P6Sbt56tA++Fz1lqsoLZD7fuN+uS7H6qqFgDexlY5Lds5pI6
 haFQCQGh5w0Np4KfFrcFiKcK3vGnWeQjJ6ehtTU7ZyACMn7dfpXJPN9C7IjINjfw6hGd
 0G1zrch53mgR0Bs5OdFN+76V7d70d/LVwZy/gePRl4JGvYiai8laPXs4c8gwrSIv+9IG
 Xvgy8jK+8CXW9QxP6KN3AFYBkOvPlf3zejSmmkdwO01G1GdhVk3/2tKRgQQzjO29tTf6
 k70Tvd2E6sWrZxAYQbNhwPq0ky3CJ8wpareg2IvpoGXmB+cnRVTdO6v1b3pNFAL2vhYI
 uVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=alq3qkQflAS1MVNIYnc6+tQ6ioRrHZq26cXio83N7sg=;
 b=niiKpNOJTTN1zXeKgUD9t3uRo+zVzqzQlHMNqB9IRoLxhPSd4Vez1GwmsmTOFTLfPs
 JbcRf9t87wH3YRrRNiLoiKoAbqY1/3hOWfLO3ClWnmy15OUStJ2qIeFe24epseUqLR8E
 WiutL/svEABFVC/D9VdNc/quAZ4+yOBX8giLWntofzPEs2qg03GH2lMM3yl0JnFPn/W/
 WMBQmSFFgWCTxgqegQrl9ZTgyUw+8lylY5WkXpOzKnKVrwMd4UrdhVpyWgc5ojVQrBJX
 NjpmOFjfRWpbolGjwSTHaGbpyxlLMIpU0WJSWG8piBSpiWH1NgQUMx4qX3Rf0C0GUprZ
 7TDQ==
X-Gm-Message-State: AOAM5311B7RH+50OwDLdO02oDsrMpnbUC7/omp3iDqOTF+d/cbAo49HX
 P5HAPMfyM7dGmpvKW8jOmqZ3+3QyE9M=
X-Google-Smtp-Source: ABdhPJz5w94neA0VwO3r4+iMbe3TbPZznURWvI5g0DU98W+dWq7QjbuugEoUCrd6/N/7ZsbKiYA6lQ==
X-Received: by 2002:adf:c401:: with SMTP id v1mr15100517wrf.379.1597675085720; 
 Mon, 17 Aug 2020 07:38:05 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 040/150] meson: convert vss-win32
Date: Mon, 17 Aug 2020 16:35:33 +0200
Message-Id: <20200817143723.343284-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x434.google.com
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
 Makefile                    |  1 -
 Makefile.objs               |  8 --------
 qga/Makefile.objs           |  1 -
 qga/meson.build             |  6 ++++++
 qga/vss-win32/Makefile.objs | 23 -----------------------
 qga/vss-win32/meson.build   | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 39 insertions(+), 33 deletions(-)
 delete mode 100644 qga/Makefile.objs
 delete mode 100644 qga/vss-win32/Makefile.objs
 create mode 100644 qga/vss-win32/meson.build

diff --git a/Makefile b/Makefile
index 174d1ecc4f..9b35c0d00a 100644
--- a/Makefile
+++ b/Makefile
@@ -290,7 +290,6 @@ endif
 dummy := $(call unnest-vars,, \
                 authz-obj-y \
                 chardev-obj-y \
-                qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
                 storage-daemon-obj-y \
diff --git a/Makefile.objs b/Makefile.objs
index 259f9936ac..baf15656e8 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -91,11 +91,3 @@ common-obj-y += disas/
 ######################################################################
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
-
-######################################################################
-# guest agent
-
-# FIXME: a few definitions from qapi/qapi-types.o and
-# qapi/qapi-visit.o are needed by libqemuutil.a.  These should be
-# extracted into a QAPI schema module, or perhaps a separate schema.
-qga-vss-dll-obj-y = qga/
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
deleted file mode 100644
index 9ecf2496da..0000000000
--- a/qga/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-qga-vss-dll-obj-$(CONFIG_QGA_VSS) += vss-win32/
diff --git a/qga/meson.build b/qga/meson.build
index 3513a90f5d..948302e06d 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -44,3 +44,9 @@ qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
                  dependencies: [qemuutil, libudev],
                  install: true)
+
+if host_machine.system() == 'windows'
+  if 'CONFIG_QGA_VSS' in config_host
+    subdir('vss-win32')
+  endif
+endif
diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
deleted file mode 100644
index c82676aeb8..0000000000
--- a/qga/vss-win32/Makefile.objs
+++ /dev/null
@@ -1,23 +0,0 @@
-# rules to build qga-vss.dll
-
-qga-vss-dll-obj-y += requester.o provider.o install.o
-
-obj-qga-vss-dll-obj-y = $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
-$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS := $(filter-out -fstack-protector-all -fstack-protector-strong, $(QEMU_CXXFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
-
-QGA_VSS_LDFLAGS = -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32 -static
-$(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.def
-	$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/vss-win32/qga-vss.def $(CXXFLAGS) $(QGA_VSS_LDFLAGS),"LINK","$(TARGET_DIR)$@")
-
-
-# rules to build qga-provider.tlb
-# Currently, only native build is supported because building .tlb
-# (TypeLibrary) from .idl requires WindowsSDK and MIDL (and cl.exe in VC++).
-MIDL=$(WIN_SDK)/Bin/midl
-
-$(obj)/qga-vss.tlb: $(SRC_PATH)/$(obj)/qga-vss.idl
-ifeq ($(WIN_SDK),"")
-	$(call quiet-command,cp $(dir $<)qga-vss.tlb $@,"COPY","$(TARGET_DIR)$@")
-else
-	$(call quiet-command,$(MIDL) -tlb $@ -I $(WIN_SDK)/Include $<,"MIDL","$(TARGET_DIR)$@")
-endif
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
new file mode 100644
index 0000000000..42c8d31a3d
--- /dev/null
+++ b/qga/vss-win32/meson.build
@@ -0,0 +1,33 @@
+if add_languages('cpp', required: false)
+  glib_static = dependency('glib-2.0', static: true)
+  link_args = cc.get_supported_link_arguments(['-fstack-protector-all', '-fstack-protector-strong',
+                                               '-Wl,--add-stdcall-alias', '-Wl,--enable-stdcall-fixup'])
+  shared_module('qga-vss', ['requester.cpp', 'provider.cpp', 'install.cpp'],
+                name_prefix: '',
+                cpp_args: ['-Wno-unknown-pragmas', '-Wno-delete-non-virtual-dtor', '-Wno-non-virtual-dtor'],
+                link_args: link_args,
+                vs_module_defs: 'qga-vss.def',
+                dependencies: [glib_static, socket,
+                               cc.find_library('ole32'),
+                               cc.find_library('oleaut32'),
+                               cc.find_library('shlwapi'),
+                               cc.find_library('uuid'),
+                               cc.find_library('intl')])
+endif
+
+# rules to build qga-vss.tlb
+# Currently, only native build is supported because building .tlb
+# (TypeLibrary) from .idl requires WindowsSDK and MIDL (and cl.exe in VC++).
+midl = find_program('midl', required: false)
+if midl.found()
+  gen_tlb = custom_target('gen-tlb',
+                          input: 'qga-vss.idl',
+                          output: 'qga-vss.tlb',
+                          command: [midl, '-tlb', '-I' + config_host['WIN_SDK'],
+                                     '@INPUT@', '@OUTPUT@'])
+else
+  gen_tlb = custom_target('gen-tlb',
+                          input: 'qga-vss.tlb',
+                          output: 'qga-vss.tlb',
+                          command: ['cp', '@INPUT@', '@OUTPUT@'])
+endif
-- 
2.26.2



