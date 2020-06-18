Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50211C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5DA208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1IznIQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5DA208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlkoW-0007qg-8K
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 23:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlknF-00065E-Lr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 23:00:45 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:41956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlknC-0005K0-Jp
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 23:00:45 -0400
Received: by mail-ej1-x633.google.com with SMTP id dp18so4771885ejc.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqraAebD5QRbKdQuVrquG+gMExl4B+6MCfHrrf8I8S0=;
 b=d1IznIQQgl4Mh2P5OM3+Mod6tNsOOimFOQOis1Wwd/BKGlJvpR6evccc4Oc86tJCWD
 AVD57rJy0eYQgtSX6NgV4lzhEw4hb3cm8aqcwv3y5Seex/IaxTF5oSCUdyBapJhvAYRG
 BN9OLVUcpDYjGYqd9VG09oWGY164n+KZlhd7DwIc31mhaL+cI7ARw4GYIstcIcSsaaFS
 Hgh9B5gwN7w3xZSPmBckGisKnHbM3aRhGKF5sqNxMYawBuJTKE5rSMO/7MkUZFOVuSnv
 rzRtWihhQtyj0942vzFBXzNCGLIvll3+c6kIYKqTmm3qr1cvTtT2WYdUUD9pZrDCao0d
 zFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dqraAebD5QRbKdQuVrquG+gMExl4B+6MCfHrrf8I8S0=;
 b=eARKGJaq8JkspsEiiah9yaU7Tt0imV6U1kcgsGKAzz77BFdmV2wDPPba4nmG8cDcDS
 oMH6/bCi8ppNanBgzFFJE3zx5cbcgJczKbKkdMuwCFOPDnJ3PShSmsPujyPWQVfXkirq
 wfG2TDBpOrVNky3HlVEs/VPz3e/WE97NoygMRKOMWJGK9YIPJKBKFYNRMHiBncGAmQaC
 IjYUnWUWmryzt9C+HwKYYjyXAdEfYmtuBIBI8EJiyyUpexV0sNCvA/nyWksEmhHmi1ej
 SsRcP17jMS861+1VbhDbgst6hPmP47kroHe9YWx8WbB1yeO0pE0qx3Lt8flJkVDtOy74
 TyXw==
X-Gm-Message-State: AOAM531+/2CZ5/r8c+74yCKRLOjgI9zylEuT+44ao9zzuk0EzyiWryit
 QGQLAWMWT/lAMbbKVXKMAUWnLwutcMo=
X-Google-Smtp-Source: ABdhPJy2SsqiafbwlqYU+fkKe9FgjCHsz6d+TazIIB0I8SZFKl/ZHh5h161dAB8zah7k8qMR9uLyoA==
X-Received: by 2002:a17:906:f189:: with SMTP id
 gs9mr1957000ejb.203.1592449241021; 
 Wed, 17 Jun 2020 20:00:41 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 l18sm1034131eds.46.2020.06.17.20.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 20:00:40 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] hyperv: vmbus: Remove the 2nd IRQ
Date: Thu, 18 Jun 2020 06:00:25 +0300
Message-Id: <20200618030027.759594-2-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618030027.759594-1-arilou@gmail.com>
References: <20200618030027.759594-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x633.google.com
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
 hw/hyperv/vmbus.c                | 3 +--
 hw/i386/acpi-build.c             | 4 +---
 include/hw/hyperv/vmbus-bridge.h | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

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


