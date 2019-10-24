Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA09CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7412F205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IW1U/8Da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7412F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgvK-0002qO-25
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyT-0000Aq-TP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyS-00018I-TV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyS-000182-NN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id 3so3221451wmi.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TW1rHEa4Yt+Clo9YX+nLhtNEgx47fDesU2q7Xi3+SMM=;
 b=IW1U/8DauZCiUdzyrb45j+OZKBHmnRYYJ0HrHRmfTzQdGpKQMtDk5HGT7M/jXpcpZd
 iXx+9HL5kQUb8kz3yzM525dIguE9H89a6sv/MlRuwwsLZIQUSo7+IewoQIi5cFlVBATS
 o1lB4rKrHJZLDTy+1DFdfB0Zm3dA4RD2WQNiWDD1Gp+37u23MZE+lzbTwABj/X777SHj
 Df4Bxwc/lABBIVPsEo1JD5noz5NSgBTd9CyTrfUPd46DfXEwcDI0yqqMnnt7i7r0uokM
 RbFW5kyHu2KSIde1fqXotBs/c0hKYblGvSLKjYpy2mgjXES7HztkYPdUufAYq819TReX
 2JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TW1rHEa4Yt+Clo9YX+nLhtNEgx47fDesU2q7Xi3+SMM=;
 b=kEHgBAE6BtnBICPpSVHltj0jRhPosDIjkIINmhY3jSXJ9mLehsQb5NW92wUVEZFuqL
 GpO6CyLxvUGxaDLeos3jhxJBFKwjd4tCbZkJs+phX5iiISjP/oYIwfMFJhiiyiwnGEg1
 6hVUcknazpvLex0TfuQPaJ0gdwgIdcHTIREg5B8WkAPvT2c3f9nJMQj2slClecZPXq1n
 nfIhz5wzvv0wizzMjlmrTszahIA+Kt2iUhj5RP7jO4rkGH2hDflcCdv/6gxbA8ddB2sf
 Y83ygC98KIiM96msFNWgGo8OjlRqFP6QicgrBOJmDGsKKbGcIeroxqqL3zvF8lagcTbm
 JX1w==
X-Gm-Message-State: APjAAAVirvn/iL+pZpBNgVjBsnwxDovWHKnzt/cSu1h7XkOiVUrcpSRY
 6b4Es6/KO+UJehnALnjqlOt+mSnE8pE=
X-Google-Smtp-Source: APXvYqwDb1l8z/AUSogAhBAPDc0lzKHagIm7TSIzRnEV2+8es246w946LzWld3yIbFz1Az5sTgtCOg==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr6001285wmc.34.1571934511495; 
 Thu, 24 Oct 2019 09:28:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/51] hw/arm/highbank: Use AddressSpace when using
 write_secondary_boot()
Date: Thu, 24 Oct 2019 17:27:24 +0100
Message-Id: <20191024162724.31675-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

write_secondary_boot() is used in SMP configurations where the
CPU address space might not be the main System Bus.
The rom_add_blob_fixed_as() function allow us to specify an
address space. Use it to write each boot blob in the corresponding
CPU address space.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191019234715.25750-15-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f1724d69290..518d935fdf6 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -78,7 +78,8 @@ static void hb_write_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
     for (n = 0; n < ARRAY_SIZE(smpboot); n++) {
         smpboot[n] = tswap32(smpboot[n]);
     }
-    rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot), SMP_BOOT_ADDR);
+    rom_add_blob_fixed_as("smpboot", smpboot, sizeof(smpboot), SMP_BOOT_ADDR,
+                          arm_boot_address_space(cpu, info));
 }
 
 static void hb_reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
-- 
2.20.1


