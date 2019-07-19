Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C89C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10F12173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxE7v0uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10F12173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT8T-0000mY-JN
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hoT88-00086n-Kr
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hoT87-000236-Kd
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:41:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1hoT81-0001yj-QB; Fri, 19 Jul 2019 09:40:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id r1so14199071pfq.12;
 Fri, 19 Jul 2019 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Sgvj1ecqf5A8ZdfMhXMbPJTPiuDyoTaOKfMmH7WZQRc=;
 b=PxE7v0uOsPwDFHy9sZS8rkHcn4NPnhh/dP65Z1Z/b8crpQsgJdhScDetY2Saf995cY
 QJBi0J6R6oq7Ovo5umdP7RzbakK1e/54iVcBdGNrQhwqVWfULBkNSQdW0USbuCNIWQ7z
 lTZotQYSHMbXrbYGD5gOTO3CjPHYaa7iHYtqLmcGbztrY54h7QaVR/c5UGYBKbVT0r9F
 f0LZ54BomceyS8txkWm4zdRofH+30rEzce6eyNHSQVDLmvbo4AsiE0XbnIkCegJspGa1
 NslXdI+LISWOwft/nEh28t7jULbke9BB7hwQP+PQSKJ3Hq4uSY40fqlj4apwy6H9IqCx
 9ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Sgvj1ecqf5A8ZdfMhXMbPJTPiuDyoTaOKfMmH7WZQRc=;
 b=cEpbGinPJudvzgNbHt+cYmFzBLKxU9IcRaoJWUh6HY+djBL3gqFNrCF/vV6Rn6YV2F
 m+XY35wbRK1rKAEk7UahVi1Rnp0zjeVA/u3ZrAYffLGg2s+tBPxoMAsC0nrIFHldk8iR
 Oi3v5kbSa+pHj0geaPfO4xCDV/BtK3/yNDy54K6P1wVpcT8ecWI8j5DC5Srf/xWmw9oa
 OC3LgBjkDbO7raFQDwFhIyVmT2lhKmuxzejjSD8a2nsHH6MYe5OPwpmO/XXHZN5mCNEg
 tbqZub/EvdPlv+MbGxRcBhKYEoweZLpQ/1tbACNCrC5w1p0eR1hWwgpi2WejR4m+AoeS
 DuJQ==
X-Gm-Message-State: APjAAAV10r2UsZifojw72hvUSMt8PgvdlN271YekIThwZRnnuuc48yYv
 ry3zZJFeNzDq00Ocua7jVqg=
X-Google-Smtp-Source: APXvYqzKRyY/qI7NzHak+yRTpengF5lMD9ErXZcPNx086Xxht4os6TorH+irck+x32xAJAEkUoIZaA==
X-Received: by 2002:a65:5082:: with SMTP id r2mr28869355pgp.170.1563543651676; 
 Fri, 19 Jul 2019 06:40:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v8sm25953097pgs.82.2019.07.19.06.40.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 06:40:51 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 19 Jul 2019 06:40:45 -0700
Message-Id: <1563543645-20804-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
References: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 3/3] riscv: sifive_u: Fix clock-names property
 for ethernet node
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The correct property name is clock-names, not clocks-names.

Without this patch, the Ethernet driver fails to instantiate with
the following error.

macb 100900fc.ethernet: failed to get macb_clk (-2)
macb: probe of 100900fc.ethernet failed with error -2

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5a221c6..64e233d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -215,7 +215,7 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         ethclk_phandle, ethclk_phandle, ethclk_phandle);
-    qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
+    qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
         sizeof(ethclk_names));
     qemu_fdt_setprop_cells(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cells(fdt, nodename, "#size-cells", 0);
-- 
2.7.4


