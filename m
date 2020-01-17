Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83967C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E932073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsC0beMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E932073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSls-00013Q-65
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbu-0006Io-I7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbt-00074y-BG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSbt-000747-59
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:29 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z7so22863831wrl.13
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yAXStqvSo75J+RhFz6OTyKrPT64wS5FAux7gYRx0+CQ=;
 b=ZsC0beMfjQld6iTNEYAfF8YBq+Xlb5u843+eo3HMe4lSTqUrcud3L1/kBLQ/IP4GH4
 NznG4kHxSp3CDK2dfl1uytDuqXAKfqxvp8HakADQ9AbobC+YLIitxbVhrlrT+/G0fCjj
 JZIwaoZrpJGv9FoJkpVVCL/UiB35lA9Yf43A+kJIPEx5so6+w1wPaRztB5pLubg3YPTJ
 tL1SzRKZsHUQN8O+z/1s8n2Cszxf4A0tMkkIC9b53ZDStZjxaSYxkFOKgFHqTu23te8c
 OWlt/kBEepzVUKc9OtNxdwpvoPGIeqHV2iMu6XSe4B2J7BpjYFJMtOoK8TbCtN6WKNWG
 uh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yAXStqvSo75J+RhFz6OTyKrPT64wS5FAux7gYRx0+CQ=;
 b=JgbX7zh5GQvOE913E1F4PCv599nKjUq4axKfCq1nlwsaBC21p/c4L+ZOEmLW+Y3+TG
 LlTb6U4HSfybWiGeZjUsSUEo0oxGbJYdzVaRYxa/QbLow15j6QGY0wXX2GYYBaokRBOm
 9a66S8WFHYpfMSUcpn1hxt1R9afapcUJtW9vau8EshcPpT64UqbHczhUM8GsPArvFYp6
 O5uFIpBfuKR87ZP6jOBGAMGa1J+43xM1kyh30vyOkaj8Jrjk9Ektx5xpb9GtoAmKnUe6
 i8i+D+osOA1COh9FOsxYyTA3BE+UyNzjrmL7QHxF17/Cl0zIx3VAeMfHogHUKmezTv6Z
 HWgA==
X-Gm-Message-State: APjAAAW0thK0Fxz9P62BVBpwp35mtqGqTWMZdu958QG9kuCuc3V2pqyA
 4T24RMNMYkKlYDoxgnVkti8HE/+sOsSfTA==
X-Google-Smtp-Source: APXvYqxNF/2R/T8vABiouIZfp1Bcpg7Y1YWV1sUbzAJOoxL/2vA43Bf+ruytc2zgPut8OXNGBJ25UA==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr3361568wru.122.1579271307867; 
 Fri, 17 Jan 2020 06:28:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] hw/arm/allwinner-a10: Move SoC definitions out of header
Date: Fri, 17 Jan 2020 14:28:08 +0000
Message-Id: <20200117142816.15110-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

These definitions are specific to the A10 SoC and don't need
to be exported to the different Allwinner peripherals.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20191230110953.25496-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-a10.h | 6 ------
 hw/arm/allwinner-a10.c         | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 7d2d2156308..941c61e5336 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -12,12 +12,6 @@
 #include "target/arm/cpu.h"
 
 
-#define AW_A10_PIC_REG_BASE     0x01c20400
-#define AW_A10_PIT_REG_BASE     0x01c20c00
-#define AW_A10_UART0_REG_BASE   0x01c28000
-#define AW_A10_EMAC_BASE        0x01c0b000
-#define AW_A10_SATA_BASE        0x01c18000
-
 #define AW_A10_SDRAM_BASE       0x40000000
 
 #define TYPE_AW_A10 "allwinner-a10"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 118032c8c72..0f1af5a880f 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -25,6 +25,12 @@
 #include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
 
+#define AW_A10_PIC_REG_BASE     0x01c20400
+#define AW_A10_PIT_REG_BASE     0x01c20c00
+#define AW_A10_UART0_REG_BASE   0x01c28000
+#define AW_A10_EMAC_BASE        0x01c0b000
+#define AW_A10_SATA_BASE        0x01c18000
+
 static void aw_a10_init(Object *obj)
 {
     AwA10State *s = AW_A10(obj);
-- 
2.20.1


