Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8163AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6AE22CF7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmglgkV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6AE22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12GV-0005A2-8t
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rV-0004OT-5y
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rT-0002kw-VF
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:44 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rT-0002kN-PV; Fri, 23 Aug 2019 01:11:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id gn20so4881109plb.2;
 Thu, 22 Aug 2019 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=gZltYDF3iwdJcGYLhKT3YuPe5k+kq1mwUmYAQAVkYAc=;
 b=QmglgkV9i9dSU/JgxxDAna2XKFFs0e0OOy3tqwl5ihpZbqZwpD8kpNbt87bVQsze9S
 TdliBx1wCcgqSXvzSolXweF1i106fqDN+ILUtdiLJsyKI/LQfLDeT5BGfaQtx/XZIIqE
 r22o2QGJm41gJY1eVU4NXg2xRqO4bsvg8G2JxsquCKK7Waak6Iebn8T1wgXyKMLccwRT
 LNYaUOMOeixMkgL8LzHFbJevklaUOO5Y80ezCPHC555XLYawHu0abnySbxa/VGWsT6jn
 Of1eeH52be/XIjtiN0/jLF4QA4iYfzbvpIoGlLvwUoS7sGYqAonqhCwKhNcVqxnon9tb
 fSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=gZltYDF3iwdJcGYLhKT3YuPe5k+kq1mwUmYAQAVkYAc=;
 b=Z3XmnaNkp2mtl74VtblSwfoHlzRg+tOxA5OxxcOlwIx0ASpGz4cYdfZSkRFoTUaxQf
 iTLBuzMpWRO94oIUsMWeBHDXZAcy2YJI/DqUrLi8uo8IIhtOjLh6I2/AhqN7bfidC/9x
 hasrPFoWsSlcrobk0OIxY4fp+HC31xC8X1+4NIU3yTIwGyJl5WlmtL202urSa2gkezfL
 ku7Tlbm4Gs/1Q+FivKB6hOulUxdYfDOmRr6lfXrepHVxzS0RpMBW1jnIioY421/KEipE
 uKV0+2VGLTvYWU2wIkWpnVvp3986LP8GMyrTKIKFwzXdZwDfIRrZOdOEuksbMQpT/xLd
 pCkg==
X-Gm-Message-State: APjAAAXpFnti5wxjpWG7acCfreTeil0NoPZq8C7qVJKCLm2NO57ai6O2
 1UgeiHqYybvTRqpjErUorXE=
X-Google-Smtp-Source: APXvYqyPP9Dqypdi929g5eyAkxQt0ZanfCzYwVd4WtAhF+plGFMHvsui8ueHNYIWZj2isTKb3vJHEg==
X-Received: by 2002:a17:902:542:: with SMTP id
 60mr2557669plf.272.1566537103122; 
 Thu, 22 Aug 2019 22:11:43 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.42
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:42 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:11:03 -0700
Message-Id: <1566537069-22741-25-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v5 24/30] riscv: sifive_u: Change UART node
 name in device tree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
use this information to locate the serial node and probe its driver.
However currently we generate the UART node name as "/soc/uart@...",
causing U-Boot fail to find the serial node in DT.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1a178dc..6cf669c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -287,7 +287,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.7.4


