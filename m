Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B4C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE117208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OLIdfRRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE117208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iophA-0000mt-1C
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iooNn-0003V2-QI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iooNm-0000tL-8X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:34979)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iooNl-0000r6-V8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578401685;
 bh=Esy/6Z9NMXlz6p4L3fdFRS0GPpSdZw4kBhSs2vKJIV8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OLIdfRRGkA1fEOXI1WAMZvtjgaafqUbQdDQC3wpXYNC2yRBzzyJ89eMJCpQOfUCYY
 VglFqkK8o6j67ksmM6qbiS/Lz5ZQOdIPuTs5Y++JaP3gXcecNtF0Xoy248EeRZoY+r
 IMVRedOqjStovLh1Suc5GrcWmy0B/Bg9NCQQxyCA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M5fMe-1in8M23BGc-007H5v; Tue, 07 Jan 2020 13:54:44 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] Add the NVMM acceleration enlightenments
Date: Tue,  7 Jan 2020 13:54:01 +0100
Message-Id: <20200107125401.18126-5-n54@gmx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200107125401.18126-1-n54@gmx.com>
References: <20200107125401.18126-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vNZ6nz0iU75MIVWsUHT2AsPq62FvQ01v2ST4svHbbtuRxqgN5AZ
 BlnZyWsn2FN5jgGspMcwXymWa+PqVsaxscv3CiU7ZxmVnXMTsIIeyiW85cnizPumaWku7Yl
 e+CCtdsTEZcnWJv7laXJyB7M2QkKIfjTibQsfT8jHXYVHcwnJ0I8FNY67cgOaR+Uzur9amE
 unE4oP+fUwnrrN9VbW3kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOcp1Ra8bCE=:W0c4Nc5RZAwy4zAqiBXP2r
 7CAX/p4zeXc4tiMP1HDEpgXNvCi7caR9OFCtX9kM3eedW+KhFW28hdFsiQ1cfoiBwnm5F7236
 jEOXa49RY7f/jm0yQ2UiZQQntaH5eNL1dyHaiiGIv1kjylwqhNcfTy5eQ3w+lpT4iL6Q4BtBm
 QujXpkzgm75WN3KgpMILFc36Zk258qOy+qndqzuPN7OtIHvEowL8xC8ivbWzNIBJSzZpazNXj
 Lg7G6boBaS+w8EiJg8yxMHasdx1B/Id1p+WqOOsHIeigSC/qBd2AyEpXvUdyxTAxmOL2SMmaO
 KYZprv14TinmwipAFuUJdMhq3Et2RtLsCOuZ9GPJXHkAdhdOqv55M93itbT2+hSXu/w2V9WAj
 zN/DHD47J9lY/4jXEe5q9EcZC4lvQs1dHYJ+5ER9fi1yen9Pg6mwGsQiOpYmsRUx2yH/+cTg5
 sfJdnlVuhcAO+LggB0qPHA0pni+BtmEf+51kDNSK73pk8duZeyX9mYfHrfJZR97gtvHaNg7SR
 awAzwzUX0640roU1/K7pelXFbnLK1boHrWmvXq/gbwQ3hoaVfvkZ9do7KJnNPJXuodJ3/Bgc4
 QfWsYJX0pJMOD/ic6JFg2O3/0lNxTby/oPUFojiwYMckkeiGAU4NUYOic89N+IVJgHO+P58mh
 XWDpApeHyEF1v8xHdhZQb1NgO7Hl8ZweSMjlkW6KB0vB+VJtAcs3Sy/L3kjjcaA4FMirebnx5
 aPEvq/NVBFUjXQd/VEjhGjW+jHxiea4dritVmkjC0ZCIEbn8X2QIZ0q4Mdz7pGex2dgFd4Jo/
 0vwEB4JRVdZeQT9oFEJkRBFqwo47UFuNXvXpKXKnmwZvBsV/SVjwI9rCftY19dcF7xsKtm0mt
 n2NlMpkhwzsq2zCdyvhhongv1Y8+2ocMGEGtQxmJNOBY21YsJViAxJVoE3UTwAn9sR6aE9ICK
 JZXyhYZAuujNURLk42eX9b2rJKxyeSv/WRSnfUYXHiarcX7u/GFkqxvWMlwIFdt3qtYDZVaZy
 k19cWLFKnvDJOrIW+x8pXhtdpCbCkqxaPEkgChMl8dzi/O1FolfsLoehQeWBKjizh48ODsdc1
 juuolkP//8bMaRvN5d+eRyRVSOE1KS0buICVXqE/vFAi4AO5YqrH67urF49s/Ms173OHbS1BF
 jze9eHJXiloIiRsmL98T6ImNEFX0debgnt+kUDPXYy+1mWwBVIauKRG+C/UzstoCUdA4XEpew
 /NOzSjWmGAjZizP9f9w3QVuHd9hBy1qz61F7Lig==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>,
 Maxime Villard <max@m00nbsd.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Implements the NVMM accelerator cpu enlightenments to actually use the nvm=
m-all
accelerator on NetBSD platforms.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
=2D--
 cpus.c                    | 58 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/hw_accel.h | 14 ++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b472378b70..3c3f63588c 100644
=2D-- a/cpus.c
+++ b/cpus.c
@@ -42,6 +42,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 #include "exec/exec-all.h"

 #include "qemu/thread.h"
@@ -1666,6 +1667,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     return NULL;
 }

+static void *qemu_nvmm_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu =3D arg;
+    int r;
+
+    assert(nvmm_enabled());
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id =3D qemu_get_thread_id();
+    current_cpu =3D cpu;
+
+    r =3D nvmm_init_vcpu(cpu);
+    if (r < 0) {
+        fprintf(stderr, "nvmm_init_vcpu failed: %s\n", strerror(-r));
+        exit(1);
+    }
+
+    /* signal CPU creation */
+    cpu->created =3D true;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r =3D nvmm_vcpu_exec(cpu);
+            if (r =3D=3D EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    nvmm_destroy_vcpu(cpu);
+    cpu->created =3D false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 #ifdef _WIN32
 static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 {
@@ -2029,6 +2072,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #endif
 }

+static void qemu_nvmm_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread =3D g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -2069,6 +2125,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_tcg_init_vcpu(cpu);
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
+    } else if (nvmm_enabled()) {
+        qemu_nvmm_start_vcpu(cpu);
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 0ec2372477..dbfa7a02f9 100644
=2D-- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -15,6 +15,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"

 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_state(cpu);
+    }
 }

 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -40,6 +44,10 @@ static inline void cpu_synchronize_post_reset(CPUState =
*cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_reset(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_reset(cpu);
+    }
+
 }

 static inline void cpu_synchronize_post_init(CPUState *cpu)
@@ -53,6 +61,9 @@ static inline void cpu_synchronize_post_init(CPUState *c=
pu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_init(cpu);
+    }
 }

 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -66,6 +77,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *=
cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_pre_loadvm(cpu);
+    }
 }

 #endif /* QEMU_HW_ACCEL_H */
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c3a6e4fabe..2e79d61329 100644
=2D-- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -981,7 +981,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess=
 access)
     X86CPU *cpu =3D env_archcpu(env);
     CPUState *cs =3D env_cpu(env);

-    if (kvm_enabled() || whpx_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
         env->tpr_access_type =3D access;

         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
=2D-
2.24.0


