Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78997C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4694421655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHf21q0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4694421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOGC-0007nH-Uv
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyE-0003Hx-S2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyD-0006TC-EY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyD-0006RG-68
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:29 -0500
Received: by mail-wm1-x334.google.com with SMTP id p9so2247547wmc.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TtsZenLOjhtMivOafiVAH9+nVf02IjMWlP1Q3QoXfuk=;
 b=nHf21q0zmfdIQhkCw2bBgaSNZo62OAAiyFfGpLVYmAbw8JYPxrhrROnCsqBUx4ngTl
 /to9W5ZihlV2OB98MoTwl7Zp561yefMVAjZv3pTvTEZsVUEGddmdYSDJrM1n0hcfGp2q
 psYkO4LfuDcCGFS7dOXCjl35UxzCKPDhxK5znxvPSCmw4QlcTSZTDHXoiYbyXBtwe5/y
 MY++Xm1+cZ6MA2bN5x1cq8dhBLW0Wi1amBT5F8/+gGo08T0NhaeVNQAZs4yMD/UoGTMo
 qhxWb7CIb1WAAfyIUts1G3yuXlr5AXxfQiKBXF8CPXnfyZet+nQFg9YllboIf5bv0Sra
 0u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TtsZenLOjhtMivOafiVAH9+nVf02IjMWlP1Q3QoXfuk=;
 b=jRqytIgl5T3Ikdq3Kn6KWjTwognJcq652wWw3/8sZ/Ixs1AffU1wXUe8Sm23tvYeay
 ITvZKDHeyTSiSgz2c/dJynVvEtUv6Xkx6CI3ynHy9bAfW59X6PFDki2tmFNnAOLLWOpa
 HhEVk30y3mbEWOUH5fy00UtMSjJRl04IZA/Dfor8PKHFUB7vGI5CyYYKC2jk6s19dG/i
 /mX6nmsah90HUHAMi8YFq8/eircY4lM+mmLPA9F4Cw/ac6ShJmgpibFaiX3FzohP1poe
 NRBp4UQCUyuK7bNsEbzfby4wYXRnsEGUTjkyARRwQs6toyhajY1MZajh8irf15hFT75+
 kz6A==
X-Gm-Message-State: APjAAAWyfBt2HymagS98dME+Zcjz9ojfU84H+FWaBgqDmynRMw9bNYJD
 Y5jLm6B61jFNWrqlL5dfvVwGF1Yo
X-Google-Smtp-Source: APXvYqyiwxpt1/Rb4ybO43wK0oxur81PBbpMUjnEAV6lfPAM9+ACXkbOzBZ5CVgxHrQ30guYuYCm/g==
X-Received: by 2002:a1c:1d16:: with SMTP id d22mr6696540wmd.158.1576155207966; 
 Thu, 12 Dec 2019 04:53:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 030/132] meson: generate hxtool files
Date: Thu, 12 Dec 2019 13:51:14 +0100
Message-Id: <1576155176-2464-31-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 Makefile        | 19 +------------------
 Makefile.target |  6 ------
 meson.build     | 35 +++++++++++++++++++++++++++++++++++
 scripts/hxtool  |  2 +-
 4 files changed, 37 insertions(+), 25 deletions(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/Makefile b/Makefile
index 472962d..7588467 100644
--- a/Makefile
+++ b/Makefile
@@ -96,7 +96,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y = config-host.h qemu-options.def
+generated-files-y = config-host.h
 
 generated-files-y += module_block.h
 
@@ -221,8 +221,6 @@ all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all mo
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
@@ -314,9 +312,6 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
-
 ifneq ($(EXESUF),)
 .PHONY: qga/qemu-ga
 qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
@@ -629,18 +624,6 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 	$(call build-manual,specs)
 
-qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor.texi: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
-qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@
 
diff --git a/Makefile.target b/Makefile.target
index c5af974..1f19d68 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -210,12 +210,6 @@ endif
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
-hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
-
-hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
-
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
diff --git a/meson.build b/meson.build
index 447a32c..de5a26e 100644
--- a/meson.build
+++ b/meson.build
@@ -113,6 +113,7 @@ have_block = have_system or have_tools
 
 # Generators
 
+hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/events.py',
@@ -123,6 +124,40 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/events.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
                      meson.source_root() / 'scripts/qapi-gen.py' ]
 
+hxdep = []
+hx_headers = [
+  ['qemu-options.hx', 'qemu-options.def'],
+  ['qemu-img-cmds.hx', 'qemu-img-cmds.h'],
+]
+if have_system
+  hx_headers += [
+    ['hmp-commands.hx', 'hmp-commands.h'],
+    ['hmp-commands-info.hx', 'hmp-commands-info.h'],
+  ]
+endif
+foreach d : hx_headers
+  custom_target(d[1],
+                input: files(d[0]),
+                output: d[1],
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                command: [hxtool, '-h', '@INPUT0@'])
+endforeach
+
+foreach d : [
+  ['qemu-options.hx', 'qemu-options.texi'],
+  ['hmp-commands.hx', 'qemu-monitor.texi'],
+  ['hmp-commands-info.hx', 'qemu-monitor-info.texi'],
+  ['qemu-img-cmds.hx', 'qemu-img-cmds.texi'],
+]
+  custom_target(d[1],
+                input: files(d[0]),
+                output: d[1],
+                capture: true,
+                build_by_default: true, # to be removed when added to a target
+                command: [hxtool, '-t', '@INPUT0@'])
+endforeach
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
diff --git a/scripts/hxtool b/scripts/hxtool
old mode 100644
new mode 100755
index 7d7c428..27cbab5
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -64,6 +64,6 @@ case "$1" in
 "-h") hxtoh ;;
 "-t") hxtotexi ;;
 *) exit 1 ;;
-esac
+esac < "$2"
 
 exit 0
-- 
1.8.3.1



