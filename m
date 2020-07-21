Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7D3206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3jL4mSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D3206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrfR-00007V-26
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrbm-0004ES-LI; Tue, 21 Jul 2020 08:42:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrbk-0005B4-Ur; Tue, 21 Jul 2020 08:42:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id f18so21109351wrs.0;
 Tue, 21 Jul 2020 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P65Bv8Dg7uT0DN6qbTNjhnvSKqzYAGqpE5gNoNpHkJo=;
 b=P3jL4mSSu2Usjqpi2o65sEQgOmd1L9tnpdf7ArJX9yZ4/r8/uFr9vxaD/zQKSDGzu3
 JKP/XRIyjZtx8Hd4zMxSn8VjCX1F1GXtI+K66GX6JgpUCGLmU69J5FfCYy7NSAmXruRH
 i/zl2gC/lFn709k+jccnyfFGAUFLdFgtPwHKN/zw4Bs1OgN0c7vMgxjoZKcMhDLKwmf8
 YLjbUiR704TJmMtVHTzaa2IgBimnNXRRsrqqe0V2H4C18oU9SCz1w6bsVZdZO/Vtc+l0
 6cCjOiHPgXxw/fU9db57ifPFpGz1CCF5AbSA11C0A/2R+oVdOI59RKNbdF4HyLXc8Fh8
 jYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=P65Bv8Dg7uT0DN6qbTNjhnvSKqzYAGqpE5gNoNpHkJo=;
 b=VXu4T0GvCgWgp7ju7+gtQraexpaF+GVkjPrI2gej9ZLIRovnJxLgHf+6dougrYydjI
 KClR3B42nydGp/IDrD2cChCafaNvBCJsZkd8DX15F+fDUJGt5wADkEaweRQ0j4FGcApn
 wpw8rrIcv6XcJv+draBOssmT8ZpoGXCwmFfMKGycOp8eCOwtl4GFEWpndQ7n0JfbI7Zv
 KnmEWvtByUGqk2bXBbwLYGkAxi2a3nFc2mGszkhD2GKSXr3BdLexksKfoOIO0dN7T0qf
 Fqvq2pPk9Gaz8g84VxzD9B27VCdU+wtzKKWcyR1q/I6xl/VqxccI1X6hsYgVafD2OGYr
 V4/Q==
X-Gm-Message-State: AOAM533zV7hxswfAWT82LY/itqb7RR2jcqf+b/axoA0xnqsoEDvGLG8Y
 husJzWTiU4Ge8Tf9zb8JZrxeI4qHU8I=
X-Google-Smtp-Source: ABdhPJz92YSjDlHGp4WNvXx5UtPyQ37A4OxAJfkjFN0OZRjOLjpgAjA4PSMKnshypn+ZHagUF64z8w==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr8572381wrq.422.1595335373540; 
 Tue, 21 Jul 2020 05:42:53 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q1sm37018777wro.82.2020.07.21.05.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 05:42:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3] hw/misc/aspeed_sdmc: Fix incorrect memory size
Date: Tue, 21 Jul 2020 14:42:50 +0200
Message-Id: <20200721124250.8601-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SDRAM Memory Controller has a 32-bit address bus, thus
supports up to 4 GiB of DRAM. There is a signed to unsigned
conversion error with the AST2600 maximum memory size:

  (uint64_t)(2048 << 20) = (uint64_t)(-2147483648)
                         = 0xffffffff40000000
                         = 16 EiB - 2 GiB

Fix by using the IEC suffixes which are usually safer, and add
an assertion check to verify the memory is valid. This would have
caught this bug:

  $ qemu-system-arm -M ast2600-evb
  qemu-system-arm: hw/misc/aspeed_sdmc.c:258: aspeed_sdmc_realize: Assertion `asc->max_ram_size < 4 * GiB' failed.
  Aborted (core dumped)

Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Assert (Cédric)
v3: Fixed typo (Markus)
---
 hw/misc/aspeed_sdmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0737d8de81..855848b7d2 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -255,6 +255,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     AspeedSDMCState *s = ASPEED_SDMC(dev);
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
+    assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
     s->max_ram_size = asc->max_ram_size;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
@@ -341,7 +342,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2400 SDRAM Memory Controller";
-    asc->max_ram_size = 512 << 20;
+    asc->max_ram_size = 512 * MiB;
     asc->compute_conf = aspeed_2400_sdmc_compute_conf;
     asc->write = aspeed_2400_sdmc_write;
     asc->valid_ram_sizes = aspeed_2400_ram_sizes;
@@ -408,7 +409,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2500 SDRAM Memory Controller";
-    asc->max_ram_size = 1024 << 20;
+    asc->max_ram_size = 1 * GiB;
     asc->compute_conf = aspeed_2500_sdmc_compute_conf;
     asc->write = aspeed_2500_sdmc_write;
     asc->valid_ram_sizes = aspeed_2500_ram_sizes;
@@ -485,7 +486,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2600 SDRAM Memory Controller";
-    asc->max_ram_size = 2048 << 20;
+    asc->max_ram_size = 2 * GiB;
     asc->compute_conf = aspeed_2600_sdmc_compute_conf;
     asc->write = aspeed_2600_sdmc_write;
     asc->valid_ram_sizes = aspeed_2600_ram_sizes;
-- 
2.21.3


