Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110CBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7622077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHwwG302"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7622077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNGg-00020P-Ut
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKNEL-0006MS-2u
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKNEK-0008H9-05
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKNEJ-0008CK-Pw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id d77so7352482wmd.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pUolEYbY8XbrgT/4XGlHpmye2+orYYv6X2aq+U3yuRI=;
 b=fHwwG302DTBYoT8VtGfEOXJxy5QjPXzAq2IfaF6QrwgILJwDDsBC4BKHesWGyTIkgi
 LT3+L80/gL+HLYg3GQuQkwLLE6u99O22zXXPpmHBTHPcvrQgGxHc2wU5vq4l4rF6hBMR
 i3hb71kLufagdDgulxB2YHXg5e3Ff4kCwqATnzoen8cN0brbC8A33agoFL/ctqSizO4W
 GQlK8W3z4M2n5g9gBP7LjxtGKmbxwxyFWJKzgYhzCXw51wCWypr2+U3bnyKgKgSgOb8o
 H1Pa9MsCC3WyXcUI0ImsnUp4/3iaLLItK6+4zSSy3gvWYQh05lc6KA8r6aaDc6Ynulei
 6Z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pUolEYbY8XbrgT/4XGlHpmye2+orYYv6X2aq+U3yuRI=;
 b=ssU/cjnx9AHfjLTBf2QrzBKWN7f/BA6yP54DEK/oM+0WY4tp0CkZtyIrymoxgBbUma
 4ZnrvfnDwf8CSXJLD3coU2xgjGmqGPjHhTo8jjV8YhtP8P7TfPFFr8NELoI5h76J1ZyE
 YmLCBthKb0bAfmA42/NjQI0PVxdKwsfWkiw7pGZ+71siAzEHr5a9wtE4YH531Wk5ktTS
 AG9p6KG1Iyza27F6SatYeBNdHTXKEpik9K7xBAdGNChVETR/exf6GA22ExAX5NYw5db1
 j5FFxmWbnop4LBWV2oFQrOhlI9QOJDZK/5NVRjW45mZDRhL+23KEpi8wfA/1ppKw5ZRH
 MTiQ==
X-Gm-Message-State: AGi0PuY3XMzdKKW6z4GUywE26gkT8i79ArUKZ2dN58nST/S60yMBz2cA
 womXI5u8AzBk+foeqTQhLOxUOXqoJW0IBQ==
X-Google-Smtp-Source: APiQypK18WYEsG+wCvjYX7HNDF5n6s7BKXq5pN+51+bcyK1p+kebPRY27CjJv+Gpn9FUnIu96nRT/Q==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr8956511wma.35.1585923810659; 
 Fri, 03 Apr 2020 07:23:30 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-167.inter.net.il. [84.229.154.167])
 by smtp.gmail.com with ESMTPSA id i2sm12218646wrx.22.2020.04.03.07.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 07:23:30 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Date: Fri,  3 Apr 2020 17:23:08 +0300
Message-Id: <20200403142308.82990-6-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403142308.82990-1-arilou@gmail.com>
References: <20200403142308.82990-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com, vkuznets@redhat.com,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
entry to DSDT in case vmbus has been enabled.

Experimentally Windows guests were found to require this entry to
include two IRQ resources, so this patch adds two semi-arbitrarily
chosen ones (7 and 13).  This results, in particular, in parallel port
conflicting with vmbus.

TODO: discover and use spare IRQs to avoid conflicts.

Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/acpi-build.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2a7e55bae7..6d7fdbbe9b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/boards.h"
+#include "hw/vmbus/vmbus.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
@@ -1270,6 +1271,43 @@ static Aml *build_com_device_aml(uint8_t uid)
     return dev;
 }
 
+static Aml *build_vmbus_device_aml(void)
+{
+    Aml *dev;
+    Aml *method;
+    Aml *crs;
+
+    dev = aml_device("VMBS");
+    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
+    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
+
+    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
+                                     aml_name("STA")));
+    aml_append(dev, method);
+
+    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
+                                     aml_name("STA")));
+    aml_append(dev, method);
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_name("STA"), aml_local(0)));
+    aml_append(method, aml_return(aml_local(0)));
+    aml_append(dev, method);
+
+    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_irq_no_flags(7));
+    aml_append(crs, aml_irq_no_flags(13));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    return dev;
+}
+
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
@@ -1296,6 +1334,10 @@ static void build_isa_devices_aml(Aml *table)
         build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     }
 
+    if (vmbus_exists()) {
+        aml_append(scope, build_vmbus_device_aml());
+    }
+
     aml_append(table, scope);
 }
 
-- 
2.24.1


