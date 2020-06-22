Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B19EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96A020738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGprnMsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96A020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRIz-0007lb-6x
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHI-0005ZN-Is; Mon, 22 Jun 2020 14:34:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHG-000828-RN; Mon, 22 Jun 2020 14:34:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so402753wrj.13;
 Mon, 22 Jun 2020 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4GBGEh6Db674+Aji4tc1w+GewZpWzYhsxSqd+J2m2Y=;
 b=DGprnMsv4oKNw34j4Fel/qGrapLLg1nxtJKOpxB6h0mVTgHsfQF8ltovH6lgaSxkUC
 u8I+aRCietuslCUUO2RPXfqFYDadVmi1Wr2kDbnZfgkRr3RVmIYpBhN5s95ECYZy0mr9
 5RzOCWCDaMuW////l6OZZPBhPQMmlJjLyq3N01BeSuk/aBy4QZkEgzz0+pxfmKBXPd+0
 8Pgkk8pbpy1bAIZA4q4RMGNIdiFNHt0FdSlyTO9wJZfryBvsePJ8LEjnV2Tkl9TNnfER
 otYzTVF/b+q3mLpCz5ldWLp3/9C4VxskVlXebwbTiC27308GYFSY7fofzCBlF9WEeVAC
 MAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B4GBGEh6Db674+Aji4tc1w+GewZpWzYhsxSqd+J2m2Y=;
 b=aa/1efjCnAEtwNvq4LMzBHapBOauVCcPpgkAF6p1tLvjze9givc5ONlL3dbPgnJRoc
 Oyk+3eUn72k8RLNUAQPmY54HqgDNDN1SjTmmZ70PKbMueBlUxMaF2NT1haOUMNlCK/5b
 QB/gOm9uvOCy2PWLnmOmRCf1Unn96k/Qm6NQwycNN1OemJ2h1RvN54WTl3AxqjIXFeaB
 QDRgIW2Hra5HRJv3Y1B740smqRG1hEwS9+pUU6mf3VgmZZkFCxS78EMLoVPKg6+nr7K7
 D1rc2n/N8oHyM4xvFiNmuPyri+bCf+LWoGr0UInHrrhANmPkDBlOqENs4tVKFaQBCIvB
 C7WQ==
X-Gm-Message-State: AOAM5321VFXwxn9MOyjbATapgJp/zyS+evyFHBfF7AeoKezw/rrxYiok
 eYXVv3ZYITATR7LTXuSAQF8plrW/
X-Google-Smtp-Source: ABdhPJzhn/fVwHvBQ4GiJOjuVAKaSoMk/2xGZF8OeGbV6tClllvvKMFaCoCfwTBb8uq29Rqov6u4wQ==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr7852217wrw.211.1592850880946; 
 Mon, 22 Jun 2020 11:34:40 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 8/9] hw/misc/pca9552: Trace GPIO change events
Date: Mon, 22 Jun 2020 20:34:27 +0200
Message-Id: <20200622183428.12255-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622183428.12255-1-f4bug@amsat.org>
References: <20200622183428.12255-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emit a trace event when a GPIO change its state.

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_change
  1592690552.687372:pca955x_gpio_change pca1 GPIO id:0 status: 0 -> 1
  1592690552.690169:pca955x_gpio_change pca1 GPIO id:1 status: 0 -> 1
  1592690552.691673:pca955x_gpio_change pca1 GPIO id:2 status: 0 -> 1
  1592690552.696886:pca955x_gpio_change pca1 GPIO id:3 status: 0 -> 1
  1592690552.698614:pca955x_gpio_change pca1 GPIO id:13 status: 0 -> 1
  1592690552.699833:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690552.700842:pca955x_gpio_change pca1 GPIO id:15 status: 0 -> 1
  1592690683.841921:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690683.861660:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690684.371460:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690684.882115:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690685.391411:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690685.901391:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690686.411678:pca955x_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690686.921279:pca955x_gpio_change pca1 GPIO id:14 status: 0 -> 1

We notice the GPIO #14 (front-power LED) starts to blink.

This LED is described in the witherspoon device-tree [*]:

  front-power {
      retain-state-shutdown;
      default-state = "keep";
      gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
  };

[*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n140

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/pca9552.c    | 15 +++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 13f5ed0da4..5997eef8b2 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -82,6 +82,21 @@ static void pca955x_display_pins_status(PCA955xState *s,
         buf[i] = '\0';
         trace_pca955x_gpio_status(s->description, buf);
     }
+    if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_CHANGE)) {
+        for (i = 0; i < k->pin_count; i++) {
+            if (extract32(pins_changed, i, 1)) {
+                unsigned new_state = extract32(pins_status, i, 1);
+
+                /*
+                 * We display the state using the PCA logic ("active-high").
+                 * This is not the state of the LED, which signal might be
+                 * wired "active-low" on the board.
+                 */
+                trace_pca955x_gpio_change(s->description, i,
+                                          !new_state, new_state);
+            }
+        }
+    }
 }
 
 static void pca955x_update_pin_input(PCA955xState *s)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 9282c60dd9..7ccf683dd1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -209,3 +209,4 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
+pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
-- 
2.21.3


