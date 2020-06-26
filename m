Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7AAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCA520702
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPfqbBg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCA520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq7M-00071E-3x
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq40-00027V-Cy
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3w-0006I1-Pv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id g18so9900907wrm.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RX+/KL2V5N56qsvGdealctYk7vBUGmzE5uNTGiV8fFk=;
 b=UPfqbBg6Plf49zdwp7xWUDjXIB2z+dfIP4BQftCMCYq8IKwFEerltLx5GeUDX/hAkJ
 nV/CP/+CQM60BL+QIXHfVtTQrMjDqL39nVg/stduAa4Zc1eGuODLCJHANW0WKFCTj/am
 P+o3Pp17M3K/0cRge9gBCBfkWTQLoTQFpgMDJpa+HFufJ0ylde8r6HbzHHCNq+qqhMXl
 ygQLtWHfGHS73RNBMLpBtV0npSg3u0zAvY+JaGI52b93H6U9aWE6Wx707JP3UjK5ERyo
 gieBKBbmvu81XdJ9m2UVm+jtAoqr1eF0JnwrkFfHF/CKANFNYh664vv+94Ip7NdzhW9v
 y8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RX+/KL2V5N56qsvGdealctYk7vBUGmzE5uNTGiV8fFk=;
 b=pKUywJpaqsgUE3jvsCdYVagV5znja4wU+ezINasnkyOqItNH2vgqmga1IqLNF2k4Kp
 auizKDyyhKugjZfnBCI15pID6kq2vpB9LZewcbQ7NMIxkp6DITSyp/afJNo986P3Jizi
 jNOugHVTzicFNq6c1wbBmh6Iv4owZFeJpTIC/ukLWkursPkydNsxxYE5m4UI8k7V66rs
 GofnghgG4vKANyky9TVsy42Sq0xVCHtp9EnZYcrSfuyCZbbkegUqdxF47ZkLq4indh4S
 wUs2JFKOc9yayyI5MLKGjRXmBtDaUjjckbSWSLHmMX0YNAsbtfZzGD1DstOw3B+IxRjg
 2TRQ==
X-Gm-Message-State: AOAM531cKrehAH3jrlQp4Lz3OLPTwRNQOfZ0D9Bh/RIZ7USZHiPXTLjP
 pcFhg7tumYdta1X8nh4fwyT8iqRCFmGPFg==
X-Google-Smtp-Source: ABdhPJzIT3HXS6wf54XZdzojf+5Yu+3JGXH+xEiZ6wWlzzZl4BzFfSOsaZYGHDmfvFxyOYwTGCF7gg==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr4360107wrj.264.1593184478890; 
 Fri, 26 Jun 2020 08:14:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/57] hw/misc/pca9552: Trace GPIO change events
Date: Fri, 26 Jun 2020 16:13:38 +0100
Message-Id: <20200626151424.30117-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-9-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/pca9552.c    | 15 +++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 41f8ad213dd..1c3ad57432a 100644
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
index bd7bd37ea8d..ebea53735c4 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -212,3 +212,4 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
+pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
-- 
2.20.1


