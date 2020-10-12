Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE9C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D982076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLaCeaFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D982076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS077-00053R-0n
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqI-0006uU-6Z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqF-0007Ij-RP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id e18so19669593wrw.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dd6UT/sJQhVQoU/A5etTLisFLDqNewMQfmLXJ1m4wic=;
 b=sLaCeaFWyaNYwaqhma5Era5sXLXUoCCL/+CMXMHuUmtF0pAE+DyRYbkqh00Wv8oRXy
 5MkzjC4Fx6cO9XRznNrsrPYatsv3cA7/Cg+Odi51txC4cetgB55QhHPXdlizyXGOo5cm
 i1XSXYZ1jnHtSpFId8l2sFEsrvLJ0WRw0Xk6hb8HF1i5ImPJT7eAfmed5x9HTcmmr/h8
 SjAMDmdAZ/8+7e0f3hJFeJeciScIU2/8F8HTRC5NuNSkK3mx/yqWoaBYwH7fuRMPDnfi
 LMACTMMM9xk2uztH9FZ6UQF1kuvelw+z0WVHQdidu4UkNFI/oYAP153qCTD780AF+AWk
 vL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dd6UT/sJQhVQoU/A5etTLisFLDqNewMQfmLXJ1m4wic=;
 b=ld+pzsmy6YWFwBKJb/zPRFQFsoT0EoibOb9pLgBZaS5jfSXvqf7Tq2PXy5HV7za+sz
 bOISi7OytBR2+YW2a11q6u4lEBQc0mMopeR4yX1ZLyJSjdCtSygOMOkO3Hr89kj3WcnM
 obZW8K03pfchoTIw2MNJBETwTlLmYF9ZQnHxpWqZyYd1KEGoiRFm3yTr8y90p04QEOk/
 ycvZX8kVmYtPr7g63b57EHp+Q2pb0bK9MO3KyZcomr4TGio3vDd8uUrGc4emUcBCpRo6
 mmdCfFpgPFdxSo7cZgOJWu8bdpmjg5BPJNCx+WkNX+QtycDGlywtbqfAx/rO8pqkdq3j
 j7Sg==
X-Gm-Message-State: AOAM53083E47NjQT6vGnmTfQg6S8vynml0GCMPAQ3AL6E18rattmJtLc
 6NeLXPcJ/roWbxcTZe/wBkOI4Q==
X-Google-Smtp-Source: ABdhPJxkvN7dJjRD2U2SopzYNX3IGT1OtHqhN1PFrQ/WFa/RRJrWLRrywtP2L9q6dYWn4HggIccYWQ==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr4233875wrs.240.1602516866625; 
 Mon, 12 Oct 2020 08:34:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/display/bcm2835_fb.c: Initialize all fields of struct
Date: Mon, 12 Oct 2020 16:33:37 +0100
Message-Id: <20201012153408.9747-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In bcm2835_fb_mbox_push(), Coverity complains (CID 1429989) that we
pass a pointer to a local struct to another function without
initializing all its fields.  This is a real bug:
bcm2835_fb_reconfigure() copies the whole of our new BCM2385FBConfig
struct into s->config, so any fields we don't initialize will corrupt
the state of the device.

Copy the two fields which we don't want to update (pixo and alpha)
from the existing config so we don't accidentally change them.

Fixes: cfb7ba983857e40e88
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not sure why this wasn't a visible bug -- alpha isn't used,
but if pixo changes from zero to non-zero we flip from
RGB to BGR...
---
 hw/display/bcm2835_fb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index c6263808a27..7c0e5eef2d5 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -282,6 +282,10 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
     newconf.base = s->vcram_base | (value & 0xc0000000);
     newconf.base += BCM2835_FB_OFFSET;
 
+    /* Copy fields which we don't want to change from the existing config */
+    newconf.pixo = s->config.pixo;
+    newconf.alpha = s->config.alpha;
+
     bcm2835_fb_validate_config(&newconf);
 
     pitch = bcm2835_fb_get_pitch(&newconf);
-- 
2.20.1


