Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B9521734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLFpkxlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B9521734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1FJ-0004xQ-Ay
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu1Eg-0004We-6i
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu1Ef-0007Ap-7K
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:38:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu1Ee-0007AP-Vt; Tue, 21 Jan 2020 16:38:57 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so5070136wro.2;
 Tue, 21 Jan 2020 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4YI519z4F/iZ1loOmyQ18PERAwvamdmtU/8VAEDn3Sc=;
 b=qLFpkxljfehHzepiuArqbAWqzdoTh8PXV7gXp1KvXJ/LHNvt0qwIGxcD5QWLGYIIFo
 CJ5v0gOGfOGLAu3Mg/TK8D3nIbPUgkw/xdZ2UXy6jZuZ7jZUyMIwlS7NkMrL/ozd5MmI
 T3zcaIJNd4OZ3MJANdq186Gqm10Op76eN4bSUfB8peHmlij8YWeFhTaC20WQEfldf771
 sig9M9JrjUXjUtubs4H+QpLD+0aUlsJVU4vAXpPJ52GJNNRM2GNkY7RGerI0XaDTMH30
 bgICpLs8liPeaXDRqiJCRV5J8IdqrU1pQcuEyYhOg5JdHXP7dHRDhRZCcwyyk5hNN4pl
 Bkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4YI519z4F/iZ1loOmyQ18PERAwvamdmtU/8VAEDn3Sc=;
 b=emakqITmzsqK8La6R7qLC72Z3IXMnnpwV+fqnLDIt4vYUku8Ke3AnU0tRlON90P6Av
 WJSEsMUq3L8GdxI3Y4UpNV+J0HdiHHGsEUymD6EFqIQ4D8dJllWFpc98FD6wBTpAWWBP
 jRj4jAKRJpyTdqKlKZ9Os+1HWX9hVv5a68oRf1AqZ/j5TYtARk70pITpmMbQ9p0qoNkZ
 Z+si8xS0SjYb+0DIAXendQ89apx2yCwkmBomPVWQLOZ8BCBGL6s10RW8K3aJP61nP3ta
 4FJjC9wPpu7j+s00PGPa1hClscqQghAxfsFxRl2ImGqnrwymIAVPpFIEDVMfk3Xxwq1g
 WeCw==
X-Gm-Message-State: APjAAAXbX37fRSnqRXY8Ya3ZlnpYOzFo3AsClE7tHk++qLMn7lXlG9wg
 pEhjlSWP+NWJUnsVmZ5AJPgRSdMV
X-Google-Smtp-Source: APXvYqxKKa1S1gJwA3U0iFR9pou1ob+vTlGudSEvWDtkiVqD0KzYMROJy9s7VcgLggnL/SUyZXpaLA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr6989032wrv.79.1579642735385;
 Tue, 21 Jan 2020 13:38:55 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id v22sm935609wml.11.2020.01.21.13.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 13:38:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] hw/misc/stm32f4xx_syscfg: Fix copy/paste error
Date: Tue, 21 Jan 2020 22:38:53 +0100
Message-Id: <20200121213853.9601-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missed in 870c034da0b, hopefully reported by Coverity.

Fixes: Coverity CID 1412793 (Incorrect expression)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/stm32f4xx_syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
index dbcdca59f8..f960e4ea1e 100644
--- a/hw/misc/stm32f4xx_syscfg.c
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -47,7 +47,7 @@ static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
     STM32F4xxSyscfgState *s = opaque;
     int icrreg = irq / 4;
     int startbit = (irq & 3) * 4;
-    uint8_t config = config = irq / 16;
+    uint8_t config = irq / 16;
 
     trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);
 
-- 
2.21.1


