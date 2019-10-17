Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C2FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D1F2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuGkR5zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D1F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6FI-0003mI-E7
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5id-00053N-LK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5ic-0000Pp-F8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5ic-0000PD-79
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so2535214wma.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KWHu+m1O+EERA4S9NNTm+FIYK5BZF9JX07P8U3F6Cyk=;
 b=iuGkR5zCFL4filGYWyr6lIL6j5aQJ/Bxt6aRGY5pOq+xT7IEWp8369nt/MTC1yiN7h
 AZi6Sl8AsceN6aONXZ2s9fXrqRLyDVvmkXD0/Qtck7e07xwjTSylbb87zArPWTsiakUv
 T8BGsgJ2ILhHgqC/MQSyveu3o/i3NZQem/3jU9SCgBaJRNC2mwNVISy37Vv1ZJ7OSrjH
 kX5bDe2FXD2QmhTIzTfxQQUBcqalUpdri0pTxo7VwNgPqFugSBm5HNelZAgJIoxPaLR0
 INMp3EZDvG7LDpUF4n+jG+lxAUGtnc5o4SzOz66wfiqAqyrXdWqoj0MXiVlahB31ohOm
 9t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KWHu+m1O+EERA4S9NNTm+FIYK5BZF9JX07P8U3F6Cyk=;
 b=S9O9YohQbHTKacbFGRyIn7VLAhAJREz971coMYn+AZF7bAmQGSfEh295JuFb8XFRAb
 1ZKqtXbycbOzs3HtFTokv4Ef4CsySSUMkotmWFj1o6xsw3mYA+Bm+Z2I8Smcj9/G+sx3
 +ExD8KHUiCr/f1/rROrWf/OJkUgkWawnDsw2aTGi4ep5EH1t+uzcbWSpdcHUhUVWoQqr
 8eK08UDQyzPDmmtqcuP563/uwCto4n6hNEixlyq+UeThjGvTvLiK86YLDOyu3BdaeWKN
 VOQhoYIvLFcUR+HdxhRSj9B+T+V2JuYRF3njaFuYXu5ju0g7mfaR7uYBAyiDPf8wVjre
 NUzQ==
X-Gm-Message-State: APjAAAU/3Ncgoa4pkRzN+owFGoyYAhmgdPYcoQJh+ZjZcEqT02dMxJ+2
 lJQypj/X0U1MDTinJL5WihIxgM00d3+m9w==
X-Google-Smtp-Source: APXvYqyO68O8sT8SfsWQwNqGoXsIoG9yk6awNeiYKx/xMQU4OcRBgfNCTH6ZtIqi3UJRicKuI28peQ==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr2959378wmb.95.1571318488967; 
 Thu, 17 Oct 2019 06:21:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e9sm11543164wme.3.2019.10.17.06.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:21:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/dma/xilinx_axidma.c: Switch to transaction-based
 ptimer API
Date: Thu, 17 Oct 2019 14:21:22 +0100
Message-Id: <20191017132122.4402-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132122.4402-1-peter.maydell@linaro.org>
References: <20191017132122.4402-1-peter.maydell@linaro.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the xilinx_axidma code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xilinx_axidma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index e035d1f7504..fb3a978e282 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -31,7 +31,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #include "hw/stream.h"
@@ -104,7 +103,6 @@ enum {
 };
 
 struct Stream {
-    QEMUBH *bh;
     ptimer_state *ptimer;
     qemu_irq irq;
 
@@ -242,6 +240,7 @@ static void stream_complete(struct Stream *s)
     unsigned int comp_delay;
 
     /* Start the delayed timer.  */
+    ptimer_transaction_begin(s->ptimer);
     comp_delay = s->regs[R_DMACR] >> 24;
     if (comp_delay) {
         ptimer_stop(s->ptimer);
@@ -255,6 +254,7 @@ static void stream_complete(struct Stream *s)
         s->regs[R_DMASR] |= DMASR_IOC_IRQ;
         stream_reload_complete_cnt(s);
     }
+    ptimer_transaction_commit(s->ptimer);
 }
 
 static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
@@ -551,9 +551,10 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         struct Stream *st = &s->streams[i];
 
         st->nr = i;
-        st->bh = qemu_bh_new(timer_hit, st);
-        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
+        st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(st->ptimer);
         ptimer_set_freq(st->ptimer, s->freqhz);
+        ptimer_transaction_commit(st->ptimer);
     }
     return;
 
-- 
2.20.1


