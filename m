Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FD0C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF361215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfHXd/vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF361215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBm5K-0001ix-3H
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jBm3O-0008M1-M1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jBm3M-0000VV-NV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:04:42 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jBm3K-0000FT-G6; Tue, 10 Mar 2020 17:04:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id b22so5928852pls.12;
 Tue, 10 Mar 2020 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=jrIOHuZP1oxkfN9GTVMUUgnOuhZtmWKN3NFie7XBlMY=;
 b=RfHXd/vAaRRt1mWsbQ4MJS7JTK9O91zGYhWeOYUHpS+5Qm5GMyhUP4d4cL7NFGCP29
 jB1Un97TVHw0VrOC0NS92ndBG3iU1Mi/Gp2vbeaa067pfpKYXp31i2wGMOM+DOeVQmZ9
 QfbnaGt+eS5IWXZAa77z4E23FP7qq2mlFVOVMBXsgzJCZjR2MyvTigNTjcl1xPocln5O
 gVslLhFtoGvoXJYOApHa6nKcAPvzKD3opZa8TYO57YHtG92eAFMsiNqDIl+1YIDLkYsk
 Xug8Uekcge7p1YEdC3yCCybugMCGSvm3pUx3MF5T5LNGUTNeJfe1l3JEp3mtNRIB+bHn
 aQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=jrIOHuZP1oxkfN9GTVMUUgnOuhZtmWKN3NFie7XBlMY=;
 b=hb4BMHgqPfdDHeVySQEP3KvyfR0yEgkOQMcEyJY4l4dSR6H5vyO1elaKYMc8LAGDFA
 FyMqWzkmm9Ni77f8Wy+e1HF2gx4ARODl5EqFvFaMf/ZPHq3JRVmHmh+W+ydZgS+3nD85
 qtW1F1HeBR7xafMvTlZGRHg3nJD8z6Q18yBhWja9M2CMZqvSsaVIXmJn/U4y1peEphVI
 AXDT0tyrdYF+wjMpBmLYaZTqaFanjKr6bRqOWzb1Aa5Frp88xttZQofDKbkvk6JytCZX
 LBvsTz18DonZhNDHDCFCRVseCLAMYCSzLLFHaXkah1/jIb5wIpEW5d/tp/3ofFUSqAfI
 c4pA==
X-Gm-Message-State: ANhLgQ3nfEJm+q06Yya7e6UTGW6djFYnnyQc/LyPPa4wzwClpuE+qkXg
 uwAAAJKLdRjT7NDRHAnyOCk=
X-Google-Smtp-Source: ADFU+vtRqoZUCAdb419OFtXVN+hGyeGskdkqLHuuQ9/5aSXjOGMxG3aqe0Ldkd9UBM4KnS0eUvNpAw==
X-Received: by 2002:a17:902:e991:: with SMTP id
 f17mr22316059plb.72.1583874277320; 
 Tue, 10 Mar 2020 14:04:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id s126sm25621678pfb.143.2020.03.10.14.04.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 10 Mar 2020 14:04:36 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/3] Wire up USB controllers in i.MX6 emulations
Date: Tue, 10 Mar 2020 14:04:31 -0700
Message-Id: <20200310210434.31544-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series wires up the USB controllers on fsl-imx6 and fsl-imx6ul
emulations.

The first patch is a prerequisite for the following patches. It provides
a basic implementation of the USB PHY controller used in i.MX28 and later
chips. Only reset bit handling in the control register is actually
implemented. This is needed to make the USB ports operational in Linux.

v2:
- Implement and instantiate basic USB PHY implementation
  instead of emulating a single USB PHY register

----------------------------------------------------------------
Guenter Roeck (3):
      hw/usb: Add basic i.MX USB Phy support
      hw/arm/fsl-imx6ul: Wire up USB controllers
      hw/arm/fsl-imx6: Wire up USB controllers

 hw/arm/Kconfig               |   1 +
 hw/arm/fsl-imx6.c            |  34 +++++++
 hw/arm/fsl-imx6ul.c          |  33 +++++++
 hw/usb/Kconfig               |   5 +
 hw/usb/Makefile.objs         |   2 +
 hw/usb/imx-usb-phy.c         | 225 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h    |   5 +
 include/hw/arm/fsl-imx6ul.h  |   9 ++
 include/hw/usb/imx-usb-phy.h |  53 ++++++++++
 9 files changed, 367 insertions(+)
 create mode 100644 hw/usb/imx-usb-phy.c
 create mode 100644 include/hw/usb/imx-usb-phy.h

