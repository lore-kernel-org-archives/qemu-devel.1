Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F92D2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKOPzUME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F92D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXCD-0006yR-Ay
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7U-0006sk-I1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:40 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:32967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7T-00029D-N0
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:40 -0400
Received: by mail-ej1-x643.google.com with SMTP id n24so23290455ejd.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W8VxI71hr8dlU8kpN6GleuQ2+cio9Eeh3dClavw718g=;
 b=cKOPzUMESSblq/LcZNknge+VaG0pxAtqvDGt2wq9x9vNl3I1NDNi+UzMtO+Y9O3hKo
 eaa34QWIQBL7Bwqvc7hJVDvNMyn9LkwEgIeQZqdP6PFC1OJmVBIYBrDXroEXVz8GsDcn
 jJb2pxpSv/P4zWuSq/vgqlAYaGo1dhtlLtyLkxsd3Yl917GnUdO2VmXuSDH4s9RBJnHO
 guqyDiI/QSK4e8l+RltyfRNVgq+uFZeKAIChU35sBttEi2jlspbUts/IymftjWiRJ+tN
 wo6/Tc5beoYcp6RLIc5rSFVIczA6HeyxAcs9/WozTPz9QXn5rnY8z0+PzPOfabOL5pGu
 QLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W8VxI71hr8dlU8kpN6GleuQ2+cio9Eeh3dClavw718g=;
 b=ORHGnTEGInJDfqASI3oeY84kp9z4XQSqVN2+Wb/Sz9t4mnhQJ+IICZYDZrG3eH6Qj+
 3E0Lnv42AbRvQbl/QTPFL3/2h7lG509NIXBOPRy7iLB9f4ZgEng3AfMXAHhtbSaAAOmp
 JG8en6hZ9OW68gEeogs7N/hibjZ5zj5PdAjG6jXgFAjQHNElHG/v1JIIhZtQoaqhfmhd
 qcvrRmdOecHp8Xdugt2Af3wfIgSSy9lcxC6kocBuFEbt138Givg6ZKieQ0PYTnI6VwpV
 KIgTuLxkR4fUtPeVaSljj4ZmeoOjDIejQkzKqhyZIYfvl6oGesPT/6QFOEAI01huq73v
 Y0jg==
X-Gm-Message-State: AOAM530JFksD1Bqlp5lzJ0SPHatkIVoOpufur9zOijZSSvNODAp/By6d
 Zk6PJj/1OMa/xOxILzrzxcdLDkIqnKk=
X-Google-Smtp-Source: ABdhPJysxEIj5mQJcqunjHYD14fn4IkDf5j5oqnDQLPJI7jYdR0p7CfygqX2pBbp92IoN5Y/5iaf7g==
X-Received: by 2002:a17:906:f208:: with SMTP id
 gt8mr533561ejb.358.1590490058229; 
 Tue, 26 May 2020 03:47:38 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/14] hw/pci-host/bonito: Better describe the I/O CS regions
Date: Tue, 26 May 2020 12:47:19 +0200
Message-Id: <20200526104726.11273-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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


