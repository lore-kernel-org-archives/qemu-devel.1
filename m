Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D215208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQm/bFMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D215208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRs7-0006Lf-LO
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlRrJ-0005WU-Fr; Wed, 17 Jun 2020 02:47:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlRrH-0004p9-R8; Wed, 17 Jun 2020 02:47:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id b82so712575wmb.1;
 Tue, 16 Jun 2020 23:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CnaLNwUn8V4ZTLNAsPC6dg4DQs3YM2sT/YEQ8oA2ti4=;
 b=nQm/bFMMIQSLLf++soFh+4IbWZYDY7wYpYc1hYshzS310O0Lsd1XU0FkgE3q1RKA+R
 LqJlxfysU3i8K7CklZEtfmYQT6fLh7Pcbc0+vhXUpG1/tZeDilZ5QsnfnPlezbfI5DTK
 q0W77CrA56EVBhSjng66XVqM+nyM8KrFP/Ou1DT6r0LiGfmoawpFWKdFVNKzhDJ5oaaf
 WA8ZRD8kvUN7/G5YcB7e3MooqdIi6NU9hb2zQcua0UpOePJEBTu83JHx8MqN1J0L2NW1
 hlN1SHzKP9YopOudWgmdSDG/tQbBCJRPiAHVgLsAWeS/OZ37ZkDbkSpRczTpi6G864Fu
 ceQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CnaLNwUn8V4ZTLNAsPC6dg4DQs3YM2sT/YEQ8oA2ti4=;
 b=Wbnr+ENlzb76khpHhsT24tdHAGmsW8EW788fuM2syGB8Pl53vveBnGYJZQdqJl+hvZ
 a4tj7T/LssNLtJxpg2/wxJclzAxlMkKzUn9yA2uLUEWLbMHD2Spq0fX9D0hMOwp/SCGT
 Dgw/9FN5pe276NjaW6T5Tx04q7bZws1gxcrmKV36IhpegPpbFZHozmRGP6jgbo4ObPr1
 QuOziAxBzQhIRGZXskgUu8ExshB2L4Ll9DIqYAbL9EPlZC3tOt7Ck5Hxi4ipCPkH4vIp
 tKrtMNTTWVmQUhkkl2vjdog9/hFUkRgWqj0N4EL5q5DH7Z9Q6rYVwf4NOgdwE5AF5pBU
 1PNA==
X-Gm-Message-State: AOAM533PXkEt/DQDCe5R6scEenHTV94MG7YrsZWutBR2e+WBX5JAnnwC
 spGDdnAleeAPWNptpmLGyp4lB0O5
X-Google-Smtp-Source: ABdhPJyvuIXp5b41CExF6t0GhmjU9pq2GUVUKvWaoTdGOxwoLNQInbsF4c9fxOp6aEnDyZ0dUJ8mnA==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr6762485wmc.134.1592376456937; 
 Tue, 16 Jun 2020 23:47:36 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id u12sm32452607wrq.90.2020.06.16.23.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 23:47:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/misc/pca9552: Trace LED On/Off events
Date: Wed, 17 Jun 2020 08:47:34 +0200
Message-Id: <20200617064734.26956-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace pca\*
  26033@1592376001.873828:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
  26033@1592376001.874169:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
  26033@1592376001.874348:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
  26033@1592376001.874514:pca9552_led_state 0x5594a9f57560 LEDs [........ ........]
  26033@1592376001.879601:pca9552_led_state 0x5594a9f57560 LEDs [........ .......*]
  26033@1592376001.880507:pca9552_led_state 0x5594a9f57560 LEDs [........ ......**]
  26033@1592376001.880885:pca9552_led_state 0x5594a9f57560 LEDs [........ .....***]
  26033@1592376001.881228:pca9552_led_state 0x5594a9f57560 LEDs [........ ....****]
  26033@1592376001.881601:pca9552_led_state 0x5594a9f57560 LEDs [..*..... ....****]
  26033@1592376001.881952:pca9552_led_state 0x5594a9f57560 LEDs [.**..... ....****]
  26033@1592376001.882299:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
  26033@1592376065.090910:pca9552_led_state 0x5594a9f57560 LEDs [*.*..... ....****]
  26033@1592376065.600649:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]
  26033@1592376066.110565:pca9552_led_state 0x5594a9f57560 LEDs [*.*..... ....****]
  26033@1592376066.620390:pca9552_led_state 0x5594a9f57560 LEDs [***..... ....****]

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/pca9552.c    | 18 ++++++++++++++++++
 hw/misc/trace-events |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index cac729e35a..693f6c3b24 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -17,6 +17,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "trace.h"
 
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
@@ -95,6 +96,23 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
     case PCA9552_LS3:
         s->regs[reg] = data;
         pca9552_update_pin_input(s);
+        if (trace_event_get_state_backends(TRACE_PCA9552_LED_STATE)) {
+            char buf[2][9];
+
+            for (int i = 0; i < 2; i++) {
+                uint8_t val = s->regs[PCA9552_INPUT0 + i];
+                sprintf(buf[i], "%c%c%c%c%c%c%c%c",
+                        val & 0x80 ? '*' : '.',
+                        val & 0x40 ? '*' : '.',
+                        val & 0x20 ? '*' : '.',
+                        val & 0x10 ? '*' : '.',
+                        val & 0x08 ? '*' : '.',
+                        val & 0x04 ? '*' : '.',
+                        val & 0x02 ? '*' : '.',
+                        val & 0x01 ? '*' : '.');
+            }
+            trace_pca9552_led_state(s, buf[1], buf[0]);
+        }
         break;
 
     case PCA9552_INPUT0:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5561746866..21e52f192d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
+
+# pca9552.c
+pca9552_led_state(void *object, const char *bufhi, const char *buflo) "%p LEDs [%s %s]"
-- 
2.21.3


