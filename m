Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856E8C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4913D2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gePcBw+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4913D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9wy-0003ZE-Fq
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:20:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r5-3R
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9en-0006jr-Ps
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9em-0006bE-CE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id b10so156608wmj.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=DpCWA8urHehTaRg7N5jOwEu2yGv1l6Iqr2FRMYJg3yk=;
	b=gePcBw+qc5KffZy+qTTKFjdLV51AwS2TCH7UMiUIzbRpQd0TVAGfOtlZL1EcBeQUn0
	GG3cW74LJnWw7fhor7osnevDBnAJUtK+jkw1B7pHgILoDwOUI61hKisHYZ5N8limKhrR
	vNTpNimpxoUu1rHmyGH8miLRfLUHJeaTHbJ0PTVxm/N/n86HhqvgEzoDy9rCpwnDNu8+
	/1Y9cf5iC5b1uCg8Re7bfsxtaijDvAq3ZKAL8X53LYKNrO47H7k+5N9rSWc31dZqbscU
	LJVLjrsSkk1V4HXWGZs2r6IBxs36s5C6TjcphqLoULuN/wfulxwzSSoCniHW4LmFp5Rv
	4YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DpCWA8urHehTaRg7N5jOwEu2yGv1l6Iqr2FRMYJg3yk=;
	b=gAdz8ckZ4CFqgROUr0R3EXLVb3i63kVfCxgnp+oFMiNZzYkg9euTXQgLYzkZTRy9xH
	huwcgEQyjEott1bN+NuAUW4+6WqYLPUYnTvjFM1aawufzb6iKVWPzxJ2UnEkhLZaWOm+
	5+JMJKXNB2PAk1RlqjrZWvVDYaxc9zGaf+qDc1y3tVwRGaBD3mjW5MAX5CADUXcQ3wQl
	ZbGWIqx24ZvXKcsRvRZDd/tbRHadaNiUtIHM5KTpSl7EJ+WETcBEPureRi3Rv6Vrm9Ra
	qIJBRMmRgPZT6g17dAHxLXC4PvqJK6kW3Y9AeqJiF+w8+Z/6HimHlL5YC3Q6YgilERV5
	qw6Q==
X-Gm-Message-State: APjAAAVyg4RoCHmvb65OcUh1aa9U5ADytFGpBMx6ojTYqRwz//L0DvSw
	h12NvhT6VnW4y5ZkhRuQSFf4CvYqLJ0=
X-Google-Smtp-Source: APXvYqx7rSbbzZVEe+odfUnubBCi3kb2rpJIWNul8PTd3L0RuDRGmXh1bcY7ClVh4G+T4eonhK9AmQ==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr19955wmh.123.1556557273675;
	Mon, 29 Apr 2019 10:01:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:20 +0100
Message-Id: <20190429170030.11323-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 32/42] hw/arm/nseries: Use TYPE_TMP105 instead
 of hardcoded string
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170020.sJtvaZle8sw0fztuiczm8G0d0jFmlsKECFY5ymEnuLw@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-3-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nseries.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d4..2b710c3d49f 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -31,6 +31,7 @@
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/devices.h"
+#include "hw/misc/tmp105.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
 #include "hw/bt.h"
@@ -218,7 +219,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
     qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier);
 
     /* Attach a TMP105 PM chip (A0 wired to ground) */
-    dev = i2c_create_slave(i2c, "tmp105", N8X0_TMP105_ADDR);
+    dev = i2c_create_slave(i2c, TYPE_TMP105, N8X0_TMP105_ADDR);
     qdev_connect_gpio_out(dev, 0, tmp_irq);
 }
 
-- 
2.20.1


