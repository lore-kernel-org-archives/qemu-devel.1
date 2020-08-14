Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908EAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E062074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWynQV41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E062074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V9R-0002CC-GE
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V55-0003cv-DD; Fri, 14 Aug 2020 04:28:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V53-0004N4-Sv; Fri, 14 Aug 2020 04:28:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id f1so7614599wro.2;
 Fri, 14 Aug 2020 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=etBgOERj9PnsiIU1OWuoGsH2uwmn42946LFCXfF1LJ4=;
 b=VWynQV41LpgWgKjmmFdhEmpTOhhwsGjcU8NfGDsfDSBd67cjZgeRMVTMh1Qmx1UOrw
 VD8r/jc80h1JOdxHyAoisVXB+OAEGzHY6j4lxZ+OuzeHrHhCYbsKClWJ7KsO0+8zEro3
 m5AI3nK9KVAyQT8KH7tRbs25bkwmiQ0S0dNyNmwvKr12ywwV6IEJTvtSwFrU343kN8iX
 l+z26Y/ml+bfAsu9gYZtjhrtlrlbaUduOKEwY/cqUYBAdlh/gpCmXZs5He+nlFCazzCL
 td6Ga7kkj5D7nWhue2q3pJDPl1XAX5Zi9DvO6K+/txYDK9STDeFggHbB6afIoTVKhTDb
 tJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=etBgOERj9PnsiIU1OWuoGsH2uwmn42946LFCXfF1LJ4=;
 b=qb0YR766hl9myooHvYGT+3dVFVsmwIdPWe6yRYV2la6Z/5of3xR3M7XCTL8j9gv+jy
 C/SjybmFRIqmJqgANlvTcMXCaetQsxoYzDRLlZQhvKkcNvnq+mwd+De3BmpCyqqUIM0T
 mIN6OiLfgVGrqYC1uqpdoouJ69misgCxzCdyCS8FfTxQg/zuicQoJB/CzzIZWRWbWyjU
 NJuM5Q8GMfMWWuz4BXu5pD7FASDVPX+iC7PUb0c6vGcr1jgCJuPkxYXjQVzbLCZ8HAOU
 Gsgxm7AMSXy205UG2BTddQ1TbrGaJ96KtrquBZlCvGUJrJjyu3+jF/naQ7ANeEXAP9XN
 0VeQ==
X-Gm-Message-State: AOAM533jO1MBYcy7qnw6HveR1vFYv1i9pEjIHHsjfiRYk47C5crsO2zq
 YRkj7sMThNhogykETOqyiFEWXZShPpA=
X-Google-Smtp-Source: ABdhPJypItJ7BS6Ak46+S8EZ9vXwvMoQjuorvxaRyWao6o3rJrHTJemFZR/5laAy5CMBPoYrmJHK/g==
X-Received: by 2002:a5d:5588:: with SMTP id i8mr1698627wrv.177.1597393731525; 
 Fri, 14 Aug 2020 01:28:51 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE
Date: Fri, 14 Aug 2020 10:28:40 +0200
Message-Id: <20200814082841.27000-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 5e85c4ad17..b50091b615 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -138,7 +138,7 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
     int l, len;
 
     pci_dma_sglist_init(&s->sg, pci_dev,
-                        s->nsector / (BMDMA_PAGE_SIZE / 512) + 1);
+                        s->nsector / (BMDMA_PAGE_SIZE / BDRV_SECTOR_SIZE) + 1);
     s->io_buffer_size = 0;
     for(;;) {
         if (bm->cur_prd_len == 0) {
-- 
2.21.3


