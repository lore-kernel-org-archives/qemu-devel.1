Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF0C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114C92054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGq0gr2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114C92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOmq-0003D1-5g
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjn-0006ij-CL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjm-0002ki-Ag
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjm-0002k7-4U
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id s8so14576850wrt.7
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UsmjsPrqu/tMkzebNtgKAC7Wj/hA5gO7KEKMoSm+cTo=;
 b=rGq0gr2T54Kd376rXedZbjxb4QI/1ZqMBU9/jImwIc8eLcou3oMlki44pt7j9KBkHH
 IH9F4dz/NDTuD2fWmLGxWGHWJ2ECIRaDacG8JF1UvGaOWxf8xSYSbKbozC8eeHEFRMH2
 ohKg0ryuhQDROZzSEQzl8gr/rzI1dNsUr0Fe7ZwdA2TukrPdGJokgNfuvu8VKxyU27jL
 MU8U9qQeu5L+8Pn6DmrhVnmcYUAF1DSlcy93Ym2nTl/TxIyJhZNJ6lseR0uUgOj3cw3A
 O5X2ZEY42dcaUmFXeiompj2SgHBBIYhxp8nilwF4JTjglaKcaxWTnkIOjPm4nY4BzWdV
 nqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UsmjsPrqu/tMkzebNtgKAC7Wj/hA5gO7KEKMoSm+cTo=;
 b=tKKDEYBIeOGce1On0xeJ5EE1jHF7MMB1lcjM+ZMuHNQhnLv/cIsK8RLcWJoETDqWCC
 YAMXIZNBEbdEaXvsjV1LxWsaMeBQ9lDYwu9Y6zT+FnMpTj2scbvmhMhtZELLnWu4D6j+
 CFx57lBix8M01Kuz4gA37VyRl4z1qT/b7BOheujKqPmd7lRgm5FYQTfTHou4YbJ57KYN
 5awWWiwClmI9RuHg8EuTSUg1ANJ5efC8ymol+nFQ6/R53XviOeo01TarLp7q04piKFxf
 8edwHIv1vN8TlcTW9t1vLUl6PROItRPrcJWc0n8MN1ItfgAbB+dw2bZ0KLRRpOmCuymz
 zXQA==
X-Gm-Message-State: AGi0Pua1CKYw47qbs95jCn3T/sT3pFi1CvHDoLARB010Jxyu2LmkO3uv
 E1cHXWqWb+hzeWoIHNm5ZBfqxdaLH1G7DA==
X-Google-Smtp-Source: APiQypLHouNldcqU2CpoCyddMDnkJu1KFJ1nkmE2fUR3Q3EDvlifux4KFuBxlvKEW1ec4UquHI7TNQ==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr1460205wrx.112.1586167932813; 
 Mon, 06 Apr 2020 03:12:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] hw/gpio/aspeed_gpio.c: Don't directly include assert.h
Date: Mon,  6 Apr 2020 11:11:59 +0100
Message-Id: <20200406101205.23027-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
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

Remove a direct include of assert.h -- this is already
provided by qemu/osdep.h, and it breaks our rule that the
first include must always be osdep.h.

In particular we must get the assert() macro via osdep.h
to avoid compile failures on mingw (see the comment in
osdep.h where we redefine assert() for that platform).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200403124712.24826-1-peter.maydell@linaro.org
---
 hw/gpio/aspeed_gpio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 41e11ea9b04..e52fcfd9a03 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -6,8 +6,6 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <assert.h>
-
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
-- 
2.20.1


