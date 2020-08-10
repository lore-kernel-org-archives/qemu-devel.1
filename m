Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE242080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKCs2wUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE242080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CEH-0003lq-P8
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLz-0003Y6-Uw
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BLx-0003NO-SH
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi1yBhTiJxBmEAtjHe8ER84d9T1BH/tlS2/NzYfm/KE=;
 b=JKCs2wUN0q1xYhRvofjr/oeKJPR7xTyoI8jzt5q4dvCLXV8xlWVQCyQNN7PKY9pRLPp2d2
 f1JH0pGH2xQGLVA7iyA9dg1/KzkjySJRxgUAMiYUVKu8hN+5tRRHrjV0iHhamL369pwTGZ
 Udpa/K3WXLypY3zE2lNcufKLCM/h5VE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-gP6xMOF_MMKMMgFlxzsz2Q-1; Mon, 10 Aug 2020 13:12:51 -0400
X-MC-Unique: gP6xMOF_MMKMMgFlxzsz2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F54106B244
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:50 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71C9187D64;
 Mon, 10 Aug 2020 17:12:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 134/147] remove Makefile.target
Date: Mon, 10 Aug 2020 19:08:52 +0200
Message-Id: <1597079345-42801-135-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile        | 53 ++++-------------------------------------------------
 Makefile.target | 12 ------------
 configure       |  2 --
 3 files changed, 4 insertions(+), 63 deletions(-)
 delete mode 100644 Makefile.target

diff --git a/Makefile b/Makefile
index 2962a41..2297712 100644
--- a/Makefile
+++ b/Makefile
@@ -163,17 +163,6 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
-config-host.h: config-host.h-timestamp
-config-host.h-timestamp: config-host.mak
-
-TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
-
-.PHONY: $(TARGET_DIRS_RULES)
-# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
-# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
-$(TARGET_DIRS_RULES): $(TARGET_DEPS)
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
-
 # LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
@@ -210,8 +199,6 @@ slirp/all: .git-submodule-status
 		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
 		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
-$(filter %/all, $(TARGET_DIRS_RULES)):
-
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -219,11 +206,9 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 $(ROM_DIRS_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
 
-.PHONY: recurse-all recurse-clean recurse-install
-recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-install: $(addsuffix /install, $(TARGET_DIRS))
-$(addsuffix /install, $(TARGET_DIRS)): all
+.PHONY: recurse-all recurse-clean
+recurse-all: $(ROM_DIRS)
+recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 
 ######################################################################
 
@@ -273,9 +258,6 @@ distclean: clean
 	$(call clean-manual,system)
 	$(call clean-manual,tools)
 	$(call clean-manual,user)
-	for d in $(TARGET_DIRS); do \
-	rm -rf $$d || exit 1 ; \
-        done
 	rm -Rf .sdk
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
@@ -379,8 +361,7 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 # Needed by "meson install"
 export DESTDIR
 install: all $(if $(BUILD_DOCS),install-doc) \
-	install-datadir install-localstatedir \
-	recurse-install
+	install-datadir install-localstatedir
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
@@ -410,9 +391,6 @@ endif
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
-	for d in $(TARGET_DIRS); do \
-	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
-        done
 
 # documentation
 MAKEINFO=makeinfo
@@ -527,20 +505,6 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
 
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 
-# Reports/Analysis
-
-%/coverage-report.html:
-	@mkdir -p $*
-	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) \
-		$(foreach t, $(TARGET_DIRS), --object-directory $(BUILD_DIR)/$(t)) \
-		 --object-directory $(BUILD_DIR) \
-		-p --html --html-details -o $@, \
-		"GEN", "coverage-report.html")
-
-.PHONY: coverage-report
-coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-
 ifdef CONFIG_WIN32
 
 INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
@@ -628,15 +592,6 @@ endif
 	$(call print-help,cscope,Generate cscope index)
 	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
-	@$(if $(TARGET_DIRS), \
-		echo 'Architecture specific targets:'; \
-		$(foreach t, $(TARGET_DIRS), \
-		$(call print-help-run,$(t)/all,Build for $(t)); \
-		$(if $(CONFIG_FUZZ), \
-			$(if $(findstring softmmu,$(t)), \
-				$(call print-help-run,$(t)/fuzz,Build fuzzer for $(t)); \
-		))) \
-		echo '')
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/Makefile.target b/Makefile.target
deleted file mode 100644
index a07149c..0000000
--- a/Makefile.target
+++ /dev/null
@@ -1,12 +0,0 @@
-# -*- Mode: makefile -*-
-
-BUILD_DIR?=$(CURDIR)/..
-
-include ../config-host.mak
-include config-target.mak
-include $(SRC_PATH)/rules.mak
-
-all:
-install: all
-	
-.PHONY: all clean install
diff --git a/configure b/configure
index 23e93aa..21b9ed2 100755
--- a/configure
+++ b/configure
@@ -8096,8 +8096,6 @@ if [ "$TARGET_SYSTBL_ABI" != "" ] && [ "$TARGET_SYSTBL" = "" ]; then
   TARGET_SYSTBL=syscall.tbl
 fi
 
-symlink "$source_path/Makefile.target" "$target_dir/Makefile"
-
 upper() {
     echo "$@"| LC_ALL=C tr '[a-z]' '[A-Z]'
 }
-- 
1.8.3.1



