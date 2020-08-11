Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B31C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF7C206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ftNWE+ZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF7C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5V3x-0005U5-Cj
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5V0Z-0003Dy-GK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:12:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:45409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5V0X-0000zd-H5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597155115;
 bh=UQC8hbt7Y63znu/ljFuJ4oYlMH3w497UZ5X8j02VolI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=ftNWE+ZGwXqhvFCGxjnfZa3bwsh7JP5PMOmGui8HS2tLdDYhEp3XpaQJoFbOjphum
 Yt1VqUr76QQEciPowV8SL9s9wR1XqOqabTFGpjRAf0mkanCjNNvu5aZEljU2iYqzo2
 VHYVEaaiJNPVhrcuNw7Et2ZDu+4p/LoOE8+cSkiU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.79.191.25]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MHXBp-1jsYZO06bZ-00DaTu; Tue, 11 Aug 2020 16:11:55 +0200
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 1/4] Add the NVMM vcpu API
Date: Tue, 11 Aug 2020 16:10:46 +0200
Message-Id: <20200811141049.15824-1-n54@gmx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/W6PhvsDbS0Y3sFFoiUwbXduk6x+G5deAPgTAkCvhGVO95HBIFI
 xBZM9f3Nz1XgrZJYs0e2ilJyGI6x77WsB0OpBLBADRWi0/Hy9WS+PPFE2oc085I6Rql1UPc
 GXfY7utFhM/v+SDEndxv86MeKU7Xe6HmkPd78L3t0porI8yxxu3T6rEkiE5UfUhfDKCFEDJ
 /yTJz7qcOTppRXggZkqGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5PkeTEsxNg=:Nvhi0DtsL4IAZn7uavKbUU
 gic8/KI6K7juNTYcPymBwoFefEPJ1wUChAl8TzLi8oOmBKiCVz3LpX8xVqgFYWQJIvRucCmNQ
 PiWquz7RaxNKjWyg9XZlsQGqHTjVJJtMucISCBEn5jvsiTLks4MejISubAuvRgW83Qo590X5c
 F64VZqUEUnxI7EcsVOjNs+sf25/ZcKZeCIjg00Yp/X6r410gHklLtQ+2qt3spTzXwyPIL+GbE
 jiXP+ppfoecHu0MEnDSCRlOkc/Xahmo3hfm3Ei+nG7r0J21ra2cWMhsCNRa/YfcRe8e7qjVed
 1W0/KZKUDezsW5OYs/Bl8WtykyDxnnA1qztxFAoVVNC14S6CeQV8bbCfOZtdByYJ/nTa9TApg
 iF1M0SJ2JSwpSbD4b7Wt3OAfo7kDVoWC8ULusUOFgnt3MbQ0v8lQC1xwjsXVld3QtVi1PZ2Gl
 dwD5/mMIL0M30ZSn72iYgS59r8EtxgTAk8eVRexpjf1+fJAIBIpy5qfBYXRm0vt5kR2/TghSx
 yfQ0fsCYACeaeeLVWu5rat/P+UpC/2cYDbNmwPh4Q8DYwU26JYou3LqhHR+fkxt0x48hdpWm2
 S4e8qA9AsycPjA7dCdbdFdYtyWRZPESjrpOZcK4ygJqmvF4jt9U0I4C4lwd3BwBGKFxxSIVPT
 I6UNa2gjTJUsAhCY6iHNGpv7tOEBCVJKPoKLpH0WSE5WBfaT7yV1JLw4MmBSwV3rYBuJhfteK
 avJNqH1EGA1aLXZWR1jnzaaJhc51Ai3Dus9n7cc04G5Kbf0pQno+V3Vd9gz83qh2EVcbdEG+m
 b7lk9J8PPC+03qvDkqH58YZguFiGtaj/VFLJKFRvy8X51fs4uWXcBtPn2gY4Oc0zv8uw/77sc
 +ZE+aycckrtZCAdb1I6QW+NVDb8SOXUyphuXKGohTcMx0SeonEv+WIEN+EbYeXedFHogeZwtk
 qHLfcsbGzq/Z56bEVBp2CsRBS0VKkibkO1+vKifcJtG/n6d+Yzx6A2+BtvIrwQLxVy+cClo5l
 +wAJ1LGlrBwUV1SmE310xs7spAbe2LeqllR4TQex9jlAuqZSiagbUyegjygVTuGIq2MmtzBYo
 QhqriSC74Fnreq+EfzqUb2iq7t9OFFbMNPnJXINBaqCHBoxS3D/jzy2UZBwaQnNgzlLB08Tr7
 yPKJ02pr0dMHfLnwp/L2d9uRcU4GmjpqWCGgVYyka4m/ytnP5yG49GfK1HlB35gQBV5iXYJ2V
 YB0ZtrjSr7fnU1UD9
Received-SPF: pass client-ip=212.227.17.20; envelope-from=n54@gmx.com;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:12:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
introduces the nvmm.h sysemu API for managing the vcpu scheduling and
management.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
=2D--
 accel/stubs/Makefile.objs |  1 +
 accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h

diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index bbd14e71fb..38660a0b9b 100644
=2D-- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,6 +1,7 @@
 obj-$(call lnot,$(CONFIG_HAX))  +=3D hax-stub.o
 obj-$(call lnot,$(CONFIG_HVF))  +=3D hvf-stub.o
 obj-$(call lnot,$(CONFIG_WHPX)) +=3D whpx-stub.o
+obj-$(call lnot,$(CONFIG_NVMM)) +=3D nvmm-stub.o
 obj-$(call lnot,$(CONFIG_KVM))  +=3D kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG))  +=3D tcg-stub.o
 obj-$(call lnot,$(CONFIG_XEN))  +=3D xen-stub.o
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 0000000000..c2208b84a3
=2D-- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator stub.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "sysemu/nvmm.h"
+
+int nvmm_init_vcpu(CPUState *cpu)
+{
+    return -1;
+}
+
+int nvmm_vcpu_exec(CPUState *cpu)
+{
+    return -1;
+}
+
+void nvmm_destroy_vcpu(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_state(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
new file mode 100644
index 0000000000..10496f3980
=2D-- /dev/null
+++ b/include/sysemu/nvmm.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator support.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_NVMM_H
+#define QEMU_NVMM_H
+
+#include "config-host.h"
+#include "qemu-common.h"
+
+int nvmm_init_vcpu(CPUState *);
+int nvmm_vcpu_exec(CPUState *);
+void nvmm_destroy_vcpu(CPUState *);
+
+void nvmm_cpu_synchronize_state(CPUState *);
+void nvmm_cpu_synchronize_post_reset(CPUState *);
+void nvmm_cpu_synchronize_post_init(CPUState *);
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *);
+
+#ifdef CONFIG_NVMM
+
+int nvmm_enabled(void);
+
+#else /* CONFIG_NVMM */
+
+#define nvmm_enabled() (0)
+
+#endif /* CONFIG_NVMM */
+
+#endif /* CONFIG_NVMM */
=2D-
2.28.0


