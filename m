Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A459FC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B88D2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpgXzVVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B88D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGjG-0007BX-Df
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgd-0004TS-Ch; Mon, 21 Sep 2020 03:56:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgb-0005tc-UP; Mon, 21 Sep 2020 03:56:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id w2so11140255wmi.1;
 Mon, 21 Sep 2020 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cW7dIGVbLQRxcINm7s/47MM1xbv6QEuEycp0D1/7E0k=;
 b=gpgXzVVOO+zBlYb0re2X/evLPDGwyGDIhqHOJnk/q7YD7/asCH0I8PpUlA3uGmRUr/
 RdKKNBldda8vjCpLtwP5f94sXXbM6q2HFVgGQxwJU3lc37zedSznVzsBV3Y6F1gtPum9
 EP1kN50X3WeiXDrmVJM1u4Y5vFCWmuSd08pt+2QPJJ/gG7mNxbCMwf+CLJJbXruYBlQ4
 bWWUhvqGU+XFVIV4QixSPpQBXNxy6kIlUWCk3RmFslRgdRLOqJdoB1lDXxjJZQIJjiF/
 EwPNtfOPHO/FxiLDUo7JQvWI5MIDUuwm2j5GpBvZVr1ecebpD+82AWYChomr2RCrOydN
 SXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cW7dIGVbLQRxcINm7s/47MM1xbv6QEuEycp0D1/7E0k=;
 b=g0w4BueLNs2HMLbewAo8xQReYDSlAJxjHhrlhn8Gqdqx3biBNJFCCFVXCd+FffPurd
 MhU9PWXWvSYTo08p2GAgQqGYu/8B2eOROTnVnaM/Ys0dvIDFGTF8mwwewWKEUbiyuNBj
 l9g3HAJ2hyja1iPGXiBenKMmhpDw3ak4BRRqamZoKTxAY/5e2gN1Q6LIdQwZd5mLOa/N
 4IjqOlS4DKUTH8Czqn4VsLin+y1ySZSlGJ2/m2ctY4HJPui9w6tivS4lpDqCAVW+5OJz
 ussZ09k1oYQWBkBPga01RYhGzZJHnuU38woZmvNLs0ZdDHvYXJUOoaqVcpC/7eh8Hs82
 jK8g==
X-Gm-Message-State: AOAM533qnfB0uvCajixM9qWyOPEWBnp6pZkGsAZeFYdjXkPwHjmBZBTy
 gX4bcGhvmlQbxiTJTyi9NlaHHgl94eQ=
X-Google-Smtp-Source: ABdhPJxI/1LlX+OaqnI7x6OSbQKlglj2xH+IBdTAZaHagYNfJkLl9cl0dx5NPyrXp7bYnD3SxZkXgA==
X-Received: by 2002:a05:600c:215:: with SMTP id
 21mr28514189wmi.105.1600674991610; 
 Mon, 21 Sep 2020 00:56:31 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] hw/arm/raspi: Display the board revision in the
 machine description
Date: Mon, 21 Sep 2020 09:56:21 +0200
Message-Id: <20200921075628.466506-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Display the board revision in the machine description.

Before:

  $ qemu-system-aarch64 -M help | fgrep raspi
  raspi2               Raspberry Pi 2B
  raspi3               Raspberry Pi 3B

After:

  raspi2               Raspberry Pi 2B (revision 1.1)
  raspi3               Raspberry Pi 3B (revision 1.2)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 811eaf52ff5..46d9ed7f054 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -312,7 +312,9 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
+    mc->desc = g_strdup_printf("Raspberry Pi %s (revision 1.%u)",
+                               board_type(board_rev),
+                               FIELD_EX32(board_rev, REV_CODE, REVISION));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.26.2


