Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D3EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8A82078E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlDQE2Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8A82078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6Rs-0002ca-Iy
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6Na-0003oP-R0; Tue, 16 Jun 2020 03:51:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NY-000854-Sy; Tue, 16 Jun 2020 03:51:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so19645032wrw.9;
 Tue, 16 Jun 2020 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jNTvdD7mpsXZtfy12szHXck2/SJaUPu7sRItCYEvWmI=;
 b=hlDQE2Y+qIt5bfkxo5d9ivmg+RnCdrgZik2djnVqg9fzhIrguwMe2kvyLMnFNkvBF0
 fOj9yLWI3qWupCP8+4J6HdrmB6U6CcDV1+n2BP/RiO0JrA8cEh552ypE9Nl/rz/qBoJo
 XmMkyuNRVWUAXwAxiyexhm2kPcCDhHZRCgO2JIgEgAg1KK1jUXpeyDspzmSsRWgDMniV
 8me6Zg+qkEGe1jKLfX86KnAffrKijmKYaClzj9NU4zsNReHvGBxeK+9M6DWvVHkvrhC4
 XljtSuY3fqb+52RxtIOd4Piyrfumm5zdTR16RpUQkyKxrDE3P4RWFlvKvfQoRZZZOxRZ
 hJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jNTvdD7mpsXZtfy12szHXck2/SJaUPu7sRItCYEvWmI=;
 b=lTxB+SjuF4UXWO/+qgx795nv54TIckOQiWi4PlHjbBEaoG9P+lGR86UcNhPhGsmi87
 mBlzw1jO0LK9pqD7xiGQr97LlWxOvV8STF+sYQ1tkiJsjUtgu9prfVmE6qvG1GbzuCMU
 E4WsVqKXy9WmHFnGIDGfV733Shi9/Iho/gvyi3yx47nH1iPVyZTG8oCyikzMy/yqOXS7
 mjaDFwpSFhjI8a6ooEcV/kDWXlLuubM0ABL44RUyoCjn5CPGnnpAqkmJ7idNQ/Vr/zcB
 5g11RXR27WZr7FFLdAaJgnqubU4jY+LohMvUbbVM91vpT5FhfiIhyrjHCQ+mzFLASyad
 F7Ow==
X-Gm-Message-State: AOAM5311VsAP1M7QtKc7tb8DjGov3OBakQKh3nVqAB4o5q0syBYMWUGa
 LuRp9VvfySRtLSkWrHr88rFVom4g
X-Google-Smtp-Source: ABdhPJw+EFEn77nFC6P8FC/flCFkku6pfG6x4QObNoCxtmxUNdNMglqucXXL/xjsW6biX12wvEnnzA==
X-Received: by 2002:a5d:45c2:: with SMTP id b2mr1541194wrs.323.1592293890541; 
 Tue, 16 Jun 2020 00:51:30 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/rtc/m48t59: Reduce timer precision to milli-second
Date: Tue, 16 Jun 2020 09:51:19 +0200
Message-Id: <20200616075121.12837-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
while the RTC can not be more precise than a milli-second.
Simplify by using a milli-second based timer.
Rename the timer 'alrm_timer_ms' to have the unit explicit.

Inspired-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/rtc/m48t59-internal.h |  2 +-
 hw/rtc/m48t59.c          | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/rtc/m48t59-internal.h b/hw/rtc/m48t59-internal.h
index cd648241e9..f21b603f97 100644
--- a/hw/rtc/m48t59-internal.h
+++ b/hw/rtc/m48t59-internal.h
@@ -49,7 +49,7 @@ typedef struct M48t59State {
     time_t   stop_time;
     /* Alarm & watchdog */
     struct tm alarm;
-    QEMUTimer *alrm_timer;
+    QEMUTimer *alrm_timer_ms;
     QEMUTimer *wd_timer;
     /* NVRAM storage */
     uint8_t *buffer;
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 47d48054fd..d2717d00a9 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -89,7 +89,7 @@ static M48txxInfo m48txx_sysbus_info[] = {
 static void alarm_cb (void *opaque)
 {
     struct tm tm;
-    uint64_t next_time;
+    uint64_t next_time_s;
     M48t59State *NVRAM = opaque;
 
     qemu_set_irq(NVRAM->IRQ, 1);
@@ -104,42 +104,43 @@ static void alarm_cb (void *opaque)
             tm.tm_mon = 1;
             tm.tm_year++;
         }
-        next_time = qemu_timedate_diff(&tm) - NVRAM->time_offset;
+        next_time_s = qemu_timedate_diff(&tm) - NVRAM->time_offset;
     } else if ((NVRAM->buffer[0x1FF5] & 0x80) != 0 &&
 	       (NVRAM->buffer[0x1FF4] & 0x80) == 0 &&
 	       (NVRAM->buffer[0x1FF3] & 0x80) == 0 &&
 	       (NVRAM->buffer[0x1FF2] & 0x80) == 0) {
         /* Repeat once a day */
-        next_time = 24 * 60 * 60;
+        next_time_s = 24 * 60 * 60;
     } else if ((NVRAM->buffer[0x1FF5] & 0x80) != 0 &&
 	       (NVRAM->buffer[0x1FF4] & 0x80) != 0 &&
 	       (NVRAM->buffer[0x1FF3] & 0x80) == 0 &&
 	       (NVRAM->buffer[0x1FF2] & 0x80) == 0) {
         /* Repeat once an hour */
-        next_time = 60 * 60;
+        next_time_s = 60 * 60;
     } else if ((NVRAM->buffer[0x1FF5] & 0x80) != 0 &&
 	       (NVRAM->buffer[0x1FF4] & 0x80) != 0 &&
 	       (NVRAM->buffer[0x1FF3] & 0x80) != 0 &&
 	       (NVRAM->buffer[0x1FF2] & 0x80) == 0) {
         /* Repeat once a minute */
-        next_time = 60;
+        next_time_s = 60;
     } else {
         /* Repeat once a second */
-        next_time = 1;
+        next_time_s = 1;
     }
-    timer_mod(NVRAM->alrm_timer, qemu_clock_get_ns(rtc_clock) +
-                    next_time * 1000);
+    timer_mod(NVRAM->alrm_timer_ms,
+              qemu_clock_get_ms(rtc_clock) + next_time_s *
+                                             NANOSECONDS_PER_SECOND / SCALE_MS);
     qemu_set_irq(NVRAM->IRQ, 0);
 }
 
 static void set_alarm(M48t59State *NVRAM)
 {
     int diff;
-    if (NVRAM->alrm_timer != NULL) {
-        timer_del(NVRAM->alrm_timer);
+    if (NVRAM->alrm_timer_ms != NULL) {
+        timer_del(NVRAM->alrm_timer_ms);
         diff = qemu_timedate_diff(&NVRAM->alarm) - NVRAM->time_offset;
         if (diff > 0)
-            timer_mod(NVRAM->alrm_timer, diff * 1000);
+            timer_mod(NVRAM->alrm_timer_ms, diff * 1000);
     }
 }
 
@@ -539,9 +540,9 @@ void m48t59_reset_common(M48t59State *NVRAM)
 {
     NVRAM->addr = 0;
     NVRAM->lock = 0;
-    if (NVRAM->alrm_timer != NULL)
-        timer_del(NVRAM->alrm_timer);
-
+    if (NVRAM->alrm_timer_ms != NULL) {
+        timer_del(NVRAM->alrm_timer_ms);
+    }
     if (NVRAM->wd_timer != NULL)
         timer_del(NVRAM->wd_timer);
 }
@@ -603,7 +604,7 @@ void m48t59_realize_common(M48t59State *s, Error **errp)
 {
     s->buffer = g_malloc0(s->size);
     if (s->model == 59) {
-        s->alrm_timer = timer_new_ns(rtc_clock, &alarm_cb, s);
+        s->alrm_timer_ms = timer_new_ms(rtc_clock, &alarm_cb, s);
         s->wd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &watchdog_cb, s);
     }
     qemu_get_timedate(&s->alarm, 0);
-- 
2.21.3


