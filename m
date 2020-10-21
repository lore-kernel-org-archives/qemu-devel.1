Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DEAC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF5C223BF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDcf6gZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF5C223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIBD-0004Hf-UJ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1J-0003Wu-1S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:29 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1G-0006G1-Re
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id n15so4079526wrq.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1T44dRrHJFyTG6J3zUPzNWduAlmSBzN4WxwodQQd2DE=;
 b=vDcf6gZu0N7BOib+GMVdXn2IJ+yMN7KzNJyEZt8IbpLlR0mqm1pLlyHuEcmULWLQ1R
 pLeUa5zPK0MtS83JrcwSA1MeBzbBY62lzHueHhozsZtyrhWATjOzP7pdEXVxUnx44vgc
 RHPALfbJYmNuq+AwmpE0zEFDV6vg/MnOB4F/iJ1WPzuu8RLaQTot8Ml84Zuf7YsS5PeH
 f/5fogY7GUshEdB5mLXk/EDav3YGluzZF4UUCzwxNFUHc97NesLIlafy9DEyOWvTir6N
 YwqJb2pdzSCxZHnnfdLiDd6NE/oON580qMYNa4PVOGyPZGSfdLssqMMdxlxDcYwe+hIY
 u8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1T44dRrHJFyTG6J3zUPzNWduAlmSBzN4WxwodQQd2DE=;
 b=CDfby2G24ooWN/LNQZkUG0AZjoCXl7Vf5j2RD6lXMSuWxi66gUWstTtc2DsB5vuH5W
 6BxX44dYGrYHypDt3nQQp3fMdHBuD4RAC/4gy85oJX/4vgCbz+Ni/zS+I0TeES11VTgI
 KRVR12iMoX3ICPOcDbvMx5Kpfjv0DbUq0Lt5JtC2HdbIJrxk1ZT5qPFcTc6TJyzWau42
 NEeOQRQ37QU9aDCRWiPWtXAkW7PXumPRlIsqqn6MUV5oq+2+rgSRgHQhUSvUT06xw+VA
 Gp3ywgZdLM5xslCesGtctcwySOuQOLJBtxWTjTUN5M8Pa9m2WJP8GgtSMMMX5aaN6g8E
 9SVA==
X-Gm-Message-State: AOAM531KfH3rBts3x/KW7hJjfW7TTLjPPgxyMzQVXQRJeRN53mhMxvrA
 ryqIsphlud2DKhJEaW9xT8c33QiXVuI=
X-Google-Smtp-Source: ABdhPJxsvOAD4Sg/dhZO+BQpjrfn3YX1tqt3EiPn72WcpBB/de83OEXxGzxoJmuosXE+Jv5PQR4SDQ==
X-Received: by 2002:adf:9069:: with SMTP id h96mr6289680wrh.358.1603301725217; 
 Wed, 21 Oct 2020 10:35:25 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s5sm4320261wmc.3.2020.10.21.10.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] hw/sd/sdhci: Yield if interrupt delivered during
 multiple transfer
Date: Wed, 21 Oct 2020 19:34:44 +0200
Message-Id: <20201021173450.2616910-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Descriptor Table has a bit to allow the DMA to generates
Interrupt when the operation of the descriptor line is completed
(see "1.13.4. Descriptor Table" of 'SD Host Controller Simplified
Specification Version 2.00').

If we have pending interrupt and the descriptor requires it
to be generated as soon as it is completed, reschedule pending
transfers and yield to the CPU.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200903172806.489710-5-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b93ecefd20c..2f8b74a84f7 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -837,7 +837,10 @@ static void sdhci_do_adma(SDHCIState *s)
                 s->norintsts |= SDHC_NIS_DMA;
             }
 
-            sdhci_update_irq(s);
+            if (sdhci_update_irq(s) && !(dscr.attr & SDHC_ADMA_ATTR_END)) {
+                /* IRQ delivered, reschedule current transfer */
+                break;
+            }
         }
 
         /* ADMA transfer terminates if blkcnt == 0 or by END attribute */
-- 
2.26.2


