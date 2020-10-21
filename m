Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0EC56202
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475E320795
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShXjz51L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475E320795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBim-00069M-2b
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhh-0004u9-4k
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:50:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhd-0000bw-9y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:50:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n18so2530717wrs.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SenI/m4MVR8+NEEf8DYCWuc6xCFneoK33J1yat7CMnQ=;
 b=ShXjz51LTHeUnMo9Z93PYgblwftpUaBC/j4xroc7mvpmzWc2GAXbMBcCPni1SkOsMs
 9KWoQ2TUawPOR9a/jQDWpuEk7h3dlgh6k4Ns2b5oO68YHu0464xnwY71MyQP+rMrtcXc
 ruQ3jsGIEeFPFxDiVPZXJb78/qv/5BXrkJCbd3Ac5wkCxFXAq+NSiv5sdjpEGLMIPnZA
 611QuJz73yRGUvYznoKIL8KIqjPCYWiQNFU1nuqdE0ylSRsg9avsT+dYla056KKoMfy9
 menkbXbaSM/eSygNX8e1VwbTQjpCW+8qaJNi7T6KolXNwsA7vyLvPP/lZz0IA3HaRjvW
 0cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SenI/m4MVR8+NEEf8DYCWuc6xCFneoK33J1yat7CMnQ=;
 b=jEnOJPML1/EK5pRvb7VpQ8NaeHziszzf73QcvVWYf8c4kcV6Nv/5YxaP2CQ+/CWiK0
 QQVCY5FMMnRurFIawYckm4/WKz9lbiSG85yhthLwYrsC6xcLHbz5/kjGa978sY21/Bcs
 wyo0/a93k82A2HKDZNblKK+LshxZtP7skZTC6CTBx6bA7dguWDq2iBcC+aiEfs9qs4oo
 SeJSBP9PYHcYMtWsduXjZQof5j4gRr36PzsMISRlloDNt7M5grgmCFqy/Yi/s1ah2+G9
 TyRyGvJadGwO6lrjUMcMZXmAXA9y6NTvxCLZSt1WAwVMxzXiiUobQNI7sMYH6aUZQJKB
 fjyw==
X-Gm-Message-State: AOAM531j4r4xMejHowaIa7FhMcW2C1/Dt5LZqa1sTIBhhW7pLdXn6VJu
 GyFlztFHcUZpX4FOoqS/a4t47dzA/dA=
X-Google-Smtp-Source: ABdhPJzQASHdZneSo8xHkPK+4PCMLsJ7tmRs70aOHofxRuo8HOc8WbWzB7eED4dEA/gGy3O6E6J6xA==
X-Received: by 2002:adf:e685:: with SMTP id r5mr4302071wrm.340.1603277442931; 
 Wed, 21 Oct 2020 03:50:42 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u195sm2910068wmu.18.2020.10.21.03.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:50:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] tests/acceptance: Remove unused import
Date: Wed, 21 Oct 2020 12:50:30 +0200
Message-Id: <20201021105035.2477784-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
References: <20201021105035.2477784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_m68k_nextcube.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
index 32cf571f948..9d289f2fab7 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -9,7 +9,6 @@
 import re
 import time
 import logging
-import distutils.spawn
 
 from avocado_qemu import Test
 from avocado import skipUnless
-- 
2.26.2


