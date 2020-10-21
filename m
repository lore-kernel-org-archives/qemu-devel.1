Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA9EC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621C22224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaV+oj0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621C22224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI2B-0004DT-S1
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0q-0002nY-EC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI0o-00061d-Tk
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id c77so2988080wmd.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KaLHZkyMV310GRpm8xmZb+UEiBALh924PFEJvj8hcI0=;
 b=XaV+oj0FziPlbSlHvjGjj/aR9lAah6vuPv5eHBR4MN6rZv7zfpiHm2vx/mP43rNEwI
 1+kBNefVAQd0K811g6ovqCI6pyeTvgFXD2LTJViPI0pN3nND1P4HXk6JtiEu3FITGYrD
 DwZdt6EvrJVNTL8E668bQcdg2ZpEGFOqU/L7IsG8rci5vvhG8KZG9O81tJON+X1iVyc9
 EgwDd+VLnr6mQ7b1Q/Vh3foY5Y3xn2INIGcLevUwqgjAVLWPjRpQWnGTrrP5miL1M8Nl
 j62IE/H681F4RI9a+SVPChBtJMfodh65YVwhj6brFTUvtytc4e5zg9SH5DH9ZEpwz0dH
 eX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KaLHZkyMV310GRpm8xmZb+UEiBALh924PFEJvj8hcI0=;
 b=peuQ5OjxAHPhXF1duAdP6ZtzYOOvenmAHQjqHTXnCYwom3YL8nTdjdzLssB+y54EQ2
 XBSZ0Kct6dV0CsYDtMv4Z2U0I+vZqLW+joBJy/GpPLre0Pz5kSJSDehYGEZxJpZrZPZm
 qc2W7ySljXAzMoyK7/pGmQb6t5xWgyKoTuQlPS4NI7SoRAmIPcTv1+2/dUVgb9IuX0X6
 QM+SuEnbdHa9Ye4st9JM9LOPxcqGV6nRSbNoNEX2WADPx6QQY2rjqjPCGZNpR7J8dsJp
 uJtPboAkdq/oHuzq4288SCL4W7P6QQgCeTReWc6CbmLbuW+GJmCIhhoGnK63q/BRgqm3
 C/oQ==
X-Gm-Message-State: AOAM531oTGI6rjpRP4vEqlB/GxPcKb7/j8DJ71cytIghb96+Z8baI/ZX
 sPKCXjaHMkKONqF93fccH1iekxlq0As=
X-Google-Smtp-Source: ABdhPJxC5HhsH3754EGbfk2rd2x1DQd0L3Hh82CY25ufBmUR9ajcWKntZZve+rDuPao2thV9Duq5ZQ==
X-Received: by 2002:a1c:9641:: with SMTP id y62mr4823756wmd.145.1603301697230; 
 Wed, 21 Oct 2020 10:34:57 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i126sm4943809wmi.0.2020.10.21.10.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:34:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] hw/sd/sdhci: Fix qemu_log_mask() format string
Date: Wed, 21 Oct 2020 19:34:38 +0200
Message-Id: <20201021173450.2616910-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add missing newline character in qemu_log_mask() format.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200901140411.112150-2-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 69002130839..6d4603f5b19 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1112,7 +1112,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /* Limit block size to the maximum buffer size */
         if (extract32(s->blksize, 0, 12) > s->buf_maxsz) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than "
-                          "the maximum buffer 0x%x", __func__, s->blksize,
+                          "the maximum buffer 0x%x\n", __func__, s->blksize,
                           s->buf_maxsz);
 
             s->blksize = deposit32(s->blksize, 0, 12, s->buf_maxsz);
-- 
2.26.2


