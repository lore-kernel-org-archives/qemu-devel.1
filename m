Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64814C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254212070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 21:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254212070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR1Ar-00056r-AZ
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 17:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s4-0006Wi-JW
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0s2-0001eo-Ic
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0ry-0001Wq-Nu
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97F493019880
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:08 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A09245C5B0;
	Wed, 15 May 2019 20:51:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:27 +0200
Message-Id: <1557953433-19663-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 15 May 2019 20:51:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/21] build: replace GENERATED_FILES by
 generated-files-y
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

When possible use generated-files-$(FLAG) to disable
some targets (like KEYCODEMAP_FILES).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190401141222.30034-3-lvivier@redhat.com>
---
 Makefile                   | 36 +++++++++++++++++-------------------
 Makefile.target            |  6 +++---
 target/s390x/Makefile.objs |  2 +-
 tests/Makefile.include     | 26 +++++++++++++-------------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index 66d5c65..d9a3040 100644
--- a/Makefile
+++ b/Makefile
@@ -101,7 +101,7 @@ QEMU_PKGVERSION := $(if $(PKGVERSION),$(PKGVERSION),$(shell \
 # Either "version (pkgversion)", or just "version" if pkgversion not set
 FULL_VERSION := $(if $(QEMU_PKGVERSION),$(VERSION) ($(QEMU_PKGVERSION)),$(VERSION))
 
-GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
+generated-files-y = qemu-version.h config-host.h qemu-options.def
 
 GENERATED_QAPI_FILES = qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
 GENERATED_QAPI_FILES += qapi/qapi-types.h qapi/qapi-types.c
@@ -121,20 +121,18 @@ GENERATED_QAPI_FILES += $(QAPI_MODULES:%=qapi/qapi-events-%.c)
 GENERATED_QAPI_FILES += qapi/qapi-introspect.c qapi/qapi-introspect.h
 GENERATED_QAPI_FILES += qapi/qapi-doc.texi
 
-GENERATED_FILES += $(GENERATED_QAPI_FILES)
+generated-files-y += $(GENERATED_QAPI_FILES)
 
-GENERATED_FILES += trace/generated-tcg-tracers.h
+generated-files-y += trace/generated-tcg-tracers.h
 
-GENERATED_FILES += trace/generated-helpers-wrappers.h
-GENERATED_FILES += trace/generated-helpers.h
-GENERATED_FILES += trace/generated-helpers.c
+generated-files-y += trace/generated-helpers-wrappers.h
+generated-files-y += trace/generated-helpers.h
+generated-files-y += trace/generated-helpers.c
 
-ifdef CONFIG_TRACE_UST
-GENERATED_FILES += trace-ust-all.h
-GENERATED_FILES += trace-ust-all.c
-endif
+generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.h
+generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.c
 
-GENERATED_FILES += module_block.h
+generated-files-y += module_block.h
 
 TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
 TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
@@ -147,10 +145,10 @@ ifdef CONFIG_TRACE_UST
 TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
 endif
 
-GENERATED_FILES += $(TRACE_HEADERS)
-GENERATED_FILES += $(TRACE_SOURCES)
-GENERATED_FILES += $(BUILD_DIR)/trace-events-all
-GENERATED_FILES += .git-submodule-status
+generated-files-y += $(TRACE_HEADERS)
+generated-files-y += $(TRACE_SOURCES)
+generated-files-y += $(BUILD_DIR)/trace-events-all
+generated-files-y += .git-submodule-status
 
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
@@ -281,7 +279,7 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-osx-to-qcode.c \
 		 $(NULL)
 
-GENERATED_FILES += $(KEYCODEMAP_FILES)
+generated-files-$(CONFIG_SOFTMMU) += $(KEYCODEMAP_FILES)
 
 ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile.objs
 	$(call quiet-command,\
@@ -643,10 +641,10 @@ clean:
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
-	@# May not be present in GENERATED_FILES
+	@# May not be present in generated-files-y
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
-	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
+	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
@@ -1062,7 +1060,7 @@ endif # CONFIG_WIN
 # rebuilt before other object files
 ifneq ($(wildcard config-host.mak),)
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
-Makefile: $(GENERATED_FILES)
+Makefile: $(generated-files-y)
 endif
 endif
 
diff --git a/Makefile.target b/Makefile.target
index ae02495..fdbe7c8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -166,7 +166,7 @@ else
 obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
-GENERATED_FILES += hmp-commands.h hmp-commands-info.h
+generated-files-y += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
 
@@ -236,5 +236,5 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
 endif
 
-GENERATED_FILES += config-target.h
-Makefile: $(GENERATED_FILES)
+generated-files-y += config-target.h
+Makefile: $(generated-files-y)
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 68eeee3..312bf4f 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -12,7 +12,7 @@ obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
 ifneq ($(MAKECMDGOALS),clean)
-GENERATED_FILES += $(feat-dst)gen-features.h
+generated-files-y += $(feat-dst)gen-features.h
 endif
 
 $(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 60de085..ad95a14 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -468,19 +468,19 @@ qapi-schema += unknown-expr-key.json
 
 check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
 
-GENERATED_FILES += tests/test-qapi-types.h \
-	tests/include/test-qapi-types-sub-module.h \
-	tests/test-qapi-types-sub-sub-module.h \
-	tests/test-qapi-visit.h \
-	tests/include/test-qapi-visit-sub-module.h \
-	tests/test-qapi-visit-sub-sub-module.h \
-	tests/test-qapi-commands.h \
-	tests/include/test-qapi-commands-sub-module.h \
-	tests/test-qapi-commands-sub-sub-module.h \
-	tests/test-qapi-events.h \
-	tests/include/test-qapi-events-sub-module.h \
-	tests/test-qapi-events-sub-sub-module.h \
-	tests/test-qapi-introspect.h
+generated-files-y += tests/test-qapi-types.h
+generated-files-y += tests/include/test-qapi-types-sub-module.h
+generated-files-y += tests/test-qapi-types-sub-sub-module.h
+generated-files-y += tests/test-qapi-visit.h
+generated-files-y += tests/include/test-qapi-visit-sub-module.h
+generated-files-y += tests/test-qapi-visit-sub-sub-module.h
+generated-files-y += tests/test-qapi-commands.h
+generated-files-y += tests/include/test-qapi-commands-sub-module.h
+generated-files-y += tests/test-qapi-commands-sub-sub-module.h
+generated-files-y += tests/test-qapi-events.h
+generated-files-y += tests/include/test-qapi-events-sub-module.h
+generated-files-y += tests/test-qapi-events-sub-sub-module.h
+generated-files-y += tests/test-qapi-introspect.h
 
 QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
-- 
1.8.3.1



