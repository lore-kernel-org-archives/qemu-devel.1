Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACEEC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46FB206D6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBMwDMC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46FB206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53757 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j32vx-0001VX-Se
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32ur-0008EE-Ar
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uq-0004D9-Dw
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:49 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uq-0004Cb-6Y; Sat, 15 Feb 2020 14:15:48 -0500
Received: by mail-wm1-x333.google.com with SMTP id t23so13348084wmi.1;
 Sat, 15 Feb 2020 11:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=94TQ3PHsPmM1h4P1Ok9gsOjwJAK9YdMeQSxwEBTkMcA=;
 b=XBMwDMC8cKaB3W102R1NH5FzFJb+ixSeUYrMYKOMSGhvkIxhN7diQVjv2SH7QM1xr0
 IL4No9ABAVLM0bPWE6ds10fzrRc8EQ9kkpnfYNk4K+UVWEXNywzpvhIxpUdPbXloAZt4
 0+2timNLHBHoVZwLoJsLr9fQZNfohHST7+WICxWzXTnf1xFM2yUoKC9imB0mBXiM5P2y
 i3DvVk8TP4yGY22KaqbrrMWfup5LF5TWS5q2ENLxyCHnJWpoD/164PsRe6fOZiJG9y9F
 4J913wOKCLm6MhxXZTxEY39ZXe8PE1a1wkIGumffKXU7Wfm141U0EyrSiyiyslzyQ6Np
 7jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=94TQ3PHsPmM1h4P1Ok9gsOjwJAK9YdMeQSxwEBTkMcA=;
 b=myWLZ/87gnSm2hH/7XuSVtjzbHegE/1B58UZ5uLx636SKWaIsCxMU2cNLQgAdQOv0X
 nhpyNHLY5anFUP1tVVtut5j+KzPtwJb3KbzB1RScoO8IHN+4CyzgUX3g2V1G5vnRUWNc
 Ri6puHJSmSOGbppSoKe9fOsOI/6+sAcgri0DviuCHakXkMXP1zvlbb2D6Kb5X4wOyFjw
 Ptvhi6ILFWFq0AK3l68mhDJn9rCit8L/+yaYktxtQPysL9WcGa/JcjHZmHTCirsqjYU2
 Hzng/AFBrARWWrzAAo+jPakjp7CPpp5k3pIiWwEXQbyqtTQwICvZXBn+6h2o1qQZ7Dy4
 fplQ==
X-Gm-Message-State: APjAAAWjlHD35wqJ1UFdd8OFCN4PSpZH4UA9Jx3EmF2fyhES2BBfA9Er
 1xg7tvERohbSDoeV5JbiZcjBilW6i+U=
X-Google-Smtp-Source: APXvYqx0WiFSeC2ezhnwisnUMlOZBKkoQ23ymAkjAuZR6WKIC7i6abRDekrctcWrDwkCTtew6+gtuA==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr11635928wmd.62.1581794146339; 
 Sat, 15 Feb 2020 11:15:46 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:15:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] hw/arm: Add raspi0 and raspi1 machines
Date: Sat, 15 Feb 2020 20:15:31 +0100
Message-Id: <20200215191543.3235-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series addresses suggestions from Igor and Peter on the
raspi machines, then add the raspi0 and raspi1.

Philippe Mathieu-Daudé (12):
  hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2
  hw/arm/raspi: Avoid using TypeInfo::class_data pointer
  hw/arm/raspi: Introduce RaspiProcessorId enum
  hw/arm/raspi: Remove use of the 'version' value in the board code
  hw/arm/bcm2836: Restrict BCM283XClass declaration to C source
  hw/arm/bcm2836: QOM'ify more by adding class_init() to each SoC type
  hw/arm/bcm2836: Introduce BCM283XClass::core_count
  hw/arm/bcm2836: Only provide "enabled-cpus" property to multicore SoCs
  hw/arm/bcm2836: Split out common realize() code
  hw/arm/bcm2836: Introduce the BCM2835 SoC
  hw/arm/raspi: Add the Raspberry Pi B+ machine
  hw/arm/raspi: Add the Raspberry Pi Zero machine

 include/hw/arm/bcm2836.h |  13 +--
 hw/arm/bcm2836.c         | 192 ++++++++++++++++++++++++++-------------
 hw/arm/raspi.c           | 145 ++++++++++++++++++-----------
 3 files changed, 220 insertions(+), 130 deletions(-)

-- 
2.21.1


