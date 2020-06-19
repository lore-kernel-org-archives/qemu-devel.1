Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C0EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DB0218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbDkTw0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DB0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIOI-0007am-OD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmIMJ-00043S-SR; Fri, 19 Jun 2020 10:51:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmIMF-0003fq-Tt; Fri, 19 Jun 2020 10:51:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id q2so7532637wrv.8;
 Fri, 19 Jun 2020 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=16xjyyRgElKBAJMa5MhJMGbj3Pu1zRssl4AgrYkonAg=;
 b=nbDkTw0dLgrqDBjj5Hs5NojrXscADRtzLI9DnFW346lJEOEHt+OFMp/+J7f71V20YR
 J7BpUYu3IUMeEjUo3cZVj065beiZNzERDr0xw4MqIFWA2gaNWuHBF50JMVeuVfEZq05v
 YCZ5SmnbnPftLg6M4ZRbISq88hDlVp6tyieb3weMuc+hvzl4GDcs0PJdW1bi6BwyhrWB
 uneeeH96RZMONxGfsa+V1J8+k+xiHBgbe2ORgtCfJ+RvgwrgNwlz7hfk9Y8mPdCEdKyZ
 vNGg5VGHU2Iw9EhHTus8IuouHTDIiGnqaMlWhXeCjnglw4bo6QcZZOrPqSMBlazSngpn
 fIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=16xjyyRgElKBAJMa5MhJMGbj3Pu1zRssl4AgrYkonAg=;
 b=Orzbwz55ldmm9aS9HmfdMniNnWzDJMuO41UT1gRcaF6GErA9DUmOH9GHk0jau3JxaX
 pNJeFg0qnoHw7lBeReadCZUZnBbZitFJnO5OggWE5XpuB6A4BSC/MVBOzbORaL4QFQxj
 zjBOPSfo7PSCtG3P46juTO2y5K+XrzeabzKq2xjPg3FUD/CiwMI6ArM4UoQ36Bn5JOSF
 zBFxr7MvGIdwfGJMn6uw626wx1NUQnG0Fp2Ru03kTOwontzexZ9vhew8nFsi9QMtxP/Z
 +nZGw8C5fLsQDDHlq7/Q7JzzQ0KZX3rZMexfyqxrwQodQIjxUtW1/uyhSAMR9v6H2nyL
 bmgg==
X-Gm-Message-State: AOAM5324o1BVbFq2HmRWRScGfFA2m4RzVEffvQqnf5m7KzHPwmTgdxAe
 L0xi9muFxQ2AqMwiX8/DaiUWDH0e
X-Google-Smtp-Source: ABdhPJzKjaTGJLmvt62Eeo0OJ76G4Al1la6iiWcC2tw4tNJNcaOonTWvdcONcK2nEsSQGhO4d3wbCg==
X-Received: by 2002:adf:ee41:: with SMTP id w1mr4647811wro.172.1592578265166; 
 Fri, 19 Jun 2020 07:51:05 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id e12sm7512548wro.52.2020.06.19.07.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 07:51:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] hw/misc/pca9552: Replace magic value by
 PCA9552_LED_COUNT definition
Date: Fri, 19 Jun 2020 16:50:58 +0200
Message-Id: <20200619145101.1637-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200619145101.1637-1-f4bug@amsat.org>
References: <20200619145101.1637-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the '16' magic value by the PCA9552_LED_COUNT definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h | 1 +
 hw/misc/pca9552.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ebb43c63fe..b2b9a5d9d4 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -15,6 +15,7 @@
 #define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
 
 #define PCA9552_NR_REGS 10
+#define PCA9552_LED_COUNT 16
 
 typedef struct PCA9552State {
     /*< private >*/
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index cac729e35a..e015ef0e5d 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -291,7 +291,7 @@ static void pca9552_initfn(Object *obj)
      * PCA955X device
      */
     s->max_reg = PCA9552_LS3;
-    s->nr_leds = 16;
+    s->nr_leds = PCA9552_LED_COUNT;
 
     for (led = 0; led < s->nr_leds; led++) {
         char *name;
-- 
2.21.3


