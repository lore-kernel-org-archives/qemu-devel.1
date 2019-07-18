Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDE2C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8C021783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnSMfJtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8C021783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3qw-0007ia-1l
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34910)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1ho3py-00043z-7V
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1ho3pw-0000sh-Qt
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1ho3pu-0000mU-41; Thu, 18 Jul 2019 06:40:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id u14so12448020pfn.2;
 Thu, 18 Jul 2019 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lteyBjEv79ancuyu48+6RkOCiXixXc/t0skBD9V32vQ=;
 b=nnSMfJtfbz3GZR6j8f14cbn6GCnbfFXOalYlIrtLUOooKg4J9NRyQ4RkUexObVi3Om
 u13CAM8Y5tHXEVVthXSk38zcgCVW43+AeREk2Z55AYZlIDLaQM35LElOAQSjMo1qvjJp
 SDsrPAUvjZPb1XCgYdYtzq8OyeOmnb84KH61zuBfit6FVwKBJ1rTUlK7pTxGb6pObLmQ
 NlLbq4KONCQ0sqa5hwmx4nobJsrOqwCWvUZ5FCgH1Hj++4cdVphAAfhvjosy09oipk4h
 bBGwlo6+8TsttppnRU0hYI8lvC+V2RZTknFQxmokPSL5xirMJ9us3W5zJm3/KMskSFPb
 AOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lteyBjEv79ancuyu48+6RkOCiXixXc/t0skBD9V32vQ=;
 b=D4c03Xb0jJze3oPqNsknH/RevB8nHQQL2t6nzVRevAJe1+qWEVRA1t70eNj7DKS45m
 tm7x5ZXQl+WpzdPwx40/XHCAdahR4c7Eee5laywY9hvjeVgyyvrH3TNY3Iwvwdb/tiKg
 aXae9oj8nY/XWom3dfQ4rrQIOLSvFUKRjHU3160HdBcrKmun05xwiGIJ6RPBSjz7FpqW
 yU7NnaFt3hliq9zMKhTr+vn22tkKunp4MX02AbfR6rWlsL623Xlx/yWz1JrCiJPZWJBH
 ppG323GCvuEUcG/QeRkUgDIzqCemb/3sYmtL2o3ZSc0Ll6zRQ6yO4oB9Lxbd59oiAf9L
 euPA==
X-Gm-Message-State: APjAAAXWI2EHgolpHCBdFdUJD2e28i/JacGbhkrXVz/fEkYy7i9KoETB
 YG+4CJxmrctlAFr4NNWxrc1bdRuq
X-Google-Smtp-Source: APXvYqwsvM882HpPaC8IJLzlJuWwOuOQI3DlFNuwZW+dJykqstq1ueq/aLUA/i5Xr58MQwG37Me+EA==
X-Received: by 2002:a63:c106:: with SMTP id w6mr47324592pgf.422.1563446428755; 
 Thu, 18 Jul 2019 03:40:28 -0700 (PDT)
Received: from bobo.local0.net (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id y10sm28243415pfm.66.2019.07.18.03.40.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 03:40:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 20:39:51 +1000
Message-Id: <20190718103951.10027-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718103951.10027-1-npiggin@gmail.com>
References: <20190718103951.10027-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 3/3] spapr: Implement ibm,suspend-me
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has been useful to modify and test the Linux pseries suspend
code but it requires modification to the guest to call it (due to
being gated by other unimplemented features). It is not otherwise
used by Linux yet, but work is slowly progressing there.

This allows a (lightly modified) guest kernel to suspend with
`echo mem > /sys/power/state` and be resumed with system_wakeup
monitor command.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 11 +++++++++++
 hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 00f7735a31..c7725d3586 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1701,6 +1701,14 @@ static int spapr_reset_drcs(Object *child, void *opaque)
     return 0;
 }
 
+static void spapr_machine_wakeup(MachineState *machine)
+{
+    /*
+     * Nothing needs to be done to resume a suspended guest because
+     * suspending does not change the machine state.
+     */
+}
+
 static void spapr_machine_reset(MachineState *machine)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
@@ -3078,6 +3086,8 @@ static void spapr_machine_init(MachineState *machine)
 
     qemu_register_boot_set(spapr_boot_set, spapr);
 
+    qemu_register_wakeup_support();
+
     if (kvm_enabled()) {
         /* to stop and start vmclock */
         qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
@@ -4373,6 +4383,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->init = spapr_machine_init;
     mc->reset = spapr_machine_reset;
+    mc->wakeup = spapr_machine_wakeup;
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 1024;
     mc->no_parallel = 1;
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index a618a2ac0f..87175c1e0a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -216,6 +216,36 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
     qemu_cpu_kick(cs);
 }
 
+static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           uint32_t token, uint32_t nargs,
+                           target_ulong args,
+                           uint32_t nret, target_ulong rets)
+{
+    CPUState *cs;
+
+    if (nargs != 0 || nret != 1) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *c = POWERPC_CPU(cs);
+        CPUPPCState *e = &c->env;
+        if (c == cpu) {
+            continue;
+        }
+
+        /* See h_join */
+        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+            rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
+            return;
+        }
+    }
+
+    qemu_system_suspend_request();
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static inline int sysparm_st(target_ulong addr, target_ulong len,
                              const void *val, uint16_t vallen)
 {
@@ -483,6 +513,8 @@ static void core_rtas_register_types(void)
                         rtas_query_cpu_stopped_state);
     spapr_rtas_register(RTAS_START_CPU, "start-cpu", rtas_start_cpu);
     spapr_rtas_register(RTAS_STOP_SELF, "stop-self", rtas_stop_self);
+    spapr_rtas_register(RTAS_IBM_SUSPEND_ME, "ibm,suspend-me",
+                        rtas_ibm_suspend_me);
     spapr_rtas_register(RTAS_IBM_GET_SYSTEM_PARAMETER,
                         "ibm,get-system-parameter",
                         rtas_ibm_get_system_parameter);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5d36eec9d0..6e8e18b077 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -631,8 +631,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
-- 
2.20.1


