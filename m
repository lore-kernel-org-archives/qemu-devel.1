Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBBC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED3F206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNoGvRiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED3F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWWt-0002SO-6O
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTF-0006gn-Hq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTE-0004uR-Ib
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHWTE-0004uA-D7; Mon, 07 Oct 2019 13:06:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id j11so10436819wrp.1;
 Mon, 07 Oct 2019 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+3UBHXl0Q3tHZixwPH6fsHjN2QJ1bQEaKGonQtRbZd4=;
 b=uNoGvRiwUiJCmtif4CMZwT/OIBf3S16hlWuLfBWCCXfgBFUaX9G1tIMwRHG13jyilN
 vRHCU5qu8YrV9G5S8Quvx2AHrS7d6jWpYWzmzO52/ODpgv8LvE1TQ7NdNBQkmLbaCqrp
 9yJIKdSv1YJ5x8yDyZuKbhi+VaqeJqdqzpefUPbl0tok/H8PT4oX59FeNIU+k7nn7WqE
 mPmu7Rs4UOunzrfVdZ0ZmGV/Jb+pF2oGsbDiqSaUPQ7tVtqhyuZj/s9KWby09Vv7yIhs
 G8XbKzQUDKy1yXnGsdzS9RVwazbMnogz34TikL07BfEJq/oNi+XlhacCNaJtBtsaPYXB
 o6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=+3UBHXl0Q3tHZixwPH6fsHjN2QJ1bQEaKGonQtRbZd4=;
 b=J6YxVH3ZNw5M1HWP+KPylaOcF3nsdAPZtNBsezgEtqkPuCjY+gqBU1b/hzk4w11iJF
 SjVrOGc9nXuahpdiftSLa8yVe1qIR71vN/kkFtF1ZF7MjccyDXtp8rGpBgxaHm/QsUC7
 lB9pQNvoW8UBhoz2N0NHPKXQsyjNA58JGSiXIWfVHQZUnWXl+q0urCNW3NQhGUUmDGQs
 EuE+28h6BOsYgEzJFmDSSEf6wM7ajc0dAfGKPEErwDkbdoCucjy4xsSqALBW2bS4fBJd
 u9lEbgHFidNyCS1SAARvqHAAH1CVFWO8/ESudOCzHR6ysE1kEyCexmD3QR1G5F8CmbfN
 GZwg==
X-Gm-Message-State: APjAAAWSnWbK8Dv9/GZwaCAkORPFS2Qu0L7sJxjnJOau3fLBJRycFzgz
 FKfzi5TX80WyguOgxEyE0ETiy/oQPlk=
X-Google-Smtp-Source: APXvYqz+YxgmR2IZ7rrtBhmeQuIvakF9WZ//tH3LTCuRFeOxVAX9XKYtpW+CxNQCzVb3wXih5YKQkA==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr21350322wrw.24.1570468010620; 
 Mon, 07 Oct 2019 10:06:50 -0700 (PDT)
Received: from x1w.redhat.com (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id x5sm14036603wrt.75.2019.10.07.10.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 10:06:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/arm/raspi: Split the UART block from the AUX block
Date: Mon,  7 Oct 2019 19:06:43 +0200
Message-Id: <20191007170646.14961-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2838 has many more peripherals than his little brother,
the BCM2837. With the raspi4, the Linux kernel takes more steps
to configure the various MUXed devices. At some point it started
to bug me, so I plan to add a dummy simple BCM2835_SPI block.
It is cleaner to add it as a separate device than mixed with the
AUX block. As a first step, split the UART block out.

Since this part is self-contained and my raspi4 branch is getting
too big, I'm sending it as a single series.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  hw/char: Add the BCM2835 miniuart
  hw/char/bcm2835_aux: Use the BCM2835 miniuart block
  hw: Move BCM2835 AUX device from hw/char/ to hw/misc/

 hw/char/Makefile.objs                   |   2 +-
 hw/char/bcm2835_aux.c                   | 317 -----------------------
 hw/char/bcm2835_miniuart.c              | 327 ++++++++++++++++++++++++
 hw/char/trace-events                    |   4 +
 hw/misc/Makefile.objs                   |   1 +
 hw/misc/bcm2835_aux.c                   | 189 ++++++++++++++
 hw/misc/trace-events                    |   4 +
 include/hw/arm/bcm2835_peripherals.h    |   2 +-
 include/hw/char/bcm2835_miniuart.h      |  37 +++
 include/hw/{char => misc}/bcm2835_aux.h |  10 +-
 10 files changed, 567 insertions(+), 326 deletions(-)
 delete mode 100644 hw/char/bcm2835_aux.c
 create mode 100644 hw/char/bcm2835_miniuart.c
 create mode 100644 hw/misc/bcm2835_aux.c
 create mode 100644 include/hw/char/bcm2835_miniuart.h
 rename include/hw/{char => misc}/bcm2835_aux.h (73%)

-- 
2.21.0


