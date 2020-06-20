Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91648C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607B52474A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMXuAsbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607B52474A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmbZ-0000Lv-EU
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma9-00072v-SO; Sat, 20 Jun 2020 19:07:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma8-0002MO-9I; Sat, 20 Jun 2020 19:07:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id g75so3579642wme.5;
 Sat, 20 Jun 2020 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+2AZIJNfLoRM7W1nhvrnhDoshMHCbhObjMtaHucBvyY=;
 b=MMXuAsbKzPtw7rmEOVHoV8Oop7VX86Tkj4DrAl46aA2mOaOjz9HzpDmKsuaVb3KxAh
 vku1E6fv41DU2qKN5/D+apHbo4FGqnox4RyNYrHt5VvY+8EsveqC8YmK1OXEDuS1MLv6
 nnN16xbYLL7YSHdKEetrrSYx3MObTS434z8+rB4cjjSrElsXRW19Cz+KgtXH2bSVf5PB
 0Gl/VTOvmqCA6C1thQIhux6Q/gqgjRsEVHhDk/q6VcZVNjp12hxvvgDq6uE0cDOX3Q1+
 gdhUDQJ9LfETRUJxOJts5Zy/8OS7uyFZ/bxE7xkVe3RI5eNdwuuyJX0jskt66g0XZGR6
 QPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+2AZIJNfLoRM7W1nhvrnhDoshMHCbhObjMtaHucBvyY=;
 b=b+KculVetlfRO6zn8u8sDOLP4bzyPkp08Ohxl6V8zellPfSuMlcK4MLHPt0FFEteN4
 ouzfaKNusJb6F3gISDfFs5bcUBcG8uBK70/FpdWXmKssaZ9w1EonD9VQCWmBaTJtuEeD
 EmUKF7evW2nnraXO6Qh5r0z6iZyJTvhTXI2AFqqh4R8ovhDmLE6Mnn9JdX4xZfd6dH+m
 KkfvBfhuR4pOgd4NovG6jOc6TolkwvRMLv5yZfWj1uXJUjmYQiD+E5hQE5O0BofLMKLM
 at6iFsopT7Cy7LA8Lz7j2/PR/Q6Hn6XHDqJjUJaR+twfU3UgUZLFFAMUrTSpRi6mkEKM
 zbPw==
X-Gm-Message-State: AOAM532x9SitZDXnAXYBtRQNqO6o3MeV7UZ1fpAiwFuGsLuV47+NO61M
 /st3rRQxgCDVEHBcH60fbbUA8olp
X-Google-Smtp-Source: ABdhPJyGR+eoAV+MqIXDn7Tg8PLjadjC83sNT4bs9d5/O/4DfozIbWEBtPwgqLm7Ep1FjMQj+cyLiA==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr39464wma.180.1592694446355;
 Sat, 20 Jun 2020 16:07:26 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o82sm11455037wmo.40.2020.06.20.16.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:07:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] hw/misc/led: Emit a trace event when LED intensity has
 changed
Date: Sun, 21 Jun 2020 01:07:15 +0200
Message-Id: <20200620230719.32139-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620230719.32139-1-f4bug@amsat.org>
References: <20200620230719.32139-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Track the LED intensity, and emit a trace event when it changes.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/led.h | 1 +
 hw/misc/led.c         | 5 +++++
 hw/misc/trace-events  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
index 883006bb8f..df5b32a2db 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -35,6 +35,7 @@ typedef struct LEDState {
     DeviceState parent_obj;
     /* Public */
 
+    uint16_t current_intensity;
     qemu_irq irq;
 
     /* Properties */
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 8503dde777..37d9f1f3d2 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -32,6 +32,11 @@ void led_set_intensity(LEDState *s, uint16_t new_intensity)
 {
     trace_led_set_intensity(s->description ? s->description : "n/a",
                             s->color, new_intensity);
+    if (new_intensity != s->current_intensity) {
+        trace_led_change_intensity(s->description ? s->description : "n/a",
+                                   s->color,
+                                   s->current_intensity, new_intensity);
+    }
     s->current_intensity = new_intensity;
 }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index f58853d367..57d39bf9b9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -209,6 +209,7 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # led.c
 led_set_intensity(const char *color, const char *desc, uint16_t intensity) "LED desc:'%s' color:%s intensity: 0x%04"PRIx16
+led_change_intensity(const char *color, const char *desc, uint16_t old_intensity, uint16_t new_intensity) "LED desc:'%s' color:%s intensity 0x%04"PRIx16" -> 0x%04"PRIx16""
 
 # pca9552.c
 pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-- 
2.21.3


