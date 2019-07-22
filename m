Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8CC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 06:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083D021994
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 06:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/MCsaZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083D021994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpReZ-00037L-A9
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 02:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hpReH-00021x-TM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hpReG-00064g-Mi
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 02:18:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hpReG-000626-Eq; Mon, 22 Jul 2019 02:18:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id q10so16851947pff.9;
 Sun, 21 Jul 2019 23:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ysITdSttWfCis1fWSqIVFrIzSd7gXyHaum5r30vSHjk=;
 b=N/MCsaZCpFAfAXJIb0uxkS7lLUDWvISqDad7GRjJmWNvY1XkWCgqL06KTNUIhmMOmf
 kj/3z0E+VoW5KkyJBzKJZfbIVfNbgj37sjmX5nO7Ef4grwusYxeeFinHYDCI9DRk4NEe
 0apl2RDnFA4kVjtZCu1HCvES84s4IIObcvYVUWawE6GjIuwQMlQrRQTiK8jxIJiPZ3Ft
 h+xadY0HuCPeV6rTJ6wQOGtI/D4JPUHMMFKcT5bDKh01jlFVkhP2N3msnxZH3cvNfUKk
 o25FSw0QRvKPxr1v3E+RPZAYrM9VQS4ngYxxfzRm3M2oeC5CdK77MwkTj16uux3APVf6
 orCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ysITdSttWfCis1fWSqIVFrIzSd7gXyHaum5r30vSHjk=;
 b=oK3C4jRli2wN1vIIdIrEHNBhHtTSf45IJfIny2sVInfTjFckl3OAbvd8jg14RUEEeh
 W33GpvpuR0J5Ig82e5+x3VIIiZrhBDE5+47GKHBlhBe5/FPPEUR08wvSnnMQqQeebzmr
 Q/OHpoYExAmOaU2OzHb90Ru+rBIXfsVEIbVIwN+Arb9mkY78SN4pVMr9/OdtFomI0rSv
 S5+gJuWy3zySpp+jqFCf7/E0y10u1sJ9rvHXXSmsafvFJ0vJVzIw37NkTW++OyDZLImc
 PTtiOzheJ1HCep80S6dlWTkBq9Grb6TmY3PyfSFMfbU2dMvXwa50qY2ZF5NyvKAMleRp
 MLkw==
X-Gm-Message-State: APjAAAXYI/ZSfn8GAiPPUa7JYGfXH9OVZip10/3dBde5wPhE4DlbClo9
 wxqlAIVlDfN0cq5agwk5I8t+jEPepOw=
X-Google-Smtp-Source: APXvYqzderhzSEtkpuoR1vbPETfsKXo0sTrr1Mr7oJyMtbjOevSJloaPk2Vu+kjECLFdLLPryRxJLA==
X-Received: by 2002:a17:90a:350c:: with SMTP id
 q12mr75506158pjb.46.1563776291336; 
 Sun, 21 Jul 2019 23:18:11 -0700 (PDT)
Received: from bobo.local0.net (193-116-123-212.tpgi.com.au. [193.116.123.212])
 by smtp.gmail.com with ESMTPSA id 14sm57895983pfj.36.2019.07.21.23.18.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 21 Jul 2019 23:18:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 16:17:52 +1000
Message-Id: <20190722061752.22114-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722061752.22114-1-npiggin@gmail.com>
References: <20190722061752.22114-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 3/3] spapr: Implement ibm,suspend-me
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
Cc: "Liu, Jinsong" <jinsong.liu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
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
 hw/ppc/spapr.c         |  7 +++++++
 hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 00f7735a31..a580466d01 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3078,6 +3078,13 @@ static void spapr_machine_init(MachineState *machine)
 
     qemu_register_boot_set(spapr_boot_set, spapr);
 
+    /*
+     * Nothing needs to be done to resume a suspended guest because
+     * suspending does not change the machine state, so no need for
+     * a ->wakeup method.
+     */
+    qemu_register_wakeup_support();
+
     if (kvm_enabled()) {
         /* to stop and start vmclock */
         qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
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


