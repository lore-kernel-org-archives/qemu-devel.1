Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E52C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF89720748
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1MLTzsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF89720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gYi-0006E3-5Y
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHC-0004fq-J7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHA-0006As-3T
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id c80so13420568wme.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/aH4iBKN922X2HXuFdePsCa+x0naNeFT1q3IhKpEgnE=;
 b=f1MLTzskyMTbf9k4N1vclGvbUjb/a97cLiP/xqYB7/91v4MPalv0kl3oFGS2SsioKN
 N7D/2sKHnA7nQD2wCJ4ZRcHniUhWm1cBNvnfXhaSQ485QRj+VklSilPT1P1tiuvhALXs
 Jb9sKpLsrMRRarDqs/cWHq9YMeajSUPA7vBHQ/6BW1H0YVmmnnf4a6ZjI6eb8UIeXfJa
 ZTDl4nS3lIhgwfAGqzb5tqaMGWZxVyN2mIoJLutx1bhrOKvkEhlrAfBeccVcJInjjH5Y
 knDx+R+r3tqwLY8ayIa629EurBbPsNpJkWeGskqdh6pseKyXebWzQ+7k4KfySMl33ckj
 Zniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/aH4iBKN922X2HXuFdePsCa+x0naNeFT1q3IhKpEgnE=;
 b=KxeAh9lUw94gDPhSYTXlqtoKpdgHpqNrnEa4aMe9eI1weRCkgxWETEhm1dIpoI2dQO
 ZQUgEHzb9Eyth6hb8fw/nVCV5EJY1e8MJs+JqqKk6/wMjUH83dOsBmqiLnEWTntDwOBm
 Yt67fs+ehwaaXqirmMzYnxTPk5xZnWs0YUjwemh3PqCw0/cFG1Wcy3MCoYItvmXPkKyE
 7/FFBgeK6EU41iIu/T7VP+g/03wpWvKaP3DEudCUzx23LDbtfOOTGF8ZfAYa0eO+tA0w
 EDtRDMIzfKQNXlozlSuYAk4vT3egg3fYpc6Fj7PW/74LOrAkh4pTjAQb9rVNeG10wgmR
 5Uaw==
X-Gm-Message-State: AOAM530pGFEnutktNsa5KWhoTy0khH6mvLlysjFUVHP29jQeQoGkxMoM
 MjFnU9GE19wWhYm0fpn0XKJ8HWQ3PmI=
X-Google-Smtp-Source: ABdhPJxyOPSzNI12lz6m4mOQvE6D4K3DZCytbxPUc90sjhP7F8+opznE20UeJ8adMz1FTg2ojC+Drw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr14679747wme.50.1597675094536; 
 Mon, 17 Aug 2020 07:38:14 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 050/150] meson: generate hxtool files
Date: Mon, 17 Aug 2020 16:35:43 +0200
Message-Id: <20200817143723.343284-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x336.google.com
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
 Makefile        |  8 +-------
 Makefile.target |  6 ------
 meson.build     | 22 ++++++++++++++++++++++
 scripts/hxtool  |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/Makefile b/Makefile
index 11f1845196..ca331b13dc 100644
--- a/Makefile
+++ b/Makefile
@@ -110,7 +110,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y = config-host.h qemu-options.def
+generated-files-y = config-host.h
 
 generated-files-y += module_block.h
 
@@ -252,8 +252,6 @@ all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all mo
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
@@ -360,9 +358,6 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
@@ -381,7 +376,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 	rm -f $(edk2-decompressed)
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
-	rm -f qemu-img-cmds.h
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f config-all-devices.mak
 	rm -f $(SUBDIR_DEVICES_MAK)
diff --git a/Makefile.target b/Makefile.target
index 0b323641bb..257afc2723 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -225,12 +225,6 @@ endif
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
index f9bcf04533..131ba26c1d 100644
--- a/meson.build
+++ b/meson.build
@@ -155,6 +155,7 @@ have_block = have_system or have_tools
 # Generators
 
 genh = []
+hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
@@ -192,6 +193,27 @@ qemu_version = custom_target('qemu-version.h',
                              build_always_stale: true)
 genh += qemu_version
 
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
+genh += hxdep
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
diff --git a/scripts/hxtool b/scripts/hxtool
old mode 100644
new mode 100755
index 7b1452f3cf..80516b9437
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -19,6 +19,6 @@ hxtoh()
 case "$1" in
 "-h") hxtoh ;;
 *) exit 1 ;;
-esac
+esac < "$2"
 
 exit 0
-- 
2.26.2



