Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C9C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F3E21789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeIebk0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F3E21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQX3R-0000kk-Sd
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs0-0004IR-Hg
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWry-0005zD-J3
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id d3so6722834wma.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+vfXC1GgsBMwnsH6E6kbQ/y0jQGmL+x6ugfMXRWI8gA=;
 b=EeIebk0dG75HOMschTihPaxztknWltWItiQQn4qMVGL2jTkeZRP8lsW3f6Y/Bh9RUB
 Fz9w2G5VfFR2tIgeGSk4IuXabcnHH3fZw00FKRDBmFBJrWobfV0A0/WCGFxE19HItCfj
 IWDMTNm0PkiXnIUEoDhogduw0/SB/QJkSVfPLft8saBXIpZna+rDonNB4QZ41rfmQbK+
 j3hcAwxmHEzuflG5owxt6VijsatpqDa1Fpy8BK2u3Nt6YS+g4YDBZWyKLxXlk+m4whdp
 fQklEYWwVFVlcy0m9kCSMtvoXl5v5fkfvVHtV6rg0VPJ4emLxkxbhbi5w3+uUt+g558L
 wqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+vfXC1GgsBMwnsH6E6kbQ/y0jQGmL+x6ugfMXRWI8gA=;
 b=r/MXRTVLUJXsm6TEobfj6R2OPXKWhClY0DlQte1X4EeGuGM5Zd7nVmYv1jCreiTiXI
 vVeEuWP91WBcCAXpA6gjgOjP6qGaWLNbp7biJVpVQ9tjOssDtJ6Q6whSM4hrLq0qW8Lj
 9oEGcFQeQoKVbnPd6NI8SsHxialJEz7ebn4XGUdrRbll87JLGwJ4118F2PDnjqbZOshX
 NHEWys8TvwzfVh0f2lydvuLujJaQDzP8M/WbUPxWotrajRcgaX9GaQ/mBDT86CbNJiUn
 aOx76bV4DtFTIb5X3860k4uitUyg74tOhROoNzDtVXDYuXNSPMsaMR6B/99G3/LSWV2b
 lo2Q==
X-Gm-Message-State: AOAM533QWUOUsPi7ykyoC6dlfSqidGySdPgxmKcgoqiUyr2Xw/NjedFt
 yicjLL5o2mzSLILbQfE0an91qYinRthBrHCz
X-Google-Smtp-Source: ABdhPJyK3t04ARNtSEnUNnaIJAZviTAhbH71ZdU1X9AJCe3cdYDyAwfGboYMZg1/qo21+9ekKtXD+A==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr9154961wmh.106.1602167165781; 
 Thu, 08 Oct 2020 07:26:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/char/bcm2835_aux: Allow less than 32-bit accesses
Date: Thu,  8 Oct 2020 15:25:50 +0100
Message-Id: <20201008142557.9845-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The "BCM2835 ARM Peripherals" datasheet [*] chapter 2
("Auxiliaries: UART1 & SPI1, SPI2"), list the register
sizes as 3/8/16/32 bits. We assume this means this
peripheral allows 8-bit accesses.

This was not an issue until commit 5d971f9e67 which reverted
("memory: accept mismatching sizes in memory_region_access_valid").

The model is implemented as 32-bit accesses (see commit 97398d900c,
all registers are 32-bit) so replace MemoryRegionOps.valid as
MemoryRegionOps.impl, and re-introduce MemoryRegionOps.valid
with a 8/32-bit range.

[*] https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Fixes: 97398d900c ("bcm2835_aux: add emulation of BCM2835 AUX (aka UART1) block")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201002181032.1899463-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/bcm2835_aux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index ee3dd40e3c7..dade2ab5fd5 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -249,7 +249,9 @@ static const MemoryRegionOps bcm2835_aux_ops = {
     .read = bcm2835_aux_read,
     .write = bcm2835_aux_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid.min_access_size = 4,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
 
-- 
2.20.1


