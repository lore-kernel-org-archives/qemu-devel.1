Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27611208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewy2ofI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27611208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCpd-0001c8-By
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ0-0002hK-GX; Tue, 16 Jun 2020 10:18:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPz-0006kY-0B; Tue, 16 Jun 2020 10:18:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id n6so16067011otl.0;
 Tue, 16 Jun 2020 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E99qbF+LJ1aftYVGDxQKrqzQk4RtFRFY8oKglRjiv8Y=;
 b=ewy2ofI37a46bVvM2kL+9RY5vvIf7EDMBMlrcQCC2eSWpgTgob9xIBXtYuu2Lsszv/
 n+ISRKq4neXbVi1BG9zdGdlLRUkUieYWrBtRIhhoO3SJD886ilQVtbnqbLbaj/P2KjKe
 YXRqAB/n5v01O/kcw5uPgCvQ/AocrYrOcZVtidxKvQdRGJ0eeVVQTiOPXy3LFXkfYTtM
 tuLUi5yPodDpCDq8Rhd/ahuZ2yOpEGoR6Z7O25G+OigM+owaGXZDRFW37119s7WQ3TbH
 OBKe2rU9QmstPXlOp65LLkwPpZA8RgTDRh0IVOgHvZiTfTuGkUU4+vY6ype7KuVK0opH
 fiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=E99qbF+LJ1aftYVGDxQKrqzQk4RtFRFY8oKglRjiv8Y=;
 b=BQk0s8V+CkyKTQEEm3nnZlxhEi2KIqjbWLiNFwlOQ5aNLs08mUDVGKjoo/UX3sz3Oe
 Ito2hpQIjCbMj/d3b78A9a9T7EkF1cpFsNkS00pgTRvxN8iXfbGb3rD3K77Ss1gy3FFM
 Pg9kuX5qxywJgq7XesDmeUTEr3TRAxJLnsDXQdng8pCOERkt72nc+WL3CDW9ND4WXEyD
 12tj7QD8bJc8Ax5+LNBsvz8888yQ4nBHVynKMjrDr1iTqJnEgCpv+3FLw2EIdBrwZcMZ
 AnjcUcFG1yalb7WYEileo+tRz0zDn3aH6KGqh2Llp0SBRoEko9x6/LiI21xYMmMD+GyO
 V8kQ==
X-Gm-Message-State: AOAM530VEOSqThutRg+4NUJffLZPf7rr3+4mQoX1z1AfoLI1R70xWVSm
 Tc9fI9cQ8XbOhFSFvn4v0k+8bwdG
X-Google-Smtp-Source: ABdhPJzpBUsOqb2YGelkjbzuILfuLOkjDTvWUSI/P0QPVxFz64Z5j9nPULx/OACaIrNyD9rKxyKtVQ==
X-Received: by 2002:a9d:7458:: with SMTP id p24mr2341757otk.330.1592317105284; 
 Tue, 16 Jun 2020 07:18:25 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id k2sm3090455oib.10.2020.06.16.07.18.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:24 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/78] dp8393x: Don't reset Silicon Revision register
Date: Tue, 16 Jun 2020 09:15:08 -0500
Message-Id: <20200616141547.24664-40-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

The jazzsonic driver in Linux uses the Silicon Revision register value
to probe the chip. The driver fails unless the SR register contains 4.
Unfortunately, reading this register in QEMU usually returns 0 because
the s->regs[] array gets wiped after a software reset.

Fixes: bd8f1ebce4 ("net/dp8393x: fix hardware reset")
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 083e21bbdde7dbd326baf29d21f49fc3f5614496)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index aa7bd785f3..d33f21bd0b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -919,6 +919,7 @@ static void dp8393x_reset(DeviceState *dev)
     timer_del(s->watchdog);
 
     memset(s->regs, 0, sizeof(s->regs));
+    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux/mips */
     s->regs[SONIC_CR] = SONIC_CR_RST | SONIC_CR_STP | SONIC_CR_RXDIS;
     s->regs[SONIC_DCR] &= ~(SONIC_DCR_EXBUS | SONIC_DCR_LBR);
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_LB0 | SONIC_RCR_LB1 | SONIC_RCR_BRD | SONIC_RCR_RNT);
@@ -971,7 +972,6 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
-    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
 
     memory_region_init_ram(&s->prom, OBJECT(dev),
                            "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
-- 
2.17.1


