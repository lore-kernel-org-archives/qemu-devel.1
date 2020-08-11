Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ABAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BABE205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BABE205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5bWB-0003jL-Ed
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5bR3-0002oW-Dq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:03:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:57888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5bQy-0001eH-4v
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:03:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9A14AFAC;
 Tue, 11 Aug 2020 21:03:57 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [RFC v4 13/14] hax: remove hax specific functions from global includes
Date: Tue, 11 Aug 2020 23:03:25 +0200
Message-Id: <20200811210326.4425-14-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200811210326.4425-1-cfontana@suse.de>
References: <20200811210326.4425-1-cfontana@suse.de>
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:05:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Colin Xu <colin.xu@intel.com>, Claudio Fontana <cfontana@suse.de>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 accel/stubs/hax-stub.c    | 10 ----------
 include/sysemu/hax.h      | 17 -----------------
 target/i386/hax-all.c     |  2 +-
 target/i386/hax-cpus.c    |  2 +-
 target/i386/hax-int.h     | 41 +++++++++++++++++++++++++++++++++++++++++
 target/i386/hax-mem.c     |  2 +-
 target/i386/hax-posix.c   |  3 +--
 target/i386/hax-windows.c |  2 +-
 target/i386/hax-windows.h |  2 ++
 9 files changed, 48 insertions(+), 33 deletions(-)
 create mode 100644 target/i386/hax-int.h

diff --git a/accel/stubs/hax-stub.c b/accel/stubs/hax-stub.c
index 7ad190cae2..1a9da83185 100644
--- a/accel/stubs/hax-stub.c
+++ b/accel/stubs/hax-stub.c
@@ -21,13 +21,3 @@ int hax_sync_vcpus(void)
 {
     return 0;
 }
-
-int hax_init_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-int hax_smp_cpu_exec(CPUState *cpu)
-{
-    return -ENOSYS;
-}
diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index 9b27e65cc7..12fb54f990 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -22,29 +22,12 @@
 #ifndef QEMU_HAX_H
 #define QEMU_HAX_H
 
-
 int hax_sync_vcpus(void);
-int hax_init_vcpu(CPUState *cpu);
-int hax_smp_cpu_exec(CPUState *cpu);
-int hax_populate_ram(uint64_t va, uint64_t size);
-
-void hax_cpu_synchronize_state(CPUState *cpu);
-void hax_cpu_synchronize_post_reset(CPUState *cpu);
-void hax_cpu_synchronize_post_init(CPUState *cpu);
-void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
 
 #ifdef CONFIG_HAX
 
 int hax_enabled(void);
 
-#include "qemu/bitops.h"
-#include "exec/memory.h"
-int hax_vcpu_destroy(CPUState *cpu);
-void hax_raise_event(CPUState *cpu);
-void hax_reset_vcpu_state(void *opaque);
-#include "target/i386/hax-interface.h"
-#include "target/i386/hax-i386.h"
-
 #else /* CONFIG_HAX */
 
 #define hax_enabled() (0)
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index fd1ab673d7..6230ad0ea6 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -28,13 +28,13 @@
 #include "exec/address-spaces.h"
 
 #include "qemu-common.h"
-#include "hax-i386.h"
 #include "sysemu/accel.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "hw/boards.h"
 
 #include "hax-cpus.h"
+#include "hax-int.h"
 
 #define DEBUG_HAX 0
 
diff --git a/target/i386/hax-cpus.c b/target/i386/hax-cpus.c
index 69a4162939..902e0b10b5 100644
--- a/target/i386/hax-cpus.c
+++ b/target/i386/hax-cpus.c
@@ -22,12 +22,12 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "hax-i386.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "qemu/guest-random.h"
 
 #include "hax-cpus.h"
+#include "hax-int.h"
 
 static void *hax_cpu_thread_fn(void *arg)
 {
diff --git a/target/i386/hax-int.h b/target/i386/hax-int.h
new file mode 100644
index 0000000000..64083d66e1
--- /dev/null
+++ b/target/i386/hax-int.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *  Xin Xiaohui<xiaohui.xin@intel.com>
+ *  Zhang Xiantao<xiantao.zhang@intel.com>
+ *
+ * Copyright 2016 Google, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef HAX_INT_H
+#define HAX_INT_H
+
+#include "hax-interface.h"
+#include "hax-i386.h"
+
+int hax_init_vcpu(CPUState *cpu);
+int hax_smp_cpu_exec(CPUState *cpu);
+int hax_populate_ram(uint64_t va, uint64_t size);
+
+void hax_cpu_synchronize_state(CPUState *cpu);
+void hax_cpu_synchronize_post_reset(CPUState *cpu);
+void hax_cpu_synchronize_post_init(CPUState *cpu);
+void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
+
+int hax_vcpu_destroy(CPUState *cpu);
+void hax_raise_event(CPUState *cpu);
+void hax_reset_vcpu_state(void *opaque);
+
+#endif /* HAX_INT_H */
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 6bb5a24917..7148b294f3 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -13,7 +13,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
-#include "target/i386/hax-i386.h"
+#include "hax-int.h"
 #include "qemu/queue.h"
 
 #define DEBUG_HAX_MEM 0
diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index 6fb7867d11..431d775cc6 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -14,9 +14,8 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
-#include "target/i386/hax-i386.h"
-
 #include "sysemu/cpus.h"
+#include "hax-int.h"
 
 hax_fd hax_mod_open(void)
 {
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 469b48e608..8bb87859a1 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hax-i386.h"
+#include "hax-int.h"
 
 /*
  * return 0 when success, -1 when driver not loaded,
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 12cbd813dc..cf51731354 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -23,6 +23,8 @@
 #include <winioctl.h>
 #include <windef.h>
 
+#include "hax-int.h"
+
 #define HAX_INVALID_FD INVALID_HANDLE_VALUE
 
 static inline void hax_mod_close(struct hax_state *hax)
-- 
2.16.4


