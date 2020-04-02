Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69AEC2D0F3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960832072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjCme009"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960832072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0CN-00088v-IW
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Aj-0006Pq-IY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Ai-0001w1-GH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:17 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jK0Ai-0001sT-8t; Thu, 02 Apr 2020 09:46:16 -0400
Received: by mail-lj1-x244.google.com with SMTP id g27so3245295ljn.10;
 Thu, 02 Apr 2020 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mv581YRzXI92+CyIbMqqG1wv/ClfMBsDNk55giNrpKw=;
 b=WjCme0091l9eipzU1azBJUlULpVLxN0T8Wwtf/gbFRx29p7sqLQDK8s9lh4m7YLeYA
 ElwBUaxaAinUDhd2OaKxmvhLqXygTd4Ky6mTdBx7sw5nX5NKXrvrI9KuuM7vDeZG88uH
 3cUIFm1AWeX0ssqOGN4Ftl7cAKikWYyZYXwXGpghcPe+dZZm1Cfj3z8maHf8VDCtUeKn
 hqcjLRHlfoz9YkHvxHrHa6S/wCNBBFDanVkCWKSMKfhFRP2zSCSY4tQ6iBb1bbsSXv1J
 efRbjSL0ruloKiBfqkIzStHk2uJOR/EdNlDkdkTNaIHX9QrigIuctJQUHUMnoAuoDM0d
 w0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mv581YRzXI92+CyIbMqqG1wv/ClfMBsDNk55giNrpKw=;
 b=IuDbB3DHtaBaea6w2IOC0ybRzbai5lqSJ6/hQAiPLR5c/K2QvVJlOQOPmForQFfSDS
 30Lsg6wmVZ/GockO9kzoWDSBf5QIIg651Tx5jDvq/XRWPeWQ4TyfWm7tMjRzTxt9/vAJ
 Gkh6a5+ngS4aFnDcFGDyR01BTvSJthqnYGQxGNde1uwVBRRhd8bvRtKqGedOGAQP03G1
 WwXsAslLuG02FEYFH5mooIhL5xCqtC3DwvqXaPDhSUnC4SZkJ9l6IPhSaTT444ENL29a
 259XSjQadNnUDvnKugbCWAjO+5P7/dM4JBhhANWr6ZSK7fRqLd8xnvP8wCwZq9+qHcS7
 RK/g==
X-Gm-Message-State: AGi0PuY5jiIXsveOYJTxksvOvph6TPL+FUzP+gv6qIHrp5ak5cU9392c
 ozij/Z5wgryjTImIhbdgh08AOEIVJ6vkAQ==
X-Google-Smtp-Source: APiQypJfcXUQUmntVUMz9u11hXHyIIRzlXMGPjmHRCHfNZVYTw2Lj6cLu/BkV5UQFPWhEx4prGCBuA==
X-Received: by 2002:a2e:6e0f:: with SMTP id j15mr1932963ljc.230.1585835174651; 
 Thu, 02 Apr 2020 06:46:14 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id g12sm3612416lfb.66.2020.04.02.06.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:46:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/5] dma/xlnx-zdma: Populate DBG0.CMN_BUF_FREE
Date: Thu,  2 Apr 2020 15:47:18 +0200
Message-Id: <20200402134721.27863-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402134721.27863-1-edgar.iglesias@gmail.com>
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Populate DBG0.CMN_BUF_FREE so that SW can see some free space.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xlnx-zdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index a6c5b2304a..6a4699757a 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -680,6 +680,12 @@ static RegisterAccessInfo zdma_regs_info[] = {
     },{ .name = "ZDMA_CH_DBG0",  .addr = A_ZDMA_CH_DBG0,
         .rsvd = 0xfffffe00,
         .ro = 0x1ff,
+
+        /*
+         * There's SW out there that will check the debug regs for free space.
+         * Claim that we always have 0x100 free.
+         */
+        .reset = 0x100
     },{ .name = "ZDMA_CH_DBG1",  .addr = A_ZDMA_CH_DBG1,
         .rsvd = 0xfffffe00,
         .ro = 0x1ff,
-- 
2.20.1


