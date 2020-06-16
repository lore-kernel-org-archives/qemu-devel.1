Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1108206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuwfCX5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1108206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5AR-00018E-SF
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58d-0007ty-E0; Tue, 16 Jun 2020 02:32:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58b-0003L7-SB; Tue, 16 Jun 2020 02:32:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so19470515wrp.2;
 Mon, 15 Jun 2020 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f9zWhfeSHYsZv9FAIqlLBjo48TjWhw0wg+NWuxqj8vw=;
 b=UuwfCX5CkOhlw3e/BftIxvfQayuTzx3I9EwR96/Q4gc+VJQqBuM5Bi9PBn7n5LI08W
 qDBwQ7BGfTALa/vIdIiFxSjX5K9mBHhbMVECMF3VJ8P0mvRiU5DJJE4dMY6nTEQg4guA
 GCYZx9dJBdCQkE1ZiI+sR7N4WapxJ7r4Thx0970cn10Z8egTLW6xTY5lQcPQ3XIrjIRT
 UOAdcJwPlxWEYFHdRJmB7hdadnK+S2heEBwJxPpklDH+XCDZOMzPPgtN91x1jt2eTDYZ
 eYnNqWfZvAJtDFICfxUvQNskSdLOCNQeP27YIZZxfMAcoovOZfeIdrCmvCxK123hzXrE
 +sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=f9zWhfeSHYsZv9FAIqlLBjo48TjWhw0wg+NWuxqj8vw=;
 b=VkKERCh5xKPK18o8NV4O9mIAd4irfAWGiAWqVmjTseh2zbCgvRuBeJKJxxcUm646hI
 qQH8QEFhmAKcMNLppD8wMVxAzEcMnAqBhkCS86d9iEvyKvMhkobzVptPRRX7D4q+Hwu7
 MYZjC+6CKPAsd0YRif4ax+GoJlKU1w+PW8uk9XSiKpP+iY5SmC80dbh2Dv/6Jzaoaq5h
 q8Mm2AM8EliF5P5NKP8S0ehmvXUJ8aR00SnLSK2fGJnS/ex0+I0VXx9qpKHncuHEu4tj
 MLA6eufuxBRFQ++wc3ICHYhlnETZnof+96UzrnPSqLzIVYrt23xAYJDq8CQB6cbt9N79
 7XFg==
X-Gm-Message-State: AOAM532fK873XbVEiJflyI+u0xnLaTTDA9XsWD8o299WzKU45AHaOO3T
 uwyHiRVhrBAt9+Nf2MtPuKQbCoow
X-Google-Smtp-Source: ABdhPJxVNuUa64NzNecRpVZiFLKHpmjTq1P2/rRqK/SPGevqFP38RXP3dXUv2rW7XhfLWHX8rKGTKg==
X-Received: by 2002:a05:6000:1184:: with SMTP id
 g4mr1282802wrx.46.1592289119471; 
 Mon, 15 Jun 2020 23:31:59 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:31:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] mps2: Add few more peripherals
Date: Tue, 16 Jun 2020 08:31:50 +0200
Message-Id: <20200616063157.16389-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few patches while playing with Zephyr:

- added i2c
- added fpgaio
- added gpio/wdg as unimp

Unfortunately the blinkled sample app is not blinking.

Zephyr ressources used:
https://docs.zephyrproject.org/latest/boards/arm/mps2_an385/doc/index.html

Philippe Mathieu-Daudé (7):
  hw/arm/mps2: Rename CMSDK AHB peripheral region
  hw/arm/mps2: Rename dualtimer as apb-dualtimer
  hw/arm/mps2: Add CMSDK APB watchdog as unimplemented device
  hw/arm/mps2: Add CMSDK AHB GPIO peripherals as unimplemented devices
  hw/arm/mps2: Add I2C busses on FPGA APB
  hw/arm/mps2: Map the FPGA I/O block
  hw/misc/mps2-fpgaio: Implement push-buttons

 include/hw/misc/mps2-fpgaio.h |  1 +
 hw/arm/mps2.c                 | 29 +++++++++++++++++++++++++----
 hw/misc/mps2-fpgaio.c         | 13 ++++++++++++-
 3 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.21.3


