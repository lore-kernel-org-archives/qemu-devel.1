Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6DAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E560E20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG5YaizV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSYN-0004gD-35
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMe-0006dW-BY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMY-0007BJ-MA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2b6suSUQoUCdu/svLeROGq1EoTJ292BuA8aeHzcUKCw=;
 b=JG5YaizVFU03GB9psQNaSAdlK0nC41OP9qxrsardeFcKUPF4p0oJB8i2XHU51qjVkODT8m
 A+nRxVaHxDOg44DNd2NR7KVS82XxA99GTv/sEp51AXWZzDWXf1JkEgk0Sw0Vyw1mJbY6k/
 pubHckwfMuSY15Z/LWEjzyS8hWhHhdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-IP6AGhKyNu6HXS2b6R26dA-1; Wed, 02 Sep 2020 08:59:33 -0400
X-MC-Unique: IP6AGhKyNu6HXS2b6R26dA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F21D801AEF
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC4776E01
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/39] Makefile: remove dead variables and includes
Date: Wed,  2 Sep 2020 08:59:06 -0400
Message-Id: <20200902125917.26021-29-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Makefile.objs, the .d files and various CONFIG_* symbols are not
used anymore by the Make side of the build; they are only processed
by Meson.  We can delete them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               | 20 --------------------
 Makefile.objs          | 34 ----------------------------------
 tests/Makefile.include | 40 ----------------------------------------
 3 files changed, 94 deletions(-)
 delete mode 100644 Makefile.objs

diff --git a/Makefile b/Makefile
index d4d6a67d96..9bdf5fc072 100644
--- a/Makefile
+++ b/Makefile
@@ -80,13 +80,6 @@ seems to have been used for an in-tree build. You can fix this by running \
 endif
 endif
 
-CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
-CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
-CONFIG_XEN := $(CONFIG_XEN_BACKEND)
-CONFIG_ALL=y
--include config-all-devices.mak
--include config-all-disas.mak
-
 config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 	@echo $@ is out-of-date, running configure
 	@if test -f meson-private/coredata.dat; then \
@@ -117,9 +110,6 @@ build.ninja: config-host.mak
 
 include $(SRC_PATH)/rules.mak
 
-# lor is defined in rules.mak
-CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
-
 generated-files-y += .git-submodule-status
 
 # Don't try to regenerate Makefile or configure
@@ -132,14 +122,8 @@ configure: ;
 
 $(call set-vpath, $(SRC_PATH))
 
-LIBS+=-lz $(LIBS_TOOLS)
-
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
 
-ifneq ($(wildcard config-host.mak),)
-include $(SRC_PATH)/Makefile.objs
-endif
-
 include $(SRC_PATH)/tests/Makefile.include
 
 all: recurse-all
@@ -256,10 +240,6 @@ Makefile: $(generated-files-y)
 endif
 endif
 
-# Include automatically generated dependency files
-# Dependencies in Makefile.objs files come from our recursive subdir rules
--include $(wildcard *.d tests/*.d)
-
 include $(SRC_PATH)/tests/docker/Makefile.include
 include $(SRC_PATH)/tests/vm/Makefile.include
 
diff --git a/Makefile.objs b/Makefile.objs
deleted file mode 100644
index c351b59641..0000000000
--- a/Makefile.objs
+++ /dev/null
@@ -1,34 +0,0 @@
-#######################################################################
-# Common libraries for tools and emulators
-qom-obj-y = qom/libqom.fa
-
-#######################################################################
-# code used by both qemu system emulation and qemu-img
-
-ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
-
-authz-obj-y = authz/libauthz.fa
-authz/libauthz.fa-libs = $(if $(CONFIG_AUTH_PAM),-lpam)
-
-block-obj-y += libblock.fa
-
-libblock.fa-libs = $(ZSTD_LIBS)
-libblock.fa-libs += $(LIBNFS_LIBS)
-libblock.fa-libs += $(LIBISCSI_LIBS)
-libblock.fa-libs += $(CURL_LIBS)
-libblock.fa-libs += $(RBD_LIBS)
-libblock.fa-libs += $(GLUSTERFS_LIBS)
-libblock.fa-libs += $(VXHS_LIBS)
-libblock.fa-libs += $(LIBSSH_LIBS)
-libblock.fa-libs += $(BZIP2_LIBS)
-libblock.fa-libs += $(LZFSE_LIBS)
-libblock.fa-libs += $(if $(CONFIG_LINUX_AIO),-laio)
-libblock.fa-libs += $(LIBXML2_LIBS)
-
-chardev-obj-y = chardev/libchardev.fa
-
-crypto-obj-y = crypto/libcrypto.fa
-
-io-obj-y = io/libio.fa
-
-endif # CONFIG_SOFTMMU or CONFIG_TOOLS
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1592a647f4..f93e611220 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -40,41 +40,6 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
 
 SPEED = quick
 
-# gtester tests, possibly with verbose output
-# do_test_tap runs all tests, even if some of them fail, while do_test_human
-# stops at the first failure unless -k is given on the command line
-
-define do_test_human_k
-        $(quiet-@)rc=0; $(foreach COMMAND, $1, \
-          $(call quiet-command-run, \
-            export MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} $2; \
-              $(COMMAND) -m=$(SPEED) -k --tap < /dev/null \
-              | ./scripts/tap-driver.pl --test-name="$(notdir $(COMMAND))" $(if $(V),, --show-failures-only) \
-              || rc=$$?;, "TEST", "$@: $(COMMAND)")) exit $$rc
-endef
-define do_test_human_no_k
-        $(foreach COMMAND, $1, \
-          $(call quiet-command, \
-            MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} $2 \
-              $(COMMAND) -m=$(SPEED) -k --tap < /dev/null \
-              | ./scripts/tap-driver.pl --test-name="$(notdir $(COMMAND))" $(if $(V),, --show-failures-only), \
-              "TEST", "$@: $(COMMAND)")
-)
-endef
-do_test_human = \
-        $(if $(findstring k, $(MAKEFLAGS)), $(do_test_human_k), $(do_test_human_no_k))
-
-define do_test_tap
-	$(call quiet-command, \
-          { export MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} $2; \
-            $(foreach COMMAND, $1, \
-	      $(COMMAND) -m=$(SPEED) -k --tap < /dev/null \
-	      | sed "s/^\(not \)\?ok [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
-	      | ./scripts/tap-merge.pl | tee "$@" \
-	      | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only), \
-	  "TAP","$@")
-endef
-
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -182,7 +147,6 @@ endif
 check-build: $(QEMU_IOTESTS_HELPERS-y)
 
 check-clean:
-	rm -rf tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
 clean: check-clean
@@ -191,8 +155,4 @@ clean: check-clean
 
 check-speed: bench-speed
 
-# Build the help program automatically
-
--include $(wildcard tests/*.d)
-
 endif
-- 
2.26.2



