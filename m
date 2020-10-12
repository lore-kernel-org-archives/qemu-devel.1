Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA15C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC5320838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzncg49R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC5320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1MT-00050K-Sy
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Ku-0003F7-Tj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kt-0002hl-Ep
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id e18so20009919wrw.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g+ZuN081JnWofgtvw5Xcnn25A8ChgQoZUlp7TAnTGlc=;
 b=Tzncg49ROC/sfxYjVrVxZ7A+r7tL+fD5nrGLNX8NgPAiDn/wJddqdLgNRfAIaCYioz
 Aup7mvBGbCcsBnf17lHSZ5qVuQWLxYFsN0sKxtXVBmTenDU/Obh/oHdSN/5X1abvjaB8
 2CIQcPJtRe+nbMGb4Rg1zVNCIQgYS/a7vKsztHA9/DSMu9TkzdphaDAUnIWSyvrqXwQN
 XQzjXpmVByL6g/Z7yGArIOJfbTFofz/feVfBWRRN0f7NqEpP50nGsJaV2+9ClvG3X5WL
 VrwuQU4LJlUssE6hEYDQSLYzl1W9pPtxfX8aGeSS7jYdbF7uSM9fY14GNwfQ7V32sLLG
 DMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=g+ZuN081JnWofgtvw5Xcnn25A8ChgQoZUlp7TAnTGlc=;
 b=EO95xGAPBJeeUaew0/fo23HbmudXuKZPgZUSmnEWGe+35DhdMBVmDAksXchTeJLxG+
 dcn1+OJ3wN8U6nHgiGGOZS/lF5fRx7vZezbE+FlFW78zrlyO5jT036NhVK84Q9NjoARI
 eLEsbwNgAAARMpLqgfL5tgfBMHs9SeAXdqAcZ7fcyWNNeOM3IiWjoeooCbXdE8cqKG2v
 Db1KV4kY+a4iuMeW/vm0e/DOXoqjp3cYwhw/09xvaUPzH37K9gBp4T7MNWj1I64c4CMu
 lEEFX948Wdr28cCaTgs4PccYo5gTr30BChFmvc53jo/VFVjZKKU18ZdNk7dwtv8lvU+Q
 0yjw==
X-Gm-Message-State: AOAM533eEYiUeOqeuz92mOKiBV29HW/TUD3O10bFzfU7R2ve2q6TZKb3
 L+9KSHu1FYJrsXePkvwSLtamjDFtnBk=
X-Google-Smtp-Source: ABdhPJxGEj9mYPb+dAW62VOwNvCZDqTYCzRwcgq81RPp+ctwU3YWEo3DuJoWbgOZNW5jblugNRumoQ==
X-Received: by 2002:adf:e681:: with SMTP id r1mr1622526wrm.181.1602522609942; 
 Mon, 12 Oct 2020 10:10:09 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b5sm3359947wrs.97.2020.10.12.10.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:10:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/pci-host/sabre: Report unimplemented accesses via
 UNIMP log_mask
Date: Mon, 12 Oct 2020 19:09:48 +0200
Message-Id: <20201012170950.3491912-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012170950.3491912-1-f4bug@amsat.org>
References: <20201012170950.3491912-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report unimplemented register accesses using qemu_log_mask(UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/sabre.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 3645bc962cb..4412e23131c 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -121,8 +121,10 @@ static void sabre_config_write(void *opaque, hwaddr addr,
     trace_sabre_config_write(addr, val);
 
     switch (addr) {
-    case 0x30 ... 0x4f: /* DMA error registers */
-        /* XXX: not implemented yet */
+    case  0x30 ...  0x4f: /* DMA error registers */
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Register 0x%02" HWADDR_PRIX " not implemented\n",
+                      __func__, addr);
         break;
     case 0xc00 ... 0xc3f: /* PCI interrupt control */
         if (addr & 4) {
@@ -198,8 +200,10 @@ static uint64_t sabre_config_read(void *opaque,
     uint32_t val = 0;
 
     switch (addr) {
-    case 0x30 ... 0x4f: /* DMA error registers */
-        /* XXX: not implemented yet */
+    case  0x30 ...  0x4f: /* DMA error registers */
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Register 0x%02" HWADDR_PRIX " not implemented\n",
+                      __func__, addr);
         break;
     case 0xc00 ... 0xc3f: /* PCI interrupt control */
         if (addr & 4) {
-- 
2.26.2


