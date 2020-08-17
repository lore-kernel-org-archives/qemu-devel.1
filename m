Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8464320729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSEkW8ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8464320729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gJ5-0008OI-JB
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGV-000320-Jq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGS-00060u-P9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id l2so15247849wrc.7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/WcAi4gDTnnpB9k3+3M1VGeqqwg6I9+HGcTeOqjklrg=;
 b=GSEkW8STij2+LqjVn+8T5Yi5YNhbLW2y1yzwDq280qOvTjfYOMULIXAbk9aaprAOfK
 yBYMID8tGrfW+Exwai2gDj5BJ3DsKz4Ipaw+foltkvQHbtQFad8SsPNOOPbiIApwuz9y
 KZ/8xXUhHTMT2ybfEYyr/R4C8VxiaKDCzAbPOW7f4NPZ15VLGnKOB5HyJ+5v7INOvC0O
 yH4XA3HyiMTkkfiVtUHlsuN4AL6BBSNvdU0MwWyMQddIlc8r06N/ZdFqqXVarY0ahh3k
 LtsZlfmhLhYTXag0mVjysPfkmPFHhz9EuINJzrxpXIKa9/mxegTQTKjF4ovPMOEfA79S
 599g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/WcAi4gDTnnpB9k3+3M1VGeqqwg6I9+HGcTeOqjklrg=;
 b=iE1Won5gQ7ZaujZ95R3d5sJ86pML/6LY3xmlTM6yky04WiWjXyl3Y07fin2PbeWx0h
 f8WQRA8aQ6YgpUKkFVoZa5GBuTCbmQgZ+TkLKWlYHL0D9+uQTqVz8vZEzBN1xgCVXgsg
 KD2urhv1GYq0xB5cKrfqZ3TTvVv0x4HJ8d+ek3emnhsm4izBkteL8QHUn1pp38HUp10L
 xKdAVsIDCpY2anxVK7ejHQL7ZE4L7c1wNwRTftxHAoBU7uSmbMpuFvzbK42k58voL9u7
 Xq4yGgl5y3r3TY6Rcp1MiKlpeQFwtQG/oc6uvGjW8MzUKifG5GRM5Dz930aQy0u/vPMd
 lhBw==
X-Gm-Message-State: AOAM531BsXYD9mGL9B7Ta+06ZX6LfwCStuEGz9IOPtsSnMStfHciZ8ju
 uZijZSpP//vtTtzylGZtltL2c8C4/yU=
X-Google-Smtp-Source: ABdhPJzPyeMTFOTPzoU/8Y7Ux0uTLeIifZhz4vJoDwcy1evcs5O4jJQG5m77FRZnwTsJeu3xUlBGMQ==
X-Received: by 2002:adf:f606:: with SMTP id t6mr16715701wrp.182.1597675050109; 
 Mon, 17 Aug 2020 07:37:30 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.29 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 004/150] trace: switch position of headers to what Meson
 requires
Date: Mon, 17 Aug 2020 16:34:57 +0200
Message-Id: <20200817143723.343284-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x435.google.com
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
 Makefile                                 | 46 ++++++++++++++----------
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
 scripts/tracetool/format/c.py            |  5 +--
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
index 2992d15931..656e39050b 100644
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
index 13dd708c4a..00cadebf99 100644
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
index d22b3b45d7..3823463c23 100644
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
index 0000000000..67c935a6f7
--- /dev/null
+++ b/accel/kvm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_kvm.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5698292749..5349ee6b0e 100644
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
index 0000000000..db61fad3c6
--- /dev/null
+++ b/accel/tcg/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-accel_tcg.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d8b027f8c1..1d34c57ff5 100644
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
index 0000000000..4072a11b0f
--- /dev/null
+++ b/audio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-audio.h"
diff --git a/authz/trace.h b/authz/trace.h
new file mode 100644
index 0000000000..3176c127f7
--- /dev/null
+++ b/authz/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-authz.h"
diff --git a/backends/tpm/trace.h b/backends/tpm/trace.h
new file mode 100644
index 0000000000..40c4729884
--- /dev/null
+++ b/backends/tpm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-backends_tpm.h"
diff --git a/backends/trace.h b/backends/trace.h
new file mode 100644
index 0000000000..77fe57f36c
--- /dev/null
+++ b/backends/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-backends.h"
diff --git a/block/trace.h b/block/trace.h
new file mode 100644
index 0000000000..3a436e6c7f
--- /dev/null
+++ b/block/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-block.h"
diff --git a/chardev/trace.h b/chardev/trace.h
new file mode 100644
index 0000000000..eb4f9027a1
--- /dev/null
+++ b/chardev/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-chardev.h"
diff --git a/crypto/trace.h b/crypto/trace.h
new file mode 100644
index 0000000000..a9af0f315c
--- /dev/null
+++ b/crypto/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-crypto.h"
diff --git a/dma-helpers.c b/dma-helpers.c
index 2a77b5a9cb..41ef24a63b 100644
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
index 6f381f98e2..8047bf2ff9 100644
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
index f3a318cd7f..9dfb6e4142 100644
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
index 0000000000..6104fe2a77
--- /dev/null
+++ b/hw/9pfs/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_9pfs.h"
diff --git a/hw/acpi/trace.h b/hw/acpi/trace.h
new file mode 100644
index 0000000000..a7f7da7009
--- /dev/null
+++ b/hw/acpi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_acpi.h"
diff --git a/hw/alpha/trace.h b/hw/alpha/trace.h
new file mode 100644
index 0000000000..20fe698191
--- /dev/null
+++ b/hw/alpha/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_alpha.h"
diff --git a/hw/arm/trace.h b/hw/arm/trace.h
new file mode 100644
index 0000000000..91337aa6b0
--- /dev/null
+++ b/hw/arm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_arm.h"
diff --git a/hw/audio/trace.h b/hw/audio/trace.h
new file mode 100644
index 0000000000..5c7516a4d1
--- /dev/null
+++ b/hw/audio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_audio.h"
diff --git a/hw/block/dataplane/trace.h b/hw/block/dataplane/trace.h
new file mode 100644
index 0000000000..240cc59834
--- /dev/null
+++ b/hw/block/dataplane/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_block_dataplane.h"
diff --git a/hw/block/trace.h b/hw/block/trace.h
new file mode 100644
index 0000000000..cde210ae69
--- /dev/null
+++ b/hw/block/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_block.h"
diff --git a/hw/char/trace.h b/hw/char/trace.h
new file mode 100644
index 0000000000..c2df66af2e
--- /dev/null
+++ b/hw/char/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_char.h"
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 594441a150..22bc3f974a 100644
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
index 0000000000..23dfd61c49
--- /dev/null
+++ b/hw/core/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_core.h"
diff --git a/hw/display/trace.h b/hw/display/trace.h
new file mode 100644
index 0000000000..4ed0e9165b
--- /dev/null
+++ b/hw/display/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_display.h"
diff --git a/hw/dma/trace.h b/hw/dma/trace.h
new file mode 100644
index 0000000000..4bcb28b47c
--- /dev/null
+++ b/hw/dma/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_dma.h"
diff --git a/hw/gpio/trace.h b/hw/gpio/trace.h
new file mode 100644
index 0000000000..8b139071bc
--- /dev/null
+++ b/hw/gpio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_gpio.h"
diff --git a/hw/hppa/trace.h b/hw/hppa/trace.h
new file mode 100644
index 0000000000..4e8b52dc28
--- /dev/null
+++ b/hw/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_hppa.h"
diff --git a/hw/hyperv/trace.h b/hw/hyperv/trace.h
new file mode 100644
index 0000000000..7f2a88881b
--- /dev/null
+++ b/hw/hyperv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_hyperv.h"
diff --git a/hw/i2c/trace.h b/hw/i2c/trace.h
new file mode 100644
index 0000000000..4843a8d544
--- /dev/null
+++ b/hw/i2c/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i2c.h"
diff --git a/hw/i386/trace.h b/hw/i386/trace.h
new file mode 100644
index 0000000000..37a9f67e5d
--- /dev/null
+++ b/hw/i386/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i386.h"
diff --git a/hw/i386/xen/trace.h b/hw/i386/xen/trace.h
new file mode 100644
index 0000000000..a02bf755dc
--- /dev/null
+++ b/hw/i386/xen/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_i386_xen.h"
diff --git a/hw/ide/trace.h b/hw/ide/trace.h
new file mode 100644
index 0000000000..e060e0aef1
--- /dev/null
+++ b/hw/ide/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ide.h"
diff --git a/hw/input/trace.h b/hw/input/trace.h
new file mode 100644
index 0000000000..d1cc5d924c
--- /dev/null
+++ b/hw/input/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_input.h"
diff --git a/hw/intc/trace.h b/hw/intc/trace.h
new file mode 100644
index 0000000000..02394aea20
--- /dev/null
+++ b/hw/intc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_intc.h"
diff --git a/hw/isa/trace.h b/hw/isa/trace.h
new file mode 100644
index 0000000000..501205cfc1
--- /dev/null
+++ b/hw/isa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_isa.h"
diff --git a/hw/mem/trace.h b/hw/mem/trace.h
new file mode 100644
index 0000000000..2f2c945407
--- /dev/null
+++ b/hw/mem/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_mem.h"
diff --git a/hw/mips/trace.h b/hw/mips/trace.h
new file mode 100644
index 0000000000..8d1fd7c9e2
--- /dev/null
+++ b/hw/mips/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_mips.h"
diff --git a/hw/misc/macio/trace.h b/hw/misc/macio/trace.h
new file mode 100644
index 0000000000..34a3cf1b42
--- /dev/null
+++ b/hw/misc/macio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_misc_macio.h"
diff --git a/hw/misc/trace.h b/hw/misc/trace.h
new file mode 100644
index 0000000000..1ab6923d11
--- /dev/null
+++ b/hw/misc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_misc.h"
diff --git a/hw/net/trace.h b/hw/net/trace.h
new file mode 100644
index 0000000000..93249af0ac
--- /dev/null
+++ b/hw/net/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_net.h"
diff --git a/hw/nvram/trace.h b/hw/nvram/trace.h
new file mode 100644
index 0000000000..88fa900ad3
--- /dev/null
+++ b/hw/nvram/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_nvram.h"
diff --git a/hw/pci-host/trace.h b/hw/pci-host/trace.h
new file mode 100644
index 0000000000..93ec814a73
--- /dev/null
+++ b/hw/pci-host/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_pci_host.h"
diff --git a/hw/pci/trace.h b/hw/pci/trace.h
new file mode 100644
index 0000000000..3dd773e22a
--- /dev/null
+++ b/hw/pci/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_pci.h"
diff --git a/hw/ppc/trace.h b/hw/ppc/trace.h
new file mode 100644
index 0000000000..87c4198e61
--- /dev/null
+++ b/hw/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ppc.h"
diff --git a/hw/rdma/trace.h b/hw/rdma/trace.h
new file mode 100644
index 0000000000..b3fa8ebc51
--- /dev/null
+++ b/hw/rdma/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rdma.h"
diff --git a/hw/rdma/vmw/trace.h b/hw/rdma/vmw/trace.h
new file mode 100644
index 0000000000..3ebc9fb7ad
--- /dev/null
+++ b/hw/rdma/vmw/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rdma_vmw.h"
diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
new file mode 100644
index 0000000000..8c0e3ca1f3
--- /dev/null
+++ b/hw/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_riscv.h"
diff --git a/hw/rtc/trace.h b/hw/rtc/trace.h
new file mode 100644
index 0000000000..cfd5d6ee62
--- /dev/null
+++ b/hw/rtc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_rtc.h"
diff --git a/hw/s390x/trace.h b/hw/s390x/trace.h
new file mode 100644
index 0000000000..d6568b3648
--- /dev/null
+++ b/hw/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_s390x.h"
diff --git a/hw/scsi/trace.h b/hw/scsi/trace.h
new file mode 100644
index 0000000000..4ce2673582
--- /dev/null
+++ b/hw/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_scsi.h"
diff --git a/hw/sd/trace.h b/hw/sd/trace.h
new file mode 100644
index 0000000000..f3d0c58563
--- /dev/null
+++ b/hw/sd/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sd.h"
diff --git a/hw/sparc/trace.h b/hw/sparc/trace.h
new file mode 100644
index 0000000000..625d60ca70
--- /dev/null
+++ b/hw/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sparc.h"
diff --git a/hw/sparc64/trace.h b/hw/sparc64/trace.h
new file mode 100644
index 0000000000..b6ef6e611d
--- /dev/null
+++ b/hw/sparc64/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sparc64.h"
diff --git a/hw/ssi/trace.h b/hw/ssi/trace.h
new file mode 100644
index 0000000000..0c1de2679e
--- /dev/null
+++ b/hw/ssi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_ssi.h"
diff --git a/hw/timer/trace.h b/hw/timer/trace.h
new file mode 100644
index 0000000000..5f72c441b0
--- /dev/null
+++ b/hw/timer/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_timer.h"
diff --git a/hw/tpm/trace.h b/hw/tpm/trace.h
new file mode 100644
index 0000000000..9827c128aa
--- /dev/null
+++ b/hw/tpm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_tpm.h"
diff --git a/hw/usb/trace.h b/hw/usb/trace.h
new file mode 100644
index 0000000000..f3962f2baf
--- /dev/null
+++ b/hw/usb/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_usb.h"
diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
new file mode 100644
index 0000000000..5a343aa59c
--- /dev/null
+++ b/hw/vfio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio.h"
diff --git a/hw/virtio/trace.h b/hw/virtio/trace.h
new file mode 100644
index 0000000000..5d7097061b
--- /dev/null
+++ b/hw/virtio/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_virtio.h"
diff --git a/hw/watchdog/trace.h b/hw/watchdog/trace.h
new file mode 100644
index 0000000000..5d8495752b
--- /dev/null
+++ b/hw/watchdog/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_watchdog.h"
diff --git a/hw/xen/trace.h b/hw/xen/trace.h
new file mode 100644
index 0000000000..adba31a136
--- /dev/null
+++ b/hw/xen/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_xen.h"
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 79fd3e5aa9..42e3b48b03 100644
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
index 0000000000..92d63a5bfc
--- /dev/null
+++ b/io/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-io.h"
diff --git a/job-qmp.c b/job-qmp.c
index f9a58832e1..645601b2cc 100644
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
index 53be57a3a0..8fecf38960 100644
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
index 0000000000..05518e4694
--- /dev/null
+++ b/linux-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-linux_user.h"
diff --git a/migration/trace.h b/migration/trace.h
new file mode 100644
index 0000000000..e1a0f4fb74
--- /dev/null
+++ b/migration/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-migration.h"
diff --git a/monitor/trace.h b/monitor/trace.h
new file mode 100644
index 0000000000..f216e31be5
--- /dev/null
+++ b/monitor/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-monitor.h"
diff --git a/nbd/trace.h b/nbd/trace.h
new file mode 100644
index 0000000000..233d08fdd1
--- /dev/null
+++ b/nbd/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-nbd.h"
diff --git a/net/trace.h b/net/trace.h
new file mode 100644
index 0000000000..18d42c29b6
--- /dev/null
+++ b/net/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-net.h"
diff --git a/qapi/trace.h b/qapi/trace.h
new file mode 100644
index 0000000000..5c3fb674d8
--- /dev/null
+++ b/qapi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-qapi.h"
diff --git a/qom/trace.h b/qom/trace.h
new file mode 100644
index 0000000000..f2895e699b
--- /dev/null
+++ b/qom/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-qom.h"
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 23d82ea861..c390c1844a 100644
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
index 33cf6a31b3..4d84440aff 100644
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
index 2db6317f3c..72576e67d1 100644
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
index 0000000000..3e4d89a3a5
--- /dev/null
+++ b/scsi/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-scsi.h"
diff --git a/softmmu/balloon.c b/softmmu/balloon.c
index 354408c6ea..b89646f85d 100644
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
index 04e360e79a..a799697c5d 100644
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
index af25987518..70b93104e8 100644
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
index 4eb9d1f7fd..0cc86b0766 100644
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
index 0000000000..60372d8e26
--- /dev/null
+++ b/target/arm/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_arm.h"
diff --git a/target/hppa/trace.h b/target/hppa/trace.h
new file mode 100644
index 0000000000..810cc09692
--- /dev/null
+++ b/target/hppa/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_hppa.h"
diff --git a/target/i386/trace.h b/target/i386/trace.h
new file mode 100644
index 0000000000..781e8ec55c
--- /dev/null
+++ b/target/i386/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_i386.h"
diff --git a/target/mips/trace.h b/target/mips/trace.h
new file mode 100644
index 0000000000..f25b88ca6f
--- /dev/null
+++ b/target/mips/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_mips.h"
diff --git a/target/ppc/trace.h b/target/ppc/trace.h
new file mode 100644
index 0000000000..a9e8962828
--- /dev/null
+++ b/target/ppc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_ppc.h"
diff --git a/target/riscv/trace.h b/target/riscv/trace.h
new file mode 100644
index 0000000000..03a89fcd9b
--- /dev/null
+++ b/target/riscv/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_riscv.h"
diff --git a/target/s390x/trace.h b/target/s390x/trace.h
new file mode 100644
index 0000000000..d7d59d4aba
--- /dev/null
+++ b/target/s390x/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_s390x.h"
diff --git a/target/sparc/trace.h b/target/sparc/trace.h
new file mode 100644
index 0000000000..3b2f5a8e29
--- /dev/null
+++ b/target/sparc/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_sparc.h"
diff --git a/trace/control-target.c b/trace/control-target.c
index ceb55c70ce..e293eeed7c 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include "trace/trace-root.h"
 #include "trace/control.h"
 
 
diff --git a/trace/control.c b/trace/control.c
index 6558b5c906..c63a4de732 100644
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
index 0000000000..a89d769623
--- /dev/null
+++ b/ui/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-ui.h"
diff --git a/util/trace.h b/util/trace.h
new file mode 100644
index 0000000000..86ff7a390c
--- /dev/null
+++ b/util/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-util.h"
-- 
2.26.2



