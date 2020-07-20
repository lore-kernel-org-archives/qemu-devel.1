Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3633821775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUS6dqxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3633821775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSZx-0002rp-HK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxSZ9-0002JD-67; Mon, 20 Jul 2020 05:58:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxSZ7-0007CA-Jv; Mon, 20 Jul 2020 05:58:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so17170049wrl.8;
 Mon, 20 Jul 2020 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0R9WNlxMj4PxesDQXzX/Id0a5bZihglA4UZSVrsmxIY=;
 b=jUS6dqxUC93xccANDgYTtymLi4KjfHM776whWUotydd712ZcpX6u93KYbttVfqlMyQ
 bqzuEVlzBBzMmV2McTFQQuYcbwRRyQDvC9zEx7EV9jTvUclFYa2jFOfkD5QzW7WxlInn
 9+9wlvaLWlu6rsq42ep5pT1+e18zsgle/8McQtR7HAQXa30egesCugIBa5wdWUA4bezU
 KUHn6Gm+5Q3OWmLmXUGDA2tiQ/RpzUhFgk4Ri2Z4qha317AxMhwvIsItn6Y23Mhi9Gcn
 JumyM3YvBvnOhXKvYy2QgZMl+rASZtlJ5xw5uJ2Lw9b64XIUBeiRoEMcYXdltjlFHh5t
 1WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0R9WNlxMj4PxesDQXzX/Id0a5bZihglA4UZSVrsmxIY=;
 b=RNIthe9o1Cl2idSW2eE37YMLUEJkaJ89QsIC8PMmnM1CGf9inthM4ErfEEBnhblygx
 mEGKoGOaOKcbcz6ihH/7IfKgXKNlN7UbAxC05lJVMmriZuA5lFaAvfAD8Nqjo/buF/81
 HuYgRxCr/nbFx8l+vzLIDinICiN9QVQOeQLvAVtDkqFUhwRPEHZtQHk3fmCMhhjjmtPW
 xN5h8QS6rsFhFn9gq448tLroz+sEeh5fsUHEHZTtNKBMVfabtNWyXVewM+jonCcZr3eQ
 LBIv4/lFjBmJ2W3yTIK0srW4vgUsSsOD1SCJDVvtgIHsrq+K79uqk+q/pPTLp6xLXffe
 KBDA==
X-Gm-Message-State: AOAM533rmUuDhQ91bjXvX2CfeFE1HWqR4jcMDKp99cCASL69WdbEJU9y
 rZdJMxvuYniV6ze7svN0k/jJvGnsAJU=
X-Google-Smtp-Source: ABdhPJxop5LTo+3GZQF1OXE/lzZusonV5In2SHQtMzxocdKI+vDBtpzlmG7/VgZNUIYq+zVCyBm1Wg==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr20491149wrc.377.1595239111506; 
 Mon, 20 Jul 2020 02:58:31 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm31321485wme.8.2020.07.20.02.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 02:58:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] hw/misc/aspeed_sdmc: Fix incorrect memory size
Date: Mon, 20 Jul 2020 11:58:29 +0200
Message-Id: <20200720095829.22839-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
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
a check to verify the memory is valid. This would have catched
this bug:

    Unexpected error in aspeed_sdmc_realize() at hw/misc/aspeed_sdmc.c:261:
    qemu-system-arm: Invalid RAM size 16 EiB

Fixes: 1550d72679 ("aspeed/sdmc: Add AST2600 support")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/aspeed_sdmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0737d8de81..76dd7e6a20 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -256,6 +256,12 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
     s->max_ram_size = asc->max_ram_size;
+    if (s->max_ram_size >= 4 * GiB) {
+        char *szstr = size_to_str(s->max_ram_size);
+        error_setg(errp, "Invalid RAM size %s", szstr);
+        g_free(szstr);
+        return;
+    }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
                           TYPE_ASPEED_SDMC, 0x1000);
@@ -341,7 +347,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2400 SDRAM Memory Controller";
-    asc->max_ram_size = 512 << 20;
+    asc->max_ram_size = 512 * MiB;
     asc->compute_conf = aspeed_2400_sdmc_compute_conf;
     asc->write = aspeed_2400_sdmc_write;
     asc->valid_ram_sizes = aspeed_2400_ram_sizes;
@@ -408,7 +414,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2500 SDRAM Memory Controller";
-    asc->max_ram_size = 1024 << 20;
+    asc->max_ram_size = 1 * GiB;
     asc->compute_conf = aspeed_2500_sdmc_compute_conf;
     asc->write = aspeed_2500_sdmc_write;
     asc->valid_ram_sizes = aspeed_2500_ram_sizes;
@@ -485,7 +491,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
     AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
 
     dc->desc = "ASPEED 2600 SDRAM Memory Controller";
-    asc->max_ram_size = 2048 << 20;
+    asc->max_ram_size = 2 * GiB;
     asc->compute_conf = aspeed_2600_sdmc_compute_conf;
     asc->write = aspeed_2600_sdmc_write;
     asc->valid_ram_sizes = aspeed_2600_ram_sizes;
-- 
2.21.3


