Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034DBC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE459218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE459218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcaJ-0001WT-Ag
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsm-0007et-HV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsl-000761-FP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsl-00075B-9b
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so174238pfg.13
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=lLKWAarlvSIO6KN2Vy3OsCwWDCZvaYqKoz3K8rh/mk4=;
 b=EG/yaZI8R029paM1B/e7Q8h+Vc4t3/G3OK1hlxbO9yGnnWiUylWYdzNTpnaxRfTM+m
 zpcC7mLszXrl9McILrieGxAjhBC55oMQ0tEMoUclBstvNT+iqIRLBqqJakCSaFQmUQeB
 8BOk+NoCQzEHd2UzCYE1Wjpih0jBuL8twbaLF53gK7JatEr0wl3B2u9v6fQP1vTaUc3c
 kpWb+P9sUAdTwSJPfGVn8yceQjAe7iaUy2NmyEJ69jWrooz6XV7pgdQzHlVMU1xvUo+k
 HgIiQXOMHejTJqF2u4TU8/5PvRb7Vi7KBtm97TxfGOLzKeFwuvnovJUKRcHyEhKHV7YG
 l5WQ==
X-Gm-Message-State: APjAAAXLEDzqaU4g4Zw1gRbtfTAuzyx2vNi1gLIdNspQqcEZfG4cAIA5
 NdCVZMDKIW+KNN5OTb+bkIfBjA==
X-Google-Smtp-Source: APXvYqxefurZXwlUHHZwFgNAu580GpKGIuQlex55N0m5bTmV5a13L5xkM5/UXsWvnV8hgZvyrn881Q==
X-Received: by 2002:a17:90a:3aa6:: with SMTP id
 b35mr4431131pjc.94.1568820518044; 
 Wed, 18 Sep 2019 08:28:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id w5sm6166236pfn.96.2019.09.18.08.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:37 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:30 -0700
Message-Id: <20190918145640.17349-39-palmer@sifive.com>
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
Subject: [Qemu-devel] [PULL 38/48] riscv: sifive_u: Change UART node name in
 device tree
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
use this information to locate the serial node and probe its driver.
However currently we generate the UART node name as "/soc/uart@...",
causing U-Boot fail to find the serial node in DT.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b66eaef607..24f8c19eee 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -286,7 +286,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
-    nodename = g_strdup_printf("/soc/uart@%lx",
+    nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
-- 
2.21.0


