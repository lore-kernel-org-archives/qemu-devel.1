Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0755CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D8220659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHVGAaZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D8220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLtl-0006nA-24
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgLst-00054z-Ju; Wed, 03 Jun 2020 01:24:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgLss-0001mq-Jn; Wed, 03 Jun 2020 01:24:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id e9so935376pgo.9;
 Tue, 02 Jun 2020 22:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=kuWjzT/fHl3TNVa0NJLrDiVP5UKBV/oX/7p9Gs5hrW8=;
 b=VHVGAaZPmCHsQ+QcgbWl5/lWKk2WjMbi+7S7qUaBilnaPINEG41FWmkR+toHkAEB3f
 MAGRI6CHCZv2Zke5d006zG1y+RYZbxzuNTWZT1jn5zenwcXxZcvyLcQLM2dMx7psUOa8
 GXRmP0sUNyFEMbOGiCaGcCXUFpzPOKSRn3PI8B6grVh0Vn6sWRqxd/QtwjE3OJL/hrQ4
 pd+jIanj2rrAbi2zcpu5n7Ewse9+dkmzL6KkuGBmt4ygMYMUx5xohqANRbBIZtVveFU5
 +wcEN1RuhwpSoC1QFO+VCIm7k2EZqchfsz6P8H++apLVd7FVyxqrAQPDey+55OrGZapl
 uPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=kuWjzT/fHl3TNVa0NJLrDiVP5UKBV/oX/7p9Gs5hrW8=;
 b=YKvq+KSp87103T5opXZ1N+/vCrB3fkuMRrLo0a5fu35XaZuJaYMtG6b5LYfrdH3odc
 dPzx0JbkT9qpgU0hTyIsZehIOUUhi6hDsmidw0W4TUb9dmlLxJfXim/PTK3E4bQuwedd
 iHjc/+bTg7x12C3KDSon8uhQRUcxy22HcOIb0k2ae9EB17vWfVMjMnXTG9TdWw1S57Ny
 aSRjcDIp4l4dl0hwAgDAdP4QP8PX5ChaKF+jHOM5K/vjJVk4BIUgGAQgZ8V6Yr2FfUUr
 fkseWpxQmj7zvv0D0RNBJi2r2E6knj72FLMK426aEwfOf7zwgL8L3zZXlG8DRTWGGene
 koMg==
X-Gm-Message-State: AOAM531Y/5rd5FlJIODL/6Nrp+xRk8ayv7MXgMJNJq2lcCuHOvekhlGK
 Lf71K4YjtRcNJ71kifkO65o=
X-Google-Smtp-Source: ABdhPJwHPMNBi3Z5vrpaXXr0ZH4a03KQJ5nuMOOH5BTzOuYNJDgwsKyM6HzVbVOOkADUah0kC7UYEQ==
X-Received: by 2002:a17:90a:4497:: with SMTP id
 t23mr3499292pjg.88.1591161852677; 
 Tue, 02 Jun 2020 22:24:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id x14sm575088pgj.14.2020.06.02.22.24.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Jun 2020 22:24:11 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] sd: sdhci: Implement basic vendor specific register
 support
Date: Tue,  2 Jun 2020 22:24:02 -0700
Message-Id: <20200603052404.30788-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel's IMX code now uses vendor specific commands.
This results in endless warnings when booting the Linux kernel.

sdhci-esdhc-imx 2194000.usdhc: esdhc_wait_for_card_clock_gate_off:
	card clock still not gate off in 100us!.

Implement support for the vendor specific command implemented in IMX
SDHCI hardware to be able to avoid this warning.

Patch 1/2 implements vendor specific command support in the SDHCI core
code. At this time, only IMX vendor command support is implemented,
but the implementation is written with expandability in mind.

Patch 2/2 enables IMX SDHCI vendor extensions for all affected emulations.

----------------------------------------------------------------
Guenter Roeck (2):
      sd: sdhci: Implement basic vendor specific register support
      hw: arm: Set vendor property for IMX SDHCI emulations

 hw/arm/fsl-imx25.c     |  2 ++
 hw/arm/fsl-imx6.c      |  2 ++
 hw/arm/fsl-imx6ul.c    |  2 ++
 hw/arm/fsl-imx7.c      |  2 ++
 hw/sd/sdhci-internal.h |  5 +++++
 hw/sd/sdhci.c          | 18 +++++++++++++++++-
 include/hw/sd/sdhci.h  |  5 +++++
 7 files changed, 35 insertions(+), 1 deletion(-)

