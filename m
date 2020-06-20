Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BD82474C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLuOXsoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BD82474C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmSt-0002Tl-MG
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 18:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRw-0000bx-I8; Sat, 20 Jun 2020 18:59:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRu-0000xC-Qw; Sat, 20 Jun 2020 18:59:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so5436230wrv.9;
 Sat, 20 Jun 2020 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HOvnAFRk4OJaoGvOQC+SY/IXgxB8cGypTeZ4uN6x1qQ=;
 b=HLuOXsoV5kP9OTKjWDW2pA3MF1dvk4QeccFR3GXNXdqlHwBkWzzFtxxEdmIPMxRX4A
 qa0PzIKgm3gHtT32OscVUaiCgudGoB4T0piRCPt5/vMDhuOxRzlcFdNnvhiJdt/YM251
 owIm+PkR+W4N8IzuefJBWzDyognN5EIh9Y3CsO9R+xWY4wpJIdYohU4oOPEWppJcL/fS
 CPHJeR9Zl41uUfgLBwVUtKxxQgrkh0C23atdXUM4LFKK+WFFECz90TRNwpK6USIpdfF6
 7NjaVJvprPx4h5SSpY68/+PiGidcd7RpgmexiezBYBgSA8zO3AO6QYpAl7CiowUAeT90
 jSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=HOvnAFRk4OJaoGvOQC+SY/IXgxB8cGypTeZ4uN6x1qQ=;
 b=RYIUZDb0k9LVnFG/Kp5CBnuy0NjZld1Ak5KVcI7TbXClGWLZtQE0Xw+7/FvHzxh+rV
 HhtK1P8USLe/K5GBgPDAF5foAnJb82cenMFpbrWLz9E6ElEAd9ZmwPiuYrsXKFwcSYx2
 G0csiyLh+F+Kwrr7Yrjr6iY2wrMiGGxXQYp96lr+nHXe1Srcqt1SNKCSzMIoJk3HQkPO
 39c74aPdGEZGnpSCZJqPzfVz+vluh7mkQ6nnmKTYFN7T7m/NT54g0NaPbrpcSO6ysj8V
 8277/Dsep+uZ04isJLfe3xw+7F8xza3quyXsyiu73hu08pi6BLqRtLaapIvvDNTjHNXa
 jjNg==
X-Gm-Message-State: AOAM531LTvwq6y4nmESfG0CFnLszW8kv4w2bLY+rLL3/MpJAIJKL1uXX
 3SjpfJQF7GBSV6iusu34GNiVHNDt
X-Google-Smtp-Source: ABdhPJymxsLEl8BdMarkxlYewVhyAGVxHfZw6i/ntJr3RIaQFGjw8vs+2TSim7B79yQOy+JmuJGOQg==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr11572493wrn.16.1592693936680; 
 Sat, 20 Jun 2020 15:58:56 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:58:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/8] hw/misc/pca9552: Trace GPIO change events
Date: Sun, 21 Jun 2020 00:58:46 +0200
Message-Id: <20200620225854.31160-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series add trace events to better display GPIO changes.
We'll continue in the following series by connecting LEDs to
these GPIOs.

This helps me to work on a generic LED device, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg711917.html

Example when booting an obmc-phosphor-image, we can see the LED #14
(front-power LED) starting to blink.

- ASCII LED bar view:

  $ qemu-system-arm -M witherspoon-bmc -trace pca9552_gpio_status
  1592689902.327837:pca9552_gpio_status pca-unspecified GPIOs 0-15 [*...............]
  1592689902.329934:pca9552_gpio_status pca-unspecified GPIOs 0-15 [**..............]
  1592689902.330717:pca9552_gpio_status pca-unspecified GPIOs 0-15 [***.............]
  1592689902.331431:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****............]
  1592689902.332163:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*..]
  1592689902.332888:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........**.]
  1592689902.333629:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690032.793289:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
  1592690033.303163:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690033.812962:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
  1592690034.323234:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690034.832922:pca9552_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]

- Only display GPIOs which status changes:

  $ qemu-system-arm -M witherspoon-bmc -trace pca9552_gpio_change
  1592690552.687372:pca9552_gpio_change pca1 GPIO id:0 status: 0 -> 1
  1592690552.690169:pca9552_gpio_change pca1 GPIO id:1 status: 0 -> 1
  1592690552.691673:pca9552_gpio_change pca1 GPIO id:2 status: 0 -> 1
  1592690552.696886:pca9552_gpio_change pca1 GPIO id:3 status: 0 -> 1
  1592690552.698614:pca9552_gpio_change pca1 GPIO id:13 status: 0 -> 1
  1592690552.699833:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690552.700842:pca9552_gpio_change pca1 GPIO id:15 status: 0 -> 1
  1592690683.841921:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690683.861660:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690684.371460:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690684.882115:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690685.391411:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690685.901391:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1

For information about how to test the obmc-phosphor-image, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg712911.html

Supersedes: <20200619145101.1637-1-f4bug@amsat.org>
Based-on: <20200620162818.22340-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (8):
  hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()
  hw/misc/pca9552: Replace magic value by PCA9552_PIN_COUNT definition
  hw/misc/pca9552: Use the PCA9552_PIN_COUNT definition
  hw/misc/pca9552: Add a 'description' property for debugging purpose
  hw/misc/pca9552: Trace GPIO High/Low events
  hw/arm/aspeed: Describe each PCA9552 device
  hw/misc/pca9552: Trace GPIO change events
  hw/misc/pca9552: Model qdev output GPIOs

 include/hw/i2c/i2c.h      |  2 ++
 include/hw/misc/pca9552.h |  4 +++
 hw/arm/aspeed.c           | 13 ++++---
 hw/i2c/core.c             | 18 ++++++++--
 hw/misc/pca9552.c         | 72 ++++++++++++++++++++++++++++++++++++++-
 hw/misc/trace-events      |  4 +++
 6 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.21.3


