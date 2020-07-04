Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75107C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42921208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA789/g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42921208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkI8-0003Db-HV
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkG7-0000c1-Ff
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkG3-0007Rl-Rq
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nr0/mEmyL3K5IVI928eiIdMK3sHSZE7ocqWvKvjJWbw=;
 b=XA789/g+G/703P6JpzMerPYGQLeqlqY5/dNDidjYPxVs5Y2cYil9ky7NFkE10wsBVougtg
 gZsQZZLFxh4LoZTzK5MmmSOLdnLqnIg0mEs2JvGbRwDWUuTjUgo4qgaGBDPRbNII52E2S3
 eFf11/XNqx55KG4wEUxjVKDwmzNXSB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-myde3emWNDulc1y454sZxA-1; Sat, 04 Jul 2020 11:39:13 -0400
X-MC-Unique: myde3emWNDulc1y454sZxA-1
Received: by mail-wr1-f71.google.com with SMTP id y16so35853584wrr.20
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nr0/mEmyL3K5IVI928eiIdMK3sHSZE7ocqWvKvjJWbw=;
 b=F3rybbL5dc2jvXhgd35K3pjxIus7j3vDdPwZdCg+i3gViITAf49WuUxmxWyie6b9KV
 130aR3TP83OiDSiOGhSye4/y+dhcILdG4IzJpIPoJ3WcZGt7HgKsn0S4c2v0dEJh8Gkx
 x6UHsvhLNddflBdwrPYHtoSCbY1QpMgNc/jD8iA+barcdjvuvo7IDXYjAZax+Y/7nBQ5
 Gi2NafHJb3jQYaDvjXuBD5h5c86uVB/tJh87NuIX3cJYtEjSIZJYfMYNPvVtw9m+pcET
 DEBLCCs4BX9RS3aWQBomIkjml2woBmi6574d1exgKzGTw85xnQ0342sYcpMmeGSUPi2g
 yKfg==
X-Gm-Message-State: AOAM531CCu1vA1YCbTEJByoGqPGSXtfca08BQ2c6c48qT7rTmyZv5R1s
 WPnYpjekS/s1fy5aGAT4Pzt6jFFCaaj8gmtsBIszWBds23ubHeaXlbD3ncP6VOEFrkpizbfM08m
 km1IaJg85LR7ACZc=
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr6714553wrt.67.1593877151762;
 Sat, 04 Jul 2020 08:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqAVYRFYzqVU2yC5gJD1uy3EIPuKDi0xg+WN1Yf+AhcuCgCujLfggwqGqEhizhBOScVaPpFw==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr6714516wrt.67.1593877151479;
 Sat, 04 Jul 2020 08:39:11 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u8sm16658341wrt.28.2020.07.04.08.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:39:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 00/23] hw/qdev: Warn when using pre-qdev/QOM devices
Date: Sat,  4 Jul 2020 17:38:45 +0200
Message-Id: <20200704153908.12118-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a trivial RFC series to anotate pre-qdev/QOM devices
so developers using them without knowing they are not QOM'ified
yet can realize it and convert them if/when they have time.

qdev/QOM devices are introspectable, so easier to test
or even fuzz.

Since RFC v1:
- Addressed bonzini comments, removed invalid patches
- Addressed thuth comment

Philippe Mathieu-Daudé (23):
  qom/object: Update documentation
  hw/core/qdev: Add qdev_warn_deprecated_function_used() helper
  hw/arm/omap: Emit warning when old code is used
  hw/arm/pxa2xx: Emit warning when old code is used
  hw/arm/nseries: Emit warning when old code is used
  hw/char/parallel: Emit warning when old code is used
  hw/display/blizzard: Emit warning when old code is used
  hw/display/ramfb: Emit warning when old code is used
  hw/display/tc6393xb: Emit warning when old code is used
  hw/display/vga-isa-mm: Emit warning when old code is used
  hw/dma/etraxfs_dma: Emit warning when old code is used
  hw/dma/soc_dma: Emit warning when old code is used
  hw/input/lasips2: Emit warning when old code is used
  hw/input/tsc2005: Emit warning when old code is used
  hw/m68k/mcf520x: Emit warning when old code is used
  hw/misc/cbus: Emit warning when old code is used
  hw/nvram/eeprom93xx: Emit warning when old code is used
  hw/openrisc/cputimer: Emit warning when old code is used
  hw/ppc/ppc4xx: Emit warning when old code is used
  hw/sh4: Emit warning when old code is used
  hw/riscv: Emit warning when old code is used
  hw/usb/hcd-musb: Emit warning when old code is used
  hw/xtensa/xtfpga: Emit warning when old code is used

 configure                    |  8 ++++++++
 include/hw/qdev-deprecated.h | 26 ++++++++++++++++++++++++++
 include/qom/object.h         |  6 +++---
 hw/arm/nseries.c             |  2 ++
 hw/arm/omap1.c               |  6 ++++++
 hw/arm/pxa2xx.c              |  3 +++
 hw/char/omap_uart.c          |  5 +++++
 hw/char/parallel.c           |  3 +++
 hw/char/sh_serial.c          |  3 +++
 hw/core/qdev.c               |  8 ++++++++
 hw/display/blizzard.c        |  3 +++
 hw/display/pxa2xx_lcd.c      |  3 +++
 hw/display/ramfb.c           |  3 +++
 hw/display/tc6393xb.c        |  3 +++
 hw/display/vga-isa-mm.c      |  5 +++++
 hw/display/vga.c             |  3 +++
 hw/dma/etraxfs_dma.c         |  4 +++-
 hw/dma/soc_dma.c             |  3 +++
 hw/input/lasips2.c           |  4 +++-
 hw/input/pxa2xx_keypad.c     |  3 +++
 hw/input/tsc2005.c           |  3 +++
 hw/intc/sh_intc.c            |  3 +++
 hw/m68k/mcf5206.c            |  5 +++++
 hw/m68k/mcf5208.c            |  3 +++
 hw/misc/cbus.c               |  3 +++
 hw/misc/omap_gpmc.c          |  3 +++
 hw/misc/omap_l4.c            |  3 +++
 hw/misc/omap_sdrc.c          |  3 +++
 hw/nvram/eeprom93xx.c        |  3 +++
 hw/openrisc/cputimer.c       |  3 +++
 hw/ppc/ppc405_boards.c       |  5 +++++
 hw/ppc/ppc405_uc.c           | 21 +++++++++++++++++++++
 hw/ppc/ppc4xx_devs.c         |  7 +++++++
 hw/riscv/riscv_htif.c        |  4 ++++
 hw/riscv/sifive_uart.c       |  4 ++++
 hw/sd/omap_mmc.c             |  5 +++++
 hw/sh4/r2d.c                 |  3 +++
 hw/sh4/sh7750.c              |  4 ++++
 hw/ssi/omap_spi.c            |  3 +++
 hw/timer/omap_synctimer.c    |  4 ++++
 hw/timer/sh_timer.c          |  5 +++++
 hw/usb/hcd-musb.c            |  3 +++
 hw/xtensa/xtfpga.c           |  3 +++
 43 files changed, 202 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/qdev-deprecated.h

-- 
2.21.3


