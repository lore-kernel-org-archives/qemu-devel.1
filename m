Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48165C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEB2207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9KIFLkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEB2207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joJsG-0001M1-Bc
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 00:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJqH-0007ZI-3k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:50:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJqF-0006hU-LG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:50:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so5828763wmm.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 21:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g8HMQblKKnZs8OYwRQvjxqP8f1bg48Qg99bUSl1PbJE=;
 b=V9KIFLkOjUcQ9NhRnB5pbTE30S0Hm7XZxPbXMSVZA3byK08aZcecfUmNi0mblucStD
 l7E6OAjrL1jWKm4hVqUsFMFoI+iemuDpsoufadccIj7gEsej47iOH5W9jAJV0b9URiYk
 GoO2xedyvuf/czc1fnL7H/9xG6et3Mq7lF7sDQKvMeWHdn6nmmibYuqDAqKcOUj0UqH1
 n0Sh72oJZ/5IAnR1ZuvplxLE5mjEyiLehzxNqZvlfj59IfhF5xDd47sb/TJ5koRuP7S3
 vYrcRasq1iwtJSL/yx/MHe22nJ9oexQura6u+R2QjCP/7HDBglLwUG//SKddT0JXacUD
 6bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g8HMQblKKnZs8OYwRQvjxqP8f1bg48Qg99bUSl1PbJE=;
 b=UcUd6fBcnxLLN8n71me+oiO6l8iokpczsvNqDxYJ9XEpL7N0fMSsAcpVmj5BehkLoy
 Qp5xAA9uEkZotlFR+EWJH8LHns21hLBZS1BTUoW4CA8es6+QzixZiHjLTSwoZpLA00La
 5yk/riwg1eY7vtcMaIzuXR5eA0BMF5R+GkR1cQJU8so4axlrtOpSgUc0GZv4PmG1j3en
 qvUYwjv3l8uHrPZm1xI6YAVtU7SJjODoS67IjtqmqLyVPZtCva0gDd3Ajstvp47WT8y3
 iV8I6TQRKDTtg4TLWCFO9z3vS4197MW2UEz2TAyZ1zfn4bv2auIaDN6eR5yXnarvE0pY
 HFFA==
X-Gm-Message-State: AOAM531jvlZegqlzYy6V9JponfTJCitBk+RpM7Y99/vgOpQDtTg2atgM
 A46E2TXLGN8SdCNFPPYRc4cblL17
X-Google-Smtp-Source: ABdhPJyMzYl5i/cF9Wc9D6WZNdi3xfNd3cz1cBrCRXLmKcebKVvRseXw+resR/4XixzTqKQ0aoa/qQ==
X-Received: by 2002:a7b:c381:: with SMTP id s1mr1285445wmj.25.1593060626169;
 Wed, 24 Jun 2020 21:50:26 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 x7sm30684787wrr.72.2020.06.24.21.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 21:50:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] acpi: i386: Move VMBus DSDT entry to SB
Date: Thu, 25 Jun 2020 07:50:11 +0300
Message-Id: <20200625045011.1075314-3-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625045011.1075314-1-arilou@gmail.com>
References: <20200625045011.1075314-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
index 91af0d2d0d..1f938a53b2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1091,7 +1091,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
-    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     bool ambiguous;
 
     Aml *scope = aml_scope("_SB.PCI0.ISA");
@@ -1112,10 +1111,6 @@ static void build_isa_devices_aml(Aml *table)
         isa_build_aml(ISA_BUS(obj), scope);
     }
 
-    if (vmbus_bridge) {
-        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
-    }
-
     aml_append(table, scope);
 }
 
@@ -1660,6 +1655,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCIBus *bus = NULL;
     TPMIf *tpm = tpm_find();
     int i;
+    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
 
     dsdt = init_aml_allocator();
 
@@ -1702,6 +1698,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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


