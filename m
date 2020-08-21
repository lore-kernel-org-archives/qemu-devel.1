Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A220AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0C220738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNvguxeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0C220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94Wc-0007Tc-Ex
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dn-00022M-Ou
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dc-0001bq-VW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1eKXlbB816jcClyQPu9B+M57Kkv5rU72x2pi4DE9KbY=;
 b=dNvguxeOniKsOrDWa+tbWaUy3TcA9OxCzxo8tbwARQqmDXUuZxadncOM6Oy65J+/uWu6Az
 c07YGHH5VDL7QG1sdFkm+Tcih8oIEqQN4VEZ4BBDgTco2UqHLN02p1fyzSozun3OXNDLiR
 1BNhjXJvrJ5GVCJO6risbZLUmFdmnkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-SFeLRj52Og2qoX-RngwtPA-1; Fri, 21 Aug 2020 06:24:17 -0400
X-MC-Unique: SFeLRj52Og2qoX-RngwtPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B0A8030D0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50537756D7;
 Fri, 21 Aug 2020 10:24:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 052/152] meson: generate hxtool files
Date: Fri, 21 Aug 2020 06:21:49 -0400
Message-Id: <20200821102329.29777-53-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index e7394e748d..13df463e33 100644
--- a/Makefile
+++ b/Makefile
@@ -121,7 +121,7 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y = config-host.h qemu-options.def
+generated-files-y = config-host.h
 
 generated-files-y += module_block.h
 
@@ -263,8 +263,6 @@ all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all mo
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
 TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
@@ -371,9 +369,6 @@ ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
 endif
 
-qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
-	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
@@ -392,7 +387,6 @@ clean: recurse-clean ninja-clean clean-ctlist
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
index 2fb209b228..222b0d0e77 100644
--- a/meson.build
+++ b/meson.build
@@ -159,6 +159,7 @@ have_block = have_system or have_tools
 # Generators
 
 genh = []
+hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.pl')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
@@ -196,6 +197,27 @@ qemu_version = custom_target('qemu-version.h',
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



