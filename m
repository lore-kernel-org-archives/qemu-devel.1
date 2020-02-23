Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E5C35673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986F9206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjuY+e0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986F9206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60im-0002iv-KL
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j60hs-0001lt-6y
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j60hq-0006Zv-Vd
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:30:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j60hq-0006ZS-Pc; Sun, 23 Feb 2020 18:30:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id a9so7472584wmj.3;
 Sun, 23 Feb 2020 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=La3cNuySg7AvW4GmOXYMUpGVVY/iiFpjp6iEqmCbx0k=;
 b=IjuY+e0S9ggGxJslwi56PZ/GXrgJo7mN5OLotADSFCPd5qSKsNs/w8V45wSyn+wDY2
 Z4E9TcRdH2n6yfk/nigU3yTfVDIzs0fLagMhT9EgalqBSCDhDebx6sjzu/ZXvhLl0oBV
 ZK8OeJik6RyV781WV5RgXKhbvpVNOznZyppd0g53CK6HpcjIKcYbCpaWOYMpjOjeVUFn
 raKxIMQaxVmGRTkjju1nPEd/gr4J3ZftiYjEh2PXYdUtHyHWCSvYR4JlQpxv2DO/DYoL
 X3lBLToj89K7sh2ClfOFBm3HR+weEf4W+rH2SSa0aA+w9NWtPXU9F0+NMxie42K5NFv/
 EQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=La3cNuySg7AvW4GmOXYMUpGVVY/iiFpjp6iEqmCbx0k=;
 b=J4OcE2ByEmInwOg83nX25Prf668pUlOGKAfZxfPJ2s8AmUpZ+2esShTmn4zT0NJGkW
 IXcouT70gDAtN2sgXz3UpyeSyYjlKiZ9fhse+Se6aNA2x/ktv9J9rOO62LeyZh4dBNwz
 TCmPHsNLQqIqQrufu1KOydJuTDZVKGgUHZ2cnt92+XFLdzeeu6QS46xeuk6KVG2vrsRw
 kM1+uNOSlABU1xdVv8OyGyv4nYmQAZ9ZTTVayb2ExyHobzHMM6VauTKKKuF0Qq0S6Rlj
 mFTHHYbDsxU9rrpPXV2wAoYq0iJ+j09O+dPbBd0WLBWUYkADyHbX4oL6GxCdvCgVeaE4
 5gdw==
X-Gm-Message-State: APjAAAVML5xu0G5laufowKZqRmuWbqDn1dk5PrqPSJUWuStncB2Lv0ik
 34DJVjS7VGBGJkwpKtz4t4GdQ8qo4sY=
X-Google-Smtp-Source: APXvYqz8OMcIsqlsWRWxFlekfo2lM7hp/nzV64KA3b0vRMTzk107XZnMlBR3EGNoXb9b6G1PT15n1Q==
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr18830025wmd.39.1582500637568; 
 Sun, 23 Feb 2020 15:30:37 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j11sm15322117wmi.3.2020.02.23.15.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:30:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/arm/integratorcp: Map the audio codec controller
Date: Mon, 24 Feb 2020 00:30:32 +0100
Message-Id: <20200223233033.15371-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200223233033.15371-1-f4bug@amsat.org>
References: <20200223233033.15371-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel displays errors why trying to detect the PL041
audio interface:

  Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
  CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
  CPU: VIVT data cache, VIVT instruction cache
  OF: fdt: Machine model: ARM Integrator/CP
  ...
  OF: amba_device_add() failed (-19) for /fpga/aaci@1d000000

Since we have it already modelled, simply plug it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Kconfig change was not committed
---
 hw/arm/integratorcp.c | 1 +
 hw/arm/Kconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 0cd94d9f09..59804140cd 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -644,6 +644,7 @@ static void integratorcp_init(MachineState *machine)
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, 0));
     qdev_connect_gpio_out(dev, 1,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN, 0));
+    sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
 
     if (nd_table[0].used)
         smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0..61635f52c4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -69,6 +69,7 @@ config INTEGRATOR
     select INTEGRATOR_DEBUG
     select PL011 # UART
     select PL031 # RTC
+    select PL041 # audio
     select PL050 # keyboard/mouse
     select PL110 # pl111 LCD controller
     select PL181 # display
-- 
2.21.1


