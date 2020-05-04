Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5911206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZPhjKpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5911206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaKU-0005KD-VN
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHl-0008RF-HD
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:56267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHk-0000qr-IK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id e26so8234643wmk.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zKel1GTMbLzQCp40bxcgD3q9PRQfcYG3Q8Qjvpr0CO8=;
 b=yZPhjKpRTnfQSnc+6sJtsANiuagLCEsyzCkM4jcTbKGa7ApWDWySyLOZg6UOs4PAN3
 QOSBtHkYB9q6nvKytbHlKMiOrTRlvt0oQUKkzWrytVN/57KUrkGXs3BfXFJhHEXw4CFa
 whCvT4KbQ6FNMfa74KGbZeYauSwTxK7W36L8eAIN97nOaNUjkm2D0qKmLKWQTof7ZDVQ
 bj0QxYv85ObndkNsA1uljDm8NI4AAOFu4xhjLrn9Z38JcIEKiEFH32AMq6lmby9DSC/k
 l03YJqzs+H8Tybu+2rzDVjQnrB1DchKJhZLA5QUhlDuNjeCjfrljxi4GN1mseQKU7qj8
 9zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zKel1GTMbLzQCp40bxcgD3q9PRQfcYG3Q8Qjvpr0CO8=;
 b=ppApqpeMc36/sYfPGNnmbkP9Gd8FzXlOUTV6CpzN02FPDnurG+96Crpnn1h6l6Yigf
 YM18KSl6GhObaUJwWuUPbwM9r9jcl23UXNqhHMNMZmCFlaObMJZXccLRq71BKtnRn/vR
 Vuaj1zXFa+4kcVK0ajF76d3GecLeDW+9QSQy0PUZumpSZljDmZ3DVZTIvxaZqtqnXLl6
 JA1QRvfnbaMgRv/E2MqAl4fF7vOxVwGqRDJ8iO6F9dC8OByidx0FpaV5Is5Jooamb8UN
 y/Cp6tiHV1ve58mtkbpmZjVvjl+uoJ7rT/2otgYWHV1t1ygLBYY25YtA7gZDFhLeibm2
 4gLg==
X-Gm-Message-State: AGi0Pubnyr8iixptO0A2bBOAisoqyhpXusBTtEm9bn+N3cCORiySk9tx
 cIgBsu8+b8J4B3ey6RrxEvX9mM9FrXILaA==
X-Google-Smtp-Source: APiQypKJOWuawp+OoFKfUGZ1o9gmMGw6dmPsY/epldrwp4Yc/YRxrbsKKpFSXiy7+UU3YNUoux18HQ==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr13829006wmg.1.1588595602986; 
 Mon, 04 May 2020 05:33:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/39] hw/arm: versal: Move misplaced comment
Date: Mon,  4 May 2020 13:32:40 +0100
Message-Id: <20200504123309.3808-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move misplaced comment.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-3-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index c73b2fe7555..cc696e44c06 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -36,7 +36,6 @@ static void versal_create_apu_cpus(Versal *s)
 
         obj = object_new(XLNX_VERSAL_ACPU_TYPE);
         if (!obj) {
-            /* Secondary CPUs start in PSCI powered-down state */
             error_report("Unable to create apu.cpu[%d] of type %s",
                          i, XLNX_VERSAL_ACPU_TYPE);
             exit(EXIT_FAILURE);
@@ -49,6 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
         object_property_set_int(obj, s->cfg.psci_conduit,
                                 "psci-conduit", &error_abort);
         if (i) {
+            /* Secondary CPUs start in PSCI powered-down state */
             object_property_set_bool(obj, true,
                                      "start-powered-off", &error_abort);
         }
-- 
2.20.1


