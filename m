Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D62C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C99206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qju0864v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C99206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFKr-0007MQ-OU
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maxim.uvarov@linaro.org>) id 1jRF6L-00043N-2P
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <maxim.uvarov@linaro.org>) id 1jRF6I-0004Jz-SD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:40 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1jRF6I-0004DA-9w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:38 -0400
Received: by mail-lj1-x244.google.com with SMTP id u6so2189797ljl.6
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=gPyv6GKjQYuumQwDy0Zbk4FJLRJiznTbr7kAayBXHTQ=;
 b=qju0864vBOrjbCqF0MyqJopoPEZNqy91x32J0DkdohwDOKJXIdpLBGCWwDI22fzrgu
 d88z2REHE9wp6khs0HiSZKBtXANqWyUu2Hs9psbDd8k4ZxGKy8zQTeX/YzjSZLAJzYee
 EZ0yaD/eZBq885Zo0Vja6EMqiemoCHZH9adtz+CnTB0K47hNGpreAf0TjhHOfGE06YLr
 JGpRLbVHjBKAOu6HH28kwSkJO9jF7kDGaQWoZpxFPCws7qIUZHlQb8Imz1yGFuSrDeYf
 YUf7JXBpYmbUtd+rQKe/sHadpVSfa3fBfaFcAyA0BWpjJCo6puVrjItAVwaXiXl703Gn
 egTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gPyv6GKjQYuumQwDy0Zbk4FJLRJiznTbr7kAayBXHTQ=;
 b=kYgywx8kywtfqmYOHknAWkyKA8VuOUlBVD/G90daI4blKLVkUL9ZWt4KqwJWK7cWRl
 fJmPuCzdcCb5xiL/R6uhgjUZMdI0zFHO3c3HlgKboypRDBtmH5Kd2iO/bYv9omn3Rr+Z
 fgwHv8+KSxPAWxsDydXLU0z73/8vJyFoXjTGuQHAlFWnRf9d+tsE1yuyEKg7IkLby93U
 uh7HP+OGWNLfrPxBYVx2y6oO+kAkWwqtTAzpHwZabQxJ3pEsL7b7p+AVyYqHpsmMsOxi
 KflOrLYcUSSVhJ/HWhjo1N0tOQCn8TL0mWsFE2MtFJuhMOmBuAOq/dMFN7ZtPIBNfuv9
 bAWg==
X-Gm-Message-State: AGi0Pub1Mfq3PTje0dMkCpbq7+pjEAU5PfWr203wnl3nMWEoXl/s4PJN
 grcZtKrRC7pUt0sui7t1Y2s51vZBpDI=
X-Google-Smtp-Source: APiQypK8Y4bXQF6wduqwu8CS22KV11OqNPG07Wt4Fy6sSaVOazvmQHeBV7wQOT8Jrlxb+eqt274rQw==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr5298695ljg.122.1587560854725; 
 Wed, 22 Apr 2020 06:07:34 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.106])
 by smtp.gmail.com with ESMTPSA id u13sm4516564lji.27.2020.04.22.06.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:07:34 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCHv2] add optee dts entry for secure machine
Date: Wed, 22 Apr 2020 16:07:24 +0300
Message-Id: <20200422130724.3581-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add optee compatible string for dtb to force linux
to boot optee module.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 v2: added method.
 hw/arm/virt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 656b008..c937a82 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1335,6 +1335,23 @@ static void create_platform_bus(VirtMachineState *vms)
                                 sysbus_mmio_get_region(s, 0));
 }
 
+static void create_secure_tee(VirtMachineState *vms)
+{
+    char *firmware;
+    char *optee;
+
+    firmware = g_strdup_printf("/firmware");
+    qemu_fdt_add_subnode(vms->fdt, firmware);
+
+    optee = g_strdup_printf("/firmware/optee");
+    qemu_fdt_add_subnode(vms->fdt, optee);
+    qemu_fdt_setprop_string(vms->fdt, optee, "compatible", "linaro,optee-tz");
+    qemu_fdt_setprop_string(vms->fdt, optee, "method", "smc");
+
+    g_free(optee);
+    g_free(firmware);
+}
+
 static void create_secure_ram(VirtMachineState *vms,
                               MemoryRegion *secure_sysmem)
 {
@@ -1720,6 +1737,7 @@ static void machvirt_init(MachineState *machine)
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
         create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_secure_tee(vms);
     }
 
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
-- 
2.17.1


