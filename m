Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BCBC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68396206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogiOM/vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68396206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwuY-0006dI-I9
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLS-00043y-0L; Thu, 03 Sep 2020 17:00:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLM-0007fN-FL; Thu, 03 Sep 2020 17:00:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id g96so3975221otb.12;
 Thu, 03 Sep 2020 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uQPncV/jLImjoch26Nuy7gV8hNnslJV64x5ayj1AopA=;
 b=ogiOM/vcOw+4h5KxOuXCl3M24eZzMDtvLTnvk240oGhaurTjvHHY0jXrg6Gq1Pj+x9
 xZhKIpHO4Fq6at1l6n/LUcFijBx+DSFdbzvsv/WRrv4Kt2LO8C6lb4SRXhTpH6qukVoY
 HZxVOnpSTANhsBZ3My0lqAafSR8GF1IydyhRbBaKbuM4JcCpwA+SUcPBIQFkZIoTdAiM
 2xgZCvY+QNSYs3lVxJHGpQsKT5XtKgBsNLXyABVeD4ql2TWnbGsZp0YrdO8Sg1ZaP34b
 08tsMDBz/caYx3zed9sKSzi8wIlhHQHNQR9+U5NmfKrjQklA1OsGQW53cLYQej06myfE
 uIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uQPncV/jLImjoch26Nuy7gV8hNnslJV64x5ayj1AopA=;
 b=k2X1+JB2ZuIIhjM9AvtwlZpJJVp1o1zW708eN5ZoHMW+ZzxbZEUyz69joLVtTxxkC5
 UMXVsjbVfXoz1G09IBA8uArchdr9zx1aGvqweKNpCCEz1RrN26WVU0R2I+WJeHpESYO2
 ixF7KTzDLKY5rMCNCdsOamCeKHEWOCgbuxfXDHW1YYNM8QDNP6StMYjEp0JXGoDjSm2V
 KK/4netHMzjIaheNsIdQpyhNdTF9er7VbcSJKTBHoghhzuSMqp4UCTw8kqJsLWJMd6gm
 ODdIU7HLtVOGPf7dBAIQ2iGHRTqIjKPpbEnkkci8+LmAc2xKMQkvcE7WBoZR+R4UDebo
 L0hQ==
X-Gm-Message-State: AOAM530utpCO196olzRXfhYRM+URsoSUPtIfEVsEIH/yrDDcwEARUpIp
 gD7Gp1yqU5aLykHdQ3n/412yM2puwmc=
X-Google-Smtp-Source: ABdhPJzJlnG9NKW9NqggbCOnxGkTeY2euLyTy91CRCKuT6nVtP1neWk+P/hPjGtSFob1HzF1P+ZtTQ==
X-Received: by 2002:a9d:6f86:: with SMTP id h6mr3113277otq.285.1599166826509; 
 Thu, 03 Sep 2020 14:00:26 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r33sm828425ooi.48.2020.09.03.14.00.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:26 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/77] hw/audio/gus: Fix registers 32-bit access
Date: Thu,  3 Sep 2020 15:58:54 -0500
Message-Id: <20200903205935.27832-37-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Allan Peramaki <aperamak@pp1.inet.fi>, qemu-stable@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Allan Peramaki <aperamak@pp1.inet.fi>

Fix audio on software that accesses DRAM above 64k via register
peek/poke and some cases when more than 16 voices are used.

Cc: qemu-stable@nongnu.org
Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
Tested-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200618103623.6031-1-philmd@redhat.com
Message-Id: <20200615201757.16868-1-aperamak@pp1.inet.fi>
[PMD: Removed unrelated style changes]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 586803455b3fa44d949ecd42cd9c87e5a6287aef)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/audio/gusemu_hal.c   | 2 +-
 hw/audio/gusemu_mixer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index ae40ca341c..5b9a14ee21 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -32,7 +32,7 @@
 
 #define GUSregb(position) (*            (gusptr+(position)))
 #define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))
 
 /* size given in bytes */
 unsigned int gus_read(GUSEmuState * state, int port, int size)
diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 00b9861b92..56300de77e 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -28,7 +28,7 @@
 
 #define GUSregb(position)  (*            (gusptr+(position)))
 #define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
-#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
+#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
 
 #define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
 
-- 
2.17.1


