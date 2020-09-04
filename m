Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFEC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BE2206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BE2206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB3V-0007di-TH
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2P-0006Kl-R9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2O-0006b4-3F
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:53 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Feofc5LqNgG0TbNn5kBJFQ-1; Fri, 04 Sep 2020 08:41:50 -0400
X-MC-Unique: Feofc5LqNgG0TbNn5kBJFQ-1
Received: by mail-wr1-f72.google.com with SMTP id g6so2291646wrv.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vI7vDBHGjLnbO6/DwFRox42IeAyuzSp/xvHpN9rz7no=;
 b=FGNkqHGhTwNCmksMN04TGkePxDMeLmGHdg8jloC/10v+Gi5uMlmG2afm4t6vCQqQR4
 EjhFAtelPPZsAaREW7AvieYECWS5oeaA+6jp4mhdGDzKn4WCoV64dBs7MrPuXm3UkFMn
 EmGWDJ/FrKw/ynmqvFQix3vz4v0cWTQYvDhTh+sk/Jf/vg6tNRsLjbcTuHuiuVX/oZ3L
 +qDNzUHN0qcnGf1XFTJyjy92flCZjvzS6ExGzwnEuQW3T8QSLx+ISK0nwJmpF/M8N7jO
 z1f6irgzWp48zO87Toqd4njX9CNpeRGe1qWa48xEgyuOq2AYZH/l6cgSfXoRsID1XxxY
 /m/A==
X-Gm-Message-State: AOAM532oV3bj3ApEjoQbXTA/Vy1d9nuJk63InMzi0ek0YCkG6z08bsfc
 6r+JbD4hO3WcVTwwaUN57Hf0+I8QA9xJz8J1+KkXRmHZ4zc/XCYzGyNvvGHeQVwKKxN/rdfV1W1
 5Ir8YFX1qylDQPmo=
X-Received: by 2002:adf:f149:: with SMTP id y9mr7231689wro.93.1599223308696;
 Fri, 04 Sep 2020 05:41:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr2Oql+aA4tcJvUwjQLKvdfqF5/OyAsHprOOCST9QcoK61j4ErACC69/gxHO9HQERNTNQB3w==
X-Received: by 2002:adf:f149:: with SMTP id y9mr7231675wro.93.1599223308554;
 Fri, 04 Sep 2020 05:41:48 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id d18sm11184478wrm.10.2020.09.04.05.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:41:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] block/nvme: Pair doorbell registers
Date: Fri,  4 Sep 2020 14:41:30 +0200
Message-Id: <20200904124130.583838-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904124130.583838-1-philmd@redhat.com>
References: <20200904124130.583838-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For each queue doorbell registers are paired as:
- Submission Queue Tail Doorbell
- Completion Queue Head Doorbell

Reflect that in the NVMeRegs structure, and adapt
nvme_create_queue_pair() accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index a216cc407f6..f4f27b6da7d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -84,7 +84,10 @@ typedef struct {
 /* Memory mapped registers */
 typedef volatile struct {
     NvmeBar ctrl;
-    uint32_t doorbells[];
+    struct {
+        uint32_t sq_tail;
+        uint32_t cq_head;
+    } doorbells[];
 } NVMeRegs;
 
 #define INDEX_ADMIN     0
@@ -244,14 +247,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
         error_propagate(errp, local_err);
         goto fail;
     }
-    q->sq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale];
+    q->sq.doorbell = &s->regs->doorbells[idx * s->doorbell_scale].sq_tail;
 
     nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
     }
-    q->cq.doorbell = &s->regs->doorbells[(idx * 2 + 1) * s->doorbell_scale];
+    q->cq.doorbell = &s->regs->doorbells[idx * s->doorbell_scale].cq_head;
 
     return q;
 fail:
-- 
2.26.2


