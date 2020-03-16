Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A4C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BAB20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2LmqH8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BAB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsfu-0007Gd-2o
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jDqiB-0007Ze-IB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jDqiA-0004Wp-H3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jDqi7-0003xO-MN; Mon, 16 Mar 2020 10:27:19 -0400
Received: by mail-pf1-x443.google.com with SMTP id c19so10020115pfo.13;
 Mon, 16 Mar 2020 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xoJs9JmfNpjFP9lD5gKsVcM5Uv6sOBouIT9l/N6aKbw=;
 b=f2LmqH8Gfi09naAZnCcoCiAqT69lfJyqeGyfVw42FZHuUAv1C+SX/SW5gjSFWQhhFx
 dTvkVUpgq1ODDFCk+0u2jHLg9IX20O8n305r9HbusgE74CCekh7z4GhXjq+I/sYd8mzw
 B394VkBq+YKxGT/DX5ic359e/6t+OmaNCcQd9EwvbKuj6si9hcwq6xydAk1jLA9SF8rE
 RwM6PI++I5gF34wtHcacd/ZhleBwDFry76o0kZyzpW2bv9mVqn1IlZPYJxmCjuH4/hVg
 epGQ0j4ceQ4UcViy3XWSHqpOiDUXn6P+5v09bBKKF7vznBEeyhT8ovHGgGGjT7cHCskZ
 /2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xoJs9JmfNpjFP9lD5gKsVcM5Uv6sOBouIT9l/N6aKbw=;
 b=pigqx2hLq8SuAMaKWFWiOD2ny2Mh9kJfnqh2CHfzFRFaknOaKuaaVGR1qhu7RWkwGd
 QtB/gC+9mEnN+7B3qND9HcBhtjA6+IMzLkJMdXYe9efeDcG90B2h0nZTEJroZW6qfzRr
 sroQlH+25PblY6B9oAj/nAO0A3OEQ5m2cLS7foT/v2MhyykUuOmvREXMYvxN5OlQIVtF
 ReSP1VXUCRqtX3fIrlsyQjw9iInoryDTpq8nxs5k9Eam0aG0iD3jMYje4mwLflPDvwU1
 3hBmGzrAuyFFTl4JWf2yxMsX+J6szIia+G4JXEnhhHdNmTJyqesVltShfmhIIzMaGRDh
 oIyA==
X-Gm-Message-State: ANhLgQ1C+NXqijhNlJF6oPPTFR3mmbWhODAlcyOkohRE2zeCYXtixiQw
 Zj2lwcxywbkUmx9oykmX9SRYcdkCRUc=
X-Google-Smtp-Source: ADFU+vth6saRD+39UwULMq4tukN+3zxkwyb1qLhjY9w+XT8k6AKcjosPoHiIWK6PGDu2ft3UCiyJFw==
X-Received: by 2002:a63:5011:: with SMTP id e17mr139169pgb.338.1584368838557; 
 Mon, 16 Mar 2020 07:27:18 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.63.160.49])
 by smtp.gmail.com with ESMTPSA id v1sm45564pjy.35.2020.03.16.07.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:27:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take an
 alternate vector
Date: Tue, 17 Mar 2020 00:26:11 +1000
Message-Id: <20200316142613.121089-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200316142613.121089-1-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide for an alternate delivery location, -1 defaults to the
architected address.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c           | 2 +-
 target/ppc/cpu.h         | 2 +-
 target/ppc/excp_helper.c | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5f93c49706..25221d843c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3400,7 +3400,7 @@ static void spapr_machine_finalizefn(Object *obj)
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     cpu_synchronize_state(cs);
-    ppc_cpu_do_system_reset(cs);
+    ppc_cpu_do_system_reset(cs, -1);
 }
 
 static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3953680534..f8c7d6f19c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1220,7 +1220,7 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
-void ppc_cpu_do_system_reset(CPUState *cs);
+void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7f2b5899d3..08bc885ca6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -961,12 +961,15 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     }
 }
 
-void ppc_cpu_do_system_reset(CPUState *cs)
+void ppc_cpu_do_system_reset(CPUState *cs, target_ulong vector)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
+    if (vector != -1) {
+        env->nip = vector;
+    }
 }
 
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
-- 
2.23.0


