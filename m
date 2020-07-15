Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C039C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAF420657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOjUt2t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAF420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvd1m-0002i3-5g
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jvd0y-0001Y5-U6
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:43:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jvd0w-0007Bn-9q
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:43:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so1547866wrn.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f+VX6bAix+wVI16G9bVDEGe5z1BM99FcPDM7fqkqqSM=;
 b=gOjUt2t3s4AL+X5SKA2T5iMoHRqIIOwvcTEmBT0send4CSCB2rReIzqzePHmlTxyS/
 2erHGWA7UyqBfInO90Nu5MiXS0cVAftGRksXletz/8ecMkFfPeV8GcmrrygbysEh7jXH
 9XJPawU9IrGDQ+qWCO81vAaz/mBKjivCcdUqVdJG3DXhbqDoEF7XWYSIXs/dmeiMZaeo
 c0Y2OXAongA6w1nZP0l8DYDdFnRb2cylyxofPipv/MPXQN7sawjtzhkJ/gJidbT+Fp64
 tjipq2IUYwrA5YwHiqJWbB0c3TjJt62FUjpEfA6WTP88Ky1cQg33gWPJ49DTF8RPOpWs
 /vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f+VX6bAix+wVI16G9bVDEGe5z1BM99FcPDM7fqkqqSM=;
 b=YQNsaxgp7ZidmiW9gBegx/oOSAyGnqydt07syW2PdD13MkXiD5qmsukbJg8vPUXff8
 WoL0rQ+Gxo8ImCx+7m5pC9Y+2qm5047AYIXBvJBRMlBcZY7NSyGpN+hrvY14hkMC6Sh1
 Gz23H2OK18rgCqWni/nydcwPx5Bq26hEAgR4JqMOTlX7EflExKsyHGK8LB1vYp75s+xV
 npwLpWA+6jH6dQXAOGCfgpruV+u6av8N65K8mhSkezJ0ENxz0SFti0On2FOj2u+YfzR0
 oixE6NLUiW8Aajzhvl3MBRR2sNoNQcagF4oixg2BUVc5aiDgA5ZvcU9r2Q/uBkIwbpBl
 2i6A==
X-Gm-Message-State: AOAM533V3zqZqRkKnMe/OggfY4hQDojPPimNWu9uHoQ4Ykb3iciOavQT
 WOEXfgLEV5sYgzkTGPqs9dh2WzTpIbU=
X-Google-Smtp-Source: ABdhPJzKt77iUmuz2y4aQyR4mw9jHywDxZlr9r2UKmjwqteDgHyPlI51cj5wXXRodDjjhfNo0OaOTA==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr10491950wrw.374.1594802620803; 
 Wed, 15 Jul 2020 01:43:40 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 g195sm2369386wme.38.2020.07.15.01.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 01:43:40 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] acpi: i386: Move VMBus DSDT entry to SB
Date: Wed, 15 Jul 2020 11:43:25 +0300
Message-Id: <20200715084326.678715-2-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715084326.678715-1-arilou@gmail.com>
References: <20200715084326.678715-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: mail@maciej.szmigiero.name, Jon Doron <arilou@gmail.com>,
 rvkagan@yandex-team.ru, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/acpi-build.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b7bcbbbb2a..7708a27f70 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -975,7 +975,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 
 static void build_isa_devices_aml(Aml *table)
 {
-    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     bool ambiguous;
     Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
     Aml *scope;
@@ -986,10 +985,6 @@ static void build_isa_devices_aml(Aml *table)
     build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     isa_build_aml(ISA_BUS(obj), scope);
 
-    if (vmbus_bridge) {
-        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
-    }
-
     aml_append(table, scope);
 }
 
@@ -1485,6 +1480,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCIBus *bus = NULL;
     TPMIf *tpm = tpm_find();
     int i;
+    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
 
     dsdt = init_aml_allocator();
 
@@ -1526,6 +1522,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
 
+    if (vmbus_bridge) {
+        sb_scope = aml_scope("_SB");
+        aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
+        aml_append(dsdt, sb_scope);
+    }
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
-- 
2.24.1


