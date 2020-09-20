Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46CFC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF5020789
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcw1/4AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF5020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK3ep-0005GM-A5
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 14:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3be-0001ue-Vl; Sun, 20 Sep 2020 13:58:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bd-00030Z-F0; Sun, 20 Sep 2020 13:58:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id z4so10435019wrr.4;
 Sun, 20 Sep 2020 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dcCXq9EmDF/ND5OQIcbMSYGFUbh9qfqOjQv8VK2LW0A=;
 b=mcw1/4AUz+zjMfM9db6StlM88A312gpLsWvAoOOF83A5evn2GgHGmHQZI4w1ZV1kap
 tFFyzLN7EOCK5mCxRCf6Z04sEHTcNy7oveBJygH++ZMhBVH5T3WwGoUIRZERRAwUfJVz
 d1Wo+IZ9+dj4Eq+5JtPJlnkC7+v7JBKJC6DeTtc4sjNctWQ6hgSKe6R1noHwJUYCWrk3
 GDuXTlTYnpb9NFQa1uEHhRbOaHSmTYFCQ27tdr8eEfB/OXBOE8h5f+vs1A4kdRzdVp85
 T92/S1yZtCVFXl16WH1U6sqOcfPBiZQov9UvLWIrS25iuzKnZcu5Wc5TF44TGTPpa0bh
 NIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dcCXq9EmDF/ND5OQIcbMSYGFUbh9qfqOjQv8VK2LW0A=;
 b=IM0pOWzGVJ6VjFxCF62AYnnftc5DBXqoNOuBaifWurv58OAsnF+qjue7otoKH2waJo
 aNMWHfT9kS8OPQd/+LqZGe0ToiALoACRtwpMmH6ygbrYPBBMbczYK9+x0Lod+kt3x1Eh
 PGj+/eLgu5Qj8+EtwYEPbcyzcBGcuGTHu60OEToER4cFqmSUn/YfXXHznS4wcCBtVVkk
 nNzvDYLswA+TGX7ofbzQ6hhA4Pj3ctL7eU/qtZimhbvQ25bLDVo2w32r8/VqPmnTSgcB
 NHQwI1r/K1gFRjYnFgBN1xV89ZM5fq7dX3kRsTHl8YLtj8qjw910218O65oi95XAqIC0
 EbKw==
X-Gm-Message-State: AOAM533pbXl7GMjJQVpQFsvJnpf5XrBsrjIRcayguOiCPuHLMFbNs07z
 Ps9noMJsTi1apamRUnrvaTpyhoqGfOU=
X-Google-Smtp-Source: ABdhPJx8/sLmvqWLL3TJeO5YXXwImvYZb/pxaYZQTv+mQfMKrn0uPW/vUv4Vr14Vxp3D9NVeYI05UQ==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr32321632wrn.61.1600624711595; 
 Sun, 20 Sep 2020 10:58:31 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm15675781wme.12.2020.09.20.10.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 10:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
Date: Sun, 20 Sep 2020 19:58:21 +0200
Message-Id: <20200920175825.417680-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
References: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events for GPU and CPU IRQs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/intc/bcm2835_ic.c | 4 +++-
 hw/intc/trace-events | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 53ab8f58810..9000d995e81 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -18,6 +18,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #define GPU_IRQS 64
 #define ARM_IRQS 8
@@ -51,7 +52,6 @@ static void bcm2835_ic_update(BCM2835ICState *s)
     set = (s->gpu_irq_level & s->gpu_irq_enable)
         || (s->arm_irq_level & s->arm_irq_enable);
     qemu_set_irq(s->irq, set);
-
 }
 
 static void bcm2835_ic_set_gpu_irq(void *opaque, int irq, int level)
@@ -59,6 +59,7 @@ static void bcm2835_ic_set_gpu_irq(void *opaque, int irq, int level)
     BCM2835ICState *s = opaque;
 
     assert(irq >= 0 && irq < 64);
+    trace_bcm2835_ic_set_gpu_irq(irq, level);
     s->gpu_irq_level = deposit64(s->gpu_irq_level, irq, 1, level != 0);
     bcm2835_ic_update(s);
 }
@@ -68,6 +69,7 @@ static void bcm2835_ic_set_arm_irq(void *opaque, int irq, int level)
     BCM2835ICState *s = opaque;
 
     assert(irq >= 0 && irq < 8);
+    trace_bcm2835_ic_set_cpu_irq(irq, level);
     s->arm_irq_level = deposit32(s->arm_irq_level, irq, 1, level != 0);
     bcm2835_ic_update(s);
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 527c3f76cae..22782b3f089 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -199,3 +199,7 @@ nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg wri
 heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_set_irq(int num, int level) "set_irq: num=0x%02x level=%d"
+
+# bcm2835_ic.c
+bcm2835_ic_set_gpu_irq(int irq, int level) "GPU irq #%d level %d"
+bcm2835_ic_set_cpu_irq(int irq, int level) "CPU irq #%d level %d"
-- 
2.26.2


