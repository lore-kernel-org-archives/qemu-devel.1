Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97086C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC72206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qk0TXZbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC72206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQVMm-00013a-JE
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 08:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45804 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maxim.uvarov@linaro.org>) id 1jQVMC-0000WP-9T
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:17:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <maxim.uvarov@linaro.org>) id 1jQVMB-00076T-D0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:16:59 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44646)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1jQVMA-00075C-Pj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:16:59 -0400
Received: by mail-lf1-x143.google.com with SMTP id 131so7695626lfh.11
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=90U7g6QRjcavx5MlRUxgpf0KQqMNtMFsmbd8Sg10FCw=;
 b=Qk0TXZbUZRpUsUFf/9N+LWjfMBXED4QR/z1lTbIL5oD1JSogTMJBrxnhNLG99I6xtO
 l27t1JnH/0NZMAlUPx3WHqW1M9P29vfVx8NIiqZfM3Im7zCvbtN7+gatC8jyE/6LFVqd
 aV5UMXzlHRRfSQX1xraVVeyqvhyfTjglPMQjD3MUl+qZwz+tdtG8IFuYM/D4SvdnhqDS
 TRnvGcM8Wy/FFRlZKbFhyb/6cSWPiCyAYYzAhdrcZA7GAfbrCc9+oqdmt5D7+MeeS2Cp
 ihm4UFv+bCNFWHNDKD3DMb1gfL1PvKpKEcGac/KMNk/6izJttF/izwzJNZMJhsMkoxp7
 +0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=90U7g6QRjcavx5MlRUxgpf0KQqMNtMFsmbd8Sg10FCw=;
 b=NVbwI9rkLc/2vYPJLFGO/j1jfqj27xTF5nrjiiaJMCGf4q1Yv5kGkAuPDQHrwXn7/W
 41kfhHMukGzvuQ9Zbn/tN/eBYR9HQE21EprxoP3WMT1A6NuJSD6PQCgaF9meNPDRffBx
 mOSQnmEU/hQwBJyEGtd8ZuHye6X5CyNgQuxQi6IKc/909yWMyDebF8lsKNNnC+zPxFWp
 Uap+cBBt3hR1yRRuTkTPI0Stov56KZpm9tJFqKk0uQTDaYFU2M5HutjfcaDb2cwK8ujn
 gy3kQorWPr5+MYJ6aseKoV6thrkP53eha2yd2bzSYc89h0nwqqUblofiT2kUZoJjLn2s
 87+A==
X-Gm-Message-State: AGi0PuZdo2MqzG6d4A4kWxhVgCQfb2Uh0yCXCpcaBfddtFm9+Pk87Zz5
 4yIjw1XQNSwIfbuRLg5ENbKVOhQKiic=
X-Google-Smtp-Source: APiQypInREpOoN8pmLAPTky/rKtZQNZXFjkUtnYg/JGVFliPq01I89wGgJnxoAyEQP107zCQSO6aIw==
X-Received: by 2002:a19:f206:: with SMTP id q6mr10732045lfh.85.1587385016408; 
 Mon, 20 Apr 2020 05:16:56 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.106])
 by smtp.gmail.com with ESMTPSA id w15sm909249ljd.35.2020.04.20.05.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 05:16:55 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] add optee dts entry for secure machine
Date: Mon, 20 Apr 2020 15:16:52 +0300
Message-Id: <20200420121652.16615-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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
 hw/arm/virt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 656b008..7d712f3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1335,6 +1335,22 @@ static void create_platform_bus(VirtMachineState *vms)
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
+
+    g_free(optee);
+    g_free(firmware);
+}
+
 static void create_secure_ram(VirtMachineState *vms,
                               MemoryRegion *secure_sysmem)
 {
@@ -1720,6 +1736,7 @@ static void machvirt_init(MachineState *machine)
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
         create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_secure_tee(vms);
     }
 
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
-- 
2.17.1


