Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BEDC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E857E20730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFn+9OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhBs-0008Jk-48
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jLh9q-0004gp-E1
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jLh9p-0002Zb-CK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jLh9p-0002ZD-6I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9so2370376wrc.8
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hp0TKGKSi/gHtI8I2mIP8YOmXXrvnTmTwZnNNAObxR0=;
 b=DAFn+9OBHJ3XePhKbPeuQtEXXAeLDkQJUVhVDSKxHdjsiWMkDzfbM8qcW6ul+vVVNc
 rGgcT0o4Eu3X51JfbgqHsx5TQZtWqWUvNFSC53olLwshhtwcpZzHu2NxAeTzTGKGCtLl
 OBR+7T50MxNdLjMmlyeQEpPfx/i/0VhC5O1t6f/F+BnBOJ+z4P0Zb/jmGfvsBTKrzrTv
 XeMykA0N3APeR+bxZK7gDJFWJY9+WY6ecGwwfpyeovOGzmB+G+3SEWtwUaUWSxL21DUJ
 1Fuv5E2Bdbrq30mGlxaaJBouOyR4WeWvys9AV1+eaC1xgJWCNYhz4kGk+Umo47ZnlWHB
 9Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hp0TKGKSi/gHtI8I2mIP8YOmXXrvnTmTwZnNNAObxR0=;
 b=Fhm1UTNTr9lOAo0cMYZJEtQvCqnzx9FDqXxB1AooiesBWVG41S9hV37OFK/tLm6/5/
 3brGPMGHGtKHv55fQ4BoOsQpW6Ji6IOQJWT2HFK7DM8Dq6klGXJiqQGpNAi+qmXqyjrf
 me1Bf4unNREy3bHEn4sTlSFM2wyVRCrHjZaliq5PEzc2CGo9UbvDahuz+sVLBJqf00iY
 OB8DbdYfDDesO6ZxebYtazTcgKbbTIambuKfYKNKjgCkXRui7qejtmaOkMkuk0b3MhLH
 YUgYLpuB/zkU1uv1Nto78vvZEWuTToAx4zhLf3R+GyF2ZF4LwPxQUUA8gRG0aR9+es0r
 spJg==
X-Gm-Message-State: AGi0PuYqC0MqmaD10I0dhuz7wG7awlouB6TQzA0K+n4T4copLlYVsfv1
 sAasOlhMnrr+c4fIX/LUEk8HxhA7C1c=
X-Google-Smtp-Source: APiQypIuC3OFNyEw5O9VDW0yU59O2AM++DydssQssSVurW7MrWqb5wSZTXJnwiVNaiTexYB15JuLjA==
X-Received: by 2002:adf:f74d:: with SMTP id z13mr795119wrp.55.1586238740036;
 Mon, 06 Apr 2020 22:52:20 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
 by smtp.gmail.com with ESMTPSA id
 n11sm32271007wrg.72.2020.04.06.22.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 22:52:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] i386:pc: whitelist dynamic vmbus-bridge
Date: Tue,  7 Apr 2020 08:51:54 +0300
Message-Id: <20200407055156.137249-6-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407055156.137249-1-arilou@gmail.com>
References: <20200407055156.137249-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 pbonzini@redhat.com, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As vmbus-bridge is derived from sysbus device, it has to be whitelisted
to be allowed to be created with -device.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/pc_piix.c | 2 ++
 hw/i386/pc_q35.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9cceae3e2c..6daa0770fa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -60,6 +60,7 @@
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "sysemu/numa.h"
+#include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 
 #define MAX_IDE_BUS 2
@@ -417,6 +418,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
 static void pc_i440fx_5_0_machine_options(MachineClass *m)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d37c425e22..faaa39ced2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 
 /* ICH9 AHCI has 6 ports */
@@ -346,6 +347,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     m->max_cpus = 288;
 }
 
-- 
2.24.1


