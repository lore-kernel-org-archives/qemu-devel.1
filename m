Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D0A20936
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGUGsPqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D0A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVfw-0006sg-Iv
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVah-0008Eu-LB; Thu, 22 Oct 2020 04:04:55 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVae-0006vH-HI; Thu, 22 Oct 2020 04:04:55 -0400
Received: by mail-lj1-x241.google.com with SMTP id 23so937572ljv.7;
 Thu, 22 Oct 2020 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O+goKHHTPNQf+byU52c8msGIZZ/A616sN7JzkzNgsEM=;
 b=eGUGsPqXXOW4Dux81lCwXZwM1fRbvW6bynfQ5kBLRbJHDUxRfzQvNye053UtjvVy+x
 bbwOdBM52iqmOivy3wOk4U4Dw3OZgWP9z0AelSAH7oGP9DQSfwpze4lkjlO3df9CfaOD
 kLX3g8rgJ6B72Z8BZVY3oVuHMc69CKDuOXlQGFR7wvisFVhhKRUW5LjfIjmhryod+MTQ
 xKmABKlgp4y+S2AadW5H0uF4X2Raum2YIWX7FNmVaItIZ+dy4C1yXnchc/qAtelxVIH7
 u3UcVRJkkl9Yf5bc3FK8uDxANQF6DwEPxnelZ/QBWnywodqR7o6d67TQ6fGcLFskBzOe
 79iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O+goKHHTPNQf+byU52c8msGIZZ/A616sN7JzkzNgsEM=;
 b=N9VyUV5fHT6+ACGVPuil47l1yICMoMVY+Z1WB37dUtYBngvdB2WXzGHJC/xvbC9BrC
 wqiVxdJb4NIW8QTrcD/CeD0IJtq8HsrIUBCJH1LPK3jWigWKjCAW7nhHV+9I0ckqTIk3
 BDhdPenMuS5XRMtbfWYSH8+kcSPDcY5LV8AucqGbhXaR9chPWsS/fuP3XBUomnbUQFM+
 mv8nIfw/mTmqnnJem5HcAE6foIi82m6hr8StHRKLH7Ut1Kb4EJB+lXsVgZdX6HhF7eTo
 LP8ziB+w7od6b39wkzdrG1be+t7OEFxVsDgK4YURn1nCg1vAnP7U1v5HEYTVmRmpPxcy
 4C7A==
X-Gm-Message-State: AOAM532u6hosW67OSqmJuVALhO3Ot5BD8SaqpBLSINRWtyjexg68ZOWH
 Ww80xv3gHFLFaF/gf9zAIXk=
X-Google-Smtp-Source: ABdhPJy+S/GK9tFztX8WGZaPTddrWpZAV8oNJhrMbR7T5pS4yZHmxhB7jZU/TVw6DF2nf/iF7JG06w==
X-Received: by 2002:a2e:8702:: with SMTP id m2mr469768lji.21.1603353889363;
 Thu, 22 Oct 2020 01:04:49 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id l8sm143682lfk.203.2020.10.22.01.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 01:04:48 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v6 6/6] [RISCV_PM] Allow experimental J-ext to be turned on
Date: Thu, 22 Oct 2020 11:04:40 +0300
Message-Id: <20201022080440.10069-7-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201022080440.10069-1-space.monkey.delivers@gmail.com>
References: <20201022080440.10069-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1c00d9ea26..56633c14eb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -465,6 +465,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
         if (cpu->cfg.ext_j) {
             env->mmte |= PM_EXT_INITIAL;
+            target_misa |= RVJ;
         }
         if (cpu->cfg.ext_v) {
             target_misa |= RVV;
-- 
2.20.1


