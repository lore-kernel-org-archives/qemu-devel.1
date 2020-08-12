Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A26C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36182078B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36182078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vcf-0007fj-Um
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5vYh-0000L4-Bk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:33:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5vYc-0002E9-8Z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:33:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D456CAE0A;
 Wed, 12 Aug 2020 18:33:21 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v5 11/14] hvf: remove hvf specific functions from global
 includes
Date: Wed, 12 Aug 2020 20:32:47 +0200
Message-Id: <20200812183250.9221-12-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200812183250.9221-1-cfontana@suse.de>
References: <20200812183250.9221-1-cfontana@suse.de>
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 23:47:43
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
 accel/stubs/Makefile.objs  |  1 -
 accel/stubs/hvf-stub.c     | 30 ------------------------------
 include/sysemu/hvf.h       |  8 --------
 target/i386/hvf/hvf-cpus.h |  8 ++++++++
 target/i386/hvf/x86hvf.c   |  2 ++
 target/i386/hvf/x86hvf.h   |  1 -
 6 files changed, 10 insertions(+), 40 deletions(-)
 delete mode 100644 accel/stubs/hvf-stub.c

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index bbd14e71fb..6630954f30 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,5 +1,4 @@
 obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
-obj-$(call lnot,$(CONFIG_HVF))  += hvf-stub.o
 obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
deleted file mode 100644
index e81dfe888c..0000000000
--- a/accel/stubs/hvf-stub.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * QEMU HVF support
- *
- * Copyright 2017 Red Hat, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2 or later, as published by the Free Software Foundation,
- * and may be copied, distributed, and modified under those terms.
- *
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "sysemu/hvf.h"
-
-int hvf_init_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-int hvf_vcpu_exec(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
-void hvf_vcpu_destroy(CPUState *cpu)
-{
-}
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 6d3ee4fdb7..b4f7191dd9 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -23,14 +23,6 @@ extern bool hvf_allowed;
 #define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif /* !CONFIG_HVF */
 
-int hvf_init_vcpu(CPUState *);
-int hvf_vcpu_exec(CPUState *);
-void hvf_cpu_synchronize_state(CPUState *);
-void hvf_cpu_synchronize_post_reset(CPUState *);
-void hvf_cpu_synchronize_post_init(CPUState *);
-void hvf_cpu_synchronize_pre_loadvm(CPUState *);
-void hvf_vcpu_destroy(CPUState *);
-
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
 #define HVF_STATE(obj) \
diff --git a/target/i386/hvf/hvf-cpus.h b/target/i386/hvf/hvf-cpus.h
index b66f4889b0..da4a990451 100644
--- a/target/i386/hvf/hvf-cpus.h
+++ b/target/i386/hvf/hvf-cpus.h
@@ -14,4 +14,12 @@
 
 extern CpusAccel hvf_cpus;
 
+int hvf_init_vcpu(CPUState *);
+int hvf_vcpu_exec(CPUState *);
+void hvf_cpu_synchronize_state(CPUState *);
+void hvf_cpu_synchronize_post_reset(CPUState *);
+void hvf_cpu_synchronize_post_init(CPUState *);
+void hvf_cpu_synchronize_pre_loadvm(CPUState *);
+void hvf_vcpu_destroy(CPUState *);
+
 #endif /* HVF_CPUS_H */
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 5cbcb32ab6..b986213c0f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -32,6 +32,8 @@
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 
+#include "hvf-cpus.h"
+
 void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
                      SegmentCache *qseg, bool is_tr)
 {
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 79539f7282..4fabc6d582 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -35,5 +35,4 @@ void hvf_get_msrs(CPUState *cpu_state);
 void vmx_clear_int_window_exiting(CPUState *cpu);
 void hvf_get_segments(CPUState *cpu_state);
 void vmx_update_tpr(CPUState *cpu);
-void hvf_cpu_synchronize_state(CPUState *cpu_state);
 #endif
-- 
2.16.4


