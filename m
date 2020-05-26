Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20950C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63E2204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyJUyd+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63E2204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddOS-0007PD-VN
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJf-0006c8-Hz; Tue, 26 May 2020 13:24:39 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJe-0004OL-K5; Tue, 26 May 2020 13:24:39 -0400
Received: by mail-ej1-x644.google.com with SMTP id l27so2571563ejc.1;
 Tue, 26 May 2020 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bosFEsOdRNCKNds18FsMsMzsl498InAUxYmyMk4mv4A=;
 b=KyJUyd+gePEnSqSfksBC75UrrHloRRCMmGCtrlSyNh4pEllbl10GZtOzNRj5kMmqGF
 4/kQCF7wXQcRfX4wJ+k5gu4IFaye1PjSm75XwbUbPyikHilTrjbPUE22rQWfvYf9mWvE
 vKIXsuw59CfLbQ7JBca/eueF9jmo7EnGLp853riCO89SpSq8Ac6U78382kNXv9ysXCd9
 /rlhMetMgzrMici9nUAkbWVRj3u+/i5OvvFwNT7erZJsKiSaQ/QIWwWJGtajC6YYwjnm
 OmnqiVC032tTQLCO8e/994q91eLyVyaFwuEFqGU4neSbe1sIxG4DSCPcV/J3hOk9tb/W
 8YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bosFEsOdRNCKNds18FsMsMzsl498InAUxYmyMk4mv4A=;
 b=j6WNjX0NRh7FUDVEIydYw6jt+2kMWUC1pJCpW6i8itY3MYEhjLwAtU8XHFWQ1bWoAv
 GVWxKytu8JyJH15H5lxt5wo+Y88vsnc5IVuiXmounJH+TKw3to/YeF+ERMvj3MQC7ezX
 fEhS1cZhvVyFTBO6VAi3rjEpc1WR5y8L5fs+A4mCxKNaIt4zwy9TUgNJKsIhaAAAhgF4
 Km6TH6qC4j6Ks4LVbI/QPpPSHG+uUDqL4BcKsRRNRGmWhsIb5kfloSGSxuGcFo5tSTCK
 ZRCbiuQJPVKslD9FvUkWaPs3yQUt8vsMvfFl61sms4cGQvEdQ4EI7di9FH83QbCF1Xxs
 onkQ==
X-Gm-Message-State: AOAM533lGIIRvPH4l4GGFp9pFiVOTB3fYrWRJlFVu8Ud7zooDERW9HGs
 b3h1MZHahyT9eNRMFKM+k8Z5PsfYmQU=
X-Google-Smtp-Source: ABdhPJx1VtAgGZixmMlTyYjSo7rtLtXQ7p4bq4AoWGapdhDGU2ZuPJxfwxuCL08gdVywQ2AfFWu1Hg==
X-Received: by 2002:a17:906:2f8d:: with SMTP id
 w13mr2167656eji.102.1590513876142; 
 Tue, 26 May 2020 10:24:36 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] target/ppc: Restrict PPCVirtualHypervisorClass to
 system-mode
Date: Tue, 26 May 2020 19:24:24 +0200
Message-Id: <20200526172427.17460-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code related to PPC Virtual Hypervisor is pointless in user-mode.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/cpu.h                |  4 ++--
 target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
 target/ppc/translate_init.inc.c |  4 ++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7db7882f52..13d6976534 100644
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
index d8adc1bd49..09f8b10e27 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10941,16 +10941,20 @@ static const TypeInfo ppc_cpu_type_info = {
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


