Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E1DCA9EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4509F21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fccyx991"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4509F21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEk0-00022P-7G
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEid-0000GE-Q5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEic-0002H8-KZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEic-0002GJ-Bp; Thu, 17 Oct 2019 18:58:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so4141803wrj.6;
 Thu, 17 Oct 2019 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lVgPPsMZxQlKV7Uev3P1rYQRpbx5QCi6gWz7bM0qE7M=;
 b=fccyx991Ntw9hV16bt7CpnqelzTm4j8u6O4aLlsyoIGOTUA4RkjqLhjyJVdNjDa+lx
 jGpCcZBrlCSKJ18QjWAy0lTTLRhpTad3y5v87+1yqybiR0X8Sa2DJqC1aYqu1zwObpnc
 4LlxiC4FLLuUO57H3HQodAi3VllMmaMz0im21q/M+2D4IXVqsGfSujRIy4BTa5Jn8mrG
 /i138C8HiFUNMPvjBHthod6pfUt6VljNoembE5eksGVa8e5RholvIC+qlQ1Ek/PaWh9x
 XZV1FsgXKDdQwYfaVLaLh/ECNhgOBaPA8pkit3NCQP+sKhTRWeRFLJsFemC7kKSeJ1Jv
 Yy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=lVgPPsMZxQlKV7Uev3P1rYQRpbx5QCi6gWz7bM0qE7M=;
 b=plB/cMx+Lsb/zvHgODoRnuG646TQ1hgLzzCahyJJUEPPfCRniRTPHqMOkJpV6OQU8C
 Ky7YmwaAeiKHyx3UWR57hTJJhk538rnQq3F8PP6F0I66BBbwuhA8b/dgQEV93qw8fdjH
 kwq5oF6/wY+UokAwKElfYKF1ZVlkEUq4LnPs1+S3B9guSYMHYDvRNtxg2nrI18kZ8iZR
 pZK3ExihO+CuG2faMyldlhB27uqX1gm17ZHAFi/Qj3hRayogX/CUlof3Bx+CPziokVYC
 Pf2uFCKuvecE3/jiKJUmEQsrmtIk1YDE5UxFA20peA6OOvQOnjkz8DoKcnZEYtFRmluU
 KUYA==
X-Gm-Message-State: APjAAAWsM6LxD2KSUZVy2ZQDlbFpHoeZaGd8N7BEYT+v7NozugjbAQH2
 g4PnOvQz59YAv8b5VSEXkEUr3Pmo
X-Google-Smtp-Source: APXvYqw6I6p7FBuBN4jDGXhExCCEIdT+LL49UqPF+ZFXKYUdxqGA1nws5RSNSB9X+jCpLKXWCUte+A==
X-Received: by 2002:adf:a54e:: with SMTP id j14mr1986461wrb.265.1571353084236; 
 Thu, 17 Oct 2019 15:58:04 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] hw/arm/raspi: Add thermal/timer,
 improve multicore address space
Date: Fri, 18 Oct 2019 00:57:50 +0200
Message-Id: <20191017225800.6946-1-f4bug@amsat.org>
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, PhilMD <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: PhilMD <f4bug@amsat.org>

Hi,

Some patches from v1 are already merged. This v2 addresses the
review comment from v1, and add patches to clean the memory
space when using multiple cores.

Laurent, if you test U-Boot with this patchset again, do you mind
replying with a "Tested-by:" tag?

The next patchset is probably about the interrupt controller blocks,
then will come another one about the MBox/Properties.

The last patch is unrelated to the series, but since I cleaned this
for the raspi and the highbank is the only board with the same issue,
I included the patch in this series.

Please review.

Regards,

Phil.

Philippe Mathieu-Daudé (10):
  hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
  hw/arm/bcm2835_peripherals: Use the thermal sensor block
  hw/timer/bcm2835: Add the BCM2835 SYS_timer
  hw/arm/bcm2835_peripherals: Use the SYS_timer
  hw/arm/bcm2836: Make the SoC code modular
  hw/arm/bcm2836: Create VideoCore address space in the SoC
  hw/arm/bcm2836: Use per CPU address spaces
  hw/arm/raspi: Use AddressSpace when using
    arm_boot::write_secondary_boot
  hw/arm/raspi: Make the board code modular
  hw/arm/highbank: Use AddressSpace when using write_secondary_boot()

 hw/arm/bcm2835_peripherals.c         |  73 +++++++-----
 hw/arm/bcm2836.c                     |  91 ++++++++++++---
 hw/arm/highbank.c                    |   3 +-
 hw/arm/raspi.c                       | 123 ++++++++++++++++----
 hw/misc/Makefile.objs                |   1 +
 hw/misc/bcm2835_thermal.c            | 135 ++++++++++++++++++++++
 hw/timer/Makefile.objs               |   1 +
 hw/timer/bcm2835_systmr.c            | 166 +++++++++++++++++++++++++++
 hw/timer/trace-events                |   5 +
 include/hw/arm/bcm2835_peripherals.h |   9 +-
 include/hw/arm/bcm2836.h             |  11 ++
 include/hw/arm/raspi_platform.h      |   1 +
 include/hw/misc/bcm2835_thermal.h    |  27 +++++
 include/hw/timer/bcm2835_systmr.h    |  33 ++++++
 14 files changed, 610 insertions(+), 69 deletions(-)
 create mode 100644 hw/misc/bcm2835_thermal.c
 create mode 100644 hw/timer/bcm2835_systmr.c
 create mode 100644 include/hw/misc/bcm2835_thermal.h
 create mode 100644 include/hw/timer/bcm2835_systmr.h

-- 
2.21.0


