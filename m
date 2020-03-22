Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B5C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5A4206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRJ0ADOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5A4206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG81z-0004al-P3
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80H-0002qr-Dn
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80G-0002iS-65
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80F-0002iA-Up; Sun, 22 Mar 2020 17:19:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id t3so6119451pgn.1;
 Sun, 22 Mar 2020 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=5I9oUf/cC61l1u1wOnpwPYoTGGUi8Kt3f62K4lVlrlU=;
 b=cRJ0ADOrDgTgjIGvSF4WBkmumNFU1Y1XtozheZ4JD5xZ8XxFHfk3xw02a9NEWY3X09
 P3Difsln91hWExBl9pX8CNM13SRYWdChDyB6a4e9oBqsznUTNIEjxW7SG+Pqb4XLQl6X
 yPwsmG+pPiOlsRHGWmwdqY+lKLIJpEkw/c1Urdgp0U1+G42aKny7Dldx/xyo3HvhWc2L
 IG905veW8ChctrfDpGpzJiqPuIW4qYjwJmGH01371Ps6evC6W9gMNrsZuz215FRG3TZw
 1DoDrqmu0MwrZo39K3cioTp1D4U+j7cgv8wITD9+0SGXRN8pJNlq2kYBG6R7h6HwgxOq
 5kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=5I9oUf/cC61l1u1wOnpwPYoTGGUi8Kt3f62K4lVlrlU=;
 b=KoWkE3Dhxt0qVsAU29qLSqsrXnQpOwAWWVVh0kTSVfo+qIVd7iPU5Qp4LebXl+lV4L
 ro9xzuSj4cUOfzCyFL0l9WpML8yhvM6cvudVBDMh/KQ0ksYKqX8W0LQIfuzObPDJEdK8
 wgFgxEaHWLcGp31GBUcWgqla0a++PP+hTPNq+0CxmIXQSU9+iR74dIXRNymP6R6b3jPF
 NA6djOG+fJZAPVolu3UVe/NMPIvMOTAfwzkDLtyl08zhWV3+zO4k3bj1BOiJlrwVQBxu
 qwzXgd3x21DuAXhaNtj+2bQVqSZf09d97Nno/RXuEl2gZvPscclQT+Wfh2fkhbPkr09L
 XbBA==
X-Gm-Message-State: ANhLgQ025lBO+2Er+n+F3FI6XGUizubghXxWVrxTfjktAAzyXp4dQ/Ea
 88CTiQcSuS4PH+pOaAhR1Co=
X-Google-Smtp-Source: ADFU+vsnnOXOS5Lq32dmv89y9JGWp6/+g+Jkd30DmSc0ehtgJz6MYme8lEsk31FKxK8HOUhEQRN/1Q==
X-Received: by 2002:a63:6bc1:: with SMTP id
 g184mr18028347pgc.404.1584911966713; 
 Sun, 22 Mar 2020 14:19:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 185sm11456589pfz.119.2020.03.22.14.19.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:24 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/8] hw/arm: Implement i.MX watchdog support
Date: Sun, 22 Mar 2020 14:19:11 -0700
Message-Id: <20200322211919.11335-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current i.MX watchdog implementation only supports resets.
This patch series implements the full watchdog, including optional
pretimeout support.

Notable changes:
- The existing i.MX watchdog emulation (which only emulates syste resets)
  is moved from hw/misc to hw/watchdog and renamed to match the naming
  convention in hw/watchdog (patch 1/8).
- Full watchdog support is implemented in patch 2/8.
- The watchdog is wired up for i.MX25 and i.MX31 emulations (patch 3/8 and
  4/8).
- The watchdog interrupt (for pretimeout support) is connected for
  i.MX6, i.MX6UL, and i.MX7 emulations (patch 5/8, 6/8, and 8/8).
- For i.MX7, various devices are wired up as unimplemented
  devices (patch 7/8). This was necessary to avoid crashes when
  booting recent Linux kernels.

The code was tested with all available emulations.

v2: Select WDT_IMX2 explicitly for supported platforms, not automatically
    with IMX
    Rebased to current master (as of 3/22)
    Fixed typo "octop" -> "ocotp"
    Added Reviewed-by: tags where given

----------------------------------------------------------------
Guenter Roeck (8):
      hw: Move i.MX watchdog driver to hw/watchdog
      hw/watchdog: Implement full i.MX watchdog support
      hw/arm/fsl-imx25: Wire up watchdog
      hw/arm/fsl-imx31: Wire up watchdog
      hw/arm/fsl-imx6: Connect watchdog interrupts
      hw/arm/fsl-imx6ul: Connect watchdog interrupts
      hw/arm/fsl-imx7: Instantiate various unimplemented devices
      hw/arm/fsl-imx7: Connect watchdog interrupts

 MAINTAINERS                    |   2 +
 hw/arm/Kconfig                 |   5 +
 hw/arm/fsl-imx25.c             |  10 ++
 hw/arm/fsl-imx31.c             |   6 +
 hw/arm/fsl-imx6.c              |   9 ++
 hw/arm/fsl-imx6ul.c            |  10 ++
 hw/arm/fsl-imx7.c              |  35 ++++++
 hw/misc/Makefile.objs          |   1 -
 hw/misc/imx2_wdt.c             |  90 --------------
 hw/watchdog/Kconfig            |   3 +
 hw/watchdog/Makefile.objs      |   1 +
 hw/watchdog/wdt_imx2.c         | 262 +++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx25.h     |   5 +
 include/hw/arm/fsl-imx31.h     |   4 +
 include/hw/arm/fsl-imx6.h      |   2 +-
 include/hw/arm/fsl-imx6ul.h    |   2 +-
 include/hw/arm/fsl-imx7.h      |  23 +++-
 include/hw/misc/imx2_wdt.h     |  33 ------
 include/hw/watchdog/wdt_imx2.h |  78 ++++++++++++
 19 files changed, 454 insertions(+), 127 deletions(-)
 delete mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/watchdog/wdt_imx2.c
 delete mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/watchdog/wdt_imx2.h

