Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E1C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE59208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bihUoEes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE59208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwivB-0002v6-0E
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwiss-0005wE-2m
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisq-0003wU-T7
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:21 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisq-0003wF-NI; Sun, 11 Aug 2019 04:07:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id ay6so46750972plb.9;
 Sun, 11 Aug 2019 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eeAZO5I1vQDfMUsfTmGQKK/4S5NIgqx6mqJjsBGiL4k=;
 b=bihUoEesgrPfhOP8WzKcHhL+PPRY+LS7Kv82TyjLQ+TJYIyZtI+caKUZ7CZB6rDUbI
 ucMOwKbWayZFy2LQsWqUe07wg9CBk++vTaSAa6Ce14R0HK1uLFeEzIfFahV2osU3BgB6
 yVnls2MaVKTiSkzYLqlb/bATYQLYSYQPKAq8bbTQZl/jrZTUaDuAebzPblLzgyYyzMmz
 VSI0894GYYxovSKL8m3I0DruqnN1y6g5oqOGtBuPhv1btSLLdqtj4rYk9qC8/8jyEOyT
 j9Bq+Eda9DTVf8cd1IUF5W9SPjSy1LEZt9WS0ABmJoVtp5IjE6yI8ZY5j/Z76zdlH8uq
 HtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eeAZO5I1vQDfMUsfTmGQKK/4S5NIgqx6mqJjsBGiL4k=;
 b=otyudNkQEOVrMmElgh2KaPUkI6hgERe2k71g+enZ59QH6WkZHPEmLMFZJyhpQh/IlG
 nAFcDf6KaEo3/YecgojHtim+/EGUwjqh9mjrAffsFXPbkuDUi3l1AxdP+6eqgKuAa5p3
 2r27vnibNRWyEksxjBYm7zGYP14RvdHTh3URAzytcNrIaCEhfBgps2ez59OeAtm/7YcZ
 T0NPbtZ+Fv8BwCGinc5CfeJ6ZvtY4Ff3CV14GznxNDm137pYj11fkbaxxn+o2ZwKGQ2T
 LkRZRRdHLrVLPIqkgsn5/Or7uCHDY3DSU8JyrmtvqcS8+qNkMFvid19IkiLn+nNNnPQy
 +2tw==
X-Gm-Message-State: APjAAAV/67WfgITb+W9OkhseS5/a7EvFA0Kw38dsBkexgQehlz4sAahg
 ZD06MQunjBK7o9PzX5K23st4ekUR
X-Google-Smtp-Source: APXvYqx8XvDw50eMmptWnqyPnSuULrIIYvvn9ZQc98FKLlzllu9f5F45JGC05WLm0Yn8fEpVuPhBJw==
X-Received: by 2002:a17:902:ab8e:: with SMTP id
 f14mr10436500plr.6.1565510840032; 
 Sun, 11 Aug 2019 01:07:20 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.19
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:45 -0700
Message-Id: <1565510821-3927-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 12/28] riscv: sifive_e: prci: Fix a typo of
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

It should use SIFIVE_PRCI_HFXOSCCFG_RDY and SIFIVE_PRCI_HFXOSCCFG_EN
for hfxosccfg register programming.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index acb914d..c906f11 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -89,7 +89,7 @@ static void sifive_prci_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
-    s->hfxosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
+    s->hfxosccfg = (SIFIVE_PRCI_HFXOSCCFG_RDY | SIFIVE_PRCI_HFXOSCCFG_EN);
     s->pllcfg = (SIFIVE_PRCI_PLLCFG_REFSEL | SIFIVE_PRCI_PLLCFG_BYPASS |
                 SIFIVE_PRCI_PLLCFG_LOCK);
     s->plloutdiv = SIFIVE_PRCI_PLLOUTDIV_DIV1;
-- 
2.7.4


