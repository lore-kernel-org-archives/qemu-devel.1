Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27370C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77EC21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="batk8qBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77EC21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvN33-0004wJ-3g
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hvN2K-0003Yu-Kj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hvN2H-0006bi-Ky
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hvN2H-0006b8-Cq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id r1so91590333wrl.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L17nmp4EtB/bX6EdCmG6uVDw61DjK5O/rGkvV267caI=;
 b=batk8qBJkgSx9TpiC/I+ojP7pBL5bjfqkdoQnEkgcHYhPxhAXdvCC24JFHmbiSfOWi
 BsIGRy3OlfpnXmJEAymCj+GWf9uq+O4W1PbLJe1HwjKsFS6PE9vdYZUpCDxwUIGbyThU
 cdppr80uRUQx33NZn5h0hmcwK3UTKulELZlxeQUnWsSj9GoIq4/na3ysQfKW9SxnPwYZ
 1jDd0w6QdalvQSOjMja9upMJVz72nEPLTh9MZA0g3WmUeSOGac4VhecxdSw5lvZwBLlx
 08i6N5cmRcK0L6PkB83IjC38sKx93De4yKD7SoI7i49GbIZaanWtK57lD3rx+wOtM/fu
 4jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L17nmp4EtB/bX6EdCmG6uVDw61DjK5O/rGkvV267caI=;
 b=T3o7suqJsuiRTMLwhUiEtG0Q4xADZZxD7U9Rh1BpXlELOlRlHpBTJwisr3RWokOrV9
 62ADZi4l5m82+uUeuFzn7obt7GSTGIE7Xw8kC9w0oJ8oWyO2HGi7/xLEFjR3INNCpQ9N
 5G/lSpHI57i2014UegjDgo45fYeQSFbgZ+vqnZfe8wsf2LHC3lr9I9svcPOmH8SbHrvX
 W81PzGgseaNRN/13csGqvJ5DzR51b9aIqJ6GEuNMZmyTZEk181sXl3xneg+wkUCGKCkv
 15NbEm3aTmXEm7JgynJtoiwRWsfo94Qp2tgBcIuYD2mLqpb6gWY629xylgWIopbnDa26
 XYNg==
X-Gm-Message-State: APjAAAVfZBJ7DdgpUh/6rY+MZR+ie5J8J8A9UoOVO5HTcD+QPIy4YFWH
 Y8Dbyhbcg0RTHKkorXUN3aSdCyHn
X-Google-Smtp-Source: APXvYqyJYKei4bqZtO6DKUjs6sEqHRdDF21Fs0qQSa1jLrjOAq57v7IziBh6dop4fxAqY60rcmWsJA==
X-Received: by 2002:a5d:438e:: with SMTP id i14mr11283698wrq.122.1565188527954; 
 Wed, 07 Aug 2019 07:35:27 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id o4sm86004wmh.35.2019.08.07.07.35.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:35:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 16:35:22 +0200
Message-Id: <20190807143523.15917-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807143523.15917-1-pbonzini@redhat.com>
References: <20190807143523.15917-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 2/3] tests/tcg: cleanup Makefile inclusions
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename Makefile.probe to Makefile.prereqs and make it actually
define rules for the tests.

Rename Makefile to Makefile.target, since it is not a toplevel
makefile.

Rename Makefile.include to Makefile.qemu and disentangle it
from the QEMU Makefile.target, so that it is invoked recursively
by tests/Makefile.include.  Tests are now placed in
tests/tcg/$(TARGET).

Drop the usage of TARGET_BASE_ARCH, which is ignored by everything except
x86_64 and aarch64.  Fix x86 tests by using -cpu max and, while
at it, standardize on QEMU_OPTS for aarch64 tests too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target                               |  3 --
 tests/Makefile.include                        | 23 +++++----
 .../tcg/{Makefile.probe => Makefile.prereqs}  |  5 +-
 tests/tcg/{Makefile.include => Makefile.qemu} | 48 +++++++++++--------
 tests/tcg/{Makefile => Makefile.target}       | 13 ++---
 tests/tcg/aarch64/Makefile.target             | 12 +++--
 tests/tcg/arm/Makefile.softmmu-target         |  4 --
 tests/tcg/i386/Makefile.softmmu-target        |  8 ----
 tests/tcg/i386/Makefile.target                | 13 ++---
 tests/tcg/x86_64/Makefile.softmmu-target      | 36 ++++++++++++++
 tests/tcg/x86_64/Makefile.target              |  7 +--
 11 files changed, 100 insertions(+), 72 deletions(-)
 rename tests/tcg/{Makefile.probe => Makefile.prereqs} (92%)
 rename tests/tcg/{Makefile.include => Makefile.qemu} (52%)
 rename tests/tcg/{Makefile => Makefile.target} (92%)
 create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target

diff --git a/Makefile.target b/Makefile.target
index 933b27453a..5e916230c4 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -39,9 +39,6 @@ endif
 PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
-# Makefile Tests
-include $(SRC_PATH)/tests/tcg/Makefile.include
-
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd7fdb8658..8bb5c97b7a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1061,23 +1061,28 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 ifeq ($(HAVE_USER_DOCKER),y)
 # Probe for the Docker Builds needed for each build
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
-	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
-	$(if $(DOCKER_PREREQ), 					\
-		$(eval build-tcg-tests-$(PROBE_TARGET): $(DOCKER_PREREQ))))
+	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
 endif
 
 build-tcg-tests-%:
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
-		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" guest-tests, \
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
+		SRC_PATH=$(SRC_PATH) \
+	       	V="$(V)" TARGET_DIR="$*/" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
-run-tcg-tests-%: % build-tcg-tests-%
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" \
-		SKIP_DOCKER_BUILD=1 TARGET_DIR="$*/" run-guest-tests, \
+run-tcg-tests-%: build-tcg-tests-% %/all
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
+		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
+		V="$(V)" TARGET_DIR="$*/" run-guest-tests, \
 		"RUN", "TCG tests for $*")
 
 clean-tcg-tests-%:
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
+		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
+		SRC_PATH=$(SRC_PATH) TARGET_DIR="$*/" clean-guest-tests, \
+		"RUN", "TCG tests for $*")
 
 .PHONY: build-tcg
 build-tcg: $(BUILD_TCG_TARGET_RULES)
diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.prereqs
similarity index 92%
rename from tests/tcg/Makefile.probe
rename to tests/tcg/Makefile.prereqs
index 9dc654663d..53b01962e1 100644
--- a/tests/tcg/Makefile.probe
+++ b/tests/tcg/Makefile.prereqs
@@ -8,20 +8,19 @@
 # each target.
 
 # First we need the target makefile which tells us the target architecture
+CROSS_CC_GUEST:=
 -include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
 
 # Then we load up the target architecture makefiles which tell us
 # about the compilers
-CROSS_CC_GUEST:=
 DOCKER_IMAGE:=
-DOCKER_PREREQ:=
 
 -include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
 
 ifndef CROSS_CC_GUEST
 ifneq ($(DOCKER_IMAGE),)
-DOCKER_PREREQ:=docker-image-$(DOCKER_IMAGE)
+build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
 endif
 endif
 
diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.qemu
similarity index 52%
rename from tests/tcg/Makefile.include
rename to tests/tcg/Makefile.qemu
index 73b5626fc5..d3f34372de 100644
--- a/tests/tcg/Makefile.include
+++ b/tests/tcg/Makefile.qemu
@@ -2,20 +2,23 @@
 #
 # TCG tests (per-target rules)
 #
-# This Makefile fragment is included from the per-target
-# Makefile.target so will be invoked for each linux-user program we
-# build. We have two options for compiling, either using a configured
-# guest compiler or calling one of our docker images to do it for us.
+# This Makefile fragment is included from the build-tcg target, once
+# for each target we build. We have two options for compiling, either
+# using a configured guest compiler or calling one of our docker images
+# to do it for us.
 #
 
 # The per ARCH makefile, if it exists, holds extra information about
 # useful docker images or alternative compiler flags.
 
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
+include $(TARGET_DIR)config-target.mak
+include $(SRC_PATH)/rules.mak
+include $(wildcard \
+	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
+	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
 
 GUEST_BUILD=
-TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
+TCG_MAKE=../Makefile.target
 # Support installed Cross Compilers
 
 ifdef CROSS_CC_GUEST
@@ -23,9 +26,9 @@ ifdef CROSS_CC_GUEST
 .PHONY: cross-build-guest-tests
 cross-build-guest-tests:
 	$(call quiet-command, \
-	   (mkdir -p tests && cd tests && \
-	    $(MAKE) -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
-			BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
+	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
+	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC="$(CROSS_CC_GUEST)" \
+			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
 			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
 	"BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
 
@@ -39,20 +42,20 @@ ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
 ifneq ($(DOCKER_IMAGE),)
 
 # We also need the Docker make rules to depend on
+SKIP_DOCKER_BUILD=1
 include $(SRC_PATH)/tests/docker/Makefile.include
 
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
 		--cc $(DOCKER_CROSS_COMPILER) \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
-DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
 
 .PHONY: docker-build-guest-tests
-docker-build-guest-tests: $(DOCKER_PREREQ)
+docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
 	$(call quiet-command, \
-	  (mkdir -p tests && cd tests && \
-	   $(MAKE) -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
-			BUILD_STATIC=y \
+	  (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
+	   $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC=$(DOCKER_COMPILE_CMD) \
+			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=y \
 			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
 	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
 
@@ -62,27 +65,32 @@ endif
 endif
 
 # Final targets
+all:
+	@echo "Do not invoke this Makefile directly"; exit 1
+
 .PHONY: guest-tests
 
 ifneq ($(GUEST_BUILD),)
 guest-tests: $(GUEST_BUILD)
 
-run-guest-tests: guest-tests qemu-$(subst y,system-,$(CONFIG_SOFTMMU))$(TARGET_NAME)
+run-guest-tests: guest-tests
 	$(call quiet-command, \
-	(cd tests && $(MAKE) -f $(TCG_MAKE) SPEED=$(SPEED) run), \
+	(cd tests/tcg/$(TARGET_DIR) && \
+	 $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" \
+	 		SRC_PATH="$(SRC_PATH)" SPEED=$(SPEED) run), \
 	"RUN", "tests for $(TARGET_NAME)")
 
 else
 guest-tests:
 	$(call quiet-command, /bin/true, "BUILD", \
-		"$(TARGET_NAME) guest-tests SKIPPED")
+		"$(TARGET_DIR) guest-tests SKIPPED")
 
 run-guest-tests:
 	$(call quiet-command, /bin/true, "RUN", \
-		"tests for $(TARGET_NAME) SKIPPED")
+		"tests for $(TARGET_DIR) SKIPPED")
 endif
 
 # It doesn't matter if these don't exits
 .PHONY: clean-guest-tests
 clean-guest-tests:
-	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
+	rm -rf tests/tcg/$(TARGET_DIR)
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile.target
similarity index 92%
rename from tests/tcg/Makefile
rename to tests/tcg/Makefile.target
index 9f56768624..8dbcba4474 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile.target
@@ -29,8 +29,9 @@
 # We also expect to be in the tests build dir for the FOO-(linux-user|softmmu).
 #
 
+all:
 -include ../../config-host.mak
--include ../config-target.mak
+-include ../../../$(TARGET_DIR)/config-target.mak
 
 # for including , in command strings
 COMMA := ,
@@ -64,9 +65,9 @@ LDFLAGS=
 
 # The QEMU for this TARGET
 ifdef CONFIG_USER_ONLY
-QEMU=../qemu-$(TARGET_NAME)
+QEMU=../../../$(TARGET_DIR)/qemu-$(TARGET_NAME)
 else
-QEMU=../qemu-system-$(TARGET_NAME)
+QEMU=../../../$(TARGET_DIR)/qemu-system-$(TARGET_NAME)
 endif
 QEMU_OPTS=
 
@@ -82,10 +83,7 @@ ifdef CONFIG_USER_ONLY
 # The order we include is important. We include multiarch, base arch
 # and finally arch if it's not the same as base arch.
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.target
-ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
-endif
 
 # Add the common build options
 CFLAGS+=-Wall -O0 -g -fno-strict-aliasing
@@ -101,10 +99,7 @@ else
 # are expected to provide their own build recipes.
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.softmmu-target
-ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
-endif
 
 endif
 
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 31ba9cfcaa..e763dd9da3 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -2,12 +2,14 @@
 #
 # AArch64 specific tweaks
 
+ARM_SRC=$(SRC_PATH)/tests/tcg/arm
+VPATH 		+= $(ARM_SRC)
+
 AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+= $(AARCH64_SRC)
 
-# we don't build any of the ARM tests
-AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
-AARCH64_TESTS+=fcvt
+# we don't build any other ARM test
+AARCH64_TESTS=fcvt
 
 fcvt: LDFLAGS+=-lm
 
@@ -16,6 +18,6 @@ run-fcvt: fcvt
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 AARCH64_TESTS += pauth-1 pauth-2
-run-pauth-%: QEMU += -cpu max
+run-pauth-%: QEMU_OPTS += -cpu max
 
-TESTS:=$(AARCH64_TESTS)
+TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 2deb06e6e4..231e9a57b4 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -3,8 +3,6 @@
 # ARM SoftMMU tests - included from tests/tcg/Makefile
 #
 
-ifeq ($(TARGET_ABI_DIR),arm)
-
 ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 
 # Set search path for all sources
@@ -25,5 +23,3 @@ LDFLAGS+=-nostdlib -N -static
 test-armv6m-undef: EXTRA_CFLAGS+=-mcpu=cortex-m0
 
 run-test-armv6m-undef: QEMU_OPTS+=-semihosting -M microbit -kernel
-
-endif
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index cee342017e..1c8790eecd 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -12,17 +12,9 @@ X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-ifeq ($(TARGET_X86_64), y)
-CRT_PATH=$(X64_SYSTEM_SRC)
-CFLAGS=-march=x86-64
-LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
-else
 CRT_PATH=$(I386_SYSTEM_SRC)
-CFLAGS+=-m32
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-endif
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index d0eb7023e5..08c5736a4d 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -6,14 +6,11 @@ I386_SRC=$(SRC_PATH)/tests/tcg/i386
 VPATH 		+= $(I386_SRC)
 
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
-I386_TESTS=$(I386_SRCS:.c=)
-I386_ONLY_TESTS=$(filter-out test-i386-ssse3, $(I386_TESTS))
+ALL_X86_TESTS=$(I386_SRCS:.c=)
+I386_TESTS:=$(filter-out test-i386-ssse3, $(ALL_X86_TESTS))
+X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
 # Update TESTS
-TESTS+=$(I386_ONLY_TESTS)
-
-ifneq ($(TARGET_NAME),x86_64)
-CFLAGS+=-m32
-endif
+TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
 
 #
 # hello-i386 is a barebones app
@@ -26,7 +23,7 @@ hello-i386: LDFLAGS+=-nostdlib
 #
 
 test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	$(CC) $(CFLAGS) $(LDFLAGS) $(EXTRA_CFLAGS) -o $@ \
 	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
 
 ifeq ($(SPEED), slow)
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
new file mode 100644
index 0000000000..df252e761c
--- /dev/null
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -0,0 +1,36 @@
+#
+# x86 system tests
+#
+# This currently builds only for i386. The common C code is built
+# with standard compiler flags however so we can support both by
+# adding additional boot files for x86_64.
+#
+
+I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
+X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
+
+# These objects provide the basic boot code and helper functions for all tests
+CRT_OBJS=boot.o
+
+CRT_PATH=$(X64_SYSTEM_SRC)
+LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
+LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
+CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+
+TESTS+=$(MULTIARCH_TESTS)
+
+# building head blobs
+.PRECIOUS: $(CRT_OBJS)
+
+%.o: $(CRT_PATH)/%.S
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+
+# Build and link the tests
+%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+memory: CFLAGS+=-DCHECK_UNALIGNED=1
+
+# Running
+QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 74f170b9ed..20bf96202a 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -6,9 +6,10 @@
 # $(SRC)/tests/tcg/i386/
 #
 
-X86_64_TESTS=$(filter-out $(I386_ONLY_TESTS), $(TESTS))
-X86_64_TESTS+=test-x86_64
-TESTS:=$(X86_64_TESTS)
+include $(SRC_PATH)/tests/tcg/i386/Makefile.target
+
+TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
+QEMU_OPTS += -cpu max
 
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
-- 
2.21.0



