Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9BFC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1342073B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oppd9xJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1342073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfmg-00059Z-0Y
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEflv-0004iR-Ns
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:30:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEflt-00006R-Pi
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:30:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id e17so9808084wme.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g1mxUl4yXFIr29HF58nsdy5CQfguiVDDxB8BF7FF8E0=;
 b=oppd9xJ9iLqbz4rkjgL3ZIf81HaV9e7yKg8z7TTU25WYsJWxd0rXajFu0ixihd5Tt6
 5rKubmTXiqBNah3abGhXkeXK/1ySwJo/1L1hAUk4xsx+KhmF671szR+MXl31XdKk0Jxh
 EBSjr3aMYejiXVNDvT8EgmN0bptmwstyA1pwpckirWx4fIn2hdALejDlPBEgnSCq7S0Y
 ggd+cAuj0Lyy1pCyd7nHuf0pqt5VtK7SXTb/zfOan+KjSV2MfK7ogVyQz+jE5AxkWEuU
 rPSoXLxPo1/14X4y5bRusNB2jACm0tkEcPNx9F+b3+w5gqjYb8lJ0horFtazg4vWDvhw
 EiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=g1mxUl4yXFIr29HF58nsdy5CQfguiVDDxB8BF7FF8E0=;
 b=om5PQAhmUg8WUhmFepNVFTQwAUMchZ82JsN7IXQY2zuVii1AI79rHhMzB9KBc1ePNx
 FUNfErJ2hpOCSXkckbs7TNvUP5WPjuPhb6AXSiEcekftnEA896KPMrnK6UhAu2gtEi8Y
 a5spB5bLO1WxxQFNgVstI4SrPVcUsD7XaTtOgE3vxlh2d7nTP5uo+QTXCteZK8yyK2hy
 ndFGzYVs+vje5HxgzAfHZW0yvO6BE3NUI4pRVKANF7/+cdZXC8Lj1EEiALtStVee4bo+
 HhbdCetpgFmPGyHVNfXRL6cFuMPflD/OYtRJjJfXWAPRoYnYhBtimC0XvrH1VGPBAc2J
 e2ZA==
X-Gm-Message-State: AOAM530QwT+OGuy7UUjsKI3RGlfIAUPIsYsF8ra6UDOpl8moZRglAm/R
 t+xQobIYiziqWSQbFOU7EUp15AARta8=
X-Google-Smtp-Source: ABdhPJxp6Rd0ZblvSc9bHq5Qxn0mhM1rCSSrnil3OOGz6ESdcyQVCLyQBGFwq0PLVGD/GtXe2LKq1g==
X-Received: by 2002:a1c:9883:: with SMTP id
 a125mr14264271wme.133.1599341451628; 
 Sat, 05 Sep 2020 14:30:51 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a15sm21909455wrn.3.2020.09.05.14.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 14:30:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/mips/malta: Fix FPGA I/O region size
Date: Sat,  5 Sep 2020 23:30:49 +0200
Message-Id: <20200905213049.761949-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FPGA present on the CoreCard has an I/O region 1MiB wide.

Refs:
- Atlas User’s Manual (Document Number: MD00005)
- Malta User’s Manual (Document Number: MD00048)

Fixes: ea85df72b60 ("mips_malta: convert to memory API")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index a59e20c81c5..6a19be0a5dc 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -574,7 +574,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     memory_region_init_alias(&s->iomem_lo, NULL, "malta-fpga",
                              &s->iomem, 0, 0x900);
     memory_region_init_alias(&s->iomem_hi, NULL, "malta-fpga",
-                             &s->iomem, 0xa00, 0x10000 - 0xa00);
+                             &s->iomem, 0xa00, 0x100000 - 0xa00);
 
     memory_region_add_subregion(address_space, base, &s->iomem_lo);
     memory_region_add_subregion(address_space, base + 0xa00, &s->iomem_hi);
-- 
2.26.2


