Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E4C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B93D2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sq7F7HEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B93D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8KH-0004SV-Ek
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fk-0004im-0N
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fi-00067p-Qq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:39 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8Fi-00066R-Kp
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:38 -0500
Received: by mail-pl1-x641.google.com with SMTP id q13so1404856pls.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ueLaohMdpnj57qcG2jXXNJ0s60U0ZF3lFnQgnB/z7q8=;
 b=sq7F7HEWnCU8XjR+UGiS2d0U39Z35QJpM6XyvGaoXrZT3XOB70z9IVPPRI+Q30gJD+
 ieH5nr7lt86YtDQBIqsIZK+Xr8gCjOVjiV8cDYu9wZkdFzYIf5y/g4hQQGpY4OSmV8P2
 p4FJd9XbUqfJQugKMw+JfwG2gr+1gpZXjKxAhneNaWbN9EQlngDQZ0/2NJ9xxJZnvBt6
 KHzg/LrGkc61wu0tXtu+xytnCsm1wZThOObRyx5KodJihi0HlrNPAEzJyoomDIl302Cw
 bJlNtxQ/GtYu8e89n/yuJ6AEQQEVcMFN5bpg1P9Ss43lhOmNN87fyo0jq6zVZasUnPTG
 MEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ueLaohMdpnj57qcG2jXXNJ0s60U0ZF3lFnQgnB/z7q8=;
 b=sHcBUIlB4W55HlU/aZVbUtqEJUNtpgYiOB89fBMk5wHlKfskVvrSVjCaFmC7LkAi/9
 Ts5ZhFaoSir57raEo82955+3v58jeSMO6zIUqRrv8cLpH5HHvjxFo2aiNe7Ibs0eQcVJ
 pNn1fafwQoYbJRryj+tS/bBZPtRWLWHbaJwiHwoVJn9/+KGtSyIit7IZ+8fA3+m/+ck0
 J+G+EcZypX4J8+crELEmgyl5Ulla1mR8D5ceG7m/diCwK1LPesoBRabbjb3IXuTcuL2k
 lsy+HAiPCQAaRO4kn0kFipVLIij2F04vcBtwmwb5Ku2ggTC4jAgdAuW92URov/i2sA5N
 xLbg==
X-Gm-Message-State: APjAAAV2JeI83Bf/TYwYlK4SZhuQ2GqhHBAZ4fzwcMW4MDyX0TARTlz9
 sFWWq8NFg4st5rAaFI7Ua5gXuOo7JxI=
X-Google-Smtp-Source: APXvYqwC5XM7QCn8xE2aBj0Dyqb2sM50wSnNc29hht9pxxWCUEuft5QqKYCnbcELJznmMoyarO3J+Q==
X-Received: by 2002:a17:90a:b010:: with SMTP id
 x16mr1919289pjq.130.1579908037338; 
 Fri, 24 Jan 2020 15:20:37 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 09/11] hw/hppa/machine: Restrict the total memory size to 3GB
Date: Fri, 24 Jan 2020 13:20:07 -1000
Message-Id: <20200124232009.12928-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

The hardware expects DIMM slots of 1 or 2 GB, allowing up to
4 GB of memory. We want to accept the same amount of memory the
hardware can deal with. DIMMs of 768MB are not available.

However we have to deal with a firmware limitation: currently
SeaBIOS only supports 32-bit, and expects the RAM size in a
32-bit register. When using a 4GB configuration, the 32-bit
register get truncated and we report a size of 0MB to SeaBIOS,
which ends halting the machine:

  $ qemu-system-hppa -m 4g -serial stdio

  SeaBIOS: Machine configured with too little memory (0 MB), minimum is 16 MB.

  SeaBIOS wants SYSTEM HALT.

The easiest way is to restrict the machine to 3GB of memory.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200109000525.24744-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e57530950a..57cb4e0f34 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -92,12 +92,11 @@ static void machine_hppa_init(MachineState *machine)
         g_free(name);
     }
 
-    /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size = ram_size = FIRMWARE_START;
-    }
-
     /* Main memory region. */
+    if (machine->ram_size > 3 * GiB) {
+        error_report("RAM size is currently restricted to 3GB");
+        exit(EXIT_FAILURE);
+    }
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-- 
2.20.1


