Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD24C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256D720767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256D720767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn3B-0001jh-8H
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kDmv2-0003NF-R0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:56:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:49046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kDmuz-0004ZW-Lq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:56:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 50CF7B6B1;
 Thu,  3 Sep 2020 10:56:27 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v7 14/16] whpx: remove whpx specific functions from global
 includes
Date: Thu,  3 Sep 2020 12:56:12 +0200
Message-Id: <20200903105614.17772-15-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903105614.17772-1-cfontana@suse.de>
References: <20200903105614.17772-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/meson.build |  1 -
 accel/stubs/whpx-stub.c | 47 -----------------------------------------
 include/sysemu/whpx.h   | 19 -----------------
 target/i386/whpx-cpus.h | 17 +++++++++++++++
 4 files changed, 17 insertions(+), 67 deletions(-)
 delete mode 100644 accel/stubs/whpx-stub.c

diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 3fbe34e5bb..12dd1539af 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -2,4 +2,3 @@ specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
 specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
-specific_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
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
index 2393944954..bdb367d1d0 100644
--- a/target/i386/whpx-cpus.h
+++ b/target/i386/whpx-cpus.h
@@ -14,4 +14,21 @@
 
 extern const CpusAccel whpx_cpus;
 
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
2.26.2


