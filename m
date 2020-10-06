Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0661C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE0520760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryNCOtUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE0520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhms-0007nJ-2Z
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQD-0002jc-5P
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQB-0001QK-5I
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id e2so1944227wme.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SqRzPnflqZF33Smi8JSLtfga764GNYRU7t9sRkWeWhU=;
 b=ryNCOtUphSwWhHCff/cnoK1OBK8aVbxExbcSADQbdTSCoLyizvzweileTDhuZUnMlK
 4mrneczo0Q7QGoOkZA1fcTCdWbTjmNu1hYcmdgFW0rc3Y59kP3yz5eSK9U0DKs465SJu
 EDIiQvFy4EMVt2m0pXeniP3srCX7DhcCMTedkTlB1Hs1AgPWCOU/cL0m9V3npx5DLT/G
 RRqv3aSg/C4KzOCLFlMqZTEQzUYpKU7C39DVH69ca8MKFCsGq9rZF4DjhQhaxQQiph5l
 j+oplpcWoM7lRvIHSKGh9SWfP6xMUeM43yAqp/Hq8xt8vNdvURbH72k60lq5S9p5Y+KS
 ecUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SqRzPnflqZF33Smi8JSLtfga764GNYRU7t9sRkWeWhU=;
 b=Q3dJYrIfZYs1KKSmA0pe06AMvdyA1UmI3WqWSjW5rTHJ4Gh2BwkR7mv9B4N7/9YLb9
 C2bbI8PgfhP7ppzvr+VVDXOS6OBIj76EirHCuUroTbdblZzIKvoKyFrLm7Co1wMRY1W3
 yZ8ExlzyOvhavt39PmlHLyHuOwGpQjCmZO+I2HpJJMJW307wFVEGoMWl5Xv7QYvmI0BD
 8y6Whnbcty95RfE0Nv4rVb5NgaRdfktQfOALHofZetO0KrBbcpOxptCv6lyXqdaUuCSR
 o5HHpiPtHmPV+cFaTdfhnRLUntOMhW5rwNCI6Ds12Tj7mLBZ25uRgfZpw6RwyCu8qSAo
 d7cw==
X-Gm-Message-State: AOAM533n/cnHRpHwLrTav37BMngxKaonY1lSS8waE+XOEb7J5h7s6dJg
 96jLu4NBlzctuXs0IcvSxw/H6Th7A3s=
X-Google-Smtp-Source: ABdhPJyFBj5D8AmeSEoEK/YuSDeKH2QjvfiTiRuoJi1nQXwfNT2ZwqFUQa21/ehNK+MiQYhNjqmL0Q==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr3106501wmj.136.1601969401506; 
 Tue, 06 Oct 2020 00:30:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/37] kvm: kvm_init_vcpu take Error pointer
Date: Tue,  6 Oct 2020 09:29:27 +0200
Message-Id: <20201006072947.487729-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clean up the error handling in kvm_init_vcpu so we can see what went
wrong more easily.

Make it take an Error ** and fill it out with what failed, including
the cpu id, so you can tell if it only fails at a given ID.

Replace the remaining DPRINTF by a trace.

This turns a:
kvm_init_vcpu failed: Invalid argument

into:
kvm_init_vcpu: kvm_get_vcpu failed (256): Invalid argument

and with the trace you then get to see:

19049@1595520414.310107:kvm_init_vcpu index: 169 id: 212
19050@1595520414.310635:kvm_init_vcpu index: 170 id: 256
qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (256): Invalid argument

which makes stuff a lot more obvious.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200723160915.129069-1-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 19 ++++++++++++++-----
 accel/kvm/kvm-cpus.c   |  8 ++------
 accel/kvm/kvm-cpus.h   |  2 +-
 accel/kvm/trace-events |  1 +
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 784e9dad55..9ef5daf4c5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -441,17 +441,18 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
     return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
 }
 
-int kvm_init_vcpu(CPUState *cpu)
+int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     KVMState *s = kvm_state;
     long mmap_size;
     int ret;
 
-    DPRINTF("kvm_init_vcpu\n");
+    trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
     ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
     if (ret < 0) {
-        DPRINTF("kvm_create_vcpu failed\n");
+        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
         goto err;
     }
 
@@ -462,7 +463,8 @@ int kvm_init_vcpu(CPUState *cpu)
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
-        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
+        error_setg_errno(errp, -mmap_size,
+                         "kvm_init_vcpu: KVM_GET_VCPU_MMAP_SIZE failed");
         goto err;
     }
 
@@ -470,7 +472,9 @@ int kvm_init_vcpu(CPUState *cpu)
                         cpu->kvm_fd, 0);
     if (cpu->kvm_run == MAP_FAILED) {
         ret = -errno;
-        DPRINTF("mmap'ing vcpu state failed\n");
+        error_setg_errno(errp, ret,
+                         "kvm_init_vcpu: mmap'ing vcpu state failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
         goto err;
     }
 
@@ -480,6 +484,11 @@ int kvm_init_vcpu(CPUState *cpu)
     }
 
     ret = kvm_arch_init_vcpu(cpu);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "kvm_init_vcpu: kvm_arch_init_vcpu failed (%lu)",
+                         kvm_arch_vcpu_id(cpu));
+    }
 err:
     return ret;
 }
diff --git a/accel/kvm/kvm-cpus.c b/accel/kvm/kvm-cpus.c
index a120601564..d809b1e74c 100644
--- a/accel/kvm/kvm-cpus.c
+++ b/accel/kvm/kvm-cpus.c
@@ -20,6 +20,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "qemu/guest-random.h"
+#include "qapi/error.h"
 
 #include "kvm-cpus.h"
 
@@ -36,12 +37,7 @@ static void *kvm_vcpu_thread_fn(void *arg)
     cpu->can_do_io = 1;
     current_cpu = cpu;
 
-    r = kvm_init_vcpu(cpu);
-    if (r < 0) {
-        error_report("kvm_init_vcpu failed: %s", strerror(-r));
-        exit(1);
-    }
-
+    r = kvm_init_vcpu(cpu, &error_fatal);
     kvm_init_cpu_signals(cpu);
 
     /* signal CPU creation */
diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 60c5a554c2..3df732b816 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -14,7 +14,7 @@
 
 extern const CpusAccel kvm_cpus;
 
-int kvm_init_vcpu(CPUState *cpu);
+int kvm_init_vcpu(CPUState *cpu, Error **errp);
 int kvm_cpu_exec(CPUState *cpu);
 void kvm_destroy_vcpu(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index a68eb66534..e15ae8980d 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -8,6 +8,7 @@ kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
 kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
 kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
+kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
 kvm_irqchip_commit_routes(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
-- 
2.26.2



