Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC27C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EE0214D8
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP4j+tgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EE0214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPFm-0007O5-4Q
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPET-0004BD-Pd; Sat, 09 May 2020 09:09:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPES-0003m1-P4; Sat, 09 May 2020 09:09:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so13637515wma.4;
 Sat, 09 May 2020 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LLYk56bTzpbED/TEaMz+Gn8C12EvT1HOdsren3t79iU=;
 b=AP4j+tgCGiMzt4H8rWkM9LRHLvvfy6vChYsu223j14fpzOK2Pqi5/cgs7QkpACs5vh
 N1zCvIR0D66ZYllrAZ2tWAaeGkrPsXt9xm6zo9skgzr2SVMt97UEzXHLUWu6N9Qtkg4/
 euGDM4L2z8UAh+EJOMnGTRHFqqtsYRBZJhTTi+fip9mAE8szTB3dWn8Juth85+yQ+oDS
 nRW22lLT7lShq9EBYOPsyCZ4ollrQzzeo/9LMlFJ48I9X1gdie42VTArpEW7ZghsvF/V
 t7rd6CZDBwaKDER1Wx5YA6IC70y1YDpyUZt5/m71ZO0n6akG0hmukMSpoLbWaz03XO/+
 B/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LLYk56bTzpbED/TEaMz+Gn8C12EvT1HOdsren3t79iU=;
 b=pEptVyEigIZLypIRPmGlgIyCubqdYdiUm8anNOp7uJS4oFwbBCjFhql0sHnGGshxvA
 tUnhvfGvzzL8PObxYOgZ9N2M309trv6X+Q4UJmJ29RmmejOZBwyKyUtmfWojwo/5s9je
 tLOnuNOBqRes/M5Jlss1mfvGIZ9BX0eLe5JMUQ+sej92cuXgu1xSLTzchmWpaSJ/d9EG
 BDpxzwwDrBzO+pR117SdtYRj8WkBs5v53Wuxxdebm+MovcIL9s3AU7BN56HHItyYKQDT
 JIuuDUND+H4kikexM5aQrWtp/NBTXfX+VEbLvkLUPTVyxjY4WXQBjpAgSWwDT3e4NG2U
 JatQ==
X-Gm-Message-State: AGi0PuYA2xc9bWbwxIABGQ631bV7LJy8oo/8gORty0Y3ceBZpA41edSp
 QJTpaZxc1IInlF4Qu34TrSFjHZDvVGc=
X-Google-Smtp-Source: APiQypJ7r2t/Yta7gA62He4a86vm+KY7sXlClAQIeF/nfivQhskw9hfQngWMoh1D2O9TF+ukw3WKyQ==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr21365946wmh.39.1589029769835; 
 Sat, 09 May 2020 06:09:29 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] target/ppc: Restrict PPCVirtualHypervisorClass to
 system-mode
Date: Sat,  9 May 2020 15:09:04 +0200
Message-Id: <20200509130910.26335-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code related to PPC Virtual Hypervisor is pointless in user-mode.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/cpu.h                |  4 ++--
 target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
 target/ppc/translate_init.inc.c |  4 ++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b6dd7e483..73920a9cac 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1176,6 +1176,7 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
 
+#ifndef CONFIG_USER_ONLY
 struct PPCVirtualHypervisorClass {
     InterfaceClass parent;
     void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
@@ -1189,10 +1190,8 @@ struct PPCVirtualHypervisorClass {
     void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t pte1);
     void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
     target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
-#ifndef CONFIG_USER_ONLY
     void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
     void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
-#endif
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
@@ -1204,6 +1203,7 @@ struct PPCVirtualHypervisorClass {
 #define PPC_VIRTUAL_HYPERVISOR_GET_CLASS(obj) \
     OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
                      TYPE_PPC_VIRTUAL_HYPERVISOR)
+#endif /* CONFIG_USER_ONLY */
 
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index fcaf745516..701c0c262b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -280,6 +280,17 @@ static inline bool kvmppc_has_cap_spapr_vfio(void)
     return false;
 }
 
+static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
+                                     hwaddr ptex, int n)
+{
+    abort();
+}
+
+static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
+{
+    abort();
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static inline bool kvmppc_has_cap_epr(void)
@@ -310,17 +321,6 @@ static inline int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
     abort();
 }
 
-static inline void kvmppc_read_hptes(ppc_hash_pte64_t *hptes,
-                                     hwaddr ptex, int n)
-{
-    abort();
-}
-
-static inline void kvmppc_write_hpte(hwaddr ptex, uint64_t pte0, uint64_t pte1)
-{
-    abort();
-}
-
 static inline bool kvmppc_has_cap_fixup_hcalls(void)
 {
     abort();
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 2b6e832c4c..4ea0cc501b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10946,16 +10946,20 @@ static const TypeInfo ppc_cpu_type_info = {
     .class_init = ppc_cpu_class_init,
 };
 
+#ifndef CONFIG_USER_ONLY
 static const TypeInfo ppc_vhyp_type_info = {
     .name = TYPE_PPC_VIRTUAL_HYPERVISOR,
     .parent = TYPE_INTERFACE,
     .class_size = sizeof(PPCVirtualHypervisorClass),
 };
+#endif
 
 static void ppc_cpu_register_types(void)
 {
     type_register_static(&ppc_cpu_type_info);
+#ifndef CONFIG_USER_ONLY
     type_register_static(&ppc_vhyp_type_info);
+#endif
 }
 
 type_init(ppc_cpu_register_types)
-- 
2.21.3


