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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC81C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144F32073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOmR3ADU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144F32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0Ed-0003Tp-1p
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Ak-0006Rj-Mz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Aj-0001yh-Px
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:18 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jK0Aj-0001wd-It; Thu, 02 Apr 2020 09:46:17 -0400
Received: by mail-lj1-x242.google.com with SMTP id 19so3265684ljj.7;
 Thu, 02 Apr 2020 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aG0858uXhmYhe8n44TDMUkVLiuz53/ZFtxLaB/tbPg4=;
 b=IOmR3ADUmr+8jzCAe+DYZi9aEQv6+t+KFVnhymtLxnC4mLXagSxddBaq/6EC/nY7l3
 KhHifSstFQQLQfLcsCJaQH3eXQf/yvnGa3fHb0UkzPb84QEt+2+QrRasE2fRphgmN63r
 QDDUHKbP77/j85MWog0GY0WDxTv5yNXlct3z7sNsjW2TfcPc3a0VOXYTWF9WfJxmEbnm
 u20QPmjOHDtswvaMX0hDuKksuk8md0P3Fmoxi2f2qJaIODMscwPn1SqX8ECd7VWQWWrc
 s50H5/ZL76tLt/jNTBWtnOgUabPfPKn7UeiZs1MMmXakCjePgKJ6hrahfx6M+L11neAK
 srmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aG0858uXhmYhe8n44TDMUkVLiuz53/ZFtxLaB/tbPg4=;
 b=V3H5lHzCp/+l58cORYVIXudbPY74G1kqiA0kR4+duj+ZI6LSDx6JnIrUig9/7nFCc9
 CClVsS1aEO7ouMFd//BD0IShWF42UwMaDJo6kwFeyVqNxkJoFBPxTMlVxL3HYKEWtMDA
 wMs7bxXa1fZOLYHuTOS9t869sHPd+a09Ql+JwUuz5ZkgALfhRFl381ADRhkfEs1ZEs7N
 Tpiy+xykpiC3llKzmqjnSnBP3DXQwIyaEyoOr2rufQISZnLN+EOD4KJRLS07ELaqAIBC
 dFNO3VynGTFc8cD5JHUjC1+Ll8fliU/aQ8tIOXCGG9IoWzeem9GnpXMHtqx3tOXGpEqG
 sZCw==
X-Gm-Message-State: AGi0PuahXqYe7Y1g86KrsFQE6zDaai5qjLBroPJ+niljAjzpB8ST39gB
 tPvaa/nIBUL0vOalsmpbTqHeUr7rWqDy5A==
X-Google-Smtp-Source: APiQypIql4k96jW+Hnwpu7NGBalRh784Q/LWaGXy+aU7KwRDQubChWnid0/H59X9cY48lPsU+wSFVw==
X-Received: by 2002:a2e:8693:: with SMTP id l19mr2226293lji.132.1585835176058; 
 Thu, 02 Apr 2020 06:46:16 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q10sm3858710lfa.29.2020.04.02.06.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:46:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/5] dma/xlnx-zdma: Clear DMA_DONE when halting
Date: Thu,  2 Apr 2020 15:47:19 +0200
Message-Id: <20200402134721.27863-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402134721.27863-1-edgar.iglesias@gmail.com>
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

Clear DMA_DONE when halting the DMA channel.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xlnx-zdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 6a4699757a..dd893bc420 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -520,6 +520,7 @@ static void zdma_process_descr(XlnxZDMA *s)
     if (src_cmd == CMD_HALT) {
         zdma_set_state(s, PAUSED);
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, DMA_PAUSE, 1);
+        ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, DMA_DONE, false);
         zdma_ch_imr_update_irq(s);
         return;
     }
-- 
2.20.1


