Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA86C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448602068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7ihlkZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448602068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZmW-0000EF-FG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhW-0006Q9-Eb
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:02 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhV-0005ou-LQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:02 -0400
Received: by mail-ej1-x644.google.com with SMTP id o15so2454433ejm.12
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W8VxI71hr8dlU8kpN6GleuQ2+cio9Eeh3dClavw718g=;
 b=a7ihlkZhTRLKLGFyZsvQ36Buh6wJTZf+W2AFxQyfuYcCYibpYnd1ChYO8ym8yqlcLH
 EGXIRov/blgztry/kFXip78Ycuo3HW9T6D1WU9ZNXaHrCObwHF7ANvIby4/K/ElwxUa3
 rD5q493Zw0C/u0MVdcSSAC9cyYzRsO+5jd8HxEA7Z/Pky3iUMRbsQ/rmPc/dTqVC73O7
 3tcfrd39pVEBqAmEsGlcm5fp+tPUupInodfcb6WURDT9mBTLwKD8bBgU5xBhgX2/9OyC
 KB1Z/5Va9OyR2O+W5BnUXxZvb+r4bnNLURrGpM1hfAZJ/FRmVDaF5pYcyr8Lwm0CP8hW
 eeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W8VxI71hr8dlU8kpN6GleuQ2+cio9Eeh3dClavw718g=;
 b=TyoOFXT90zgcNvfQ4K8LcXuVJDn0Nz+jcnTy/ilaptbAopZ7Ltc98JCn162GQjxpy/
 U0DNhlQsbfmKMPZIN6Z8nT0yZgnYZabiTFwvAd5QBRTzNl2DHgCdDBstPf8a+arfFPNK
 ngaiwCslprYxv++fSOQh3Fwsv7ehMTIyTp5T7MHnLs6sQrxHKRQht1IFh6gcn1Xq4i67
 o/N4eXIF7xAW6bXdYSjzOrQi9VQBxkOd2vT/6dsA/EkZqwAQUBEkFasPTitFUiJDw72U
 dQC2Y2hQOVtbXBDyYkJzjYnzXRz6492t1xOIJ74xhm3dHQEaxnpUoXnHwbxCj1DpJ0GY
 Csvg==
X-Gm-Message-State: AOAM531rvFKuTScmXa3SqNt6cB4HwfmDJjiBu0DA8KAKLZaWTT2H4Tf1
 QQQHGEkfKrcNBRM2N48R3PmnRuCpf6c=
X-Google-Smtp-Source: ABdhPJzUY1mUjqfY86NxCT30EKGDVSOLNKM9YhYJAw21KF/OkFe4oJC9gCeR4bBH8SluGHqM1JaFuw==
X-Received: by 2002:a17:906:b348:: with SMTP id
 cd8mr1127899ejb.139.1590499980033; 
 Tue, 26 May 2020 06:33:00 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:32:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] hw/pci-host/bonito: Better describe the I/O CS regions
Date: Tue, 26 May 2020 15:32:40 +0200
Message-Id: <20200526133247.13066-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better describe the I/O CS regions, add the ROMCS region.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200510210128.18343-11-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 52015cc2a7..20f2797a73 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -673,6 +673,8 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &s->iomem_cop);
     sysbus_mmio_map(sysbus, 4, 0x1fe00300);
 
+    create_unimplemented_device("ROMCS", BONITO_FLASH_BASE, 60 * MiB);
+
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
                              get_system_io(), 0, BONITO_PCIIO_SIZE);
@@ -680,10 +682,17 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
 
     /* add pci local io mapping */
-    memory_region_init_alias(&s->bonito_localio, OBJECT(s), "isa_mmio",
-                             get_system_io(), 0, BONITO_DEV_SIZE);
+
+    memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
+                             get_system_io(), 0, 256 * KiB);
     sysbus_init_mmio(sysbus, &s->bonito_localio);
     sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
+    create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
+                                256 * KiB);
+    create_unimplemented_device("IOCS[2]", BONITO_DEV_BASE + 2 * 256 * KiB,
+                                256 * KiB);
+    create_unimplemented_device("IOCS[3]", BONITO_DEV_BASE + 3 * 256 * KiB,
+                                256 * KiB);
 
     memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
-- 
2.21.3


