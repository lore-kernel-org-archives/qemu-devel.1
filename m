Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD5C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07ACE2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="un5RIDbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07ACE2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2UMe-00018s-9b
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2ULp-0008Rn-OJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2ULo-0007uy-Qy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:21:21 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2ULl-0007rz-Gg; Fri, 14 Feb 2020 01:21:17 -0500
Received: by mail-pf1-x444.google.com with SMTP id n7so4372388pfn.0;
 Thu, 13 Feb 2020 22:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=7v5rQyr9eTRNU0avUKqGOcoW+Bqm4weOk0U1hS1FOnM=;
 b=un5RIDbGYFFQSzIvXCU+nTx1tljAi22l6SCXVJdMIlvjV6NjzdNkJ8HYGr9xoHkXHt
 XmZSxfxvBeBQC6TLp2+NzE7ufDQB1/FFCKBaiooM1bT/g/AIbdLvtShBd2HNeAe31m6y
 //SKorWaEt55Q3CtwZv010K8NnYU//mX/jHUyAYUpjfmaKKHOS5PjHkEAPJRFLDSXMWY
 s0s3CGkj2FUnuCMvSLuQkhMpexHHSNAiz1flFVCCrPEMXlOC42HGFiNd3gdOovMI/Zn+
 T/3guhoygBJsZI9+YOnJe/E0JOiSq2ilNZNBXCXAvMP+2E0VPEndm4o6zClKV0vNDyQL
 R0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=7v5rQyr9eTRNU0avUKqGOcoW+Bqm4weOk0U1hS1FOnM=;
 b=WD8nf4phVo9KuMg6Ven7ZuQ26VkqzNuOVgq2dTQWoiPM54ltAGn8rOHVCRLX2dJGVX
 e6KzYMgFjfd+SNQKveWEoQr034Re19EDsciTLLurL/Edu0jMqcDVMZXjeBnVz3pZptRe
 iKB71U3Q4N+eXwjm5Qj6AF9diU/BCRnNhRy7so27LXH+38PbUjx2bBIORFYYHLQkfIPo
 SfefeuaeXmG91oRd0PGeheNf6yWRgFB+WIdGe584iDj9tw3alniFKN/wBIl1+k9siOsd
 oTV71inzXUiH9s8Gr76yTjRCmOhRah2sMkc8rbh+V0zu2KTUpcqFjX0DqWE4Evpl7KGh
 L0dQ==
X-Gm-Message-State: APjAAAViuPDI4tQZmWxv1mhEROhfoHIAbPFbZOBGZ04f5Ojwix84if9P
 faE0+cbWby/jjLS1OMSHsQQ=
X-Google-Smtp-Source: APXvYqw2q3yU58AVHnWfr+ZIn4rHt9azdSGdAfBBe99JcZA/Fz+UFOn6Obft4uon3G1Ayb3sT6xn9A==
X-Received: by 2002:a62:e318:: with SMTP id g24mr1787610pfh.218.1581661276355; 
 Thu, 13 Feb 2020 22:21:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id x8sm5193838pfr.104.2020.02.13.22.21.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Feb 2020 22:21:15 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/3] hw: usb: hcd-ohci: Move OHCISysBusState and
 TYPE_SYSBUS_OHCI to include file
Date: Thu, 13 Feb 2020 22:21:07 -0800
Message-Id: <20200214062109.24494-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to be able to use OHCISysBusState outside hcd-ohci.c, so move it
to its include file.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-ohci.c | 15 ---------------
 hw/usb/hcd-ohci.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8a94bd004a..1e6e85e86a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1870,21 +1870,6 @@ void ohci_sysbus_die(struct OHCIState *ohci)
     ohci_bus_stop(ohci);
 }
 
-#define TYPE_SYSBUS_OHCI "sysbus-ohci"
-#define SYSBUS_OHCI(obj) OBJECT_CHECK(OHCISysBusState, (obj), TYPE_SYSBUS_OHCI)
-
-typedef struct {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    OHCIState ohci;
-    char *masterbus;
-    uint32_t num_ports;
-    uint32_t firstport;
-    dma_addr_t dma_offset;
-} OHCISysBusState;
-
 static void ohci_realize_pxa(DeviceState *dev, Error **errp)
 {
     OHCISysBusState *s = SYSBUS_OHCI(dev);
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 16e3f1e13a..5c8819aedf 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -22,6 +22,7 @@
 #define HCD_OHCI_H
 
 #include "sysemu/dma.h"
+#include "hw/usb.h"
 
 /* Number of Downstream Ports on the root hub: */
 #define OHCI_MAX_PORTS 15
@@ -90,6 +91,21 @@ typedef struct OHCIState {
     void (*ohci_die)(struct OHCIState *ohci);
 } OHCIState;
 
+#define TYPE_SYSBUS_OHCI "sysbus-ohci"
+#define SYSBUS_OHCI(obj) OBJECT_CHECK(OHCISysBusState, (obj), TYPE_SYSBUS_OHCI)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    OHCIState ohci;
+    char *masterbus;
+    uint32_t num_ports;
+    uint32_t firstport;
+    dma_addr_t dma_offset;
+} OHCISysBusState;
+
 extern const VMStateDescription vmstate_ohci_state;
 
 void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports,
-- 
2.17.1


