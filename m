Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D4C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581FB207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581FB207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcQ5-0006Ep-Gl
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbse-0007S7-Pv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsd-0006yy-Ce
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsd-0006yf-6o
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so199183pfb.7
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Supmr9q+8YlVFK3tNfVw7bIH+Epm9JEKvf8SkP1cu4M=;
 b=W19zeUFMJKRrIBFLRRz04KjvaxcYuVD3eihYPzX4dqgUyQ4/Mi5cI8o4NwJu4KYB0X
 WhLfxEkI4C1OxEZc1DfEmeikhvVXfGba5viyZAM8gGBslkYZiO1m0DDl7YKqOAXuOloP
 fE5hzKad0sQAkjDOHAUS1V1lR4/Tw1LkxkThwio8GGoS97Q7ApHY0JHf/t96DNaYOkn9
 KP4G28votB2RE+NCSdYUeFCSDZfn8GC2TKe9BFvuzvV5UNuHa42ES3JdRjTrD1vMkvMV
 7zPMDbaRmERVRqbMRW3/UQ7ILwao+KGtbLddEuo6ujfiBkqPef/pkn72TWycUij8UfzE
 4DNw==
X-Gm-Message-State: APjAAAXalU/cwaPObPWk6pgIjGPzsBAOXIB0M3xmd3GIvb14ubJ+Z0Aq
 rHovsHPjEbip2ii3lUj++/dP7g==
X-Google-Smtp-Source: APXvYqyMJ+wYd9nmmjJVm6JLWrdoGPi6KZ8oXXnAHkdNvsFjxmNLOYUX5TxNPikW5kKsEDwqK8j/4g==
X-Received: by 2002:a63:c203:: with SMTP id b3mr4568590pgd.450.1568820509976; 
 Wed, 18 Sep 2019 08:28:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id m24sm5122742pgj.71.2019.09.18.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:29 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:24 -0700
Message-Id: <20190918145640.17349-33-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
Subject: [Qemu-devel] [PULL 32/48] riscv: sifive_u: Update PLIC hart
 topology configuration string
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

With heterogeneous harts config, the PLIC hart topology configuration
string are "M,MS,.." because of the monitor hart #0.

Suggested-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7fc126bc06..d80b203cc1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -424,10 +424,11 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
+            strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
+                    plic_hart_config_len);
+        } else {
+            strncat(plic_hart_config, "M", plic_hart_config_len);
         }
-        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
-                plic_hart_config_len);
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
-- 
2.21.0


