Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC0C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D90520801
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5OSVWyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D90520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXtDg-0003gx-F3
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt58-0007ZH-2e
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:55 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt56-000170-Tb
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:53 -0400
Received: by mail-ej1-x644.google.com with SMTP id re23so6189200ejb.4
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wMvH9BzemTZbwCS6RWBUJZxryrrXNUHuOYFdwrB8eMY=;
 b=k5OSVWyBf+P8i9VvIOgfFCNLkJHrylHyFw38C2qAtK2WgqMC+5dY2H9UIHpD8HGp/H
 LgkolNlIGOwAHWWQmrgAd8uWmmEyF42YQ6QD/xPZ4Xp0QapfNrRLegIQobIN2nG3TOdS
 aRYoGlylfUfh6PalooCFxz4hP+ucDIcJnehAQBYUN2cYUwnxEdKj5ci/+VFg0hAH4EDX
 pk3dsEHCvcAbF3hjjXKWb/QpHqYt5Z8n+DASV5FAbAA9+6fCUtJyWW4kRpIhiEh8t9BB
 1ZD4qJ3C7hMNbu0nZSSruL2Uc57A4Olb94noe92KbNj+QtjMUwLUDSCDAlUSkuPe3DM5
 9yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wMvH9BzemTZbwCS6RWBUJZxryrrXNUHuOYFdwrB8eMY=;
 b=iLjAfQ77tj34uSVzw1GK2Eb9G7ACE5pld438jT5hEK1RVHUfU1h4f58ljEmi8MgbSi
 vtfnbpDE9q9JcJBZD1/tzep0x4mPwugxcWO0uAYPI/9/l1kyDPHruoXNYtv6TBav6NSb
 +3hQipMtSD6d0QghEdk0fKuJmlvR0s0e03whEq5DQihOYsKkQP5BecsGgVMWSxjCr/cJ
 z/bgO1EnteCDeeHZ19yhd0PypU24tliz+PVcpjVpNsIFSsvta5fxZ/jV14EkxkkCeFtp
 XZvU6SYBPoyslt+BqIxKlB4tnDObVYr0tVQNS5X45+ICDS+TYRczlkoYPQsv16B5jq8j
 FyTg==
X-Gm-Message-State: AOAM531Se0v4Qu0ZMzjNHN+V4c7xQWdPG4Aikr2J/6IaJxmpqkI8PUpX
 El3pER0t3LHMQmdQlC2+x/fYLUbaGJ0=
X-Google-Smtp-Source: ABdhPJys1BPBGEqm3ZH0YAZYDro4mCz1ueJoxljkqZkugQkAfxlcRUtiO2h1/QyWOJySA671474xdQ==
X-Received: by 2002:a17:906:2311:: with SMTP id
 l17mr2136877eja.323.1589144510993; 
 Sun, 10 May 2020 14:01:50 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] hw/pci-host/bonito: Better describe the I/O CS regions
Date: Sun, 10 May 2020 23:01:26 +0200
Message-Id: <20200510210128.18343-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Better describe the I/O CS regions, add the ROMCS region.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 90a6c52a38..335c7787eb 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -672,6 +672,8 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     sysbus_init_mmio(sysbus, &s->iomem_cop);
     sysbus_mmio_map(sysbus, 4, 0x1fe00300);
 
+    create_unimplemented_device("ROMCS", 0x1c000000, 60 * MiB);
+
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
                              get_system_io(), 0, BONITO_PCIIO_SIZE);
@@ -679,10 +681,17 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
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
 
     MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
     memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
-- 
2.21.3


