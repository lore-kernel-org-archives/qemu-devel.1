Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1057AC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67F8206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmC0xxSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67F8206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOBF-0007tG-QQ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOO8W-0004Ad-L0; Fri, 02 Oct 2020 12:42:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOO8V-0005cp-1p; Fri, 02 Oct 2020 12:42:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so2498270wrm.9;
 Fri, 02 Oct 2020 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dWp63D9c2Lr1JkfNpk3fP0mvyDGBITZOhbYefHb3Q5E=;
 b=CmC0xxSbZUsDEpDzXkvQVngmvyZ7mmQ0DdrtxBSeYl2NOvcudtRH/uQwv/rcJhXQ+R
 xsXnYAi87rYb1AlabT9IiQxlSSL1PiwZOvlQXNb6Sou3L2vf7InLzjPmGume0bhpFgTU
 VxMTzbZT45eSmbf9Vj1hvc3zJPHAPRqzs8KmC45KzrXXYdRDlrKRdFZqprwVOsFp8z8m
 EqtoIh7+n1h+huyCYCCvgVQP2g/pFjl1K4gmkDCiWQ0gnJ6cH6+hxFxKCaLjxTtx+wve
 0yIq4PAJrYkYpjI/W90L/zOC46wgMjRnp3Z7g32201FwxRXuEX/YnvPvSaT5RTztv9+v
 VUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dWp63D9c2Lr1JkfNpk3fP0mvyDGBITZOhbYefHb3Q5E=;
 b=cFUgtIryhca+R56RwIrmbveTlcx7+7snpG9Rlxmb1OYUmOOqWrQKZrGPKzUU6Gz+88
 +gYmcgZI/7sk1vsswK7sWnnkkaoFjFoPqJtf5nEMx85mv66MFOaODnVczZ38OgIIghJx
 ntP7Ny3fSaNtGc2CUUp+Y76SzmRTKoHoO/U1Co2MX7I6sSa7pR0AWkOReEWWoRtmjlKV
 k94xi4eQvz5sXFZ+byq2L77BoDwzn/8uFpr00gE0Nfjg1NC9vZuuGft/l60hKJgAcD1k
 82+N3BbGuCKH6nCminzx3q4bvPZJP7tpj+oslwDfs9lR5UJLYQ+lwUO+Nupwp8V+8VOl
 JcmQ==
X-Gm-Message-State: AOAM531uMpjcJcsjRs1uWdN5xPKCW2wTmC/0Gov8Z9y6ghO8+n4yJySB
 nUi5P5kflaB4/iNTX7CXydIbmz4+5Sc=
X-Google-Smtp-Source: ABdhPJzdZ2mkQiI8InzYwLmGX/BohZxQ6DSihyIpKr8D+Y56JZA58wq4PLe3n0bO6XNI8egAL8Sniw==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr4000702wrr.283.1601656941141; 
 Fri, 02 Oct 2020 09:42:21 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t17sm2378673wrx.82.2020.10.02.09.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 09:42:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] hw/timer/bcm2835: Rename variable holding CTRL_STATUS
 register
Date: Fri,  2 Oct 2020 18:42:14 +0200
Message-Id: <20201002164216.1741110-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002164216.1741110-1-f4bug@amsat.org>
References: <20201002164216.1741110-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable holding the CTRL_STATUS register is misnamed
'status'. Rename it 'ctrl_status' to make it more obvious
this register is also used to control the peripheral.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/bcm2835_systmr.h | 2 +-
 hw/timer/bcm2835_systmr.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index 43df7ee488..f15788a78d 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -27,7 +27,7 @@ struct BCM2835SystemTimerState {
     qemu_irq irq;
 
     struct {
-        uint32_t status;
+        uint32_t ctrl_status;
         uint32_t compare[BCM2835_SYSTIMER_COUNT];
     } reg;
 };
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index ff8c553661..b234e83824 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -30,7 +30,7 @@ REG32(COMPARE3,     0x18)
 
 static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
 {
-    bool enable = !!s->reg.status;
+    bool enable = !!s->reg.ctrl_status;
 
     trace_bcm2835_systmr_irq(enable);
     qemu_set_irq(s->irq, enable);
@@ -52,7 +52,7 @@ static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
 
     switch (offset) {
     case A_CTRL_STATUS:
-        r = s->reg.status;
+        r = s->reg.ctrl_status;
         break;
     case A_COMPARE0 ... A_COMPARE3:
         r = s->reg.compare[(offset - A_COMPARE0) >> 2];
@@ -82,7 +82,7 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
     trace_bcm2835_systmr_write(offset, value);
     switch (offset) {
     case A_CTRL_STATUS:
-        s->reg.status &= ~value; /* Ack */
+        s->reg.ctrl_status &= ~value; /* Ack */
         bcm2835_systmr_update_irq(s);
         break;
     case A_COMPARE0 ... A_COMPARE3:
@@ -133,7 +133,7 @@ static const VMStateDescription bcm2835_systmr_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
+        VMSTATE_UINT32(reg.ctrl_status, BCM2835SystemTimerState),
         VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState,
                              BCM2835_SYSTIMER_COUNT),
         VMSTATE_END_OF_LIST()
-- 
2.26.2


