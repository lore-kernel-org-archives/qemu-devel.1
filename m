Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F5ECE58E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C672C2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3tJPH+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C672C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54035 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3mA-0005M5-7O
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qw-0005aA-33
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qu-0008HC-Ur
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qu-0008Gk-Og
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id b9so20415063wrs.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Nqq/qCS55sXki5wRHSne5LpAqEVFLWInVJY+PePtc1g=;
 b=w3tJPH+OAk0u3vk2rpDI9JqQP2Tzq09mjz9OAKxvDYuHyjWd0BWHhXo3NZaLNZTj9g
 xb13Jw7KGVcH49YXrayXlR0rNY4c8MfeRFGxaVauECzOOtGQlhYMXwcKnU9i2BuMfMOK
 BQfQJ5XXZ2khx0JKweYpKypNsdqOv1LiwBzfVkpFi5U0wWCBhhAT3DDAdzYg31rUSpnb
 x5Y2o+ZkGHkD8EDr3a/FiSSftZH9QzXPngSVu5Mi6SpqqapZL58idW6LEOdTpeXwPdcc
 pmUo84LdiL7Skp6uF0rbpBunzxDDFgnIHYYaFjwQ1WkuW6U/q1RW4Pk97G1jmnF+Ziex
 VD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nqq/qCS55sXki5wRHSne5LpAqEVFLWInVJY+PePtc1g=;
 b=OkEJzgxbbVSEgSCFIC4H5G4Y8XMkcaMynKa8/kjSN8mHS2OaMlYgzXO5DG/W6YyNA3
 ZpLGdKXQn5qEdE2dyfN0GiyLkaLO4G5X+W4HNyv9oB8rekzRoo+gXRgktck+Vk5nZzV1
 YyHWfHW97wn9MC20jvn/Dr8NKcEqcgzHbFfaAipD96xpXtTPFzmdLJOLijRI0OY/hOES
 pKV9UzWfWLJ8yMjBk3MhwPSa5fMeFGMAnFjH14hu9U6Xxzj7ROm4s565nJVfTzRzK6Z1
 I8oNVYkUqcHCfgVSN9nkw8yHoFzD5l7zbPfjKPuxpoQqHhe68UQFDbOIgLB0JN+GrBJK
 tmOA==
X-Gm-Message-State: APjAAAUmaqEx9U3bgITCHwj4uVEeeZvXjrVFdEt3ip6yoO0PgK0wMmrb
 VLyu4b3PGVnmHhEaN+UsdhJlAIxZ0EAreA==
X-Google-Smtp-Source: APXvYqwxujIMyFovr6SbkO27nO+iuq9+fOuHREscJNCUrRltZQr4uxiQ1E3kVtwDeZl2Az00OjdOXg==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr4357242wrv.215.1571069143271; 
 Mon, 14 Oct 2019 09:05:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/68] hw/arm/raspi: Use the IEC binary prefix definitions
Date: Mon, 14 Oct 2019 17:03:59 +0100
Message-Id: <20191014160404.19553-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

IEC binary prefixes ease code review: the unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-id: 20190926173428.10713-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 74c062d05e3..615d7558790 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * GiB;
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * GiB;
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
-- 
2.20.1


