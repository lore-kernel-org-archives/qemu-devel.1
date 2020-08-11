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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C167C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163F1206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AR1KJeLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163F1206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5V5K-000652-35
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5V1B-0003U7-8E
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:12:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:47339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n54@gmx.com>) id 1k5V18-00013G-6c
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597155156;
 bh=ZQ0DzVPA2iYTtjlzNojomsX+j/smyo/M5PvfBoj6A6E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AR1KJeLz9T1iHHra7vvFip/g4FQInnt141cx3Jzy/1X8JUhYuM67WfCAeQbN9C6hG
 AzuJaOuH1kHiBY4wkeqslecPllUr5evng8ygsBl823BUabhKMILhiaWTwz7PKYj1QJ
 AZ8EE0N+fthBnqKXMfoam4dybrxbv36BkZC3JuEs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.79.191.25]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mxm3K-1kub413RdO-00zBkX; Tue, 11 Aug 2020 16:12:36 +0200
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 4/4] Add the NVMM acceleration enlightenments
Date: Tue, 11 Aug 2020 16:10:49 +0200
Message-Id: <20200811141049.15824-4-n54@gmx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811141049.15824-1-n54@gmx.com>
References: <20200811141049.15824-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+8t0prrX7UJ+Kdc9oMWCt4RGqikdc3V2wF9h0TXRafSm9p9TZnO
 AFY0wQa9WeC9hHjy8kF7TWc3LaZks9EhUN2UfbME9Q9PyoXgV7yppfL2zUZM6iwyu5qV5u4
 TfDEvuFpEz8F4CCEFrEndkPyzFTKvaekzzdZF3j6ijMloj4xblQJEbzY/caASUMYzdquz1v
 dCs9zN8vTmPKbjSgXRxGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgwPwZ7oMVA=:OzzDzfDQAvko6Nq/moKd+O
 Ilnt4H4U+2gv9+d/YTsUcwEYDLltLHUpJXpYRkeWCc26wxCfIWF9sb72A251N5yQRs43ksmHX
 scp6StzNMV6ymh/jxFn42VSiFoLsXzic+rrFzQbgxq1WorAbWFLTj/ERii+I39vHkyJwZdepw
 Kbk+fdZHLo1UAV1TdGeI9d/RQTfMT7J1sPNdjP+NvD7UGKqWHTWPxSvzdkWL2+FG+StJhhJLN
 olYk1Zhah+GCDUnY+UY8rSz+PVkGBkYtkrw2/S6epVq+6MxduIvmf07GcaaMEjGAJ8LnKEPIW
 ygtNZzl2VAz9X1PZPz+LWrX2GUFMFI6fFnUaDemeJlmApaoGQPrW+o7HjP16IA9bAr880BDv2
 JDt1C9jTpKYQJGPXJlQPFAv5BAebzciqUBV6XCk0abyhHyqBH7+EcdM+p6hKjvt2Rl92KovgA
 YrD8Qu6wd16vbd2dOVQlVLPlmqqRYFYFbwE328NI8vv/zmvmwxjfhfZkqP0GMZwpw426Einfl
 pfvA7oPc3ST3CSoiYyM1TxnyFnBuE0iykHn1zHu03lPCmEiT2O3BwZ+9qBOmX0CMJxBn559cN
 g1qw7tyEVb8qbFTu2pHbrd8560fdwJemT0LQr/cs8cAsu/68iK5k2zg0BhZ+O5PiCGn6Xui0v
 I9w1/TTEKlNTZ9TW5kB6TmoaumzZjWBsv5y+UF9UAyyOAVE+hYlDz6hVefWTlUnIhcsm9LSNI
 IHF0M1GIPacGaADE+9f2shKbmT2G4hFkol1kJzWps5p6FSyMA3+QMPNX2rPOmcukyFSh7sreN
 SaKUr4xMammtAoc5GV4dVTr6oHkCZjOV2ol3pRSzW07VeuhZ47f9jMcU1A4ICM4lrbMH2cGzm
 w2U9fTfamqHKo8k2il9sCrL4NHe6cyIRC4l+MwO/aKGVDiiwiCE8G3G3szaKe8QTx4w6b7LeE
 TwxmlWPQhRFwtX4AGV2k/rOYuHn7PFLNJWWUR+MyVV/NQbkxKL1IvEbzhSb1ZFtmSDG3XgwVM
 WpF9AucYK8fjn7ujn7BYlRWwNuH8sGZil5L/6VqAb90lhs1AHDhhyGQYcrqT1x7OjQNrh2GjA
 2Hv4BY4P3CtrdojZmJjQgRwlOJPZeYIXUwTh+XzhSUWSvkSPF9UuZ0DpMb8iCmYC7TC8dXE6T
 1j9d4bICkgQPpGphQVYhkDKU3J0jPBQXClB5zQKPZJ/t0nIv/2owl70cHRpgIDz/fWKRgoLec
 xhk5GsYgX2j1NahvE
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

Implements the NVMM accelerator cpu enlightenments to actually use the nvm=
m-all
accelerator on NetBSD platforms.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
=2D--
 include/sysemu/hw_accel.h | 14 ++++++++++
 softmmu/cpus.c            | 58 +++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index e128f8b06b..9e19f5794c 100644
=2D-- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -16,6 +16,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"

 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -31,6 +32,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_state(cpu);
+    }
 }

 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -47,6 +51,10 @@ static inline void cpu_synchronize_post_reset(CPUState =
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
@@ -63,6 +71,9 @@ static inline void cpu_synchronize_post_init(CPUState *c=
pu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_init(cpu);
+    }
 }

 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -79,6 +90,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *=
cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_pre_loadvm(cpu);
+    }
 }

 #endif /* QEMU_HW_ACCEL_H */
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..3b44b92830 100644
=2D-- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -43,6 +43,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 #include "exec/exec-all.h"

 #include "qemu/thread.h"
@@ -1621,6 +1622,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
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
@@ -1998,6 +2041,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
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
@@ -2038,6 +2094,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_tcg_init_vcpu(cpu);
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
+    } else if (nvmm_enabled()) {
+        qemu_nvmm_start_vcpu(cpu);
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e2c3..c2f1aef65c 100644
=2D-- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -983,7 +983,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess=
 access)
     X86CPU *cpu =3D env_archcpu(env);
     CPUState *cs =3D env_cpu(env);

-    if (kvm_enabled() || whpx_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
         env->tpr_access_type =3D access;

         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
=2D-
2.28.0


