Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C177C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1B32177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuVSf8ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1B32177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lTd-0007cS-7x
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNg-0003Ym-De
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNc-0006Mb-Ck
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=PqSWjBcq5dhW0mz/MCtTYx+DuuPSU8oclQBz9IPKkrU=;
 b=NuVSf8eyfGg1ffkj5gLzS3+LpbnTzRwuCasyzoVXvCYD1sXXMTErOv9Em0q5GSRVo853Ef
 qgeMsKH5pHoIUAKDpHgMUdkQJJIpxwfn2msMdSZ4NxQgDqnBtV+wFEEzEZgp6ZQ+pHSk/B
 03fr1obz/d0aUXflHvjhXmTk5Xi1SCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-WyDMK5QcNXOvx3Y6gQmYKA-1; Thu, 06 Aug 2020 15:16:36 -0400
X-MC-Unique: WyDMK5QcNXOvx3Y6gQmYKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E2A1DE1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:36 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 527355FC3B
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 004/143] trace: switch position of headers to what Meson
 requires
Date: Thu,  6 Aug 2020 21:14:00 +0200
Message-Id: <1596741379-12902-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Meson doesn't enjoy the same flexibility we have with Make in choosing
the include path.  In particular the tracing headers are using
$(build_root)/$(<D).

In order to keep the include directives unchanged,
the simplest solution is to generate headers with patterns like
"trace/trace-audio.h" and place forwarding headers in the source tree
such that for example "audio/trace.h" includes "trace/trace-audio.h".

This patch is too ugly to be applied to the Makefiles now.  It's only
a way to separate the changes to the tracing header files from the
Meson rewrite of the tracing logic.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitignore                               |  1 -
 Makefile                                 | 46 +++++++++++++++++++-------------
 Makefile.objs                            |  1 -
 accel/kvm/trace.h                        |  1 +
 accel/tcg/cputlb.c                       |  2 +-
 accel/tcg/trace.h                        |  1 +
 accel/tcg/user-exec.c                    |  2 +-
 audio/trace.h                            |  1 +
 authz/trace.h                            |  1 +
 backends/tpm/trace.h                     |  1 +
 backends/trace.h                         |  1 +
 block/trace.h                            |  1 +
 chardev/trace.h                          |  1 +
 crypto/trace.h                           |  1 +
 dma-helpers.c                            |  2 +-
 exec.c                                   |  2 +-
 gdbstub.c                                |  2 +-
 hw/9pfs/trace.h                          |  1 +
 hw/acpi/trace.h                          |  1 +
 hw/alpha/trace.h                         |  1 +
 hw/arm/trace.h                           |  1 +
 hw/audio/trace.h                         |  1 +
 hw/block/dataplane/trace.h               |  1 +
 hw/block/trace.h                         |  1 +
 hw/char/trace.h                          |  1 +
 hw/core/cpu.c                            |  2 +-
 hw/core/trace.h                          |  1 +
 hw/display/trace.h                       |  1 +
 hw/dma/trace.h                           |  1 +
 hw/gpio/trace.h                          |  1 +
 hw/hppa/trace.h                          |  1 +
 hw/hyperv/trace.h                        |  1 +
 hw/i2c/trace.h                           |  1 +
 hw/i386/trace.h                          |  1 +
 hw/i386/xen/trace.h                      |  1 +
 hw/ide/trace.h                           |  1 +
 hw/input/trace.h                         |  1 +
 hw/intc/trace.h                          |  1 +
 hw/isa/trace.h                           |  1 +
 hw/mem/trace.h                           |  1 +
 hw/mips/trace.h                          |  1 +
 hw/misc/macio/trace.h                    |  1 +
 hw/misc/trace.h                          |  1 +
 hw/net/trace.h                           |  1 +
 hw/nvram/trace.h                         |  1 +
 hw/pci-host/trace.h                      |  1 +
 hw/pci/trace.h                           |  1 +
 hw/ppc/trace.h                           |  1 +
 hw/rdma/trace.h                          |  1 +
 hw/rdma/vmw/trace.h                      |  1 +
 hw/riscv/trace.h                         |  1 +
 hw/rtc/trace.h                           |  1 +
 hw/s390x/trace.h                         |  1 +
 hw/scsi/trace.h                          |  1 +
 hw/sd/trace.h                            |  1 +
 hw/sparc/trace.h                         |  1 +
 hw/sparc64/trace.h                       |  1 +
 hw/ssi/trace.h                           |  1 +
 hw/timer/trace.h                         |  1 +
 hw/tpm/trace.h                           |  1 +
 hw/usb/trace.h                           |  1 +
 hw/vfio/trace.h                          |  1 +
 hw/virtio/trace.h                        |  1 +
 hw/watchdog/trace.h                      |  1 +
 hw/xen/trace.h                           |  1 +
 include/user/syscall-trace.h             |  2 +-
 io/trace.h                               |  1 +
 job-qmp.c                                |  2 +-
 job.c                                    |  2 +-
 linux-user/trace.h                       |  1 +
 migration/trace.h                        |  1 +
 monitor/trace.h                          |  1 +
 nbd/trace.h                              |  1 +
 net/trace.h                              |  1 +
 qapi/trace.h                             |  1 +
 qom/trace.h                              |  1 +
 scripts/tracetool/format/c.py            |  5 +---
 scripts/tracetool/format/tcg_h.py        |  2 +-
 scripts/tracetool/format/tcg_helper_c.py |  2 +-
 scsi/trace.h                             |  1 +
 softmmu/balloon.c                        |  2 +-
 softmmu/ioport.c                         |  2 +-
 softmmu/memory.c                         |  2 +-
 softmmu/vl.c                             |  2 +-
 target/arm/trace.h                       |  1 +
 target/hppa/trace.h                      |  1 +
 target/i386/trace.h                      |  1 +
 target/mips/trace.h                      |  1 +
 target/ppc/trace.h                       |  1 +
 target/riscv/trace.h                     |  1 +
 target/s390x/trace.h                     |  1 +
 target/sparc/trace.h                     |  1 +
 trace/control-target.c                   |  2 +-
 trace/control.c                          |  2 +-
 ui/trace.h                               |  1 +
 util/trace.h                             |  1 +
 96 files changed, 121 insertions(+), 41 deletions(-)
 create mode 100644 accel/kvm/trace.h
 create mode 100644 accel/tcg/trace.h
 create mode 100644 audio/trace.h
 create mode 100644 authz/trace.h
 create mode 100644 backends/tpm/trace.h
 create mode 100644 backends/trace.h
 create mode 100644 block/trace.h
 create mode 100644 chardev/trace.h
 create mode 100644 crypto/trace.h
 create mode 100644 hw/9pfs/trace.h
 create mode 100644 hw/acpi/trace.h
 create mode 100644 hw/alpha/trace.h
 create mode 100644 hw/arm/trace.h
 create mode 100644 hw/audio/trace.h
 create mode 100644 hw/block/dataplane/trace.h
 create mode 100644 hw/block/trace.h
 create mode 100644 hw/char/trace.h
 create mode 100644 hw/core/trace.h
 create mode 100644 hw/display/trace.h
 create mode 100644 hw/dma/trace.h
 create mode 100644 hw/gpio/trace.h
 create mode 100644 hw/hppa/trace.h
 create mode 100644 hw/hyperv/trace.h
 create mode 100644 hw/i2c/trace.h
 create mode 100644 hw/i386/trace.h
 create mode 100644 hw/i386/xen/trace.h
 create mode 100644 hw/ide/trace.h
 create mode 100644 hw/input/trace.h
 create mode 100644 hw/intc/trace.h
 create mode 100644 hw/isa/trace.h
 create mode 100644 hw/mem/trace.h
 create mode 100644 hw/mips/trace.h
 create mode 100644 hw/misc/macio/trace.h
 create mode 100644 hw/misc/trace.h
 create mode 100644 hw/net/trace.h
 create mode 100644 hw/nvram/trace.h
 create mode 100644 hw/pci-host/trace.h
 create mode 100644 hw/pci/trace.h
 create mode 100644 hw/ppc/trace.h
 create mode 100644 hw/rdma/trace.h
 create mode 100644 hw/rdma/vmw/trace.h
 create mode 100644 hw/riscv/trace.h
 create mode 100644 hw/rtc/trace.h
 create mode 100644 hw/s390x/trace.h
 create mode 100644 hw/scsi/trace.h
 create mode 100644 hw/sd/trace.h
 create mode 100644 hw/sparc/trace.h
 create mode 100644 hw/sparc64/trace.h
 create mode 100644 hw/ssi/trace.h
 create mode 100644 hw/timer/trace.h
 create mode 100644 hw/tpm/trace.h
 create mode 100644 hw/usb/trace.h
 create mode 100644 hw/vfio/trace.h
 create mode 100644 hw/virtio/trace.h
 create mode 100644 hw/watchdog/trace.h
 create mode 100644 hw/xen/trace.h
 create mode 100644 io/trace.h
 create mode 100644 linux-user/trace.h
 create mode 100644 migration/trace.h
 create mode 100644 monitor/trace.h
 create mode 100644 nbd/trace.h
 create mode 100644 net/trace.h
 create mode 100644 qapi/trace.h
 create mode 100644 qom/trace.h
 create mode 100644 scsi/trace.h
 create mode 100644 target/arm/trace.h
 create mode 100644 target/hppa/trace.h
 create mode 100644 target/i386/trace.h
 create mode 100644 target/mips/trace.h
 create mode 100644 target/ppc/trace.h
 create mode 100644 target/riscv/trace.h
 create mode 100644 target/s390x/trace.h
 create mode 100644 target/sparc/trace.h
 create mode 100644 ui/trace.h
 create mode 100644 util/trace.h

diff --git a/.gitignore b/.gitignore
index 2992d15..656e390 100644
--- a/.gitignore
+++ b/.gitignore
@@ -146,7 +146,6 @@ docker-src.*
 *~
 *.ast_raw
 *.depend_raw
-trace.h
 trace.c
 trace-ust.h
 trace-ust.h
diff --git a/Makefile b/Makefile
index 13dd708..00cadeb 100644
--- a/Makefile
+++ b/Makefile
@@ -159,8 +159,8 @@ generated-files-$(CONFIG_TRACE_UST) += trace-ust-all.c
 
 generated-files-y += module_block.h
 
-TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
-TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
+TRACE_HEADERS = trace/trace-root.h
+TRACE_SOURCES = trace/trace-root.c
 TRACE_DTRACE =
 ifdef CONFIG_TRACE_DTRACE
 TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
@@ -170,33 +170,37 @@ ifdef CONFIG_TRACE_UST
 TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
 endif
 
-generated-files-y += $(TRACE_HEADERS)
-generated-files-y += $(TRACE_SOURCES)
 generated-files-y += $(BUILD_DIR)/trace-events-all
 generated-files-y += .git-submodule-status
 
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
+trace-group-suffix = $(shell echo $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-%/trace.h: %/trace.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+define __trace_rules
+TRACE_HEADERS += trace/trace-$2.h
+TRACE_SOURCES += trace/trace-$2.c
+trace-obj-y += trace/trace-$2.o
+trace/trace-$2.h: trace/trace-$2.h-timestamp
+	@cmp $$< $$@ >/dev/null 2>&1 || cp $$< $$@
+trace/trace-$2.h-timestamp: $(SRC_PATH)/$1/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
+		--group=$2 \
 		--format=h \
 		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		$$< > $$@,"GEN","$$(@:%-timestamp=%)")
 
-%/trace.c: %/trace.c-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-%/trace.c-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/trace-$2.c: trace/trace-$2.c-timestamp
+	@cmp $$< $$@ >/dev/null 2>&1 || cp $$< $$@
+trace/trace-$2.c-timestamp: $(SRC_PATH)/$1/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command,$(TRACETOOL) \
-		--group=$(call trace-group-name,$@) \
+		--group=$2 \
 		--format=c \
 		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(@:%-timestamp=%)")
+		$$< > $$@,"GEN","$$(@:%-timestamp=%)")
+endef
 
 %/trace-ust.h: %/trace-ust.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
@@ -222,18 +226,18 @@ tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 %/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
 
 
-trace-root.h: trace-root.h-timestamp
+trace/trace-root.h: trace/trace-root.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=h \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(@:%-timestamp=%)")
 
-trace-root.c: trace-root.c-timestamp
+trace/trace-root.c: trace/trace-root.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
+trace/trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y) $(BUILD_DIR)/config-host.mak
 	$(call quiet-command,$(TRACETOOL) \
 		--group=root \
 		--format=c \
@@ -477,6 +481,12 @@ dummy := $(call unnest-vars,, \
                 common-obj-m \
                 trace-obj-y)
 
+dummy := $(foreach DIR,$(trace-events-subdirs),$(eval $(call __trace_rules,$(DIR),$(call trace-group-suffix,$(DIR)))))
+
+generated-files-y += $(TRACE_HEADERS)
+generated-files-y += $(TRACE_SOURCES)
+
+
 include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
diff --git a/Makefile.objs b/Makefile.objs
index d22b3b4..3823463 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -209,7 +209,6 @@ trace-events-subdirs += util
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
 trace-obj-y = trace-root.o
-trace-obj-y += $(trace-events-subdirs:%=%/trace.o)
 trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
 trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace-root.o
 trace-obj-$(CONFIG_TRACE_DTRACE) += $(trace-events-subdirs:%=%/trace-dtrace.o)
diff --git a/accel/kvm/trace.h b/accel/kvm/trace.h
new file mode 100644
index 0000000..67c935a
--- /dev/null
+++ b/accel/kvm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_kvm.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5698292..5349ee6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,7 +34,7 @@
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "translate-all.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/mem.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
diff --git a/accel/tcg/trace.h b/accel/tcg/trace.h
new file mode 100644
index 0000000..db61fad
--- /dev/null
+++ b/accel/tcg/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_tcg.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d8b027f..1d34c57 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -26,7 +26,7 @@
 #include "translate-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/atomic128.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/mem.h"
 
 #undef EAX
diff --git a/audio/trace.h b/audio/trace.h
new file mode 100644
index 0000000..4072a11
--- /dev/null
+++ b/audio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-audio.h"
diff --git a/authz/trace.h b/authz/trace.h
new file mode 100644
index 0000000..3176c12
--- /dev/null
+++ b/authz/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-authz.h"
diff --git a/backends/tpm/trace.h b/backends/tpm/trace.h
new file mode 100644
index 0000000..40c4729
--- /dev/null
+++ b/backends/tpm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-backends_tpm.h"
diff --git a/backends/trace.h b/backends/trace.h
new file mode 100644
index 0000000..77fe57f3
--- /dev/null
+++ b/backends/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-backends.h"
diff --git a/block/trace.h b/block/trace.h
new file mode 100644
index 0000000..3a436e6
--- /dev/null
+++ b/block/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-block.h"
diff --git a/chardev/trace.h b/chardev/trace.h
new file mode 100644
index 0000000..eb4f902
--- /dev/null
+++ b/chardev/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-chardev.h"
diff --git a/crypto/trace.h b/crypto/trace.h
new file mode 100644
index 0000000..a9af0f3
--- /dev/null
+++ b/crypto/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-crypto.h"
diff --git a/dma-helpers.c b/dma-helpers.c
index 2a77b5a..41ef24a 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
diff --git a/exec.c b/exec.c
index 6f381f9..8047bf2 100644
--- a/exec.c
+++ b/exec.c
@@ -50,7 +50,7 @@
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
diff --git a/gdbstub.c b/gdbstub.c
index f3a318c..9dfb6e4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -30,7 +30,7 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
diff --git a/hw/9pfs/trace.h b/hw/9pfs/trace.h
new file mode 100644
index 0000000..6104fe2
--- /dev/null
+++ b/hw/9pfs/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_9pfs.h"
diff --git a/hw/acpi/trace.h b/hw/acpi/trace.h
new file mode 100644
index 0000000..a7f7da7
--- /dev/null
+++ b/hw/acpi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_acpi.h"
diff --git a/hw/alpha/trace.h b/hw/alpha/trace.h
new file mode 100644
index 0000000..20fe698
--- /dev/null
+++ b/hw/alpha/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_alpha.h"
diff --git a/hw/arm/trace.h b/hw/arm/trace.h
new file mode 100644
index 0000000..91337aa
--- /dev/null
+++ b/hw/arm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_arm.h"
diff --git a/hw/audio/trace.h b/hw/audio/trace.h
new file mode 100644
index 0000000..5c7516a
--- /dev/null
+++ b/hw/audio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_audio.h"
diff --git a/hw/block/dataplane/trace.h b/hw/block/dataplane/trace.h
new file mode 100644
index 0000000..240cc59
--- /dev/null
+++ b/hw/block/dataplane/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_block_dataplane.h"
diff --git a/hw/block/trace.h b/hw/block/trace.h
new file mode 100644
index 0000000..cde210a
--- /dev/null
+++ b/hw/block/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_block.h"
diff --git a/hw/char/trace.h b/hw/char/trace.h
new file mode 100644
index 0000000..c2df66a
--- /dev/null
+++ b/hw/char/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_char.h"
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 594441a..22bc3f9 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -31,7 +31,7 @@
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qemu/plugin.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
diff --git a/hw/core/trace.h b/hw/core/trace.h
new file mode 100644
index 0000000..23dfd61
--- /dev/null
+++ b/hw/core/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_core.h"
diff --git a/hw/display/trace.h b/hw/display/trace.h
new file mode 100644
index 0000000..4ed0e91
--- /dev/null
+++ b/hw/display/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_display.h"
diff --git a/hw/dma/trace.h b/hw/dma/trace.h
new file mode 100644
index 0000000..4bcb28b
--- /dev/null
+++ b/hw/dma/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_dma.h"
diff --git a/hw/gpio/trace.h b/hw/gpio/trace.h
new file mode 100644
index 0000000..8b13907
--- /dev/null
+++ b/hw/gpio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_gpio.h"
diff --git a/hw/hppa/trace.h b/hw/hppa/trace.h
new file mode 100644
index 0000000..4e8b52d
--- /dev/null
+++ b/hw/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_hppa.h"
diff --git a/hw/hyperv/trace.h b/hw/hyperv/trace.h
new file mode 100644
index 0000000..7f2a888
--- /dev/null
+++ b/hw/hyperv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_hyperv.h"
diff --git a/hw/i2c/trace.h b/hw/i2c/trace.h
new file mode 100644
index 0000000..4843a8d
--- /dev/null
+++ b/hw/i2c/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i2c.h"
diff --git a/hw/i386/trace.h b/hw/i386/trace.h
new file mode 100644
index 0000000..37a9f67
--- /dev/null
+++ b/hw/i386/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i386.h"
diff --git a/hw/i386/xen/trace.h b/hw/i386/xen/trace.h
new file mode 100644
index 0000000..a02bf75
--- /dev/null
+++ b/hw/i386/xen/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i386_xen.h"
diff --git a/hw/ide/trace.h b/hw/ide/trace.h
new file mode 100644
index 0000000..e060e0a
--- /dev/null
+++ b/hw/ide/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ide.h"
diff --git a/hw/input/trace.h b/hw/input/trace.h
new file mode 100644
index 0000000..d1cc5d9
--- /dev/null
+++ b/hw/input/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_input.h"
diff --git a/hw/intc/trace.h b/hw/intc/trace.h
new file mode 100644
index 0000000..02394ae
--- /dev/null
+++ b/hw/intc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_intc.h"
diff --git a/hw/isa/trace.h b/hw/isa/trace.h
new file mode 100644
index 0000000..501205c
--- /dev/null
+++ b/hw/isa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_isa.h"
diff --git a/hw/mem/trace.h b/hw/mem/trace.h
new file mode 100644
index 0000000..2f2c945
--- /dev/null
+++ b/hw/mem/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_mem.h"
diff --git a/hw/mips/trace.h b/hw/mips/trace.h
new file mode 100644
index 0000000..8d1fd7c
--- /dev/null
+++ b/hw/mips/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_mips.h"
diff --git a/hw/misc/macio/trace.h b/hw/misc/macio/trace.h
new file mode 100644
index 0000000..34a3cf1
--- /dev/null
+++ b/hw/misc/macio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_misc_macio.h"
diff --git a/hw/misc/trace.h b/hw/misc/trace.h
new file mode 100644
index 0000000..1ab6923
--- /dev/null
+++ b/hw/misc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_misc.h"
diff --git a/hw/net/trace.h b/hw/net/trace.h
new file mode 100644
index 0000000..93249af
--- /dev/null
+++ b/hw/net/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_net.h"
diff --git a/hw/nvram/trace.h b/hw/nvram/trace.h
new file mode 100644
index 0000000..88fa900
--- /dev/null
+++ b/hw/nvram/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_nvram.h"
diff --git a/hw/pci-host/trace.h b/hw/pci-host/trace.h
new file mode 100644
index 0000000..93ec814
--- /dev/null
+++ b/hw/pci-host/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_pci_host.h"
diff --git a/hw/pci/trace.h b/hw/pci/trace.h
new file mode 100644
index 0000000..3dd773e
--- /dev/null
+++ b/hw/pci/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_pci.h"
diff --git a/hw/ppc/trace.h b/hw/ppc/trace.h
new file mode 100644
index 0000000..87c4198
--- /dev/null
+++ b/hw/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ppc.h"
diff --git a/hw/rdma/trace.h b/hw/rdma/trace.h
new file mode 100644
index 0000000..b3fa8eb
--- /dev/null
+++ b/hw/rdma/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rdma.h"
diff --git a/hw/rdma/vmw/trace.h b/hw/rdma/vmw/trace.h
new file mode 100644
index 0000000..3ebc9fb
--- /dev/null
+++ b/hw/rdma/vmw/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rdma_vmw.h"
diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
new file mode 100644
index 0000000..8c0e3ca
--- /dev/null
+++ b/hw/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_riscv.h"
diff --git a/hw/rtc/trace.h b/hw/rtc/trace.h
new file mode 100644
index 0000000..cfd5d6e
--- /dev/null
+++ b/hw/rtc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rtc.h"
diff --git a/hw/s390x/trace.h b/hw/s390x/trace.h
new file mode 100644
index 0000000..d6568b3
--- /dev/null
+++ b/hw/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_s390x.h"
diff --git a/hw/scsi/trace.h b/hw/scsi/trace.h
new file mode 100644
index 0000000..4ce2673
--- /dev/null
+++ b/hw/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_scsi.h"
diff --git a/hw/sd/trace.h b/hw/sd/trace.h
new file mode 100644
index 0000000..f3d0c58
--- /dev/null
+++ b/hw/sd/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sd.h"
diff --git a/hw/sparc/trace.h b/hw/sparc/trace.h
new file mode 100644
index 0000000..625d60c
--- /dev/null
+++ b/hw/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sparc.h"
diff --git a/hw/sparc64/trace.h b/hw/sparc64/trace.h
new file mode 100644
index 0000000..b6ef6e6
--- /dev/null
+++ b/hw/sparc64/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sparc64.h"
diff --git a/hw/ssi/trace.h b/hw/ssi/trace.h
new file mode 100644
index 0000000..0c1de26
--- /dev/null
+++ b/hw/ssi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ssi.h"
diff --git a/hw/timer/trace.h b/hw/timer/trace.h
new file mode 100644
index 0000000..5f72c44
--- /dev/null
+++ b/hw/timer/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_timer.h"
diff --git a/hw/tpm/trace.h b/hw/tpm/trace.h
new file mode 100644
index 0000000..9827c12
--- /dev/null
+++ b/hw/tpm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_tpm.h"
diff --git a/hw/usb/trace.h b/hw/usb/trace.h
new file mode 100644
index 0000000..f3962f2
--- /dev/null
+++ b/hw/usb/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_usb.h"
diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
new file mode 100644
index 0000000..5a343aa
--- /dev/null
+++ b/hw/vfio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio.h"
diff --git a/hw/virtio/trace.h b/hw/virtio/trace.h
new file mode 100644
index 0000000..5d70970
--- /dev/null
+++ b/hw/virtio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_virtio.h"
diff --git a/hw/watchdog/trace.h b/hw/watchdog/trace.h
new file mode 100644
index 0000000..5d84957
--- /dev/null
+++ b/hw/watchdog/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_watchdog.h"
diff --git a/hw/xen/trace.h b/hw/xen/trace.h
new file mode 100644
index 0000000..adba31a
--- /dev/null
+++ b/hw/xen/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_xen.h"
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 79fd3e5..42e3b48 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -10,7 +10,7 @@
 #ifndef _SYSCALL_TRACE_H_
 #define _SYSCALL_TRACE_H_
 
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 /*
  * These helpers just provide a common place for the various
diff --git a/io/trace.h b/io/trace.h
new file mode 100644
index 0000000..92d63a5
--- /dev/null
+++ b/io/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-io.h"
diff --git a/job-qmp.c b/job-qmp.c
index f9a5883..645601b 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -27,7 +27,7 @@
 #include "qemu/job.h"
 #include "qapi/qapi-commands-job.h"
 #include "qapi/error.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 /* Get a job using its ID and acquire its AioContext */
 static Job *find_job(const char *id, AioContext **aio_context, Error **errp)
diff --git a/job.c b/job.c
index 53be57a..8fecf38 100644
--- a/job.c
+++ b/job.c
@@ -29,7 +29,7 @@
 #include "qemu/id.h"
 #include "qemu/main-loop.h"
 #include "block/aio-wait.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qapi/qapi-events-job.h"
 
 static QLIST_HEAD(, Job) jobs = QLIST_HEAD_INITIALIZER(jobs);
diff --git a/linux-user/trace.h b/linux-user/trace.h
new file mode 100644
index 0000000..05518e4
--- /dev/null
+++ b/linux-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-linux_user.h"
diff --git a/migration/trace.h b/migration/trace.h
new file mode 100644
index 0000000..e1a0f4f
--- /dev/null
+++ b/migration/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-migration.h"
diff --git a/monitor/trace.h b/monitor/trace.h
new file mode 100644
index 0000000..f216e31
--- /dev/null
+++ b/monitor/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-monitor.h"
diff --git a/nbd/trace.h b/nbd/trace.h
new file mode 100644
index 0000000..233d08f
--- /dev/null
+++ b/nbd/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-nbd.h"
diff --git a/net/trace.h b/net/trace.h
new file mode 100644
index 0000000..18d42c2
--- /dev/null
+++ b/net/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-net.h"
diff --git a/qapi/trace.h b/qapi/trace.h
new file mode 100644
index 0000000..5c3fb67
--- /dev/null
+++ b/qapi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-qapi.h"
diff --git a/qom/trace.h b/qom/trace.h
new file mode 100644
index 0000000..f2895e6
--- /dev/null
+++ b/qom/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-qom.h"
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 23d82ea..c390c18 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -19,10 +19,7 @@ def generate(events, backend, group):
     active_events = [e for e in events
                      if "disable" not in e.properties]
 
-    if group == "root":
-        header = "trace-root.h"
-    else:
-        header = "trace.h"
+    header = "trace-" + group + ".h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index 33cf6a3..4d84440 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -28,7 +28,7 @@ def vcpu_transform_args(args):
 
 def generate(events, backend, group):
     if group == "root":
-        header = "trace-root.h"
+        header = "trace/trace-root.h"
     else:
         header = "trace.h"
 
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index 2db6317..72576e6 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -41,7 +41,7 @@ def vcpu_transform_args(args, mode):
 
 def generate(events, backend, group):
     if group == "root":
-        header = "trace-root.h"
+        header = "trace/trace-root.h"
     else:
         header = "trace.h"
 
diff --git a/scsi/trace.h b/scsi/trace.h
new file mode 100644
index 0000000..3e4d89a
--- /dev/null
+++ b/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-scsi.h"
diff --git a/softmmu/balloon.c b/softmmu/balloon.c
index 354408c..b89646f 100644
--- a/softmmu/balloon.c
+++ b/softmmu/balloon.c
@@ -28,7 +28,7 @@
 #include "qemu/atomic.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index 04e360e..a799697 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/ioport.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 
diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987..70b9310 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -24,7 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4eb9d1f..0cc86b0 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -90,7 +90,7 @@
 
 #include "disas/disas.h"
 
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
diff --git a/target/arm/trace.h b/target/arm/trace.h
new file mode 100644
index 0000000..60372d8
--- /dev/null
+++ b/target/arm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_arm.h"
diff --git a/target/hppa/trace.h b/target/hppa/trace.h
new file mode 100644
index 0000000..810cc09
--- /dev/null
+++ b/target/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_hppa.h"
diff --git a/target/i386/trace.h b/target/i386/trace.h
new file mode 100644
index 0000000..781e8ec
--- /dev/null
+++ b/target/i386/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_i386.h"
diff --git a/target/mips/trace.h b/target/mips/trace.h
new file mode 100644
index 0000000..f25b88c
--- /dev/null
+++ b/target/mips/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_mips.h"
diff --git a/target/ppc/trace.h b/target/ppc/trace.h
new file mode 100644
index 0000000..a9e8962
--- /dev/null
+++ b/target/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_ppc.h"
diff --git a/target/riscv/trace.h b/target/riscv/trace.h
new file mode 100644
index 0000000..03a89fc
--- /dev/null
+++ b/target/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_riscv.h"
diff --git a/target/s390x/trace.h b/target/s390x/trace.h
new file mode 100644
index 0000000..d7d59d4
--- /dev/null
+++ b/target/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_s390x.h"
diff --git a/target/sparc/trace.h b/target/sparc/trace.h
new file mode 100644
index 0000000..3b2f5a8
--- /dev/null
+++ b/target/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_sparc.h"
diff --git a/trace/control-target.c b/trace/control-target.c
index ceb55c7..e293eee 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/control.h"
 
 
diff --git a/trace/control.c b/trace/control.c
index 6558b5c..c63a4de 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 
 int trace_events_enabled_count;
 
diff --git a/ui/trace.h b/ui/trace.h
new file mode 100644
index 0000000..a89d769
--- /dev/null
+++ b/ui/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-ui.h"
diff --git a/util/trace.h b/util/trace.h
new file mode 100644
index 0000000..86ff7a3
--- /dev/null
+++ b/util/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-util.h"
-- 
1.8.3.1



