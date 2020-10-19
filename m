Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AE1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1893D22257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOm4sgLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893D22257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTJq-0008QJ-OZ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUTJC-0007sE-Fx; Mon, 19 Oct 2020 07:26:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUTJB-00066B-0o; Mon, 19 Oct 2020 07:26:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so11004192wre.4;
 Mon, 19 Oct 2020 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OXeBoUdOo5NY6eTN5elXmFP20gkOzGyp6dljEkbwOz4=;
 b=rOm4sgLFRXggPcf2uVYU+hOKGoG9BoYQ14AtneWNcEy+rvPhZDbnnVYQ8o9JnRFWpL
 Fbr0kySRQtez7lszCR7OlgpRAzcOrBSVt0VyZiBVHs8r5++eO7tMNk1z5GlqrUVa4Bgj
 e/b3+dvsbWAISESMXrH6IZZQl/xoEJLPxRdUmb38M+IDEfN75fIejc8YxcpU5EO2w0+f
 wckNpXT0yIgbpHbzY3+/bqjTRr+y0I2L79hI0AOiX/B1CQQsp/ms5YBhl4MPg2Gq0Pjm
 J+RewzURFVSmzIetiYYnhUEYnaLGLu8r5k69jW6u4qJrVulLn6QQCj74nAeVYDjryN/f
 IFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=OXeBoUdOo5NY6eTN5elXmFP20gkOzGyp6dljEkbwOz4=;
 b=TFznO2IpO73VM4FJTBu/pnRj5Bt4dKrC1kn3Mxa9O6YwxDeaq7HKUpwhbF1LzdQlcw
 R/0uut/8RkSR+yyREMxIEECzsCs60YHtPnO0DePGc8rieIfPR8Qf+x1HPkMWKfB+efoZ
 rxtrmUL0mL0sDx9DktOf9LYy/6UpTlE3quKqSOHeXf4rAMd4m04+jmw9LhBhvtMJkNvA
 lrgH6LjXTsgLSnS7L02ahEWXrgGClAwGn+ospmNxrRFF0MTOwaRiECS93wgdeAIKRapX
 W0NuITxLU2xUdCSdq5hiV/ORZHRdp0LWVHu4rbFRQo3q0aeRU3a2jIydNqfvjdlxwT1X
 gAyA==
X-Gm-Message-State: AOAM531v6Lj36K9He14uUGTu1nkt1cdFI+JLMyh6OsIEnhxm3CWa0QDH
 J6GS1SRKte9lai69kxXu+m2mGbAKo8w=
X-Google-Smtp-Source: ABdhPJzqhVaxMFHLdT3z+O0TKBZC8Kmh79o7G72bSoa507VwEsMgIZqaD+U6k9pzyXrGMzld8uvzrg==
X-Received: by 2002:adf:e891:: with SMTP id d17mr12813765wrm.218.1603106790729; 
 Mon, 19 Oct 2020 04:26:30 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x1sm17249422wrl.41.2020.10.19.04.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 04:26:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/bcm2835_cprman: Make cprman_internals an included
 source file
Date: Mon, 19 Oct 2020 13:26:28 +0200
Message-Id: <20201019112628.1653550-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bcm2835_cprman_internals.h is only include by bcm2835_cprman.c
and contains various static array definitions. Make it an
included source file (using the .c.inc extension).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I'm sending this on top of:
[PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
to avoid a respin before soft freeze.

This patch can be queued or squashed on top of patch #08/15:
"bcm2835_cprman: add a PLL channel skeleton implementation"

Based-on: <20201010135759.437903-1-luc@lmichel.fr>
---
 hw/misc/bcm2835_cprman.c                                        | 2 +-
 .../misc/bcm2835_cprman_internals.c.inc                         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/hw/misc/bcm2835_cprman_internals.h => hw/misc/bcm2835_cprman_internals.c.inc (100%)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 7e415a017c9..9d4c0ee6c73 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -48,7 +48,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/bcm2835_cprman.h"
-#include "hw/misc/bcm2835_cprman_internals.h"
+#include "bcm2835_cprman_internals.c.inc"
 #include "trace.h"
 
 /* PLL */
diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/hw/misc/bcm2835_cprman_internals.c.inc
similarity index 100%
rename from include/hw/misc/bcm2835_cprman_internals.h
rename to hw/misc/bcm2835_cprman_internals.c.inc
-- 
2.26.2


