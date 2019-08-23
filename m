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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C26C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB67922CF7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a35FTrJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB67922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i126t-0003rS-EK
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rF-00042k-KJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rE-0002Y8-Jt
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:29 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rE-0002XS-Cn; Fri, 23 Aug 2019 01:11:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id o70so5655174pfg.5;
 Thu, 22 Aug 2019 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=abfIhjs94ppdRZa0sqZhx+9vkYxwlbvhyOHMnX1hFyI=;
 b=a35FTrJU/yetHol+fB12TFhQFvvUG6ZO/ku5TYsKcZ7Pcn4dZzab3MLUJiTlQe5CJb
 nf8nL9Q99m+5nuPXwMc3xVGMeFoAm5hZJRYm11M0obbVrdWKw7t21Yst5hhAlRswFUDR
 yAhD1ZNfK9jhLSs1EgGtc2Aqx+iLX91X6L20D7yqslAgjzeiGP9LUOSMBB6RLIDsMUaF
 qbqSnYmgmeeKDTBvJz7Oy8eJO299RvBpuA6Mrsn0kTDzMddeWQvR1f37GAiyqMHcwUCg
 4rY5TQPeJGajfNaKHmRaRc0pb8tm+QmCsVGEtiObjL1aXsGPK+BJS4jBW/adu9kk5PyS
 Ko/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=abfIhjs94ppdRZa0sqZhx+9vkYxwlbvhyOHMnX1hFyI=;
 b=QcgANakQHhdrsBapOzmCsD5HL3haru99uB38b/fAfpWMOt2XYfrkenAihzrXhJQHx1
 xkny32ASN3U2Q7vQ3Uy0F04Y4uDdXvM93knhKupZ9ZkUO6GNnI6H/h8sbP7FJVz1SvmD
 4qTgxvzUUyU2UzDasbi2oM36rvZ40qMrLjFgDy/fvPEZI+SuYgMhoeZ+8M8P4VRhg+U6
 +Zb6NhBrYmm0RjVGeKG/A3WZrxFXStWZbosCrZn99+ds15n/AVJMpTgAre6f3wNrPiAz
 LIkll0rB/DGfMagN75BMRfs1adPLApgNmWb5ORWcgVkrRl3TN+/sbTbTaed4/uVWy5m2
 RIzA==
X-Gm-Message-State: APjAAAWQTENo1R7JxDSYNqOFF4mtLzGm9knuFsE8I9P22+GBEWkBKFwk
 norHmxv0p/jQtiF/o4ThcFc=
X-Google-Smtp-Source: APXvYqx4Yh81ILslZzR6mXpYVRFhGdQbJUfMnpNtHSe2KZa1GiS+xn6YlJb95x9zTxU32TPqoMcB+Q==
X-Received: by 2002:a17:90a:b290:: with SMTP id
 c16mr3301911pjr.34.1566537087608; 
 Thu, 22 Aug 2019 22:11:27 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.26
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:26 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:49 -0700
Message-Id: <1566537069-22741-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v5 10/30] riscv: sifive_e: prci: Fix a typo of
 hfxosccfg register programming
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

For hfxosccfg register programming, SIFIVE_E_PRCI_HFXOSCCFG_RDY and
SIFIVE_E_PRCI_HFXOSCCFG_EN should be used.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index c514032..71de089 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -90,7 +90,7 @@ static void sifive_e_prci_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
-    s->hfxosccfg = (SIFIVE_E_PRCI_HFROSCCFG_RDY | SIFIVE_E_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_E_PRCI_HFXOSCCFG_RDY | SIFIVE_E_PRCI_HFXOSCCFG_EN);
     s->pllcfg = (SIFIVE_E_PRCI_PLLCFG_REFSEL | SIFIVE_E_PRCI_PLLCFG_BYPASS |
                  SIFIVE_E_PRCI_PLLCFG_LOCK);
     s->plloutdiv = SIFIVE_E_PRCI_PLLOUTDIV_DIV1;
-- 
2.7.4


