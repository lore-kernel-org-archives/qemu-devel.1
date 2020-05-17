Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E497C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535C42070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYbzfham"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535C42070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM3m-0007Y1-Do
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2q-00061v-Oi
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:44 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2p-0006kC-KD
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:44 -0400
Received: by mail-pl1-x644.google.com with SMTP id q16so3145833plr.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=KoIlokQcc5zeByuen5XWEpE1oUxzoImXfDPl8A5VxeE=;
 b=PYbzfhamoM/Bcz6NwtbtnNV3iH4okqyJGdzDW3HnZavyYTv5px5/vwRYmABRSnHal1
 R61ccf86t7KbpIIREYCnDlnOrMY5YGmRhTujYcbqD2FeTjBYUdcUFI1AgVgdQ0E6+GsH
 ldrdX/rmh98auFtv3RqQNB6LMXrEueSuAzBJ5LqYBKlsxybPuv5ZawQanrk11nrkThPF
 KZg02XlPsaoztdVCTTtTKsSoMSNmdhXvgPt9sfon+0lirjReDocKQkuyi+9Z5BH4knDw
 SojTURf21wDFod/KL3mxK+a/fYDTrM/oj7p6Iy2g6AcGHnEQnuSLFEngyGgtdmEyfmhb
 qSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=KoIlokQcc5zeByuen5XWEpE1oUxzoImXfDPl8A5VxeE=;
 b=oA0QZAdKK8jQdXHBoN2hnBoSwEx0Zbnb2zd3WntamDWtqhrnleEQde4g9bXR+x28O0
 aLB7XAWiOJIsYf3bzlscQDGGdZbqHmAXj/rxjeKwzixU13Fiay7w/Mzvb8kD19ow95Ss
 EP/Z0l3OXSHobOL7yqBdckSX7U2eqXCE4auBiyrjEqGJG3CtQraYdnUtnZv1muq/HE9B
 Dn2Y5REg0RrihTIR9JgHtdLtXfE11Orm27Nj5GnIUlmbn+qEVzpR2QGNycbx/p0uSlL0
 agbvtV48K50iFeXdObZMbsKj6Ob6qJIROWfFlz4yNuLKZKPKmhFqIoAa1DY+ddINRz6r
 CwYw==
X-Gm-Message-State: AOAM530pZL/FMN4BmFE3OAj3+hWtct6vipBI1/Zd2YxIVmjOT3zZIDd0
 G3NLstr9AforZgNBnVItJrk=
X-Google-Smtp-Source: ABdhPJw8zTsOG67FuJY/l0oGStSMVnViRqsCamUsSc8KHos3pnvra2pXNaWNrg3PqGaHDhI9K+pSsg==
X-Received: by 2002:a17:902:6f0f:: with SMTP id
 w15mr11561074plk.191.1589732501902; 
 Sun, 17 May 2020 09:21:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id t14sm5836663pgr.61.2020.05.17.09.21.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:41 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/8] hw/arm: Implement i.MX watchdog support
Date: Sun, 17 May 2020 09:21:27 -0700
Message-Id: <20200517162135.110364-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
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

v3: Improve handling of write-once registers and bits
    Stop timers in reset function
    Use explicit policy for timers

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

