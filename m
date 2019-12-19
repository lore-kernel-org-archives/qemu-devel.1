Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9008C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730802465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzQc9jaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730802465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii11B-0008NO-2F
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0ti-00077z-5Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0th-00084p-16
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tg-00080F-Pl; Thu, 19 Dec 2019 13:51:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so7044400wrn.7;
 Thu, 19 Dec 2019 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tW8l9xeWxnpc6CHLbxLBaneaw92aGrVjK1sQT+wYwbY=;
 b=AzQc9jaV4e6K0Ae50LqzRDyN7zrg+wj6NVaot8/qY7K0pLOCo5Rtp6tqvjqbpKDTm2
 fTMIBzM4FVzuxpO4hMGutBUi6Xtqsf5SCwaMtXnojiuWtGe1SQlPnN5T1M4DSmy02EVH
 +A4hMFZkYsWYA3Vf24mB1dt8CmzD0Ea+fwKGbipdPQt5xkPdzWQ2/uUT3lWwqQolPJ0l
 d67XERN8WOFO2PaAn0jElM+Uc/fSmnkniVPKv4hQTRIS2j7Aw8kw0N3Rd94FECsCwU+3
 FDEUY0zCisGQxzl027f9YOjQAWIOPw26U17WPwIg9ube9s8fXcC4Z65PdCgcDFI73bUi
 ymJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tW8l9xeWxnpc6CHLbxLBaneaw92aGrVjK1sQT+wYwbY=;
 b=jExws7hmiQOIEbiG9DqZohrad8oW7iCu5GddJHa5sJLtDf9KRV0aZvZU0MologoHml
 xSgm7R8BConv1XVLDF4yFqJD/OalcRqKXLLrCkTLJsUArWRT9HKaQ4T/Lm3bqnB27aE1
 xMpRkWomCHqLP4KbtPi0uEzy5RBlW++Vi/DHghfYDPaDHFLcG7tTRFcwnvPuhtablHYM
 iVMSs6hyX1AFq8fEUftxOKQg8wDjezm8CbmaGeJyzOQVGrXoIxVMjBu3SxN2bPyNaeIp
 qc0qtUFN0tgH1q4OVTJcRAj7NJlU+BeohIU/O/rC/BVnmjEXhb/F+P65S4g6+YjM9IWf
 qTgQ==
X-Gm-Message-State: APjAAAUecWFvhAd9saLav/LdBq4e6WIvzjr6o+nrhCNOSTy0aYoEgcEp
 tidnso+5czSMmyKLbEUUmF/LLeJt
X-Google-Smtp-Source: APXvYqzS0NVHipIhcYaLjA7fvBbKiu9b6OCALSCEevmOk+oHbcvaEqyp9DFVU0bR9Gict0k9lljKnQ==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr11401748wrx.288.1576781499364; 
 Thu, 19 Dec 2019 10:51:39 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 08/13] hw/timer/allwinner: Add a timer_count field
Date: Thu, 19 Dec 2019 19:51:22 +0100
Message-Id: <20191219185127.24388-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to support controllers with less than 6 timers, we
need a field to be able to iterate over the different count.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/allwinner-a10-pit.h |  1 +
 hw/timer/allwinner-a10-pit.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index e0f864a954..8c64c33f01 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -24,6 +24,7 @@ struct AwA10PITState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
+    size_t timer_count;
     AwA10TimerContext timer[AW_PIT_TIMER_MAX];
     MemoryRegion iomem;
     uint32_t clk_freq[4];
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ea92fdda32..3f47588703 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -58,7 +58,7 @@ static void a10_pit_update_irq(AwA10PITState *s)
 {
     int i;
 
-    for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
+    for (i = 0; i < s->timer_count; i++) {
         qemu_set_irq(s->timer[i].irq,
                      !!(s->irq_status & s->irq_enable & (1 << i)));
     }
@@ -271,7 +271,7 @@ static void a10_pit_reset(DeviceState *dev)
     s->irq_status = 0;
     a10_pit_update_irq(s);
 
-    for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
+    for (i = 0; i < s->timer_count; i++) {
         s->timer[i].control = AW_A10_PIT_DEFAULT_CLOCK;
         s->timer[i].interval = 0;
         s->timer[i].count = 0;
@@ -309,14 +309,16 @@ static void a10_pit_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     uint8_t i;
 
-    for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
+    s->timer_count = AW_A10_PIT_TIMER_NR;
+
+    for (i = 0; i < s->timer_count; i++) {
         sysbus_init_irq(sbd, &s->timer[i].irq);
     }
     memory_region_init_io(&s->iomem, OBJECT(s), &a10_pit_ops, s,
                           TYPE_AW_A10_PIT, 0x400);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
+    for (i = 0; i < s->timer_count; i++) {
         AwA10TimerContext *tc = &s->timer[i];
 
         tc->container = s;
-- 
2.21.0


