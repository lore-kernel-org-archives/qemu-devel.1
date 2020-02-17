Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F94C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25772072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIgkCyxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25772072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3erg-0008Cv-Lb
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqI-0006Pq-Gk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqH-0002IJ-FO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:38 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqH-0002Hc-9E; Mon, 17 Feb 2020 06:45:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c9so19351269wrw.8;
 Mon, 17 Feb 2020 03:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OKKON3O0UkDeBGXdhe/eMG38enuW1oN2XE70v4ZaC5c=;
 b=pIgkCyxKcIOZYxi7YzrAu60SEKzKBROAMl1AZkI8RExOI1AfJb7Oyh2/iAUxS09PQN
 oJcGTpPxpIcYSGoVK0MIq6czedW5D8CyQ4L1zZLaS3TbhQ7kaUqC+vkZRcJ9U1hMOxqk
 yXbCzMul3cSf8rgxDyD12tQbq4dedIpGNi6pHxDStDLto8EfgDBE6Qbjz12Wd7j0IK9P
 w9SGdhKySoXgSDHZ597c1qS2b4+mVOEO74CoAF6mHLoqJ/LDKvcYEfaLdm0rCP8avGGX
 qw/vn2VGQM0ZQEZsjSsMXo0zHeXod5rr9IZn1jliNdHIVGTSmneOzwzr1ijwOdzxvsJI
 u8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=OKKON3O0UkDeBGXdhe/eMG38enuW1oN2XE70v4ZaC5c=;
 b=KmR79k1Yq0iymixHBYn2bjez8aimnBqQnZo8BuCvnIYQQP+J5Xl+AN8ey9BircZ+xQ
 TXlHi+OX/vXyuD1vCjvVakvbqq7q2Yy4UxSeMzkvYwZIKWFmataak8r+6EXiJ571IvGA
 De2nSr31DaW3cG+4sMeaBtBp0rU8yow6Bsm84KVJpBOs9c1xWefIbqjipEvBAhlJ77yn
 ruCFXnHgnahwO645AW7fe/a05vnjkoO8e38+puw2C71yuYFAWJ/V/mhWdkbvktKS8FGV
 zB8BS0O1FZvhn4A2K0Yvb1Ij+QR0uESB5F2Z3gqqrie7i/XyMGotT3ZletiHnin76PgI
 Lnhw==
X-Gm-Message-State: APjAAAUsFrpBQD0yMnPnNgablFTCizw1G/OmfNPZ4t3BZCXsovQZotRv
 BX8N+SKLrZez45l1e+1I28x2NSRM+sM=
X-Google-Smtp-Source: APXvYqyfbVKXRRlPIwLcIfyWxh7XDX00V7hw9EV0F4dUQv3k63qbE5fnyvP38dNPQnpvhT7UqKfC8A==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr21883714wrm.59.1581939935803; 
 Mon, 17 Feb 2020 03:45:35 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] hw/arm: Add raspi0 and raspi1 machines
Date: Mon, 17 Feb 2020 12:45:20 +0100
Message-Id: <20200217114533.17779-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

This series addresses suggestions from Igor and Peter on the
raspi machines, then add the raspi0 and raspi1.

Since v1:
- Use more specific machine names

Philippe Mathieu-Daudé (13):
  hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2
  hw/arm/raspi: Avoid using TypeInfo::class_data pointer
  hw/arm/raspi: Use more specific machine names
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
 hw/arm/raspi.c           | 153 +++++++++++++++++++------------
 3 files changed, 226 insertions(+), 132 deletions(-)

-- 
2.21.1


