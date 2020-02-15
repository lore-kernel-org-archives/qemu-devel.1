Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342DEC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 12:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F602073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 12:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSbx8Yp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F602073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2wVA-0005Lm-59
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 07:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2wUM-0004Ee-AS
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 07:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2wUL-0000zK-GO
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 07:24:02 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2wUJ-0000vk-9I; Sat, 15 Feb 2020 07:23:59 -0500
Received: by mail-pl1-x644.google.com with SMTP id y1so4901810plp.7;
 Sat, 15 Feb 2020 04:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=8C62QGnIr96+4MztDityiyQWSkkPM89tJTShALemV3Q=;
 b=vSbx8Yp0ed7T+Wqr/xdC2gMAsY1HrKkaKTN/6PrMoujQtqBQoJHZqh9ilc1WYJtaZz
 xdJFrqfSFNEODgkCs5OIHZz2PANHzYRgC5tRtasNpRq6uCg30T0+ZBT0yfXheafU1YM1
 QT3YNLRHxxIrhESVAq4YTOrce9JVFHzdUr/k0n2+Jlf2LBV0/hNMPdSeW+n4soZBF/PD
 MRWZ2P/VQIRRk2XsPMcRaqunoI1m2dyOOu1iXrnskH1HZQTj9zZFedQGAh2n9AHH8cKG
 L66MxjMKjM0h/J7H+otuGiL9v0I1ycXc5rl36+Vegd/wRr4NUuuYDrAOpCA8uwgsk9XP
 +sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=8C62QGnIr96+4MztDityiyQWSkkPM89tJTShALemV3Q=;
 b=AVcOL3hNkXOeghJ5mu5XFgn1w/UmHrp5l2YRbOwclu85IITPIm3qCsnxL2tG6tmIoB
 xxUNmmn6N5fJm5tDPJ057/ZGRAzmZgasIXNxBzgXOLWCzP3eDa1aSrjOHAGjAcb4FptA
 0lTBVKYa7Ug8wFNoETqg6o64nYmVgV+Rf8jDvH7f+iPdld7IyZPmYbyTsFezNSEwkKf9
 n1TPttVgw0435cFbtxe6RA5cHhZcicEAlUdpmOn/ZPBHP018WolSInFYP3uJIpT+h0hT
 8X5HuBcBNp9MJOkzY47Zrl0zWfAnUe9AWIZS0NqimJaM3cQpEsXAojeGYricQ3d1K+Kx
 TAdA==
X-Gm-Message-State: APjAAAXCz0uL4Gq42ERBt2h6z/U0WplRRp8Rvz7Ou+2ys1ToRHNR1/bW
 rKEaElYm3vEuUElKT9xMxLQ=
X-Google-Smtp-Source: APXvYqzD2fVvZop4n7X/rmTrkeTr5Xw7bYWxHXdQc5yCBXAPNDT8S3jv1og4rOFac39X2M/NJ/ciTg==
X-Received: by 2002:a17:90a:9dc3:: with SMTP id
 x3mr9281746pjv.45.1581769437579; 
 Sat, 15 Feb 2020 04:23:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id o10sm10488193pgq.68.2020.02.15.04.23.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 15 Feb 2020 04:23:56 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/2] hw/arm/xilinx_zynq: Fix USB port instantiation
Date: Sat, 15 Feb 2020 04:23:52 -0800
Message-Id: <20200215122354.13706-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
Linux expects and checks various chipidea registers, which do not exist
with the basic ehci emulation. This patch series fixes the problem.

The first patch in the series fixes the actual problem.

The second patch removes the now obsolete explicit Xilinx
support from the EHCI code.

v2: Introduced summary

----------------------------------------------------------------
Guenter Roeck (2):
      hw/arm/xilinx_zynq: Fix USB port instantiation
      hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,ps7-usb class

 hw/arm/xilinx_zynq.c     |  5 +++--
 hw/usb/hcd-ehci-sysbus.c | 17 -----------------
 2 files changed, 3 insertions(+), 19 deletions(-)

