Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDA22080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ0fl8qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDA22080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaes-0004y1-FR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacu-0002OB-8E
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:24 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:40009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacs-0008FM-N2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:23 -0400
Received: by mail-ed1-x52e.google.com with SMTP id p18so2387740eds.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Equ/JnK5/pSNVQdbslLALMATjPtO3Yn5bQ1dDGKom0k=;
 b=WJ0fl8quWLPT3anEOBHqYfAzFELZczJK6+Z2RpuFhPA+fTDiRSGXUl1zZVia+xu0Ox
 nry/FYFRdxNuhEfrTZFsexPr1GahJYEadCPH/q+Ld4pluNZPAet6LxQO0qxJOnYkZzvt
 Z9j5kBTLUz7yXINhwDZnABxqrDUSYr0Wj1fewNR0NOYWxJYSzEuEngpv5EtXfjo0vg2i
 93P/WnOCThpqSmkwzEIkLFUaB0QW8+MVRihwKqbMhoBANEZCEHEbbZHnsMuJAJM5ynW5
 qunwBukM1uj+FoYQgxCwtfd0KKkz0wpZq389UXDLVuKjiJgBihqkS7OCMrIGvzLz3aF5
 T0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Equ/JnK5/pSNVQdbslLALMATjPtO3Yn5bQ1dDGKom0k=;
 b=PD8oge5WFZ8C/c4hCVsbT/rHoGlSkhzWl6eE9BicPMcLG9oblx3qO1k70gkovqQ7u/
 bNnY3I1KZY8hG4Ql4FWDF+o0bLWm9LDa9bnoaLRbJxNRF6Ydwa29xexswPPWGInkx/nU
 ys9B8jeMuHNoLRklxoXS+jnMi5+skya60DUZaIaq/oeEd95Zzp7TxynehnQTPqbGcy2m
 /cwUInobYgKuuvm1+NTi/JasYYPon0lgBfJ0zRiZTDiDuuKFaCplH0huuUX8y4i+4M6f
 dRBz0IjsG3kR6F8fukTHSrOY5NSRaTVxFidYqUW464tG8BhobpoiKzx/deWtVIKI5Brq
 4mvA==
X-Gm-Message-State: AOAM533MC6JtSJqQmcxxKRY4f8oZe22ELFxYrA8fUaGQpGhB3xoqR/8/
 jub74n+PRfW1GYEmLEmpBCsckP+RQ1w=
X-Google-Smtp-Source: ABdhPJyFbMWua+sTn9uov6K6ShDzHMqEXEqf0+Ip6tNls/uPfup8JMSYpDGfRl7c53Y6tg9SFRi0CQ==
X-Received: by 2002:a05:6402:3078:: with SMTP id
 bs24mr7874582edb.284.1592410160669; 
 Wed, 17 Jun 2020 09:09:20 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 bs1sm65365edb.43.2020.06.17.09.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 09:09:20 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hyperv: vmbus: Remove the 2nd IRQ
Date: Wed, 17 Jun 2020 19:09:02 +0300
Message-Id: <20200617160904.681845-2-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617160904.681845-1-arilou@gmail.com>
References: <20200617160904.681845-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=arilou@gmail.com; helo=mail-ed1-x52e.google.com
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

It seems like Windows does not really require 2 IRQs to have a
functioning VMBus.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 dtc                              | 2 +-
 hw/hyperv/vmbus.c                | 3 +--
 hw/i386/acpi-build.c             | 4 +---
 include/hw/hyperv/vmbus-bridge.h | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/dtc b/dtc
index 85e5d83984..88f18909db 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
+Subproject commit 88f18909db731a627456f26d779445f84e449536
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index f371240176..a8bcb41026 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2741,8 +2741,7 @@ static const VMStateDescription vmstate_vmbus_bridge = {
 };
 
 static Property vmbus_bridge_props[] = {
-    DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
-    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),
+    DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 900f786d08..91af0d2d0d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1082,9 +1082,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
     aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
 
     crs = aml_resource_template();
-    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
-    /* FIXME: newer HyperV gets by with only one IRQ */
-    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
+    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq));
     aml_append(dev, aml_name_decl("_CRS", crs));
 
     return dev;
diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
index c0a06d832c..33f93de64d 100644
--- a/include/hw/hyperv/vmbus-bridge.h
+++ b/include/hw/hyperv/vmbus-bridge.h
@@ -19,8 +19,7 @@ typedef struct VMBus VMBus;
 typedef struct VMBusBridge {
     SysBusDevice parent_obj;
 
-    uint8_t irq0;
-    uint8_t irq1;
+    uint8_t irq;
 
     VMBus *bus;
 } VMBusBridge;
-- 
2.24.1


