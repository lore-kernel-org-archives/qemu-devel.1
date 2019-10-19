Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F5CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554E720820
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSOCS5Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554E720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyT7-0001hM-NL
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRN-0008SU-Qz
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRM-0005T4-8P
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRM-0005Sf-0N; Sat, 19 Oct 2019 19:47:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id e11so1154492wrv.4;
 Sat, 19 Oct 2019 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S1Bv5ZADtudIK2ckQmSIBf7nainSPHA/IK2m+tVYRJY=;
 b=aSOCS5Oo17NjIycLdhbIShZFmWY1mLyfM3OkGYGxu5ivna9vtDu5qkQBtOKL91AFxs
 NYIN6nKDOROYX9UzOYLcY93KeHMpAE5GHZMwkmF5ys07RG6PdmyRZ+bycQ3EXoYk3Xm6
 dNdThf3H2qeAMYPerXmAplOEVoh0Upe/iyPxbyObg3hE5ChQAaMgdtWXgV/lUdRjn08T
 z4dBYlpKONL2eVX8mAaz47LQwZCf0Z+vtYrLSEqSbcR5EK5+wee7XHH+Xb+v/DctSRLT
 TzKcFnVc8pHGykekhBI1zAXHY0CK0LwzVrUcRSGZG0tCbK/m9yMEgPpcET2Fv3wc/4LJ
 AjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=S1Bv5ZADtudIK2ckQmSIBf7nainSPHA/IK2m+tVYRJY=;
 b=V0FQscq188ZuFR5cVlQFqDFYBE6TjQVOAk370wis6TTAnCyjCewU63nTpL29bRcv13
 gF5t84wFMuFi++1F1Sa8yC0Ch9SXjclBEmtQXxFo4Kurn09XrUdf9WOEZP+8C8G44wsV
 h/12YEB4CKjKnVgsNZAebS3tJidSmZWOBIBPnvGudvessRWpvMX2Xrbw1QZ3BIWPKiIg
 CqHOndKXbi+1g9yVBiD7wLw60AL49nyMy4Z1sYlXLNyUmSb/Rt8kFJP//SOKpFOnk07k
 IGW8bcaZMjt8i3MYV8be5FmdKfAx24jNEs4jULhYFSxhFT+Sw1oW2HBq1MTzknPClW+V
 ZGfA==
X-Gm-Message-State: APjAAAU38wNNJp2hrPzgr4OL+h/VY15pmB/itZjURZGt3hnMzTDBjlkh
 ROuGNpwEo/gy4yGSHg8CFmxFox+y
X-Google-Smtp-Source: APXvYqwTK2KJgvQdmVBK69k+bjXHu25Yne39oYMDoQCSYWZc0PxhOq1FRrcHphNnBAK+AAMtaQ09Pw==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr10975826wrv.86.1571528838381; 
 Sat, 19 Oct 2019 16:47:18 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer,
 improve address space, run U-boot
Date: Sun, 20 Oct 2019 01:46:59 +0200
Message-Id: <20191019234715.25750-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v2:
- fixed issue in videocore address space
- allow to start with some cores OFF (to boot firmwares)
- add proof-of-concept test for '-smp cores=1' and U-boot
- fixed my email setup

Previous cover:

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

$ git backport-diff -u v2
001/16:[----] [--] 'hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor'
002/16:[----] [--] 'hw/arm/bcm2835_peripherals: Use the thermal sensor block'
003/16:[----] [--] 'hw/timer/bcm2835: Add the BCM2835 SYS_timer'
004/16:[----] [--] 'hw/arm/bcm2835_peripherals: Use the SYS_timer'
005/16:[----] [--] 'hw/arm/bcm2836: Make the SoC code modular'
006/16:[down] 'hw/arm/bcm2836: Rename cpus[] as cpu[].core'
007/16:[0053] [FC] 'hw/arm/bcm2836: Use per CPU address spaces'
008/16:[down] 'hw/arm/bcm2835_peripherals: Add const link property in realize()'
009/16:[0105] [FC] 'hw/arm/bcm2836: Create VideoCore address space in the SoC'
010/16:[----] [--] 'hw/arm/raspi: Use AddressSpace when using arm_boot::write_secondary_boot'
011/16:[down] 'hw/arm/raspi: Use -smp cores=<N> option to restrict enabled cores'
012/16:[down] 'hw/arm/bcm2836: Rename enabled_cpus -> enabled_cores'
013/16:[----] [-C] 'hw/arm/raspi: Make the board code modular'
014/16:[----] [--] 'hw/arm/highbank: Use AddressSpace when using write_secondary_boot()'
015/16:[down] 'python/qemu/machine: Allow to use other serial consoles than default'
016/16:[down] 'NOTFORMERGE tests/acceptance: Test U-boot on the Raspberry Pi 3'

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04474.html

Philippe Mathieu-Daudé (16):
  hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
  hw/arm/bcm2835_peripherals: Use the thermal sensor block
  hw/timer/bcm2835: Add the BCM2835 SYS_timer
  hw/arm/bcm2835_peripherals: Use the SYS_timer
  hw/arm/bcm2836: Make the SoC code modular
  hw/arm/bcm2836: Rename cpus[] as cpu[].core
  hw/arm/bcm2836: Use per CPU address spaces
  hw/arm/bcm2835_peripherals: Add const link property in realize()
  hw/arm/bcm2836: Create VideoCore address space in the SoC
  hw/arm/raspi: Use AddressSpace when using
    arm_boot::write_secondary_boot
  hw/arm/raspi: Use -smp cores=<N> option to restrict enabled cores
  hw/arm/bcm2836: Rename enabled_cpus -> enabled_cores
  hw/arm/raspi: Make the board code modular
  hw/arm/highbank: Use AddressSpace when using write_secondary_boot()
  python/qemu/machine: Allow to use other serial consoles than default
  NOTFORMERGE tests/acceptance: Test U-boot on the Raspberry Pi 3

 hw/arm/bcm2835_peripherals.c           |  76 +++++++----
 hw/arm/bcm2836.c                       | 119 ++++++++++++++----
 hw/arm/highbank.c                      |   3 +-
 hw/arm/raspi.c                         | 127 +++++++++++++++----
 hw/misc/Makefile.objs                  |   1 +
 hw/misc/bcm2835_thermal.c              | 135 ++++++++++++++++++++
 hw/timer/Makefile.objs                 |   1 +
 hw/timer/bcm2835_systmr.c              | 166 +++++++++++++++++++++++++
 hw/timer/trace-events                  |   5 +
 include/hw/arm/bcm2835_peripherals.h   |   9 +-
 include/hw/arm/bcm2836.h               |  17 ++-
 include/hw/arm/raspi_platform.h        |   1 +
 include/hw/misc/bcm2835_thermal.h      |  27 ++++
 include/hw/timer/bcm2835_systmr.h      |  33 +++++
 python/qemu/machine.py                 |   9 +-
 tests/acceptance/boot_linux_console.py |  23 ++++
 16 files changed, 671 insertions(+), 81 deletions(-)
 create mode 100644 hw/misc/bcm2835_thermal.c
 create mode 100644 hw/timer/bcm2835_systmr.c
 create mode 100644 include/hw/misc/bcm2835_thermal.h
 create mode 100644 include/hw/timer/bcm2835_systmr.h

-- 
2.21.0


