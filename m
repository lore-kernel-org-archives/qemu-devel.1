Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5AC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962622087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDrdlb2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962622087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Z1Z-0003Dz-60
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yql-0001jg-SE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqk-0007AW-Jw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqj-0007A1-MG; Wed, 04 Sep 2019 13:13:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id k1so4154652wmi.1;
 Wed, 04 Sep 2019 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fquUmVkncxEMfeAsRc3/6BsqyJ3/ccTKHRFzefWvbc4=;
 b=pDrdlb2rH6HXIVh5RptUMn3al7DtlWvRcvKpBaPq53spQUKpEKQ8tu2amFuF36KcB1
 m0xhE9u/BWG35kTr/duYfN+6ZpnvRO3m8IqMnljYOymenAdTX22gVSG3Y5HVn4hx+wuN
 4TY4rPvOUVTYpQV5MliBprE8tdGbsVkF67cHWQ6/dPredUf+NkOePIQ1iGd6dGT0e4lD
 IlRtNNsbGvFz9SAxxV/YyURoh7b0iNsTslvE5mVaAkOxu5TUGJxHSVLFTSvvS4W+ta/M
 WF74ijiw1jQpfVBvvERdwQZ7WKDth9Sf5SbO3O63n0PgA8mHsGBUEZR78lpgPnRCADw0
 1Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fquUmVkncxEMfeAsRc3/6BsqyJ3/ccTKHRFzefWvbc4=;
 b=DdaWThf8lTQCei+iygxqZAK+wqD+WHjl+5xdahGNFuSBCHB6Jfnyn2HVliB5s7GPAR
 EEZLXQmbJvftXYKkm7Uu0x9GJPPEeJ4XYjG7Dcy+N6KyKQ+xUWnJ5LuNAxMSmjeVMBA8
 87um/BbMVmgNNknJLfIb6AIabNRmGoYBQqJYl9IcGCl00h8atg3567GJuf5656vFBroK
 msFmro1JJfw0oBxesYz0DqgfPG/WDiNv/r6wBSb/TPOXkFjrp7tpm2vlAGCqBEYcRZA1
 xchYn01mUR5ro8BnZpwwQTmsyivBKkBe365EVESQjEOHnjFAamPMkpA8yYXED7t6OVJh
 NVkQ==
X-Gm-Message-State: APjAAAU9N8u+YqbMXv5ceFAR3Rb+/uGFx3VDLWc76z2Qs68O7m0SorAF
 hyIiJiQ1kGuh157sXqkaDsQ=
X-Google-Smtp-Source: APXvYqwU6MyaKzsoxz9MLfPE23lpSKADVPHZtTUJSSKe27uUWigfDMQ8nQcAcb3dE6u8zcLk6l3bug==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr224180wmi.157.1567617220721; 
 Wed, 04 Sep 2019 10:13:40 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:14 +0200
Message-Id: <20190904171315.8354-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [RFC PATCH 13/14] hw/arm/bcm2838: Map the PCIe memory
 space
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2711 has a BCM54213 Gigabit Ethernet block mapped
in the PCIe range.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
FIXME: create the bcm54213-geth in raspi.c?
---
 hw/arm/bcm2836.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index d89d7cd71d..39190a108f 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -15,6 +15,7 @@
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
+#include "hw/misc/unimp.h"
 
 struct BCM283XInfo {
     const char *name;
@@ -60,6 +61,8 @@ static const BCM283XInfo bcm283x_socs[] = {
 #define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
 #define GIC_VCPU_OFS                0x6000
 
+#define PCIE_BASE                   0x7d500000
+
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
@@ -238,6 +241,13 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
+
+    /* bcm2838 kludge to easily create PCIe */
+    if (info->gic_base) {
+        create_unimplemented_device("bcm2838-pcie", PCIE_BASE, 0x100000);
+        create_unimplemented_device("bcm54213-geth",
+                                    PCIE_BASE + 0x80000, 0x10000);
+    }
 }
 
 static Property bcm2836_props[] = {
-- 
2.20.1


