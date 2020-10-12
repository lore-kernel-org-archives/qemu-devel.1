Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6933C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4946220838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azk7yZjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4946220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1Nr-0007Vy-CE
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kj-00032r-AN
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kg-0002f9-B9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id e18so20009164wrw.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K/0FGZZwlPzFsD7CDw6LNpeg+vGvRuv9FXjLqVDCM3o=;
 b=Azk7yZjPF6VVj+hqVlAB5HhEANYY+vQUs6Csf9I93BqimulxncYmv9zvzODaZSTEzf
 9hdtmDhHtdMIXPCaBfFBhoSwMEyH6n6LSCtH0od5uZXCg9IFjUlNtyb1ESISX2ZYbLNf
 ciS73zcuYuIAvm/D3lS6nc06y5q1X7fgOYsV1gl0PmpPDCOJ/aX0aROz/EbaBIVLNBrH
 gw8iD26PzrmvUM7mqcUqABWjsd0C0J5SOKi/+DE4t8yXqaB2FzXUhH4gnm4aXjUFbPIE
 S9evP92w992zx2IsczO41kxsSrG8vcTT7ocFxgUNn0QPe0EF/CcOBOTI2GXqLxgAkXfi
 Xeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K/0FGZZwlPzFsD7CDw6LNpeg+vGvRuv9FXjLqVDCM3o=;
 b=eKVD7Z7yuqF8uhUrY8wV1oaMOxbdnHGsVUOgeY4Uf0XU2muqZqw09gNRX0j5aLz0Xt
 a8aHUNN2pMgEivVJdHhiR239HAIxw9SrYoZwp+cI0PSFmtVzXouA12xfz6nWP7ZtChsW
 JEI9XB8DVK7NbngqrKb3vDfpANtU3n2D4KsLCu2zma+UsgS4UJFr/KLyqPeEMRxIHMyX
 BVLnNKOGsh4T1MYzTnDHv8TITbPrSXQn3oddwrpwTuazjji2VRy8uRk+CtpMf2ontgqH
 ai2Pphje1JQBHOQsMF+U3Bgm6pV7dPOh7NQYs0iY1aSb4z2tsCFnD5OKfKenfw51fpEg
 IDRg==
X-Gm-Message-State: AOAM532I/cG08DJCc0ebitEFiIS+MpMq1rLK18mJmDAyeJESBS9/UyGP
 w7CV69T6RP0MOJfcQeg4Mv9gIXTbnRY=
X-Google-Smtp-Source: ABdhPJxQierGOMFl3ECY9FPz8M/NsDmtmT0d+XkIPtxvqdy28hHcR68zgD7Y4DwyrnukoDuJ+hJ/kA==
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr20584353wrr.255.1602522596794; 
 Mon, 12 Oct 2020 10:09:56 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g139sm25872629wme.2.2020.10.12.10.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:09:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/pci-host/sabre: Update documentation link
Date: Mon, 12 Oct 2020 19:09:45 +0200
Message-Id: <20201012170950.3491912-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012170950.3491912-1-f4bug@amsat.org>
References: <20201012170950.3491912-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current link redirects to https://www.oracle.com/sun/
announcing "Oracle acquired Sun Microsystems in 2010, ..."
but does not give hint where to find the datasheet.

Use the archived PDF on the Wayback Machine, which works.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/sabre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 5ac62836238..3634f8369b7 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -44,7 +44,7 @@
 /*
  * Chipset docs:
  * PBM: "UltraSPARC IIi User's Manual",
- * http://www.sun.com/processors/manuals/805-0087.pdf
+ * https://web.archive.org/web/20030403110020/http://www.sun.com/processors/manuals/805-0087.pdf
  */
 
 #define PBM_PCI_IMR_MASK    0x7fffffff
-- 
2.26.2


