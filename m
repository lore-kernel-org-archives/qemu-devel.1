Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB65C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B9020721
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 10:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RttYHTIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B9020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVBob-0002id-Ak
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 06:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVBnY-0001kG-E2
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:24:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:33017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jVBnX-00076R-0g
 for qemu-devel@nongnu.org; Sun, 03 May 2020 06:24:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id x77so4072857pfc.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jfwiI8//wmy3ik49uBy2rjnF1vTWGg8mq8vj0CK4ofw=;
 b=RttYHTIhvZo/D26CBwySPgcn7G8ibBnGNBAwnhx/ypIcXAbp8/crplIxiGfWhHPBD8
 O+kSM1uu7X0cXy2UqVeWTwNVHqpQ7j4xaDmuSMcy8LbWmRRLsrt4/H0pPLAcS/cTbGWG
 oJ4qlPgd7A/3+Mw41bRqAy8R4YPTCpPd1bq4fnXymmgM+nR4Sc4rHzsfFRlfoQZdWEG+
 vvZr3Oqg5KmEO2Q9Kx24GppXSx2kBYK397iAXWFLM+WmYgJFrMxKZU9BbS8Qv9tfXhwY
 HnH8MCV6beByIQIYuelYDXpRHrh/7RwW0hxGTXjjUwgXnLXki+ItAlAHWMLtWi3zV/ia
 2T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jfwiI8//wmy3ik49uBy2rjnF1vTWGg8mq8vj0CK4ofw=;
 b=r12cK27EBWUrCW0eanWmHd6/RX1d8KTGzQ6NAgqO5Vm02Cf2mzWZx1Rrm4hXZAOMF0
 CBUcaWVXPwqz9u8IAYORJ+jMevQrd+se5Wo4MTZ6RXUgoh2pcxiyriZVXkqdXvTog6C/
 B+BU8AvcRrn/JUtqNS1GWJnPG+YMTWuF0ooyzdImpnMiSO6HHvFY9kTNNTytxhIwfXaq
 o92sWt21+yCXEIfQPQpT3R0/XX46z5wcUxnqdqmCfQNNe+RP08wZZRPHI+scBOLKREJS
 w2J9pj6WFIa94VoUjRd1XGfaTf0lwTboiov86aPhCqZjduyrJtu73vHObUQv3DORMsL5
 Q2yg==
X-Gm-Message-State: AGi0PuYMIwJBXu4zPoW4LFw4QeFssber3uouqwemh4NEtt+y+7x0HOeW
 OpQxKO7W4HGvb2CqxEgYiVo=
X-Google-Smtp-Source: APiQypLGQT02ho06oeV1+twps5Giu+0OgK9nQUiYgUt1UsfSVAAYCfY6+61FrWjL9WVDH91Wog7pRQ==
X-Received: by 2002:a62:3857:: with SMTP id f84mr13246113pfa.56.1588501473618; 
 Sun, 03 May 2020 03:24:33 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a12sm6173654pfr.28.2020.05.03.03.24.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2020 03:24:33 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V3 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
Date: Sun,  3 May 2020 18:20:17 +0800
Message-Id: <1588501221-1205-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x432.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
IP3 delivery as well, because Loongson-3 based machine use both IRQ2
(CPU's IP2) and IRQ3 (CPU's IP3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/mips_int.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 796730b..982ce34 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -48,14 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
     if (level) {
         env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
 
-        if (kvm_enabled() && irq == 2) {
+        if (kvm_enabled() && (irq == 2 || irq == 3)) {
             kvm_mips_set_interrupt(cpu, irq, level);
         }
 
     } else {
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
 
-        if (kvm_enabled() && irq == 2) {
+        if (kvm_enabled() && (irq == 2 || irq == 3)) {
             kvm_mips_set_interrupt(cpu, irq, level);
         }
     }
-- 
2.7.0


