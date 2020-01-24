Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E91C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACB32081E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDiHsYBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACB32081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8H5-0006Ux-Qz
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fm-0004n4-9q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fl-0006C9-5s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:42 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8Fl-0006Ai-0X
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:41 -0500
Received: by mail-pg1-x541.google.com with SMTP id l24so1900218pgk.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LyaUkwCB5pGZjL9QvGR1TmTQePhraVEHq9yGAmQ9nZc=;
 b=UDiHsYBjAC2ByTUjNn9PUOMXnx1fxjmjqFEtvM6laTHPD3zUEqz4zIdVN9lxORFvOK
 aH/LfFE1wJFya8+wf1T/zlTQnsHbh2aosxXgGdlsT2sclWLqKuJPFciUiMP5I370csP/
 sJFo8asCGtIDep5mYZLv9oWBTYAmlt2NFOSZfOJuNO2Z4p0hiKyK9VubHqAwZbXFtg+A
 NKn82O7+/xj3RPHlHVXRm8JBo/vGtUFg2+CZXE0cO1C3rntET5UtyvB9wTDIGPVTw4rD
 Xfygs5hA7CXLhbJ2ek5wOH+UTcgjY20tiUXcIsr4ALjRzO7rp8mNgBkfZqmBr9xXhmbc
 BRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LyaUkwCB5pGZjL9QvGR1TmTQePhraVEHq9yGAmQ9nZc=;
 b=eWig4pKwIq/VR2PhnxZ/rN4H6mNPrscsO7x1g3N8reobO9q6zBpif0Wo/CHhMXCsrf
 j0wFk8AlYEtrnjQrl8AHcUXVfjX+acQVCXytKC8JUMturbzLM50u/bNgiMfYAF+ucoup
 HPDxmt7IlPLbXAPmh1UYXOUHVZfrpX5lw1nGEyj9NraAiyRMao+fd1G3nDCfPJHegf/6
 lTbBXHhJC0kflFA1eGk3qf0jgTTfv//V0PJ3WkFRRfksXXl5vKTxgt5LJsT7a6EjPpRu
 1QHHib/6iMDaP8jQyKNFqAaJYrUHdVmGush+LFS6HuCdYLRxcWMfoRJJpuyl22HlFDTW
 hcwg==
X-Gm-Message-State: APjAAAUob9/vEgHIb4a5RLQTRDZsbU9AkkSK55/Xz30Zk+h5eUUD/qJn
 y7CUTH4tpEsS1Lf6dO9X2RvUx5BaIHQ=
X-Google-Smtp-Source: APXvYqzd0/4058c0PGwL7h2gqwBoqHRjoElaMJThZlTyPYZoQYc2u7bIwv0aKgdGv1X0c+/izPRkzA==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr7008888pgt.208.1579908039652; 
 Fri, 24 Jan 2020 15:20:39 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/11] hw/hppa/machine: Map the PDC memory region with
 higher priority
Date: Fri, 24 Jan 2020 13:20:08 -1000
Message-Id: <20200124232009.12928-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The region in range [0xf0000000 - 0xf1000000] is the PDC area
(Processor Dependent Code), where the firmware is loaded.
This region has higher priority than the main memory.

When the machine has more than 3840MB of RAM, there is an
overlap. Since the PDC is closer to the CPU in the bus
hierarchy, it gets accessed first, and the CPU does not have
access to the RAM in this range.

To model the same behavior and keep a simple memory layout,
reduce the priority of the RAM region. The PDC region ends
overlapping the RAM.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200109000525.24744-4-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 57cb4e0f34..2d62a248b8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -100,7 +100,7 @@ static void machine_hppa_init(MachineState *machine)
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
 
     /* Init Lasi chip */
     lasi_init(addr_space);
-- 
2.20.1


