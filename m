Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A4CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E50206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDmPDV0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E50206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3o7-00068J-Vg
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3kQ-0008IQ-IS; Tue, 01 Sep 2020 06:42:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3kO-00024H-Rn; Tue, 01 Sep 2020 06:42:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id a9so672555wmm.2;
 Tue, 01 Sep 2020 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EVwru8QefO28g6zuQPi1gYOba0DhzrEbVlsJ/k3IAUU=;
 b=FDmPDV0AiezhrXiEgWW1ImO/qAXvkwiFDwQJec+ITgfbJRe4Ta7BceBuxPENvTn2JC
 7WFoIkEUJfowqeaiVQde75uOmN58ByiSnm0uFHNtMnR6X4XILqbowy85isykuWTNLA21
 K2gW0wx5G+7yiStL2u7Dk63MWFCYKzUteuLqlAlmRPWVNuOLDxF8pL7sYTNgUoS9is2f
 KGWafk8poQAm0DjlEoIQsEQbyre5A4gHpBUB1B/j9r5obH3cY46eqhQTpZyMcLzyB1UI
 IvJ03Tax7mBHWeWs98OhiryK2eH5232ZeTM/n9ESCOGSaZdQN1aKTqP3lLZE7gBCZO3P
 2fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EVwru8QefO28g6zuQPi1gYOba0DhzrEbVlsJ/k3IAUU=;
 b=ah9kF/OxqJ8WRunNLg6H73gKnJmaRnHnzpTgWwSJzvxXkLJxL9VyDj0Moy+gAG+xz4
 O3/SrwulV1+lF63l481R+ELB/XU7F4fFzItV26BelcNpMo6TeodRoOi7WlahxC9L0Xua
 Ung0Li+zITBQfD+mGD4dDMy+8lXmSU8rfdRBQGB8JDL7v6zsKyD8QpuLj2x55NQJKfWT
 9fCDM5xV0ItSLHi+zuAsjofiPCkyboTQHMcHg8c9ElJZKXpmPrYbZ/E/CZkBVSosiFxv
 lhqzJYtviQZNci4e+4I8fK/WujfFVBPAdTd9hePro7D3Ujiq+hnoDHZUSNZtN+ArYu92
 pHVQ==
X-Gm-Message-State: AOAM532lpYdvhYol+9BAgkS0dSOX+9Oj22bkIIeTRpZbqU1Jc9kx0bhj
 wjT3NcxzNqLzF6eKs1MGRZKBsk6cSUM=
X-Google-Smtp-Source: ABdhPJypEr+vaB2RF6vlq5MimhR66P+QUc5YEOr62cjKqp5COsGq+QLjspGpkV0oXoAzOBSzIxn9yw==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr1114027wmi.135.1598956958026; 
 Tue, 01 Sep 2020 03:42:38 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l8sm1693217wrx.22.2020.09.01.03.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:42:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/gpio/omap_gpio: Replace fprintf() by
 qemu_log_mask(GUEST_ERROR)
Date: Tue,  1 Sep 2020 12:42:33 +0200
Message-Id: <20200901104234.92159-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901104234.92159-1-f4bug@amsat.org>
References: <20200901104234.92159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace fprintf() by qemu_log_mask(LOG_GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/gpio/omap_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index f662c4cb958..e25084b40c9 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -392,8 +392,10 @@ static void omap2_gpio_module_write(void *opaque, hwaddr addr,
         break;
 
     case 0x10:	/* GPIO_SYSCONFIG */
-        if (((value >> 3) & 3) == 3)
-            fprintf(stderr, "%s: bad IDLEMODE value\n", __func__);
+        if (((value >> 3) & 3) == 3) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Illegal IDLEMODE value: 3\n", __func__);
+        }
         if (value & 2)
             omap2_gpio_module_reset(s);
         s->config[0] = value & 0x1d;
-- 
2.26.2


