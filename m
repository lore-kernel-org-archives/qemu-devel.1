Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA33C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664B621473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvNFfoLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664B621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7ZC-0004nT-Fc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4CN-0006hw-HO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4CM-0004n2-HI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:50:55 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4CM-0004mY-6A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:50:54 -0400
Received: by mail-wm1-f53.google.com with SMTP id 207so948891wma.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5CvhAR9JL3XvS1viNpt8Z+O+QAfXPREE5z2qgUjmg2c=;
 b=yvNFfoLsjCGbWdM+B6GYebsDQUlcOtkTMbxyZqRnMYiJV5tJZo+s9JtnP1QVutl1Dn
 YDc66fO6n2+uEEyBr4xYwc+HXUWjJ5s4nfGbBkIoAyy9FNhqf01YncAHUYo0lzUi9qKC
 skhcsPTRRJ+KgHHlE8BRl7UQCkKUUsD4YxgtlGvj9cF/nuuXIQqT4a6fvFKL3SfWIpbv
 nEzoldofboalAYt32QkZMwVj1Ik16euRq7nR3Bwb29aOYMLmv5Dgh4wepp/HU/cmhDYL
 Hglz8OTR8Ip5NBhVtP/YilHaNGFLy3IwvD8Q1ULKtJQ9onORpKkNuxDBkonjHWO7bdRO
 7bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5CvhAR9JL3XvS1viNpt8Z+O+QAfXPREE5z2qgUjmg2c=;
 b=TfYVFnEEBMq0kZRzUv2kstbcc0MTs/bG29G7pL0GiQWRw2NXk0CwPM5EeQIkdvq8YP
 PZuGvHQqs+KAHaOCRaiERCFk4wGd48woGBG8tj10Hy9djMAh6R4UVPqLKfaq0a4URtiW
 VXuUttK9XUySGvinKZtM0lbayIW6G5UcOFAStS6yLumkdM0KqOYM+T5AuCv5EcUJy1cO
 /HsV4eCAxGeUIN72qnHnqPxaH/VRKD9hLW3nPDtgQ3/Exn29iSd7UKqZPFvcgKexQhSD
 ofAF7gQdUhEp1OOidK2Z3zJSJfDUTWEdqY0ATEZ7UKDVoUhd/H7qSOEaQr2D6wy3JHlZ
 J/lw==
X-Gm-Message-State: APjAAAVhbLAYyU4ZBeYbVb1DWTi/IWHE73xVXVYN6IREYZkcwEowoTs6
 /1F1IYlitHSV//GI+pLB9aMOlJqWVipHsQ==
X-Google-Smtp-Source: APXvYqxGZJIjcK0maWtnOqNPFfxP51OnvFqKm6vC5UwPt6g31XITmyc0rlVTDP/XB3J3A8i1hy3f7g==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr112360wmg.65.1561999188397;
 Mon, 01 Jul 2019 09:39:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:00 +0100
Message-Id: <20190701163943.22313-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: [Qemu-devel] [PULL 03/46] hw/arm/virt: Add support for Cortex-A7
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Allow cortex-a7 to be used with the virt board; it supports
the v7VE features and there is no reason to deny this type.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: fc5404f7-4d1d-c28f-6e48-d8799c82acc0@web.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 431e2900fd2..ed009fa447c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -176,6 +176,7 @@ static const int a15irqmap[] = {
 };
 
 static const char *valid_cpus[] = {
+    ARM_CPU_TYPE_NAME("cortex-a7"),
     ARM_CPU_TYPE_NAME("cortex-a15"),
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
-- 
2.20.1


