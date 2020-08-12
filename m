Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91254C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661612078B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661612078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vcb-0007Vb-HK
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5vYq-0000UX-AG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:33:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:40840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5vYn-0002EC-TF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:33:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7A3EAAF90;
 Wed, 12 Aug 2020 18:33:22 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v5 12/14] whpx: remove whpx specific functions from global
 includes
Date: Wed, 12 Aug 2020 20:32:48 +0200
Message-Id: <20200812183250.9221-13-cfontana@suse.de>
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
 accel/stubs/Makefile.objs |  1 -
 accel/stubs/whpx-stub.c   | 47 -----------------------------------------------
 include/sysemu/whpx.h     | 19 -------------------
 target/i386/whpx-cpus.h   | 17 +++++++++++++++++
 4 files changed, 17 insertions(+), 67 deletions(-)
 delete mode 100644 accel/stubs/whpx-stub.c

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index 6630954f30..3c2a2fedc4 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,5 +1,4 @@
 obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
-obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
 obj-$(call lnot,$(CONFIG_XEN))  += xen-stub.o
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
deleted file mode 100644
index 1efb89f25e..0000000000
--- a/accel/stubs/whpx-stub.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * QEMU Windows Hypervisor Platform accelerator (WHPX) stub
- *
- * Copyright Microsoft Corp. 2017
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "sysemu/whpx.h"
-
-int whpx_init_vcpu(CPUState *cpu)
-{
-    return -1;
-}
-
-int whpx_vcpu_exec(CPUState *cpu)
-{
-    return -1;
-}
-
-void whpx_destroy_vcpu(CPUState *cpu)
-{
-}
-
-void whpx_vcpu_kick(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_post_reset(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_post_init(CPUState *cpu)
-{
-}
-
-void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
-{
-}
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index a84b49e749..59edf13742 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -13,18 +13,6 @@
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
 
-
-int whpx_init_vcpu(CPUState *cpu);
-int whpx_vcpu_exec(CPUState *cpu);
-void whpx_destroy_vcpu(CPUState *cpu);
-void whpx_vcpu_kick(CPUState *cpu);
-
-
-void whpx_cpu_synchronize_state(CPUState *cpu);
-void whpx_cpu_synchronize_post_reset(CPUState *cpu);
-void whpx_cpu_synchronize_post_init(CPUState *cpu);
-void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
-
 #ifdef CONFIG_WHPX
 
 int whpx_enabled(void);
@@ -35,11 +23,4 @@ int whpx_enabled(void);
 
 #endif /* CONFIG_WHPX */
 
-/* state subset only touched by the VCPU itself during runtime */
-#define WHPX_SET_RUNTIME_STATE   1
-/* state subset modified during VCPU reset */
-#define WHPX_SET_RESET_STATE     2
-/* full state set, modified during initialization or on vmload */
-#define WHPX_SET_FULL_STATE      3
-
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/whpx-cpus.h b/target/i386/whpx-cpus.h
index 60b7be3735..165e721589 100644
--- a/target/i386/whpx-cpus.h
+++ b/target/i386/whpx-cpus.h
@@ -14,4 +14,21 @@
 
 extern CpusAccel whpx_cpus;
 
+int whpx_init_vcpu(CPUState *cpu);
+int whpx_vcpu_exec(CPUState *cpu);
+void whpx_destroy_vcpu(CPUState *cpu);
+void whpx_vcpu_kick(CPUState *cpu);
+
+void whpx_cpu_synchronize_state(CPUState *cpu);
+void whpx_cpu_synchronize_post_reset(CPUState *cpu);
+void whpx_cpu_synchronize_post_init(CPUState *cpu);
+void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
+
+/* state subset only touched by the VCPU itself during runtime */
+#define WHPX_SET_RUNTIME_STATE   1
+/* state subset modified during VCPU reset */
+#define WHPX_SET_RESET_STATE     2
+/* full state set, modified during initialization or on vmload */
+#define WHPX_SET_FULL_STATE      3
+
 #endif /* WHPX_CPUS_H */
-- 
2.16.4


