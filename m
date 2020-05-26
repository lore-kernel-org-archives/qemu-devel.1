Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1912C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D18207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plYsxoYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D18207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZig-0008SA-TS
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhR-0006EU-Oi
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:36690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhR-0005oN-2p
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:57 -0400
Received: by mail-ed1-x52c.google.com with SMTP id b91so17684520edf.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ExVlN86Dv7JggIxvLUBjz5FHxHeWDg8nuqJ3/185rZA=;
 b=plYsxoYZSAgslB/C0RDbBVII2MFwI9zXj+XMhSiXSrA9RD+ot4V+ICbX2lNw8YbkCQ
 XfGLg4XTNCoWvgopHufcRduVvzUx+SGYn/Uhdb+14WZXdTJHyLnpPonnh5EAOpTb6Chv
 ef7qhRoppJ1H9T043aO0IzXz2EphMcv1Lvd/dH5ccm9HVJ51HPh2/a7X/fUPolYuKVuz
 W3pDhPKicbksceasvtsDnRP8kRqM+wsFQFdugIFNIU9IGF0yjtfLdXkcbup16qmsG39q
 WAyOZ+QhX9zDuVW1C7O18+9PVaLSubQHe8zfncwc2EwI+xMfx746rjKU8kIlP0Gt+5hk
 loxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ExVlN86Dv7JggIxvLUBjz5FHxHeWDg8nuqJ3/185rZA=;
 b=ffJGNTo7l/KPqUo1mGS+I3v5sYWZsdFhPIty6NfkGiXInRKWHtyAtFu8AtuaVN7EAz
 jaMYmEBgHLhl4OnXOaexxHYyjbOtpwCjrPoN2YsqZb2AFJQRtGK6hIriCWzsES0yQLZP
 0x9qV4gW7nA67T3BpBtU5pEHrflVTHmn7RhS/0fM1ZTnwWjWbvngtxqKQ0Q4J1ir65DW
 fcthgYVIW0C/HEfOTA2453GUha1Graqyw9V+ydC+sqWrO4Kbuut5I81PJpBCBfAY+7Eq
 x91w3dUr0x34WyzrBAK1oJC5ps0PRBvQl62KggIripm5Syv/lVh85GhiN269doUhVKcg
 ffjA==
X-Gm-Message-State: AOAM530iD/vJdZa1bzRF0lmRG6qfXZwphmWM9l6MQ1WY6EXrAhwtbGas
 isOYcYT6uCLedT7exobj/mcpzRG9PKs=
X-Google-Smtp-Source: ABdhPJzh5e2NJGorrQJUH5eWtCdS6ap4rrW8N0+JXwmSTQz4ZyMcEgH1vsP+EBW4EoanR6T4h6cucQ==
X-Received: by 2002:aa7:ca49:: with SMTP id j9mr20535964edt.186.1590499975531; 
 Tue, 26 May 2020 06:32:55 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:32:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] hw/pci-host/bonito: Map peripheral using physical address
Date: Tue, 26 May 2020 15:32:37 +0200
Message-Id: <20200526133247.13066-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52c.google.com
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

Peripherals are mapped at physical address on busses.
Only CPU/IOMMU can use virtual addresses.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-id: <20200510210128.18343-8-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index b874468ea6..b90e5a636d 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -647,12 +647,12 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
                           "ldma", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_ldma);
-    sysbus_mmio_map(sysbus, 3, 0xbfe00200);
+    sysbus_mmio_map(sysbus, 3, 0x1fe00200);
 
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_cop);
-    sysbus_mmio_map(sysbus, 4, 0xbfe00300);
+    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
 
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
-- 
2.21.3


