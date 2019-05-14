Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421C6C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8E12166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6gR4U3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8E12166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd8m-0005y6-AU
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:31:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvR-0002d7-I8
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvP-00072z-Mp
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvP-00071g-As
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so592pfn.7
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zHL5/dOLNq3cxnvhnBPOBazkJM0pmZq+fc+P6w38V4s=;
	b=M6gR4U3L/bgTDtPmpFWXLWvD77Vm4fCPpE7DYCo4iDjA4pftInBaJ9WEh2MI/25bku
	ERxLzyDm4lvi0GcKiUPCXMLQnc+msFjEVCLWSy5RW5QFa7f8SmPHpzEUeBHBp96Ls3tw
	gUr43liDbX5lUAucADct9Mv8bF/+cpbzcrFyfVbRkwo1AtWMbwjdeARv0kXoZCPErki5
	/oINr0aj5sBZumLjuLXKv87Fc8gD+C5ouLDi11xpglqafsqkL11OvjaiQFU4EYYbSy5X
	uSHJWUrk7SVDgs23zT153m9/kEZKys0Hot+jZ2EoK3BqYtliP4dq8Wy3XadpqiZD7M8n
	MEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zHL5/dOLNq3cxnvhnBPOBazkJM0pmZq+fc+P6w38V4s=;
	b=kZnUhRbssnc2IfNq2pqtYy/fMePsYFoinetWZwMcU72xmRIBUvcwLjYn1SK05xpFGv
	UPjxTrWzeWqHk+Gc5hjR11JcckEa5dxEcMKc2WEglIU/rravrLkWS5d5+D9Rt1twwmLe
	Y1mxWynUCLClno3E5aggmZmiwEEwMTGwFhstiRmtqEI5nADJ9l8pAgqh8SmpzCYkgZir
	0yPkjVbtJRsFfT97iCLLulh79k4JtqsOQxgcXRramzQupL17KYLIY1kxVPD4I0kesPI3
	pXFpAJzPMRHj+4UCeXeunHpvIfmQMxcDLvcCuHKOoVKM8AcGBy/NuPO19r9GZXbVNzqm
	Bx3A==
X-Gm-Message-State: APjAAAVxqQWBjj/Y7wY7FaiK94GXq0FC+HCacD7kCua+4XFgt7FLjzvW
	oUL+ZNQ6wB6GP5ixUHmfz5Ukznd8xRU=
X-Google-Smtp-Source: APXvYqwPJl9FUKTVDHaiuh2HddhERSKxElrRnOOv1igHwwLaqO/EvFodF9nYvK5K5AyN9d26HtyjXg==
X-Received: by 2002:a63:541d:: with SMTP id i29mr39416547pgb.174.1557861438129;
	Tue, 14 May 2019 12:17:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:46 -0700
Message-Id: <20190514191653.31488-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 17/24] hw/misc/nrf51_rng: Use
 qemu_guest_getrandom_nofail
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of error_abort directly.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/nrf51_rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index d188f044f4..3400e90a9b 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/nrf51.h"
 #include "hw/misc/nrf51_rng.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 
 static void update_irq(NRF51RNGState *s)
 {
@@ -145,7 +145,7 @@ static void nrf51_rng_timer_expire(void *opaque)
 {
     NRF51RNGState *s = NRF51_RNG(opaque);
 
-    qcrypto_random_bytes(&s->value, 1, &error_abort);
+    qemu_guest_getrandom_nofail(&s->value, 1);
 
     s->event_valrdy = 1;
     qemu_set_irq(s->eep_valrdy, 1);
-- 
2.17.1


