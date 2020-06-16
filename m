Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1850E206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMXCBPQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1850E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6Qq-00013n-Bu
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NY-0003jF-SS; Tue, 16 Jun 2020 03:51:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NX-00084r-6w; Tue, 16 Jun 2020 03:51:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id j10so19659126wrw.8;
 Tue, 16 Jun 2020 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nNUziTErkLgYz4tRwUDCFKibDK7Kq+2uBOuQqz7FOdE=;
 b=EMXCBPQQiKZ0IiZlX2V9oIPUOIocKwAiFgJ87DIbemKuT55ZMwXBHSCQ0U3ocn1tWO
 2gUlIy2C7w+mpcRxPG0O2l85DCKvbqHEcZSRvvrKqEY8SHjcy6yi3bsPl1tX3y7GaA7Q
 WNqFtDEQ/b/RRdF85QN3opwgKH1m0/bAdXcP520QisJFcqY341x10rcWRdFgeLNdTs7v
 ALWaAT9iYZIhZ1mre/JCGtbuGXTxinHP3bnPjVy2bQSUJn3bHJD508/KXxjCHjKNTszo
 GqRkYTaAhcS3ZnkpxkRFo4345EHZU/RDJT/Nbv/a2b6W0qE+aGGntMCe5s7pMi33OiY2
 tqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nNUziTErkLgYz4tRwUDCFKibDK7Kq+2uBOuQqz7FOdE=;
 b=lTaWxdpG5H+r10ReT/iYfp1AdZkNiRs2F3A5eqglJM6GD2SmVjixBsQLnugtXAo7AP
 BMbY51IV3DX4gf06rAuUem9LL6OXXGjBzHyjC81WMrZf/wP3C8B3RzXlHDoA4myJt0Ba
 udC67zOPxhIaO7vnguySLlgwxqs7d8sjb7vbJlXxfyEG3rSzpQ9b6dliEKx0EeOx9VJQ
 w5zv9Wa55vxoc4aWDtr3G8A+sZMiJ3BwwtH/f8nqBYgkMG+sLJwLyjNqHFcD903jBVCd
 97OpHkPZ3LHLr+gCQZTcAQVr9FEghjH170RfMRpmpKJ6ppgSs0QeOv2DlwzNfsxkLHkD
 /ZXQ==
X-Gm-Message-State: AOAM533jnUhzrU7IdO+TPtbL7/fhfpq0elt8wz1QznBVX8Tz9lRJkV6U
 yzETY/cq3d3GRM9ecrPQkPChxpJ/
X-Google-Smtp-Source: ABdhPJyX7kxTW4XOQXjVEj5drS5upHp8ngPtIAsARqpAsxbPN7+9xQEPXiXWWQNW++v5bR9lKQRF/A==
X-Received: by 2002:adf:e590:: with SMTP id l16mr1566679wrm.383.1592293889090; 
 Tue, 16 Jun 2020 00:51:29 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/virtio/virtio-balloon: Rename timer field including
 'ms' unit
Date: Tue, 16 Jun 2020 09:51:18 +0200
Message-Id: <20200616075121.12837-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make code review easier, append the timer unit (milli-seconds)
to its variable name.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/virtio/virtio-balloon.h |  2 +-
 hw/virtio/virtio-balloon.c         | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d49fef00ce..8a85fb1b88 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -50,7 +50,7 @@ typedef struct VirtIOBalloon {
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
-    QEMUTimer *stats_timer;
+    QEMUTimer *stats_timer_ms;
     IOThread *iothread;
     QEMUBH *free_page_bh;
     /*
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 10507b2a43..ad67cd53e4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -197,16 +197,17 @@ static bool balloon_stats_enabled(const VirtIOBalloon *s)
 static void balloon_stats_destroy_timer(VirtIOBalloon *s)
 {
     if (balloon_stats_enabled(s)) {
-        timer_del(s->stats_timer);
-        timer_free(s->stats_timer);
-        s->stats_timer = NULL;
+        timer_del(s->stats_timer_ms);
+        timer_free(s->stats_timer_ms);
+        s->stats_timer_ms = NULL;
         s->stats_poll_interval = 0;
     }
 }
 
 static void balloon_stats_change_timer(VirtIOBalloon *s, int64_t secs)
 {
-    timer_mod(s->stats_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + secs * 1000);
+    timer_mod(s->stats_timer_ms,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + secs * 1000);
 }
 
 static void balloon_stats_poll_cb(void *opaque)
@@ -315,8 +316,9 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
     }
 
     /* create a new timer */
-    g_assert(s->stats_timer == NULL);
-    s->stats_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, balloon_stats_poll_cb, s);
+    g_assert(s->stats_timer_ms == NULL);
+    s->stats_timer_ms = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                     balloon_stats_poll_cb, s);
     s->stats_poll_interval = value;
     balloon_stats_change_timer(s, 0);
 }
-- 
2.21.3


