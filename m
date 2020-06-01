Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E2BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60302077D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCGjytDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60302077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjTL-0006Sb-7s
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOc-0007vB-9q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOZ-0007m0-L2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j10so11252062wrw.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sHSdc0omkhqpxjCauytiNdW8vYCwQDAfVEOw9sLViU4=;
 b=VCGjytDFUd6wPDJwvbAH36a10LWO7guhj1HKmoTs8f5NbTYM8TTc7ZZVLnCFwDHga3
 /kWon1hYWhMriLnnLvQYFcKPDlN1ug/W7NB7Ut4GEpXAPDL2m/xcO3bnQb3mzHQDKchg
 dmW6i3fiB0UTxnHWHBPcgw4EcTjwY02HUTPoDpuvvfegGCfVS7yf9ogSWcxZE7Nu8tFq
 r5DhFZm3MT7RSCR2JzusMAKj9qzBo733mNIZMqvwrGWAeqUB9FrTQt/kvEcxrTYvfvhI
 zvvGW86qp5sg/KiPFOKNBG8Y27myQHbfE6rTWa2ObDNtdBIP9UrGyjkU5bm34arrYPoB
 3c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sHSdc0omkhqpxjCauytiNdW8vYCwQDAfVEOw9sLViU4=;
 b=Ly4+/59cMqYN6XcGvgg+Lms0jUcmAgqIML2oX3IAGb2Xg7s/+XbKHOJLt+CtRVyt6G
 Ln7BUbN4xla+fUCV3rl8i6Ixf9fQqjd/oxgqv9E2gD9chiJfsBdrudXAZsQMabxryB7v
 AlfHEAn40Xt0rXYiPvZJoeaajdrsyzk8U+bLSiafcULZhnnSoZMLiobYm0ECG3Wxtne/
 rdTmCyHjW4UqJ9fy03OavyfRm/W8P0lmkfK9LT8oTwhTfe+gwUx8RulnMhXyyjbPAR5k
 gMt6zNeSd6rJbH6v+bMynvbmJvlDlILx2E3na3jRt2ixUDeN1LPgVrbsNu6seo1bigT7
 f6MA==
X-Gm-Message-State: AOAM530dfaspbj1pIIqRhj7Ub6AKNqNwiiHQwX8WksgvfmlttegAPOo6
 zdTBGVl2G6rA1ONK0bLe6XGrln0/UtE=
X-Google-Smtp-Source: ABdhPJw9FSeeA705vA8g4+eCmPdd/aIDeQm/77McHNqVRm70+8Qmn9oC6KcBkJgJ75UkmFhKVsoV0A==
X-Received: by 2002:adf:e4d1:: with SMTP id v17mr6524836wrm.224.1591013902112; 
 Mon, 01 Jun 2020 05:18:22 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y185sm12332136wmy.11.2020.06.01.05.18.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:18:21 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] hw/mips: Add CPU IRQ3 delivery for KVM
Date: Mon,  1 Jun 2020 14:18:15 +0200
Message-Id: <1591013898-23391-4-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
IP3 delivery as well, because Loongson-3 based machine use both IRQ2
(CPU's IP2) and IRQ3 (CPU's IP3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1588501221-1205-4-git-send-email-chenhc@lemote.com>
---
 hw/mips/mips_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 4a1bf84..0f9c6f0 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -51,7 +51,7 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
     }
 
-    if (kvm_enabled() && irq == 2) {
+    if (kvm_enabled() && (irq == 2 || irq == 3)) {
         kvm_mips_set_interrupt(cpu, irq, level);
     }
 
-- 
2.7.4


