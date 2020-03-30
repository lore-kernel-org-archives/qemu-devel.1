Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D2C2D0EC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B25720771
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEwQtKwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B25720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIucJ-00061r-BS
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub0-0004Ok-SP
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIuaz-00015D-Kl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIuaz-000131-EB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id c81so19958971wmd.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CbVDnPhb7KjkBF4bPw+KOLLnLSCqhHbQ8JeT9vFEYAU=;
 b=FEwQtKwQihU/wpwY4pk9tGWNQltK+tf3DA2rwP4HutsOEWugH3PxysVLhmq0itTPFZ
 q4MrNmYEO9x7UgMo3qRGhOUWo0shxhxBpfel27envq76na2ylJHPV/YTtI4zmjI337oP
 YA0myBxLf1fh2ziRbcJz03RrNhiPrQyovTWMdkxMGzs+sH/Irrl9OJWk2cSFfCC7J63J
 n1NxTZYPBaa6NXLzEUI3CGDwSC2Bhw7eiyeH/WfAJwZnm7tKs4wCBD4hpRDm6zdSfKi9
 KjYTzloatQZAmJy/yO6I8G/2RwqB7UkhbWW+EGIOCj7yA+GP5GytTf0p27zjjqaURwVe
 5OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CbVDnPhb7KjkBF4bPw+KOLLnLSCqhHbQ8JeT9vFEYAU=;
 b=quVEbbc8leD7Z3tnfT7bzrjYwcSD8sLPhbzqbf6bw2mSQnJ9yXlw1DZ4CDR2KF60vG
 dVT5FNu9ak5HwR5jemmc2Qb00YWU2MMScuvz8vq7m6mK0ha71+Z2wPVRP5iJAL9Uz6IK
 lurmYdnKeeKVPcP8k3P4k0RxJR0UKe41GrXzyM8LQwRDHh0gn6cz/KL4dH/oj8+OOQDW
 GdmHMMyW9WiXYm9nNkjITx6DOffuj4YzWgG9WeMLER2JBPV75e8Il3Oda46xmCqAmmcA
 YO/H0xlzxiNTNTb4xmzosz+0HB6rhFc+sKNW6+jZq9ofjmkmde4LV+Tacs+yEM17UeNV
 6nPQ==
X-Gm-Message-State: ANhLgQ0+g5SpNqan+TkaRY2aO4SPQ13fUMfx9KWRVnL5GBFUQviPeLdJ
 njp4jDpR4B9+RYIdmk8woNYlnLi4rXDj8g==
X-Google-Smtp-Source: ADFU+vvvyCy1/1ZKMCDZfZtftq6Te6frDdDyhC0b3oLcr1Rhh79ZxoFHagKh3PhDIAY39y4u6yucWw==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr13149905wmz.21.1585575411598;
 Mon, 30 Mar 2020 06:36:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] hw/arm/orangepi: check for potential NULL pointer when
 calling blk_is_available
Date: Mon, 30 Mar 2020 14:36:43 +0100
Message-Id: <20200330133648.22297-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
References: <20200330133648.22297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Orange Pi PC initialization function needs to verify that the SD card
block backend is usable before calling the Boot ROM setup routine. When
calling blk_is_available() the input parameter should not be NULL.
This commit ensures that blk_is_available is only called with non-NULL input.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200322205439.15231-1-nieklinnenbank@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/orangepi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 181f5badab7..a9f64c56800 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -104,7 +104,7 @@ static void orangepi_init(MachineState *machine)
                                 machine->ram);
 
     /* Load target kernel or start using BootROM */
-    if (!machine->kernel_filename && blk_is_available(blk)) {
+    if (!machine->kernel_filename && blk && blk_is_available(blk)) {
         /* Use Boot ROM to copy data from SD card to SRAM */
         allwinner_h3_bootrom_setup(h3, blk);
     }
-- 
2.20.1


