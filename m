Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD955C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AD2206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgKlPInv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AD2206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6P7-000655-OI
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NX-0003gL-Q2; Tue, 16 Jun 2020 03:51:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NV-00084a-UO; Tue, 16 Jun 2020 03:51:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so19698101wro.1;
 Tue, 16 Jun 2020 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/VMXSScmCR3d2/xkIxPp+LwxksxY5VIsQUSqaq3gT2w=;
 b=LgKlPInvpyWcJQMbinEVBrhvjBxSLgik0kvjvBXJ5vLSHydazZm1npSvulmJf7g3ZH
 vcT06mhNwvaHJYzKexKhtPj3X1uBs26KJr/3g/Uo9f4JAi0yOjI+ggFED/eI0EIkz+dj
 ACegk5qJrKPDUdyxK64vooWuXSaDufmJHKuzwy3GSVwlFGKsCgB82NKF81X9s2w+15Mq
 4uJi2mzFI39tn702h5DYgZzIzDyIGI0h9DGV5uY1upX3G5mvZnz3sMexLNHh8qpoVE8J
 Wg6RLX76p2BP+SM4tkB06dBfc17szJClCmIftRXo4LcH9vhs4Oj86BpiP4C0Uz7dgKN9
 oKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/VMXSScmCR3d2/xkIxPp+LwxksxY5VIsQUSqaq3gT2w=;
 b=AsxLDro4zZAdu4jTRPOhclVAfS/ggw/T1El3HPDjqbreIUALnFy4jX4YvSnkVlJZvE
 8YNzH4LfkcO8ID5uZ1LcSctnPgucgYshXhqpONdbypwS9CeUwJ3oWa3NmZJenR46sH2D
 QAWv5OADI76hHcC4F3zd2iD7m7GvuLGb1TuNisUaed6N9ukp91zNDqZFNSop1HcUiVda
 ypb8iOSusEFcvzdEjnRmq/0qCJvRMYyM+LgaJ2dVPU8XtuS9t7U6Ya9IY1AoHiuW4ZHK
 9J3La/aJXqg6Xie8umBw6kiOfG5UhukeamcM1nkduIeTPmzaS4LqotFOypqcTxJgECKf
 gv2A==
X-Gm-Message-State: AOAM533O70R29T0x8VwW+cP1z8Ul5LO5kZLcPQNBsAP5fZ5l6gyKB3JV
 Ss+QvJe5qqzQlbZ/Yhn2L3mdOR5z
X-Google-Smtp-Source: ABdhPJw1CEDYD8VhkYNnlo/tDBeikFnfie1kFgHNOTqW2vK5wDAq1ur41dKnqMxnQXpjcMNkv+hOSw==
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr1633039wro.250.1592293887799; 
 Tue, 16 Jun 2020 00:51:27 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] block/curl: Reduce timer precision to milli-second
Date: Tue, 16 Jun 2020 09:51:17 +0200
Message-Id: <20200616075121.12837-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current implementation uses nano-second precision,
while the block driver is only used with a milli-second precision.
Simplify by using a milli-second based timer.
Rename the timer 'timer_ms' to have the unit explicit.

Inspired-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/curl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 6e325901dc..74950373aa 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -119,7 +119,7 @@ typedef struct CURLState
 
 typedef struct BDRVCURLState {
     CURLM *multi;
-    QEMUTimer timer;
+    QEMUTimer timer_ms;
     uint64_t len;
     CURLState states[CURL_NUM_STATES];
     char *url;
@@ -148,11 +148,10 @@ static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
 
     trace_curl_timer_cb(timeout_ms);
     if (timeout_ms == -1) {
-        timer_del(&s->timer);
+        timer_del(&s->timer_ms);
     } else {
-        int64_t timeout_ns = (int64_t)timeout_ms * 1000 * 1000;
-        timer_mod(&s->timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ns);
+        timer_mod(&s->timer_ms,
+                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + timeout_ms);
     }
     return 0;
 }
@@ -582,7 +581,7 @@ static void curl_detach_aio_context(BlockDriverState *bs)
     }
     qemu_mutex_unlock(&s->mutex);
 
-    timer_del(&s->timer);
+    timer_del(&s->timer_ms);
 }
 
 static void curl_attach_aio_context(BlockDriverState *bs,
@@ -590,8 +589,8 @@ static void curl_attach_aio_context(BlockDriverState *bs,
 {
     BDRVCURLState *s = bs->opaque;
 
-    aio_timer_init(new_context, &s->timer,
-                   QEMU_CLOCK_REALTIME, SCALE_NS,
+    aio_timer_init(new_context, &s->timer_ms,
+                   QEMU_CLOCK_REALTIME, SCALE_MS,
                    curl_multi_timeout_do, s);
 
     assert(!s->multi);
-- 
2.21.3


