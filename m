Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BADC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE992067C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDmw4Ab+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE992067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Dp-0006GD-Fx
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqp-0007Kd-S5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:35:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqW-0007MI-2o
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:35:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so7587958wro.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MHkoxi+EkVCFW4Wg+U688/CA12tSJrQLvZAe0iXiD3s=;
 b=TDmw4Ab+up5ZPeCCjMTDp0maLBBjXy0H1LsNGgtWpPV7uMX3CCH28eIbi4HRKCgNQV
 lhl9cq0lx8ya2CWBkYCr8n8uzDU/qQYL6e6WmMMlwZ7rJGaX3IsevZRFEaET7aM1zj5z
 9SzQ5IZ+hY6rVkSzc9X0Kd9Xt51ljObJotFMwNmK0X6Zp9q+9R4spQIrTwMEXlIv3xAE
 6vKdA3WiMiRgiD0yX5yZHdDJ0UaP5eXFGyeJJJDCk5dbbbelCmBJLa/UivU1/crsLOuF
 XSPnHtIMN167sOUkxS756LgTNQaunMxzLvPuIw5CfSucOhaJyS72sghFqI6Td/Kv0T1s
 DzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MHkoxi+EkVCFW4Wg+U688/CA12tSJrQLvZAe0iXiD3s=;
 b=Q/9xXeYyngl/xileHEc2faJHjSbcFK009mYTU05lv/iXW5lkpe4qHvsgRcjMqe1PVR
 jyA3NEe/Cip/e+mO15vgxoSiUFM6wbe9avwIBStfonXw1/6Suz7aPQNGKNMh2mjaVVI1
 YHreHJWWjG7QjZW6jetcWg7ATc5msKRlcxD0iudyudmnI0G5vYctrSaDmRU9af5k/lvQ
 FOo1zLuRdygfVwduj5sN2aVZyrvhZrKuX+CONqoWo7j3O53Wd9DIx2wZrGOsQtzw8xbd
 oxKJCowJFuxhO3vmqAwuFfc2Z5BL22aYdgwWVyazY2lQsi6Y06PJZizgulH48yEZEzB0
 rheQ==
X-Gm-Message-State: AOAM531dShE2y76ah1UiRTZqZTOD7I/2dVNS4was1WupsWLnt3nb29PW
 3FwSXQjkPwCe589F0pqT1sRv51F0ByJEwJNJ
X-Google-Smtp-Source: ABdhPJyPMGnuo4SxTMva4ZllUL/1S5UluBIltWrbBVhN1vWpOwcT4ULQNubXCBHEOVJQucAJDgEf7A==
X-Received: by 2002:adf:e741:: with SMTP id c1mr19304521wrn.16.1602516879214; 
 Mon, 12 Oct 2020 08:34:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
Date: Mon, 12 Oct 2020 16:33:48 +0100
Message-Id: <20201012153408.9747-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
so that it was always included from .c files and never from other .h files.
We missed adding it to net/tap-solaris.c (which previously was pulling it
in via tap-int.h), which broke building on Solaris hosts.

Fixes: a8d2532645cf5ce4
Reported-by: Michele Denber <denber@mindspring.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Untested: Michele, could you give this a try?
---
 net/tap-solaris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 4725d2314ee..d03165c57c9 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -27,6 +27,7 @@
 #include "tap_int.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu-common.h"
 
 #include <sys/ethernet.h>
 #include <sys/sockio.h>
-- 
2.20.1


