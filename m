Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A96BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF94320738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg19kbUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF94320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRIb-00074q-1y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRH9-0005It-94; Mon, 22 Jun 2020 14:34:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRH7-00080Z-Gu; Mon, 22 Jun 2020 14:34:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so539718wml.3;
 Mon, 22 Jun 2020 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WQVzrJo0+uFvQubjyJAfLAob8SKpXhhqZW9uXjPLrsI=;
 b=Dg19kbUHxMYzqYNmJs2uygUQc9xRCVbNlPrPKyxryL5XrIK1dj1P/IWqD5Vtct1ved
 85pI7y0gx0sh4WpDDbd4EN8DklkErmmqjmpY/ZvV+EJx9ud31gsksMRnUurj7KVpyeiI
 bx2owmtLyXiR8SCMDa5utgxH9E90OJCeZ1vkVQoXvhKvy0eHtvqHAn+3vklMC94e71zn
 DZ9kAvnatqH5Zxzj20ujxEJYp4rZqmCmrXf1GBCfD2TlpmVb5OTEUTzWww/PPXSD3O03
 hyDEOV6eKkKOQO2TljVfXwdGUqkgVZu1beOOwoI6FkWXiHbl/7zuV8BxQ5Hr4rmBVqwP
 KX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WQVzrJo0+uFvQubjyJAfLAob8SKpXhhqZW9uXjPLrsI=;
 b=ocjh5WSr5tGNZtS4xpKZXzwaAs8Hy7EK9LygxT6I1uJ7VoxTxb91VU/6Ul/GEvzFQp
 OxVp+Q/VH8EckNr/uyNuQw3Ads3i8GhOx4///PMaO8KihvShdaAZgoX9NmJHfLkqJqjC
 70Dd4oSvWik76IU1KaW5Qb06ENmEPKBnUdxCyCKnpvUhIAekCN3cC+e4M8es7kiLez2o
 1Wg5MsmAMDel2fuZHb6H2XvXNQO0FJ/wbSYWgTUkFxk7Pi2UoO88IEWpIxn7J2RrLz2h
 tECxEcGT2lUqajaDM7k8uGbfqhs8XcRd5tRVy7X9OdJwY0oP8uYo/R3rQP4niVrnRL4Q
 VNxg==
X-Gm-Message-State: AOAM531d+u1ebdZ1EqH/convc3PS2W9ejCZEn1TU32eAhnZabJmpMRPV
 P0IHgnfX3NDpJFLxB0cQN1wuQWXd
X-Google-Smtp-Source: ABdhPJytmsEjt25QYn6YtCa9BO/qZmMEA9G1Zo15LssoqCxrXV3bMCkNvBAy+9eh9l91xbfETUmZVg==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr20795169wmi.82.1592850870763; 
 Mon, 22 Jun 2020 11:34:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/9] hw/misc/pca9552: Trace GPIO change events
Date: Mon, 22 Jun 2020 20:34:19 +0200
Message-Id: <20200622183428.12255-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series add trace events to better display GPIO changes.
We'll continue in the following series by connecting LEDs to
these GPIOs.

This helps me to work on a generic LED device, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg711917.html

Since v4: Addressed Cédric review comments
- Extract PCA955xClass
- Add/use pca955x_pins_get_status() method instead of keeping
  cached value in PCA955xState

Example when booting an obmc-phosphor-image, we can see the LED #14
(front-power LED) starting to blink.

- ASCII LED bar view:

  $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_status
  1592689902.327837:pca955x_gpio_status pca-unspecified GPIOs 0-15 [*...............]
  1592689902.329934:pca955x_gpio_status pca-unspecified GPIOs 0-15 [**..............]
  1592689902.330717:pca955x_gpio_status pca-unspecified GPIOs 0-15 [***.............]
  1592689902.331431:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****............]
  1592689902.332163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*..]
  1592689902.332888:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........**.]
  1592689902.333629:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690032.793289:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
  1592690033.303163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690033.812962:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
  1592690034.323234:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690034.832922:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]

- Only display GPIOs which status changes:

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

For information about how to test the obmc-phosphor-image, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg712911.html

$ git backport-diff -u v4
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[----] [--] 'hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()'
002/9:[down] 'hw/misc/pca9552: Rename 'nr_leds' as 'pin_count''
003/9:[down] 'hw/misc/pca9552: Rename generic code as pca955x'
004/9:[down] 'hw/misc/pca9552: Add generic PCA955xClass, parent of TYPE_PCA9552'
005/9:[0007] [FC] 'hw/misc/pca9552: Add a 'description' property for debugging purpose'
006/9:[0031] [FC] 'hw/misc/pca9552: Trace GPIO High/Low events'
007/9:[----] [--] 'hw/arm/aspeed: Describe each PCA9552 device'
008/9:[0008] [FC] 'hw/misc/pca9552: Trace GPIO change events'
009/9:[0005] [FC] 'hw/misc/pca9552: Model qdev output GPIOs'

Based-on: <20200620162818.22340-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (9):
  hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()
  hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
  hw/misc/pca9552: Rename generic code as pca955x
  hw/misc/pca9552: Add generic PCA955xClass, parent of TYPE_PCA9552
  hw/misc/pca9552: Add a 'description' property for debugging purpose
  hw/misc/pca9552: Trace GPIO High/Low events
  hw/arm/aspeed: Describe each PCA9552 device
  hw/misc/pca9552: Trace GPIO change events
  hw/misc/pca9552: Model qdev output GPIOs

 include/hw/i2c/i2c.h      |   2 +
 include/hw/misc/pca9552.h |  16 +--
 hw/arm/aspeed.c           |  13 ++-
 hw/i2c/core.c             |  18 +++-
 hw/misc/pca9552.c         | 216 ++++++++++++++++++++++++++++----------
 hw/misc/trace-events      |   4 +
 6 files changed, 202 insertions(+), 67 deletions(-)

-- 
2.21.3


