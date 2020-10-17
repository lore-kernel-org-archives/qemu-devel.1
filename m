Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC7C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCAB20657
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/2WKzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCAB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn9w-0007HO-Et
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpG-00037K-VP
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpE-0003qO-MF
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:04:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id n6so6532057wrm.13
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r9DIlhS/zwAECFf9vZAtbGMbBBzzJfBM2jPK1vmGZTU=;
 b=PQ/2WKzi2E0RbWQLOhNCp3J7+V7Gb4+mNhk/HK3t5XL9mpHIEBbQCR7UH7CgGfd2Bp
 EZUhCsIVUNY2ofVooNeduCrPTKxwQs0/QJtH9Urf5Rm46IfJulnhWwle4eWu1Faofk+i
 OfxsnirTQV8bOJPdsgjVAWckPEgzcAE8MOPbcjrdosniAIKeMrwz2K3m7tY5D1vex7pL
 aQ4d8qFaxxlJZQAyEKpS6klWmqayrHPrs3fduSSDRZ/7pWFwN2284B0A3bCrGoQlMzWC
 bYdYN/MkzcSjfZniiH558W1rs4eEHiHlT7QdKXMopK0WHC8NbDyKusBmkOjpwdBqNzz5
 MIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=r9DIlhS/zwAECFf9vZAtbGMbBBzzJfBM2jPK1vmGZTU=;
 b=GvAjq2HrYhrmOXsU+bKp1huBi1HVuc1fNja5dB0US7BBgjXhmZQP6/qZJ9tNvEsiNh
 nf3/HWsBY1G8aTZQdqhEWn53GYxGUfCJsQ08I+u0D8x0F8aYiCRSAGAub26I9m7Rn07l
 XDnsk4d2xb7bFzx/GuLXTmywTlAklzr6Mj+654qTRlBvgqtU/Pmz7UJAaG8N3Mz9dE+Z
 i6laqQ7aM6W3LB10WZpYDhkANhqGzSH0BCUKY+fc+oKTcr3OfN9s+3yhyZw57c6DOMbL
 CDqKf27S7D2HHHQIhF3mL5x8p5iQLcD2S4/6Uris8/d+rWGBRJA5baPKmFLUwEgiGxyn
 0DZw==
X-Gm-Message-State: AOAM533qE69FxtiKefBq8PKabMfu5Hd3l/Njx+ueBl7K2moSB+lFd8Nq
 Hf3YVqXqjjZLzr0+rrzfymWk47jPfbs=
X-Google-Smtp-Source: ABdhPJyA6DQC9L5VQ0mmac/gAzSetbtYjAFC97JTI3WDSlzcYQ06mrWC3sMTCgYK1XNbj6mw18h+YA==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr10897534wrl.124.1602943487274; 
 Sat, 17 Oct 2020 07:04:47 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id x3sm7544780wmi.45.2020.10.17.07.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:04:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/44] hw/mips/cps: Expose input clock and connect it to CPU
 cores
Date: Sat, 17 Oct 2020 16:02:25 +0200
Message-Id: <20201017140243.1078718-27-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose a qdev input clock named 'clk-in', and connect it to each
core to forward-propagate the clock.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-18-f4bug@amsat.org>
---
 include/hw/mips/cps.h | 2 ++
 hw/mips/cps.c         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 9e35a881366..859a8d4a674 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -21,6 +21,7 @@
 #define MIPS_CPS_H
 
 #include "hw/sysbus.h"
+#include "hw/clock.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
@@ -43,6 +44,7 @@ struct MIPSCPSState {
     MIPSGICState gic;
     MIPSCPCState cpc;
     MIPSITUState itu;
+    Clock *clock;
 };
 
 qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 23c0f87e41a..af7b58c4bdd 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/mips/cpudevs.h"
 #include "sysemu/kvm.h"
@@ -38,6 +39,7 @@ static void mips_cps_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MIPSCPSState *s = MIPS_CPS(obj);
 
+    s->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, NULL);
     /*
      * Cover entire address space as there do not seem to be any
      * constraints for the base address of CPC and GIC.
@@ -80,6 +82,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                                       errp)) {
             return;
         }
+        /* All cores use the same clock tree */
+        qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
         if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
             return;
-- 
2.26.2


