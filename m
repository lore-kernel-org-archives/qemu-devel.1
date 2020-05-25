Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E997C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3644820888
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3644820888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEZp-00087Z-F8
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdEV7-0002v7-Jc
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdEV5-00043A-OM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FD1BAC5F;
 Mon, 25 May 2020 14:54:47 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [RFC v3 1/4] softmmu: move softmmu only files from root
Date: Mon, 25 May 2020 16:54:37 +0200
Message-Id: <20200525145440.29728-2-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200525145440.29728-1-cfontana@suse.de>
References: <20200525145440.29728-1-cfontana@suse.de>
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

move arch_init, balloon, cpus, ioport, memory, memory_mapping, qtest.

They are all specific to CONFIG_SOFTMMU.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 MAINTAINERS                                  | 12 ++++++------
 Makefile.target                              |  7 ++-----
 softmmu/Makefile.objs                        | 10 ++++++++++
 arch_init.c => softmmu/arch_init.c           |  0
 balloon.c => softmmu/balloon.c               |  0
 cpus.c => softmmu/cpus.c                     |  0
 ioport.c => softmmu/ioport.c                 |  0
 memory.c => softmmu/memory.c                 |  0
 memory_mapping.c => softmmu/memory_mapping.c |  0
 qtest.c => softmmu/qtest.c                   |  0
 10 files changed, 18 insertions(+), 11 deletions(-)
 rename arch_init.c => softmmu/arch_init.c (100%)
 rename balloon.c => softmmu/balloon.c (100%)
 rename cpus.c => softmmu/cpus.c (100%)
 rename ioport.c => softmmu/ioport.c (100%)
 rename memory.c => softmmu/memory.c (100%)
 rename memory_mapping.c => softmmu/memory_mapping.c (100%)
 rename qtest.c => softmmu/qtest.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3690f313c3..0288ffbc50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -114,7 +114,7 @@ Overall TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: cpus.c
+F: softmmu/cpus.c
 F: cpus-common.c
 F: exec.c
 F: accel/tcg/
@@ -1668,7 +1668,7 @@ M: David Hildenbrand <david@redhat.com>
 S: Maintained
 F: hw/virtio/virtio-balloon*.c
 F: include/hw/virtio/virtio-balloon.h
-F: balloon.c
+F: softmmu/balloon.c
 F: include/sysemu/balloon.h
 
 virtio-9p
@@ -2110,12 +2110,12 @@ Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/exec/ioport.h
-F: ioport.c
 F: include/exec/memop.h
 F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
-F: memory.c
+F: softmmu/ioport.c
+F: softmmu/memory.c
 F: include/exec/memory-internal.h
 F: exec.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
@@ -2147,7 +2147,7 @@ F: ui/cocoa.m
 Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: cpus.c
+F: softmmu/cpus.c
 F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: util/main-loop.c
@@ -2306,7 +2306,7 @@ M: Thomas Huth <thuth@redhat.com>
 M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: qtest.c
+F: softmmu/qtest.c
 F: accel/qtest.c
 F: tests/qtest/
 
diff --git a/Makefile.target b/Makefile.target
index 8ed1eba95b..7fbf5d8b92 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -152,16 +152,13 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
-obj-y += qtest.o
+obj-y += softmmu/
+obj-y += gdbstub.o
 obj-y += dump/
 obj-y += hw/
 obj-y += monitor/
 obj-y += qapi/
-obj-y += memory.o
-obj-y += memory_mapping.o
 obj-y += migration/ram.o
-obj-y += softmmu/
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Hardware support
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index dd15c24346..a4bd9f2f52 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,3 +1,13 @@
 softmmu-main-y = softmmu/main.o
+
+obj-y += arch_init.o
+obj-y += cpus.o
+obj-y += balloon.o
+obj-y += ioport.o
+obj-y += memory.o
+obj-y += memory_mapping.o
+
+obj-y += qtest.o
+
 obj-y += vl.o
 vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/arch_init.c b/softmmu/arch_init.c
similarity index 100%
rename from arch_init.c
rename to softmmu/arch_init.c
diff --git a/balloon.c b/softmmu/balloon.c
similarity index 100%
rename from balloon.c
rename to softmmu/balloon.c
diff --git a/cpus.c b/softmmu/cpus.c
similarity index 100%
rename from cpus.c
rename to softmmu/cpus.c
diff --git a/ioport.c b/softmmu/ioport.c
similarity index 100%
rename from ioport.c
rename to softmmu/ioport.c
diff --git a/memory.c b/softmmu/memory.c
similarity index 100%
rename from memory.c
rename to softmmu/memory.c
diff --git a/memory_mapping.c b/softmmu/memory_mapping.c
similarity index 100%
rename from memory_mapping.c
rename to softmmu/memory_mapping.c
diff --git a/qtest.c b/softmmu/qtest.c
similarity index 100%
rename from qtest.c
rename to softmmu/qtest.c
-- 
2.16.4


