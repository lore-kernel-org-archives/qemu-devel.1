Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E2EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614C32133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyLlToMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614C32133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK33q-0005FU-0H
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2ph-0003ap-0q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pf-00070B-NJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pf-0006za-H4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so20406868wrv.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=93xF/zHlNMtx3KJOnjnh3nh2MFInn1otyO8XwLGexyQ=;
 b=XyLlToMURoRWcdMIZSmORyHGgRPCoUAP/hCxC63hLYneQLTt8bK5x8hB4oJ7cE9CXN
 F7sykh0sPpu4+N01g9jVB4+K19URZcQFSnCn53+heuZQsSyGY/Yn6dHyuSsniVFRzXg0
 iQUkIvMCzN5XD/Rr9bMAPwFVk6CZ/BdoGs+RSY2z4be67HMv4jxlbrDuPLOiMC1Vi+1h
 j0uTXKsgiGZgItjU+WFq1/1cmO+Bq0TsRvVqWfaMIjAjnCJ1UxnyRepMSqn5EN77IlOT
 b7IDHn+Bf4WOcOJbhDuZWFDsqmP+OvJwzfKbKpRRsRqzb5j6nNeZ0rUcqPGEQqIGOHUf
 /O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=93xF/zHlNMtx3KJOnjnh3nh2MFInn1otyO8XwLGexyQ=;
 b=We0jcaBD67YTIVoqqITlO8XFM7ZbN6vkJgcIdwcEjZ/K21UsuE6Ydk6mpU7+IXw2HH
 80Nn2z9x7/c6jTS1fP4tKN9Zidk3KTW+qMWquOSe2JNRER941WS/ACKEpEJrwI6a8K8u
 R+F3gCvFGX+5BIC2OUeewZN20z0YLf02ywKZ+XbFV94PuxOQaGL61mMuNkrVPJm4/W+5
 9LKoM8Isu3mg9f7IvPkzfWkmaG1Hom4s/GEa+xjaLG7rELPjvUNjohP6w8FYNj/rcgPE
 Z0gIcZyMx4XaOZ/jln6BOWOXSSKyauNMPoDey2XIspd62+ADThRDqKDb/s4QJKMs8cAJ
 ulKg==
X-Gm-Message-State: APjAAAXIMxOLXxO0yoOpAnuaeqQMpVnKOlwep/vky0jpoXif1+jofVea
 feJLts52RcyhMztN7ZoTQdnPV8voJ4fhZw==
X-Google-Smtp-Source: APXvYqzpHzw+VJAyKDVUMr01SMvb1y/G7PtJJSAIKl5zYyJOIZrbAKpawKcOyekKyPqClosMmbFTGQ==
X-Received: by 2002:a5d:5705:: with SMTP id a5mr27497595wrv.112.1571069066129; 
 Mon, 14 Oct 2019 09:04:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/68] hw/arm/musicpal.c: Switch to transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:04 +0100
Message-Id: <20191014160404.19553-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Switch the musicpal code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-6-peter.maydell@linaro.org
---
 hw/arm/musicpal.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index b3624d5e280..f68a399a984 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -843,13 +843,10 @@ static void mv88w8618_timer_tick(void *opaque)
 static void mv88w8618_timer_init(SysBusDevice *dev, mv88w8618_timer_state *s,
                                  uint32_t freq)
 {
-    QEMUBH *bh;
-
     sysbus_init_irq(dev, &s->irq);
     s->freq = freq;
 
-    bh = qemu_bh_new(mv88w8618_timer_tick, s);
-    s->ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(mv88w8618_timer_tick, s, PTIMER_POLICY_DEFAULT);
 }
 
 static uint64_t mv88w8618_pit_read(void *opaque, hwaddr offset,
@@ -879,16 +876,19 @@ static void mv88w8618_pit_write(void *opaque, hwaddr offset,
     case MP_PIT_TIMER1_LENGTH ... MP_PIT_TIMER4_LENGTH:
         t = &s->timer[offset >> 2];
         t->limit = value;
+        ptimer_transaction_begin(t->ptimer);
         if (t->limit > 0) {
             ptimer_set_limit(t->ptimer, t->limit, 1);
         } else {
             ptimer_stop(t->ptimer);
         }
+        ptimer_transaction_commit(t->ptimer);
         break;
 
     case MP_PIT_CONTROL:
         for (i = 0; i < 4; i++) {
             t = &s->timer[i];
+            ptimer_transaction_begin(t->ptimer);
             if (value & 0xf && t->limit > 0) {
                 ptimer_set_limit(t->ptimer, t->limit, 0);
                 ptimer_set_freq(t->ptimer, t->freq);
@@ -896,6 +896,7 @@ static void mv88w8618_pit_write(void *opaque, hwaddr offset,
             } else {
                 ptimer_stop(t->ptimer);
             }
+            ptimer_transaction_commit(t->ptimer);
             value >>= 4;
         }
         break;
@@ -914,8 +915,11 @@ static void mv88w8618_pit_reset(DeviceState *d)
     int i;
 
     for (i = 0; i < 4; i++) {
-        ptimer_stop(s->timer[i].ptimer);
-        s->timer[i].limit = 0;
+        mv88w8618_timer_state *t = &s->timer[i];
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_stop(t->ptimer);
+        ptimer_transaction_commit(t->ptimer);
+        t->limit = 0;
     }
 }
 
-- 
2.20.1


