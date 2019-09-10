Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FE9ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6AA21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6AA21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yZ4-0002Lv-O9
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwP-0008Sc-Vh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwO-0006t6-Mq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwO-0006sT-Cr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so10679720wrq.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=og+q1n3yOAmcc+5fUot4+K3025KfQ+1ohpk/ac261lM=;
 b=Yozpq54VP/F4rOPWWfK/XAt/SiH/5s2X+3TsxVdBfmdqfNzt68lS1xxVuV1hd32Sgj
 SK+gxiy56jLvl4jcc5Q+Ncm0+J4N//zU75E4FD0j7I8y0juUtqMnSiL9PaIWvnmNhysF
 GNsG5sHAC0NQb4hUL9GE4INuy4/nKL0JnrxT/+I1Cl9W/Oovjs372ilA6JIHFBMe/K0m
 l0AVW8aIjAihAalHNqEdfFPmyUv/kRToHaVbjSpWO7TT+faym+zR0E3zU5aShcqWXlvh
 TEG/YwxFWb1yVshrqL/JBXtKRFuGK5dKoYDVai10OjW6sJE4rlKIjNNg6EaF7+Wk+rr6
 pPNQ==
X-Gm-Message-State: APjAAAU/u63uc2nL1/Fuo/cVN+2SPQ047NlHC2V6F8Caic9rBPzm0ikN
 QPsEFhO6gF1yi4daAaCnuQtd4w==
X-Google-Smtp-Source: APXvYqzA5uuON1yW9070r+5K145tuNakY8E0qF03EU/UPbeC2fY0QQT8XRQp6u6EYfnXBJYNQXtU8A==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr28134122wro.2.1568190327160;
 Wed, 11 Sep 2019 01:25:27 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id y186sm3504784wmd.26.2019.09.11.01.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:26 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:05:04 -0700
Message-Id: <20190910190513.21160-39-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PULL 38/47] riscv: sifive_u: Change UART node name in
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
index a3ee1ec0a9..5ca3793d35 100644
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


