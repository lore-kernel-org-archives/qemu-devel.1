Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A50C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B53220665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYnvqhqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B53220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48875 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Tt-000724-OF
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49P-0001T0-Rn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49L-000684-Gb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49L-00067S-Ak
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id k9so16840oib.7
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gp7YET4wc6HTTyajO3GZqgH8xALg6OOqzmcQarhMc/A=;
 b=oYnvqhqJcstRfXPGzvwwhURw/CTGjpBQ9arB7+1FkxrsE7XWR/wtiphJOYFv051TgR
 MvS2bxB8BkU6gBXubfXCXWCUuSHrBcdvVFZsTg/Jvoxy3hMTOCgr0iJ/XjHXQvtu0g41
 oIBrkd7oaQbWgcx91M/qGt5y0cLWQGlWtMcWTWEpb30SiOrqD+vRE6RN0G+8N3MNw62F
 I3+ns0EmwZRzPU80J03cX/QbI3Z28QDA3B9GcdYPQeRZ+ZesjzT/n+mw3ROdwyL5vVpj
 1rMyYEgdq0THVS28Im65gkiQ3K6yxeciJdQ2sDriUKRqysbN6qv9k2jnKDqpVQCp1t9X
 pRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=gp7YET4wc6HTTyajO3GZqgH8xALg6OOqzmcQarhMc/A=;
 b=R4eA7aJYW7OpPIfTOZimBGK7FS1oW6GkLa68AymaFMtS/b0ZtKawbXFAG3NBH3kC8s
 0uYpdtJhOO7BlzEkgPuQD4hjDxeAxEWyJh0xOgRv+jP2o34JZVIkyh2HsukAtkqpAc5z
 S0rudx9rY4TfiDK7Uq51WTi9aps4qZJaHa+H93RoQNoTE6vw8ozwgtwFmvadvSQy/VcG
 c5mapmbfj9DRo2N8f/A1eMFlELGqRTtYLW//ljglghVRIBV9y+arJjKrViEATptrkZCg
 vzPVDoiNB5zS9M2Kglx1VTzEFeh6RVvIOGhxCHwzXHPgqXjPE7waQnpb6hVbtiTBd/Bs
 ffPQ==
X-Gm-Message-State: APjAAAWDv2jfOH88QWvdJNlAaYRdTjBHL2Mcc0uofcButgUdv1YkfEpI
 cCEu03bXhiBz/9DGbECq1g==
X-Google-Smtp-Source: APXvYqwt9tTqXxSnj8j1BDdudFVIpeMcEUlprODOq+y3u0gGgk1qWwoKocw3R5zmXYHZfdTEFZ6sIg==
X-Received: by 2002:a54:410f:: with SMTP id l15mr60371oic.92.1568929178513;
 Thu, 19 Sep 2019 14:39:38 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id w20sm31167otk.73.2019.09.19.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:36 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id E727018059C;
 Thu, 19 Sep 2019 21:39:35 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 03/15] ipmi: Generate an interrupt on watchdog pretimeout
 expiry
Date: Thu, 19 Sep 2019 16:39:12 -0500
Message-Id: <20190919213924.31852-4-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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


