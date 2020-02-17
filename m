Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A004C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9060206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQF9b72R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9060206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3erl-0008MC-Uf
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqL-0006TH-VM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqK-0002OT-Vg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:41 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqK-0002NS-Pm; Mon, 17 Feb 2020 06:45:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id g3so19302341wrs.12;
 Mon, 17 Feb 2020 03:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nvtVA24YsHTPrSYwj3qF+5DzrFJmWkSlCMlNJG9JnqE=;
 b=VQF9b72RHHe7Ve/RYts9HftY4hap3MiHLjyWjcgzehS0c+FM//w6Jjqqm8mj6okGhZ
 ZR5Bn4xmXPzDuPzxKlXGPkddOlJn5iwIMen2m44Uw+lgIBmiC2DD76VybtxlF8P1ULou
 2y8F6trv96sbadbq9GdLlqW2uKrnSUhClFrtaYxkVySNjdVwigIpj97FLp4vBmMO2UTj
 jxXD4pBiUkPifDaDyQ3QEoMgSjii0iUhpJHOJasqqPESWe6gfursFxVOTmtWSesb1wRA
 jT+bi6pQBeeeolI0ysrZWZ/UOhm5qG1XPOjcPtf79ICO4yyPnoLmIFXa5Yk50ik2TNu+
 C9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nvtVA24YsHTPrSYwj3qF+5DzrFJmWkSlCMlNJG9JnqE=;
 b=VwNiq275GV5p7l1Bzbhv1va0E8A9kRG+fiRBfEJQSFubEV/7th2P/mdFHhzu9pB86h
 nsQA3dviZLXMAlOmPlnfI94j+IOH/n54qOFS2oFetnD5OeyhShBwwDQbpKPNOUmiiN++
 Kgb63J41r0jLLHpxMkjWSyuYc3Ye7LCaDGl+ncUKtDzkqWTXi1xSIjohI6tsWejFOLRD
 Tv7GD+U0zx840t+W3V5I6PhBErd2yYrXDyaFkdTM5ZWeBOOaZ4hwVjXeBo32vq37fGKn
 m2BKSimn+z8pVt/WA12V+XypMqRYB7kBETRMeAx8XSVJGHchawpjfOd/SxA6MNua16Rg
 cEKQ==
X-Gm-Message-State: APjAAAXwdQblR71unA/lgBnNXNrpbH9/n/XHNHEX1+OjME/9GVD/qvSU
 mg6jI96q+hYpmGkeV2dH4uvGWphnygs=
X-Google-Smtp-Source: APXvYqys9gdI4WIvl1HTytt/s8/fdZZO0S+4nqbKCR6trw5eKJo+PWp9YLJv364WkSGZ01x6MS1LQw==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr21591033wrn.400.1581939939548; 
 Mon, 17 Feb 2020 03:45:39 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/13] hw/arm/raspi: Use more specific machine names
Date: Mon, 17 Feb 2020 12:45:23 +0100
Message-Id: <20200217114533.17779-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can instantiate different machines based on their
board_rev register value, we can have various raspi2 and raspi3.

In commit fc78a990ec103 we corrected the machine description.
Correct the machine names too. For backward compatibility, add
an alias to the previous generic name.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 1a8c135dc6..d9e8acfe3b 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -327,6 +327,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi2";
     rmc->board_rev = 0xa21041;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -337,6 +338,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi3";
     rmc->board_rev = 0xa02082;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -344,12 +346,12 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
-        .name           = MACHINE_TYPE_NAME("raspi2"),
+        .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
 #ifdef TARGET_AARCH64
     }, {
-        .name           = MACHINE_TYPE_NAME("raspi3"),
+        .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
 #endif
-- 
2.21.1


