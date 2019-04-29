Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A2C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3222075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wi2nUQqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3222075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA4F-0002GG-1Z
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:27:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fM-0005Om-BP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fH-0006zA-2a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9fD-0006bs-T7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id h11so155332wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Kg2YYRuF9GcEYqzRNytFiB3KVAriQjQeVWin+mjaTaQ=;
	b=wi2nUQqhBBF7Z+/CwXHm3bcU+DnFRqapzYPNlhGB5jZZxHEM2ibbWhUlHnrDTjQH1l
	8AijtCx4HSZFLvxo1OiVNHiQWd61EHV0Pb0MG9tbYwtJROArzguFzyxWzK5PwgqxTneb
	T0QvCm/6bvGqVQTOXvo26yqjd46ayG89y4gBpEX5iLi6jfUtw+JjsMA/ljt4zc3/difs
	NURRfGM0onxUCim55fC92gAfk0vTXcxWs45Ff58u/HZpfsyiXaytdmOIViBpcnKkw3s1
	kh9cIA69hpnhNpoMiujZsLC6iNa6/3yhTnY0bv3orNomcyCPvecRMKrPnygLtbOlzZTE
	mZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Kg2YYRuF9GcEYqzRNytFiB3KVAriQjQeVWin+mjaTaQ=;
	b=WPu8ilGk7RMeBX+TvFEhc9OfS6m860THFtm10LrcKtVdiqZpDf3c1NfLLMiGBNS6oT
	l+4bm/RkMmcXTK1b2Hs+xyhJyHdpSbjt8q3m+mF079P1EFDWER2ymPX03596Vy5Usw94
	lT3XLME5rI7HRqizBwNDgTt7Dx77cbWJT5IDfsNbB2TV7BzNTFrPnIrsYOlyrcyUICkv
	rA7uwGhxcvua9eztnoLwD6oWA6ZZiMaL3WWZkSR0a3baVaMlG3dRrwh2xauLVX3rcvro
	UWIXUb0pGI3Hm51TN12Yh/lECr5PxVIfuEs8VvQCi8VlSQrVtOFctFaFq2kAyEaQoIGY
	kfSA==
X-Gm-Message-State: APjAAAUoZiJdPFrrqekb89qu9aE9My4Jgeltdpj7kL9VNT1k2jL/VG0R
	P9WK7oWDTjUck29mIfi1dzjLgRUKrrI=
X-Google-Smtp-Source: APXvYqzffY3KLG9vGZcE77iWCJ8vEX8xQw345mc/cPwgncWfQSrypSIc/49fgr6BMAxfVLmKEDGHhQ==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr58806wmc.68.1556557274988;
	Mon, 29 Apr 2019 10:01:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.13
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:21 +0100
Message-Id: <20190429170030.11323-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 33/42] hw/display/tc6393xb: Remove unused
 functions
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170021.GFh4MB8jTO0sWHPF-DLxoSq-4_Ejq8IZC4HLbHrv2yk@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

No code used the tc6393xb_gpio_in_get() and tc6393xb_gpio_out_set()
functions since their introduction in commit 88d2c950b002. Time to
remove them.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-4-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h  |  3 ---
 hw/display/tc6393xb.c | 16 ----------------
 2 files changed, 19 deletions(-)

diff --git a/include/hw/devices.h b/include/hw/devices.h
index 1ed5be32967..0850f697451 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -54,9 +54,6 @@ void retu_key_event(void *retu, int state);
 typedef struct TC6393xbState TC6393xbState;
 TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
                              uint32_t base, qemu_irq irq);
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler);
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s);
 qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
 
 #endif
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index e1b1e302f23..6d133d9a66c 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -137,11 +137,6 @@ struct TC6393xbState {
              blanked : 1;
 };
 
-qemu_irq *tc6393xb_gpio_in_get(TC6393xbState *s)
-{
-    return s->gpio_in;
-}
-
 static void tc6393xb_gpio_set(void *opaque, int line, int level)
 {
 //    TC6393xbState *s = opaque;
@@ -154,17 +149,6 @@ static void tc6393xb_gpio_set(void *opaque, int line, int level)
     // FIXME: how does the chip reflect the GPIO input level change?
 }
 
-void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
-                    qemu_irq handler)
-{
-    if (line >= TC6393XB_GPIOS) {
-        fprintf(stderr, "TC6393xb: no GPIO pin %d\n", line);
-        return;
-    }
-
-    s->handler[line] = handler;
-}
-
 static void tc6393xb_gpio_handler_update(TC6393xbState *s)
 {
     uint32_t level, diff;
-- 
2.20.1


