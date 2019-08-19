Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE49C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DBE214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRHeBPp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DBE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoEY-0002zD-B7
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5n-0007fc-0H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003DX-MA
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003CB-Eo
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:19 -0400
Received: by mail-ot1-x342.google.com with SMTP id w4so2874847ote.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gp7YET4wc6HTTyajO3GZqgH8xALg6OOqzmcQarhMc/A=;
 b=DRHeBPp3R371hw50G5XMRjpi4ICbO3nk1cCrnN3E8SfD8kgvk6XSh0yGY0F7wkp7d5
 eVg7s7FgC74PwFI5tBr3AJ7JnDfWXsMOwcaz0B/gMIDAqea4YEBp896Ft0WVLgjug5HC
 y0mupZFWfEwpO9VTaRXUjUqp1WpW9BRT8fp0y5rGLgzSPb4GyqTzRr1DBxoGq1Th9RdG
 gzPXL1kQY5tZjvroSwcXw2khfSPejbsH3RUOJSfgOeD9h8bwTHQ4+4GIExZnLLzFLw3w
 MXhtBodsA7yEQg/YKRnoeVamQ0RnARJMKyMb1Dqou78DWtAysSwFyBkAEHZyrsHMSxpK
 gAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=gp7YET4wc6HTTyajO3GZqgH8xALg6OOqzmcQarhMc/A=;
 b=iqsCdsZUnivYddxRdftbT33/4Cy3LV4s848WpNrPLcKSboKecLDHcRTG0eEbPkviwo
 lAyWNGii474H96IBAwc17KREbR4LLcts0S1P4afxH71yHznO4PpMd8kKW44j4x0j94+8
 iigV9y505tutllCT9r8j98kG49Q7f8B2sn9jhVHrt8OVjPTZwwWU1dXvzHbvw0G1ndUH
 q/7s5cNioR9FIioNNJTSS9ymE2m+sLLjOXqqvWMa0ycqFgHWhtxaVTWHM60j1pO9xnIx
 RJwo4G2FQsaiVxZyPnJbZtpkhJ5IS7T4hsNDYXUUwY53/ZC+BGFUe83dIGE8XMt140gf
 S+HA==
X-Gm-Message-State: APjAAAXt3IUZa6HK23bhIyFrLSlKgA2f3NERz2iunYDXNP35fetFC65l
 qpD0ar/mlAXxS96KIMd1Zmhlt2A=
X-Google-Smtp-Source: APXvYqy0wi7Y9ro0z+orYg0RdyTY4OC+msgTH8tfkVXlOKTaTLxQNWM0iif6qK37risdii0R/uUfvQ==
X-Received: by 2002:a9d:340b:: with SMTP id v11mr20510938otb.317.1566245837798; 
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id m18sm1411229oic.12.2019.08.19.13.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id A41511805A8;
 Mon, 19 Aug 2019 20:17:16 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 63B9B301176; Mon, 19 Aug 2019 15:17:15 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:53 -0500
Message-Id: <20190819201705.31633-4-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH 03/15] ipmi: Generate an interrupt on watchdog
 pretimeout expiry
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
Cc: Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Add the watchdog pretimeout to the bits that cause an interrupt on attn.
Otherwise the user won't know.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index afb99e33d7..6e6cd1b47d 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -477,7 +477,9 @@ static int attn_set(IPMIBmcSim *ibs)
 
 static int attn_irq_enabled(IPMIBmcSim *ibs)
 {
-    return (IPMI_BMC_MSG_INTS_ON(ibs) && IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(ibs))
+    return (IPMI_BMC_MSG_INTS_ON(ibs) &&
+            (IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(ibs) ||
+             IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK_SET(ibs)))
         || (IPMI_BMC_EVBUF_FULL_INT_ENABLED(ibs) &&
             IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs));
 }
-- 
2.17.1


