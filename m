Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94955C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594DD206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFAuf9y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594DD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8p7-0006Oz-GO
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8a5-0002kE-BK
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8a4-0007Gj-B7
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:53 -0400
Received: by mail-wm1-x344.google.com with SMTP id e26so18067961wmk.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qZYn/HyqRvR7ovVMuBjlnAavq0N/O2mBVeAXoig0owA=;
 b=dFAuf9y3fvxtb50VSqDyae4PHj1DBkI4LEWzuw6VfowHy/j//JXqZAEE5/9Gyd02uD
 nCnf7bPnaxKJyJ2uCAE861/wMHzrMG9zt5xg/312bFeWIjY58K8otGFHOpF3RwWaBHzS
 onzBe3pX7aHBm8xXIqKDtSjxSusTLDgD3XQNpsfHSu65kRuzj/uKqwE3o4mChkS2B1eJ
 2n3FtAdm9nrCJMT71PwxDM9ssvihIZKfurXcME6YI+3pFskOCqFDCepxHcUrdp5egPTf
 jI9XYi0PESTBy8ccK41KkQXLClyMC4DIb4BL9kl7YtNhpa6AAomD9v0jPoe/jMoSjndI
 7ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qZYn/HyqRvR7ovVMuBjlnAavq0N/O2mBVeAXoig0owA=;
 b=CtJWwZEAYHeoFaCWvnq3c8g8nSZN7uF/dY1FSwFUGFdthGtN6VkfhAMiBVakaqBfj/
 8ek+IWW6QzeTbMCHtIk3B2fTdDrNPyZy7bxYHzKx3xIQ/y+FMnFW7Sq7hvkYV9o9QZRe
 vGsFe26ndZ5CLxxCh3RS9VGboOsmCkzF1ad+fHY2qXqDdP6i/D7jSoWN1bKG8DzEMvsm
 XSdfVR9MKhGncMZKt2Lr2U/W86yr8fLsfH7A07iERevt8c7AjCU5YlakKj7v6ji///+5
 KxZIP7DsaNX7KU1bfMw6z3i1pzkQT9B6/H8t/F2JYStFfsZIi+tpsryL09JDuGgmAvKq
 RW7g==
X-Gm-Message-State: AGi0PualP0TxFEN4yMUJjXNVJwKgjxySdOuLdnmLBaAsCoFD+VUh3Rdr
 3k7nRuxezQCZqAo2VDAH4Zq/Oec1FmxLmg==
X-Google-Smtp-Source: APiQypIJ0h/csqSjKHKdsLGBkBk4p2GOsFMqFfuyRlxLO4KGluOK27UBSsSSwwzHfGlSrHEuE5qVbw==
X-Received: by 2002:a05:600c:2041:: with SMTP id
 p1mr1439959wmg.152.1589204088154; 
 Mon, 11 May 2020 06:34:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/34] hw/arm/musicpal: Map the UART devices unconditionally
Date: Mon, 11 May 2020 14:34:03 +0100
Message-Id: <20200511133405.5275-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

I can't find proper documentation or datasheet, but it is likely
a MMIO mapped serial device mapped in the 0x80000000..0x8000ffff
range belongs to the SoC address space, thus is always mapped in
the memory bus.
Map the devices on the bus regardless a chardev is attached to it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jan Kiszka <jan.kiszka@web.de>
Message-id: 20200505095945.23146-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b2d0cfdac8a..92f33ed87ed 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1619,14 +1619,10 @@ static void musicpal_init(MachineState *machine)
                           pic[MP_TIMER2_IRQ], pic[MP_TIMER3_IRQ],
                           pic[MP_TIMER4_IRQ], NULL);
 
-    if (serial_hd(0)) {
-        serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
-                       1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
-    }
-    if (serial_hd(1)) {
-        serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
-                       1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
-    }
+    serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
+                   1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+    serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
+                   1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
 
     /* Register flash */
     dinfo = drive_get(IF_PFLASH, 0, 0);
-- 
2.20.1


