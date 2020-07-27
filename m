Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D052053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gk4F3Wpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D052053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04x4-0005PY-W2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uX-0001XH-OJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uW-0001Ks-3p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id k8so4845977wma.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=I7vtUCKWCL7jNAPS28tV4Fp/0HKktgVJJq19XFkLoME=;
 b=gk4F3WpkToQUQLoNzahhS+hadEIu8b712RU8/l31NxkR9U6oCBgt0Y5rbCd19alkvE
 7vorpbqhtdMR+aL0FWEqsAFJDPV2gDV4bTmxn9doY0UvuDRqV24/GSG8Duq0B1tBXkae
 bL1opfmv49SFXVyZBHp9YYOLCnCadYPmpmAplP0CjdpHLkyAUc2UfcO9Cd+lqA+Bq/SL
 jC2OOpG8CLTTbKM8Sct7Zo9dyeuQXUOgzLeMO0X8CxZfM2jRY5Gfj1PW/i7az122FC+i
 SBS5Dd23w8bd3KTT8p8I68dQ69bxkM94cDkpYTfayeCgr8KinPOaZJuzQMK/osa0qd60
 9X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I7vtUCKWCL7jNAPS28tV4Fp/0HKktgVJJq19XFkLoME=;
 b=uAPQdrgw2Cx5tLGNinwUoYx5dox7HgZzF/a3e4yBHbweSId5TKj1n1eUe3Wibv5q5c
 VUIbbKxCYocH5Kn7FglMlClMxLCbvo7d/6hD1gKa0ki3FXo4qK/NJl3G4hOJ8avqjHVH
 2gSCmGMyDa8vdnoBVVv050Wo3TbMb9AB8jATu6j7y7IQNfEA59DhPa5WjA/+4c8eILtM
 r2ik9+1v+4hrkm9H7qxL6+kFo4rrBjuSpj+gfXEf8y6maeQdrFxrVLgswrP4oSO4r6xF
 +NCbAOcooxSF5hGq1yKxJJbh4aY9SsKJ0JSZ7jQmf+dEozvyz3Xh8TROf9aN60czX7cl
 mFsw==
X-Gm-Message-State: AOAM531OrdG9jhxzY0VuIxy5BFf43PWpFyC2RRMKfwBzYwwEKGI+OkW3
 uo/pWG986gj7CwfN2+TSBft2jXNp1G7oxA==
X-Google-Smtp-Source: ABdhPJy6quRYMErTnC/XsuFRJd5qUYgrA/S627xOIUEMcy/4Z7X1Z5HuF90TBwDthfqHUTp0VtXPyQ==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr12473262wmf.0.1595863166226; 
 Mon, 27 Jul 2020 08:19:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] hw/misc/aspeed_sdmc: Fix incorrect memory size
Date: Mon, 27 Jul 2020 16:19:15 +0100
Message-Id: <20200727151920.19150-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727151920.19150-1-peter.maydell@linaro.org>
References: <20200727151920.19150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_sdmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0737d8de81d..855848b7d23 100644
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
2.20.1


