Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09ABC21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmebtgvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ABC21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMusY-0007di-P5
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHk-0003YB-4G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHc-0001eb-Ja
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHY-0001dC-Tp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id p7so17325574wmp.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IoXcmOl+RMmkT7xPfub9s2J7YQU8S0ooN19xanzMCEA=;
 b=OmebtgvYfFM4G3zMSBEEYA9Etqke1bPa1zLFy6PcQKqN0ojX9UXs8KFWEa3mt2E3n5
 wqhodWjJaQOAvRhAiNFA197qw+S1LgSY+SDy1WNFMpI/VxrKqXIv1HzBMUyB+IB2fEOY
 C6D73JvNeBO2AC+Ky/+AHtXM2CdURi6kyQddELiZslB+6nrDcSM+rbA6ebX8BSUbLLCK
 oIX0q+7qhPylaxQnSq98Ne5OJHINHS/kjAveeriaQDikkux405GKRKlRFxaR0QMD2z8g
 FSU23T76IunPp2WVNay+dajnvMPyOAp6vRPjuXPZBU199pYX6YHruBTAqMIT3YejsVFH
 XgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IoXcmOl+RMmkT7xPfub9s2J7YQU8S0ooN19xanzMCEA=;
 b=DKuPQr3rh+ZQ6w+uhEhv2AhJBuULzGHha3364jPrsvEjXtjK0wlBFlBsGgqazKS8pP
 Goiu0MI0lA3mjx9cHfxSO0CnCqoCaDMeSd8mKUX8Q/U36+QyJORVp3fHdG8NVFZnoJEf
 cOBcf/Bms8z5mAv8nAD08B/IuhoAxIRztc4WEbrzkt4KK0M5KWXWNdR3yEXP2VcsVivK
 oXRzwAsN3VUA7vOYVfSeMHQlITmUhon4g26lub/4ftpPA5VOgqn3FG2wji3VGRh1ImMe
 3VFLwn9cR+Q/IIH6lgFH8EEHbM0V8uCYiESXZKVOSEbOwcLOmUgN482v+Z1I2UU4RDqc
 hEEA==
X-Gm-Message-State: APjAAAUOyNnSjCv73bobdN+rLLg7qI1aUvPIYJ8SdS5mn15GWcPIi1Xc
 265Cuho62pmAMLL8u4O+ErA73/r71Ew=
X-Google-Smtp-Source: APXvYqyXTfOk3hgQWVxA9NU2IlEy9XlKXsor8G+O26cLhvF4+nKMr7YOkf1GVoTYKcCqThcoqcDSWA==
X-Received: by 2002:a05:600c:214:: with SMTP id
 20mr3183868wmi.45.1571751182209; 
 Tue, 22 Oct 2019 06:33:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:33:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/41] hw/arm/mps2: Use the IEC binary prefix definitions
Date: Tue, 22 Oct 2019 14:31:30 +0100
Message-Id: <20191022133134.14487-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191021190653.9511-3-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 3 ++-
 hw/arm/mps2.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 6b24aaacded..f8b620bcc65 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -38,6 +38,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
@@ -458,7 +459,7 @@ static void mps2tz_common_init(MachineState *machine)
      * call the 16MB our "system memory", as it's the largest lump.
      */
     memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 0x01000000);
+                                         NULL, "mps.ram", 16 * MiB);
     memory_region_add_subregion(system_memory, 0x80000000, &mms->psram);
 
     /* The overflow IRQs for all UARTs are ORed together.
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 10efff36b23..d002b126d39 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
@@ -146,7 +147,7 @@ static void mps2_common_init(MachineState *machine)
      * zbt_boot_ctrl is always zero).
      */
     memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 0x1000000);
+                                         NULL, "mps.ram", 16 * MiB);
     memory_region_add_subregion(system_memory, 0x21000000, &mms->psram);
 
     switch (mmc->fpga_type) {
-- 
2.20.1


