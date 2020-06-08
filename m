Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46689206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vl2KU2t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46689206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKHu-0001pm-IR
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKCx-000608-62
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKCq-0007RO-K4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r7PHbUODraiyYDfGeXtIeVn3Evhw0HgQCb8r2diF6v0=;
 b=Vl2KU2t3N7F4y1OKRb3SHpIDX9N5RULVx53pG4jixqEm/LRn89v0Z5/VAXwPBrrOS/5117
 2MBIuigqMmThY9Ht1bk/5yHODZU+KB/daEB63NdbldH5lgAKcxLJXGY/YsOcbz7sQ35Gw2
 jaqTYShLv2VdJAlFqwHvLsstv3NrqH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-SpfGOMPNNgOR65NtLTo91g-1; Mon, 08 Jun 2020 12:00:50 -0400
X-MC-Unique: SpfGOMPNNgOR65NtLTo91g-1
Received: by mail-wr1-f72.google.com with SMTP id n6so7360724wrv.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r7PHbUODraiyYDfGeXtIeVn3Evhw0HgQCb8r2diF6v0=;
 b=kkuM3w/TU094ZiVB9N69XHA5dvcn4SwjUWiDbRe3cPw8XxX6n888f2+LmG0TbXn/vR
 lA/Q/gnBkIvdnUiiwCH1ADLSj0e+oTE9B1Szj1/tiMty/QTpp0yZGhOStcOFforuoA+o
 HqbmN0tscb2HqAnqzpgMmR1/xitCpMBJcvM42b2GAi9gTa6kb5HNUoR30rAvbZB/zcX0
 NyoqtzaI2i32QY1/3bqrZUYAcbGVZdaMxeP9Yp75dR81+KfFuB/MGMqg6CN2hIbZz0Wp
 8D24NDdJWC7gGnBf5NWdXGoXbYEQCtZXw2vJva7bmxVt9O3BzNcJZOZiNxMJwmoeTvCE
 Gj0Q==
X-Gm-Message-State: AOAM533CN+2C7um23ct8zLWbj1vtGCGtj67v/5ETNnJhAwZL45iWKTuz
 J5wCqpKRLcAvUiHrAmbJVKSnQp7ZEvFawY9Jaqbw2fIjtoIQZY6COLjHYPjBouE41CTE+6wqpIK
 SjCVlKcnC7UfO2DE=
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr24291808wrw.91.1591632048450; 
 Mon, 08 Jun 2020 09:00:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMtorKuHBb+MRvZ6tBeip6kyiiVi39BDg4R5E8m4jpXwbcp5IXslWyCaizAHQ0jAbG9qrLqg==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr24291746wrw.91.1591632048080; 
 Mon, 08 Jun 2020 09:00:48 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o15sm175107wrv.48.2020.06.08.09.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:00:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/35] hw/qdev: Warn when using pre-qdev/QOM devices
Date: Mon,  8 Jun 2020 18:00:09 +0200
Message-Id: <20200608160044.15531-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on today's IRC chat, this is a trivial RFC series
to anotate pre-qdev/QOM devices so developers using them
without knowing they are not QOM'ified yet can realize
it and convert them if they have time.

qdev/QOM devices are introspectable, so easier to test
or even fuzz.

Philippe Mathieu-Daudé (35):
  qom/object: Update documentation
  hw/core/qdev: Add qdev_warn_deprecated_function_used() helper
  hw/arm/omap: Emit warning when old code is used
  hw/arm/pxa2xx: Emit warning when old code is used
  hw/arm/nseries: Emit warning when old code is used
  hw/timer/arm_timer: Emit warning when old code is used
  hw/char/parallel: Emit warning when old code is used
  hw/display/blizzard: Emit warning when old code is used
  hw/display/ramfb: Emit warning when old code is used
  hw/display/tc6393xb: Emit warning when old code is used
  hw/display/vga-isa-mm: Emit warning when old code is used
  hw/dma/etraxfs_dma: Emit warning when old code is used
  hw/dma/soc_dma: Emit warning when old code is used
  hw/i386/pc: Emit warning when old code is used
  hw/i386/xen/xen-hvm: Emit warning when old code is used
  hw/input/lasips2: Emit warning when old code is used
  hw/input/pckbd: Emit warning when old code is used
  hw/input/ps2: Emit warning when old code is used
  hw/input/tsc2005: Emit warning when old code is used
  hw/intc/i8259: Emit warning when old code is used
  hw/lm32/lm32_hwsetup: Emit warning when old code is used
  hw/m68k/mcf520x: Emit warning when old code is used
  hw/misc/applesmc: Emit warning when old code is used
  hw/misc/cbus: Emit warning when old code is used
  hw/nvram/eeprom93xx: Emit warning when old code is used
  hw/openrisc/cputimer: Emit warning when old code is used
  hw/ppc/ppc: Emit warning when old code is used
  hw/ppc/ppc4xx: Emit warning when old code is used
  hw/ppc/ppc_booke: Emit warning when old code is used
  hw/ppc/virtex_ml507: Emit warning when old code is used
  hw/sh4: Emit warning when old code is used
  hw/riscv: Emit warning when old code is used
  hw/timer/slavio_timer: Emit warning when old code is used
  hw/usb/hcd-musb: Emit warning when old code is used
  hw/xtensa/xtfpga: Emit warning when old code is used

 configure                    |  8 ++++++++
 hw/lm32/lm32_hwsetup.h       |  3 +++
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
 hw/i386/pc.c                 |  3 +++
 hw/i386/xen/xen-hvm.c        |  4 +++-
 hw/input/lasips2.c           |  4 +++-
 hw/input/pckbd.c             |  4 +++-
 hw/input/ps2.c               |  6 +++++-
 hw/input/pxa2xx_keypad.c     |  3 +++
 hw/input/tsc2005.c           |  3 +++
 hw/intc/i8259.c              |  3 +++
 hw/intc/sh_intc.c            |  3 +++
 hw/m68k/mcf5206.c            |  5 +++++
 hw/m68k/mcf5208.c            |  3 +++
 hw/misc/applesmc.c           |  3 +++
 hw/misc/cbus.c               |  3 +++
 hw/misc/omap_gpmc.c          |  3 +++
 hw/misc/omap_l4.c            |  3 +++
 hw/misc/omap_sdrc.c          |  3 +++
 hw/nvram/eeprom93xx.c        |  3 +++
 hw/openrisc/cputimer.c       |  3 +++
 hw/ppc/ppc.c                 |  3 +++
 hw/ppc/ppc405_boards.c       |  5 +++++
 hw/ppc/ppc405_uc.c           | 21 +++++++++++++++++++++
 hw/ppc/ppc4xx_devs.c         |  7 +++++++
 hw/ppc/ppc_booke.c           |  4 +++-
 hw/ppc/virtex_ml507.c        |  4 +++-
 hw/riscv/riscv_htif.c        |  4 ++++
 hw/riscv/sifive_uart.c       |  4 ++++
 hw/sd/omap_mmc.c             |  5 +++++
 hw/sh4/r2d.c                 |  3 +++
 hw/sh4/sh7750.c              |  4 ++++
 hw/ssi/omap_spi.c            |  3 +++
 hw/timer/arm_timer.c         |  3 +++
 hw/timer/omap_synctimer.c    |  4 ++++
 hw/timer/sh_timer.c          |  5 +++++
 hw/timer/slavio_timer.c      |  3 +++
 hw/usb/hcd-musb.c            |  3 +++
 hw/xtensa/xtfpga.c           |  3 +++
 55 files changed, 240 insertions(+), 10 deletions(-)
 create mode 100644 include/hw/qdev-deprecated.h

-- 
2.21.3


