Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A41C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0713218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0713218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAceP-0005sS-D9
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsu-0007r2-SQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbst-0007Bp-Mr
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbst-0007BO-Ha
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so185095pfo.10
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=oPwMt36c+qjgfMs2sORHI/jyAZMzpgus3H9ildbbPVw=;
 b=CgQpSGo6LfF95LAoTMhiA4XjRzYIm8e3na0ee7YXtjfA9W9lTZC5V2c1pN0uVtq4pd
 OcG36aMRqvUvFrKoKuOSIt1ahokZkcAe+GVg50/zjq4iwZUK1oatPoy8nNBMMV45Fx1/
 6KMxkMHXVFkn/nsYylCbE4AJVqxvCInvdPFLNygey+aSSBlFOQsF9Sib6OeD6Wq4odLU
 SuZJF2cfkt/nG0TMDT3rM1GSLIzs3WAkCymi37liWOq1h3Y9+9SZm5nHT7AqOt06yPyY
 w1KBxEfhHsA9su5nR8tAvbkBScqcfdCyuCCEXJIiUfMPLKdFJXBgKWYWdc+QNPcDaW8D
 nLJQ==
X-Gm-Message-State: APjAAAXIW+V0w/zg8iJT6djDWlI7Tda4/+I/Mlecv/UvI1TGYFyaXYyf
 wuBcXcfHwZdY/wwYIEuAPU63YoFtd8s=
X-Google-Smtp-Source: APXvYqy54FRPgOoq321R1y28p5bMKtWiDdHc9O/jShzz6Mn+b5D+avw3d0oiHP7PPLnoKtdFkNzrSw==
X-Received: by 2002:a17:90a:aa82:: with SMTP id
 l2mr4552715pjq.73.1568820526378; 
 Wed, 18 Sep 2019 08:28:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id o42sm3331187pjo.32.2019.09.18.08.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:45 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:36 -0700
Message-Id: <20190918145640.17349-45-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 44/48] riscv: sifive_u: Update model and
 compatible strings in device tree
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

This updates model and compatible strings to use the same strings
as used in the Linux kernel device tree (hifive-unleashed-a00.dts).

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 444c699f49..9f8e84bf2e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -96,8 +96,9 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         exit(1);
     }
 
-    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
-    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
+    qemu_fdt_setprop_string(fdt, "/", "compatible",
+                            "sifive,hifive-unleashed-a00");
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
 
-- 
2.21.0


