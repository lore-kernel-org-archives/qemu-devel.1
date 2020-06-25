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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2059207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmolLcq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2059207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joJrI-0008RF-7N
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 00:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJqG-0007YR-DG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:50:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:33888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJqE-0006gA-Ov
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:50:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id u26so5834570wmn.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 21:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CJfSXCaF+nr/YHgiK31SJsbCa7LaSj7U7PCE0AopqEY=;
 b=rmolLcq0bQec9EhAOY1M8jOQ7pIkMGH6Vq5hnuIAobJ11dIcxkG8prku1l7gWtXzYc
 Wf7s+vfu7zhVYQQgs15MRD8gPhYt8el6ZrffSgVX6M129rkkp6+rRpcd/jDrfGZLMs3q
 QogW3zo1NplLvyt3vEKyWck1Lhe4G+eYCTCObLqvIfqj3lG0R41IR+M1+H5XBGiEGlwS
 8yNhAPe+fOHYB4KMw1W3GuJoCe3ifGe0AHjYN0MrBY36Jq7vQumwLrh5JojJTYV7ak3m
 MsvMlkqcFM4bX6CK4HZc2J5CghhZ6yRY8g6qxuQ4+aYDwtNUOACN4ats/z9tNqLL0hgD
 Wh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CJfSXCaF+nr/YHgiK31SJsbCa7LaSj7U7PCE0AopqEY=;
 b=HDzbK7eKADu+QpLmtqcd7OstHog+vdEa/IlfV3zeAPLCGygcDJhNLLGG5CrojlcT85
 Y5DXbcLpdJQrTuf0iB8umvC9XozfvujUvUvyrn/DeDYJuWW9d4zVEZpb+AJWJiDHzp3L
 R/eKpawARxeTJYX6gGPTAlIcNqc3AI6OhOw+wfVQkRc11n2b9E97Hsj9CMkpKElIn8Sp
 vAfGIdmZ8XYQLflLFsl7I3vCddlvEqZwcVuYwywlvCFnXyR76ASa5aDkoEv6QtAqHHRm
 0F2ZUoPZhqtWppx6TXLnEyo33mDXG3OU3SKGwxZN8hECxXH3u3LM9TerBpDaHYy4q1EZ
 GlWw==
X-Gm-Message-State: AOAM531SxY6seYUE2wcmx28H+I+4yGHkrvbvBeffKuHX5+BPhS+6DUqU
 +Fx85XJBwyWsDihq3PN+W70U+sLd
X-Google-Smtp-Source: ABdhPJxefrrguF+VyYUosSZG0gHnYEHxg8c9K2ihG7vMM6VdTxzdoI7icjEQWJObJ5h2I1HTlM5Zkw==
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr1255480wmd.36.1593060624827; 
 Wed, 24 Jun 2020 21:50:24 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 x7sm30684787wrr.72.2020.06.24.21.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 21:50:24 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] hyperv: vmbus: Remove the 2nd IRQ
Date: Thu, 25 Jun 2020 07:50:10 +0300
Message-Id: <20200625045011.1075314-2-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625045011.1075314-1-arilou@gmail.com>
References: <20200625045011.1075314-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x332.google.com
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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


