Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C99C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8721D2082E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCCx5r18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8721D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVpu-00028L-O9
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVnw-00007V-G3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVnu-0001Cj-0m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:04 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:43363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVnt-00014z-Pn; Wed, 05 Feb 2020 20:18:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id z9so5097032wrs.10;
 Wed, 05 Feb 2020 17:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z1xR+0C5iuS2wN0NuNjbYnlECeDv4TSFHvruaFSgWQ8=;
 b=rCCx5r18dNcTT2f6Jbau+M/SsPO+FkV0V3R2FgN1AKZzWzD7RruZRXAnlOAbUfwxoi
 3IbD4WoEG6NmV1JrW7yWjYp+tXRlSqAW1jPjZq9x8rerqah3+Rsg8rMu97NBEn0KqUoX
 BdGFNg0Q872sEGINoX8n3egtPS7f+dikGQO8zPwssILGaMFaSC1JVkCV5AFsCCQ5KpZH
 EBn+VQcWOzlOjKETMCGMWtzV73lyD1C10lqK+CRQvnzC0L/IhN+h7bagfZzKruicxO+x
 BOs3jnReB7Um/9jyextxigsmjMAMWkgkYmyEPCWTj8/JplMrfbwRPA+K/x37YuMI/mwY
 XLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=z1xR+0C5iuS2wN0NuNjbYnlECeDv4TSFHvruaFSgWQ8=;
 b=ksDKChMD7IfSKi5GBZx67mien/onaUnYw8vdpgClQ4ZC2jiXUKgiFqTKvKHHn7ET4/
 9fGkb38lD9j4UD1ptDzqicynFgopURm243+UTZ6Sd9nZaChHkDrwW1xchEZVHFYZASPP
 i2Jqr3iyeM5BlbMYINVfKoEcX3eUZetIiTaD5DjfmKsFEONr8VV5x0GD6qh4MHIq2hWq
 WYkksMJoNxqfOx+ZQqA2tKayR/ViDrp1iCAj/d08ZVRkcoCdVWSSpHGkefAellqnZAtS
 WmsQM6bQuC1K7/ltcdR1vSqwDh+PVJdsTe/gzT2e4trsy0gYAOT2hvWfr52juRIpfC7S
 Ol5Q==
X-Gm-Message-State: APjAAAVdb5UhZrTjFxWHo+mDGujX/9xKMDDFa4SOIGm0T4IkuqrwE6fw
 6aDuiCCLAq0VG8xi67yV4Mo0BheD
X-Google-Smtp-Source: APXvYqyJP++MC9R05whn7QRYY/xuy5beAu1NKmegEu4ItiJWObnlq1CLEoPHVXifTrS1+WJZbYC1Gg==
X-Received: by 2002:adf:e692:: with SMTP id r18mr305949wrm.413.1580951880165; 
 Wed, 05 Feb 2020 17:18:00 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:17:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/30] hw/arm/raspi: Dynamically create machines based on
 the board revision
Date: Thu,  6 Feb 2020 02:17:26 +0100
Message-Id: <20200206011756.2413-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These patches simplify adding the raspi0/raspi1/raspi4 boards.

Igor has been working in his "refactor main RAM allocation to use
hostmem backend" series, and now v4 [1] is almost reviewed.

His raspi patch [2] clashes with my work, Since it is easier for
him to apply his on top of mine, I am sending these patches first.

Only the 4 first patches matter regarding Igor's refactor, to
include "Extract the RAM size from the board revision" which
should solve the problem he has to fix in [2].

I finally finished the SoC code, so can add the raspi0/1.
Avocado tests also include to demostrate the boards work.
I will probably move the raspi tests out of boot_linux_console.py,
but that is another series.

Latest patches NOTFORMERGE are mostly to justify this refactor,
like the raspi0 and 1, it is easy to add a new soc/board.
However other bcm peripherals patches need to get merged first
(on the list but old so I need to rebase/repost them).

Please review, at least up to patch 21 (before the tests).

Phil.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675738.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675752.html
Supersedes: <20200203082619.7426-1-f4bug@amsat.org>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg676154.html

Philippe Mathieu-Daudé (30):
  hw/arm/raspi: Use BCM2708 machine type with pre Device Tree kernels
  hw/arm/raspi: Correct the board descriptions
  hw/arm/raspi: Extract the version from the board revision
  hw/arm/raspi: Extract the RAM size from the board revision
  hw/arm/raspi: Extract the processor type from the board revision
  hw/arm/raspi: Trivial code movement
  hw/arm/raspi: Make machines children of abstract RaspiMachineClass
  hw/arm/raspi: Make board_rev a field of RaspiMachineClass
  hw/arm/raspi: Let class_init() directly call raspi_machine_init()
  hw/arm/raspi: Set default RAM size to size encoded in board revision
  hw/arm/raspi: Extract the board model from the board revision
  hw/arm/raspi: Use a unique raspi_machine_class_init() method
  hw/arm/raspi: Extract the cores count from the board revision
  hw/arm/bcm2836: Restrict BCM283XClass declaration to C source
  hw/arm/bcm2836: QOM'ify more by adding class_init() to each SoC type
  hw/arm/bcm2836: Introduce BCM283XClass::core_count
  hw/arm/bcm2836: Only provide "enabled-cpus" property to multicore SoCs
  hw/arm/bcm2836: Split out common realize() code
  hw/arm/bcm2836: Introduce the BCM2835 SoC
  hw/arm/raspi: Add the Raspberry Pi Zero machine
  hw/arm/raspi: Add the Raspberry Pi B+ machine
  tests/acceptance/boot_linux_console: Use raspi console model as key
  tests/acceptance/boot_linux_console: Add raspi version=2 parameter
  tests/acceptance/boot_linux_console: Test the raspi1 console
  tests/acceptance/boot_linux_console: Test the raspi0 console
  python/qemu/machine: Allow to use other serial consoles than default
  tests/acceptance/boot_linux_console: Test the raspi1 AUX console
  tests/acceptance: Count Raspberry Pi logos displayed on framebuffer
  hw/arm/bcm2836: Add the ARMv8 BCM2838
  hw/arm/raspi: Add the Raspberry Pi 4

 include/hw/arm/bcm2836.h               |  16 +-
 hw/arm/bcm2836.c                       | 396 +++++++++++++++++++++----
 hw/arm/raspi.c                         | 204 ++++++++++---
 python/qemu/machine.py                 |  10 +-
 tests/acceptance/boot_linux_console.py | 154 +++++++++-
 5 files changed, 645 insertions(+), 135 deletions(-)

-- 
2.21.1


