Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A60DC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129BE2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fs+TiaEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129BE2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAbb-0002T6-73
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaT-0000Mu-MO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaS-0001my-AN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaS-0001W7-1x
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id h4so4579179wru.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u8V6G/fofhq2k+Qe+1y0PjIEHIje250Fyw6Dc0c5EZE=;
 b=fs+TiaELSvKLhN7F9/3DiQak4iU2SKVlLPwDSmxcZy2N4jsU2TJ2xXM5TTwJFS1KZN
 ipTEtLMvosdcUbzc8WkImSadTGw8f3ibS4MVpiLAdXRNNx8HZznABLQdTsopL3v/KoqP
 d8f27xXveDZhL/P1Q6poukt6tzopU40Ry0wCgT6vlktzxUnDU1GeyoZzbOWdfkhlae0G
 nMjgEPwZLu6y8eYyFyOmhVQe5UJMH7Pl23k7x/hXlLZwZnzimiV4ctSWrpFt4gXXGEl3
 iZk2LQ/kr7NfXozWf1eEPQz3B4PXvvd4U2dnhPtq64kh2xedzETXEGVeNFcSQvRr5hCa
 HPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u8V6G/fofhq2k+Qe+1y0PjIEHIje250Fyw6Dc0c5EZE=;
 b=fYmBuw88mDWlwTaMis2lL+jrErN6QtjnckQxzpiclsML9C8KFbLFdQ+QIV9o3TNwwa
 RB0OLIDrsyT64E0LjAnI/epE3exJe5ll6o5E32bIXdaGUZClnNHH/rf6n0R/MomZqAjQ
 L8W2aYTdt2qe3Qu14q3Jvc55Hc3vyW/pN0SDnlEwZqsRoyRaCklYng/9FT/dU9nTSUaE
 jk8VEXic4SrxetP44USEzJJ43iXpPz4UBVduW/yXkUQRxP27NegDNNzo/oP51qnY82K/
 kQcLXLIPAvy2b2ZCn+Mz7inQlVYyo6OxJ+DI14ckVyf7kgcCwbu+yPgPtIMcNJkxdK/P
 H0NA==
X-Gm-Message-State: ANhLgQ0Eb++hap23anshel8PCmeUSXh+9bfAaWAkd3rccvCqSo6AFTbw
 9NU3NFuV4nuI1boHcHmEQbzKNxgGT0jmgQ==
X-Google-Smtp-Source: ADFU+vsB3dCwYXV48aJq7fkP8VU9FNNX+N0iROFmAEYK4BE/+3NIA9LOpDiuhM79f+1J+GrZHTcaKw==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr954634wro.13.1584445242367;
 Tue, 17 Mar 2020 04:40:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Tue, 17 Mar 2020 11:40:28 +0000
Message-Id: <20200317114039.26914-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

Last handful of arm patches before softfreeze...

The following changes since commit a98135f727595382e200d04c2996e868b7925a01:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200317

for you to fetch changes up to e88d3671e3bbd59d385838a4101ea19cdcf47309:

  hw/arm/pxa2xx: Do not wire up OHCI for PXA255 (2020-03-17 11:36:48 +0000)

----------------------------------------------------------------
target-arm:
 * hw/arm/pxa2xx: Do not wire up OHCI for PXA255
 * aspeed/smc: Fix number of dummy cycles for FAST_READ_4 command
 * m25p80: Improve command handling for Jedec and unsupported commands
 * hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
 * hw/arm/fsl-imx6, imx6ul: Wire up USB controllers
 * hw/arm/fsl-imx6ul: Instantiate unimplemented pwm and can devices

----------------------------------------------------------------
Chen Qun (1):
      hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()

Guenter Roeck (10):
      hw/usb: Add basic i.MX USB Phy support
      hw/arm/fsl-imx6ul: Fix USB interrupt numbers
      hw/arm/fsl-imx6ul: Instantiate unimplemented pwm and can devices
      hw/arm/fsl-imx6ul: Wire up USB controllers
      hw/arm/fsl-imx6: Wire up USB controllers
      m25p80: Convert to support tracing
      m25p80: Improve command handling for Jedec commands
      m25p80: Improve command handling for unsupported commands
      aspeed/smc: Fix number of dummy cycles for FAST_READ_4 command
      hw/arm/pxa2xx: Do not wire up OHCI for PXA255

 hw/usb/Makefile.objs         |   2 +
 include/hw/arm/fsl-imx6.h    |   6 ++
 include/hw/arm/fsl-imx6ul.h  |  16 ++-
 include/hw/usb/imx-usb-phy.h |  53 ++++++++++
 hw/arm/fsl-imx6.c            |  36 +++++++
 hw/arm/fsl-imx6ul.c          |  49 ++++++++++
 hw/arm/pxa2xx.c              |   3 -
 hw/block/m25p80.c            |  58 +++++------
 hw/net/imx_fec.c             |   6 +-
 hw/ssi/aspeed_smc.c          |   2 +-
 hw/usb/imx-usb-phy.c         | 225 +++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |   2 +
 hw/arm/Kconfig               |   1 +
 hw/block/trace-events        |  16 +++
 hw/usb/Kconfig               |   5 +
 15 files changed, 444 insertions(+), 36 deletions(-)
 create mode 100644 include/hw/usb/imx-usb-phy.h
 create mode 100644 hw/usb/imx-usb-phy.c

