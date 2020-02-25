Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1842DC35E02
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E9E21D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvsvpgTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E9E21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZWk-00012P-VT
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0H-0003fm-6d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0F-0003Xf-W0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0F-0003Wn-Pq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:55 -0500
Received: by mail-wr1-x436.google.com with SMTP id v4so1568670wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SyTyh+hj9dmzFdqGJju4vMBemsN0R3gcjG95CgJjbDY=;
 b=RvsvpgTHHwOwjzyTrPCUn16p59NkUj5T5iqo7ico88OL/RtoDfR6/wCJ5j9rQZQ7Rq
 h70VID1/4joR0JGa4Weu8PDBwFtnnvtelf1bqQ6dtjzihW96eR123OTkYPyfKTjmbKCz
 zuuCEbWjBDJ/NkecHC56qJc/6LhKtyIoXzRKCZ2qkoXWT9gnRn8chekgDTNRRq2/w4pA
 W93Km/L8p2uBlG6TeHV6pGb/E5EmjgNXqQQIJkw6BWPKRgYie/M6WaPcrWCjLACD0rh/
 k9AviHkleEqCJy4O+7rweCRx4VMytvCkI0Chud1WL+HecrxpkBe/jtPhO4ehFEUKg8E/
 aH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SyTyh+hj9dmzFdqGJju4vMBemsN0R3gcjG95CgJjbDY=;
 b=V7DtqYBW7QYXmlnxiX7oU4qZ+C/JgcgctCVpXcPiYfNhS5gF2OgqtxW5GCdvR4YUuf
 jaZEcZHG3wD7fVM+YQab+GVJwrGFE8xy5YGghAKl4X+XSzJjIWI7RIcePm0RRwSwYZOW
 5mIX5ep8VuUw6xbSBNs4xuWdtYABR3elWVAvE/MOKKW3siqYWaLT0FVmW/eXWdIQ5TR2
 wu6wQ/BM36RmP549ZedmqzqIJCNR826hYmKfqVTwYs4liU8vBLDCj3zbP51KwQzAGDy5
 MtK7OGNglPwWVHf4xAjQQZcJK9hvECVHUzFuLTHGSnPd8gWwdQngHCaehzW4ta+RPBxO
 bfEg==
X-Gm-Message-State: APjAAAWif9aIzjXMaKGSEdDKUNb5NhuuiQ+t2LQQkSLVJzNdyCJzOCC3
 G/P3p7RYNySQCyse6/Ggtve3btg0
X-Google-Smtp-Source: APXvYqy1k6HEDYS8rAy16Lds+OX0p4tAKPeNoo/Ak+mKNLCKpwUSSldraB5OO0NKLzRT12NlkXtcGw==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr14845777wrr.373.1582632472434; 
 Tue, 25 Feb 2020 04:07:52 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 119/136] hw/arm: Remove unnecessary
 memory_region_set_readonly() on ROM alias
Date: Tue, 25 Feb 2020 13:07:17 +0100
Message-Id: <1582632454-16491-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-22-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/arm/exynos4210.c    | 1 -
 hw/arm/stm32f205_soc.c | 1 -
 hw/arm/stm32f405_soc.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 3af6502..4e1fd7e 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -320,7 +320,6 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                              &s->irom_mem,
                              0,
                              EXYNOS4210_IROM_SIZE);
-    memory_region_set_readonly(&s->irom_alias_mem, true);
     memory_region_add_subregion(system_mem, EXYNOS4210_IROM_MIRROR_BASE_ADDR,
                                 &s->irom_alias_mem);
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 2de5627..6e93726 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -97,7 +97,6 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
                            &error_fatal);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
-    memory_region_set_readonly(flash_alias, true);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index b8fca13..d590cd0 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -103,7 +103,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias",
                              &s->flash, 0, FLASH_SIZE);
-    memory_region_set_readonly(&s->flash_alias, true);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
-- 
1.8.3.1



