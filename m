Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0920EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD8520652
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qatKxeMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGD5y-0007Y6-Of
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:41:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0006Ru-U5
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0007nf-4r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:34 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGD4O-0007lo-0n; Mon, 15 Apr 2019 21:39:32 -0400
Received: by mail-pl1-x644.google.com with SMTP id g12so9453628pll.11;
	Mon, 15 Apr 2019 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=O1HanAiLIqZLGe6dUHaYDaXwNAIovuSElTmnSBYnjqU=;
	b=qatKxeMepdaue45AXG1TGC4deoutbX1dSZxfkmSfc8MryYWqgX90iZNTWrwxN68S+R
	5kD7ulvOLDrnVzVisOq4wdyRhcqNVKJEu2NBoTJ0/gefOJ072q2B9ls8a472iY9PdQgS
	BEgBCwxJeJ71ALSp+NzuIoFakpAGaQS4Y4oYcwGflgEujM33yWxBHZR5qqo+fKZnL3vv
	1lcWDNybKp9IxrZI8J+Ulx5RbE4r7sJVVx7AHbBIkmsaTCp85gHD8Kg9hS6T4VbUD8Aj
	rNht8DjBeASzqFk86s2AA/M6pETCb+lf95UG6RxBPmZpSgANmEmxcQJDjQZiPBGVPWAc
	L7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=O1HanAiLIqZLGe6dUHaYDaXwNAIovuSElTmnSBYnjqU=;
	b=ORrJJRuETFjNyiab6jEGWCueBCxJbtHO7rKH/N0TxyWqgbVkhkBDPzvMqke0nYk7Mk
	0XgExollwpvydtBCxibG5bncMbZHGdvYNDSmkhAxa+4vy9snuSwjAQvsENiT+IIhPYoR
	36a5o1G7HVfUBQlsiDamzo8RVhh3yjvE0no9nFjgqCFFNX0QlBDONTmNDy2if2JUVmmh
	/z7ln5tiC3i4NtnitxXbZHbyoX5+gbbOiC3tfJMybiEoQBArySeva+I+LhfP8bYGIV0e
	cfr4MqKPUHlUR/7ayfH4SOSvjVKuSBlQY5U6yU4FX9n80gT12FVYZrfHyrolyJDZ6vja
	L2tw==
X-Gm-Message-State: APjAAAWFk56LByGf5gMfQVMxPpXJr0UAe4NG2cS+GEF/VBrAM021p2JJ
	B/A9llP+P5gTXIcZzZ+kzdYtki6F
X-Google-Smtp-Source: APXvYqy+D0NV5nDo9yYF0iCbu1p/NzQACDSRjmY6zXVJdtYgw4HFXQi98Lm2nAQ3zyD6M3XDnFuCSA==
X-Received: by 2002:a17:902:b489:: with SMTP id
	y9mr70733381plr.17.1555378769108; 
	Mon, 15 Apr 2019 18:39:29 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
	[24.22.235.96]) by smtp.gmail.com with ESMTPSA id
	v20sm74710362pfn.116.2019.04.15.18.39.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 18:39:28 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Apr 2019 18:38:57 -0700
Message-Id: <20190416013902.4941-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 0/5] Various i.MX7 fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416013857.o7u5q1Erym7EjyeMjflvWrmPuJYzxDD7M18umFC372A@z>

Everyone:

I recently revisited my i.MX7 work and this series contains all of the
fixes I had to make to get it to work with latest (5.1-rc1) Linux
kernel again as well as fixes for genuine bugs that I somehow missed
during original submission ("pci: designware" patches). Hopefully each
patch is self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (5):
  i.mx7d: Add no-op/unimplemented APBH DMA module
  i.mx7d: Add no-op/unimplemented PCIE PHY IP block
  pci: designware: Update MSI mapping unconditionally
  pci: designware: Update MSI mapping when MSI address changes
  i.mx7d: pci: Update PCI IRQ mapping to match HW

 include/hw/arm/fsl-imx7.h | 14 ++++++++++----
 hw/arm/fsl-imx7.c         | 11 +++++++++++
 hw/pci-host/designware.c  | 18 ++++++++----------
 3 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.20.1


