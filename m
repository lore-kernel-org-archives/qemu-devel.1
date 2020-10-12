Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2447C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3119320878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qculCezz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3119320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1MQ-0004tV-9K
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kq-0003AL-PC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kp-0002gw-8L
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:08 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n18so20033769wrs.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u3qL4sMDH/Dtxtrv1yhVgK7r2RReEwtHtQeIMbIgt3M=;
 b=qculCezzeD43ig0+I83rawGeWv6OJTl8Z3uEMRe8vAk2ALOqMMnXDnULec4QESxgBl
 tPqDER1gzLmj/NVg23d5c8Ummt2E8HU3PzCAZYGZ7CY5crt/ruKPOHBjAG5pkD90Xns7
 zxKqjdsJUaDk6/lt+rnHLLiB5P58sigWEDbg31oS4J12t7Rr35ehYsy6GPSJcLn7RPLX
 1i3GS4iOHFzhi4irFKb/JO1MzqTaafPrkCMKAlB9aziHLN3VH9z8eM9JEschc34MWRlc
 MQsHzkVc3V8Jn1zNeLVlv8ffE3xucCrBREia3UlmPlvMk/14hC3pfg4VE/itcRPm3DcV
 OaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u3qL4sMDH/Dtxtrv1yhVgK7r2RReEwtHtQeIMbIgt3M=;
 b=ZNqlpL1+QO/myxyVuj8vxIhl5BSuYZ4ifd6n+vWT1GtVNwsMtRN8mAlY3G/9EzBTJL
 IYqDBarZJO3c4EX/JnlDZgSp6g4XV8HA3f+PNd+vKVqy7UezcCsJy4pO7hiMSKTGjX3A
 KvtR6LaCUhO64BQNHmiAmpbk0vlK9b5M4kfD+JZxMwulR9XpTzbADMEf8JYO5R0wTzB9
 kln20/pbrGnPTeo8x1+mDPdx330CAWvNX6UMgOmvcj6RY+ZwwE0YNX1SsjhzCRzIWXDp
 SeswToXwsWgKu7Wx49XtvgRi9IJjE9d3IL8MxDoPL6qwfR5eWzt+EvHO9RAasQedGprQ
 9d1g==
X-Gm-Message-State: AOAM532+fU8nsPF3k+1TM94RHjH4jj5eKW/k1cERVysF1sdJkVPvGimt
 h2AvU8pgQiGYFCl4sF+WxV3oVfh5Ha0=
X-Google-Smtp-Source: ABdhPJx9YarihkbWCLjLA+zauH3C5Ur5TUjz8h6l42q4X7K0ulHNlIBXm9b1PdViTxEjViRGQUF2QQ==
X-Received: by 2002:a5d:6143:: with SMTP id y3mr13532957wrt.277.1602522605660; 
 Mon, 12 Oct 2020 10:10:05 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y6sm25666395wrt.80.2020.10.12.10.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:10:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/pci-host/sabre: Simplify code initializing variable
 once
Date: Mon, 12 Oct 2020 19:09:47 +0200
Message-Id: <20201012170950.3491912-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012170950.3491912-1-f4bug@amsat.org>
References: <20201012170950.3491912-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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

We only need to zero-initialize 'val' once.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/sabre.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 0889c9369f6..3645bc962cb 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -195,32 +195,25 @@ static uint64_t sabre_config_read(void *opaque,
                                   hwaddr addr, unsigned size)
 {
     SabreState *s = opaque;
-    uint32_t val;
+    uint32_t val = 0;
 
     switch (addr) {
     case 0x30 ... 0x4f: /* DMA error registers */
-        val = 0;
         /* XXX: not implemented yet */
         break;
     case 0xc00 ... 0xc3f: /* PCI interrupt control */
         if (addr & 4) {
             val = s->pci_irq_map[(addr & 0x3f) >> 3];
-        } else {
-            val = 0;
         }
         break;
     case 0x1000 ... 0x107f: /* OBIO interrupt control */
         if (addr & 4) {
             val = s->obio_irq_map[(addr & 0xff) >> 3];
-        } else {
-            val = 0;
         }
         break;
     case 0x1080 ... 0x108f: /* PCI bus error */
         if (addr & 4) {
             val = s->pci_err_irq_map[(addr & 0xf) >> 3];
-        } else {
-            val = 0;
         }
         break;
     case 0x2000 ... 0x202f: /* PCI control */
@@ -229,8 +222,6 @@ static uint64_t sabre_config_read(void *opaque,
     case 0xf020 ... 0xf027: /* Reset control */
         if (addr & 4) {
             val = s->reset_control;
-        } else {
-            val = 0;
         }
         break;
     case 0x5000 ... 0x51cf: /* PIO/DMA diagnostics */
@@ -239,7 +230,6 @@ static uint64_t sabre_config_read(void *opaque,
     case 0xf000 ... 0xf01f: /* FFB config, memory control */
         /* we don't care */
     default:
-        val = 0;
         break;
     }
     trace_sabre_config_read(addr, val);
-- 
2.26.2


