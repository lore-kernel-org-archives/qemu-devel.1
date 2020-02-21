Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F74BC35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8F0222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evR2OpGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8F0222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CA4-0007Um-5R
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8g-0005x3-0H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8e-0007uN-Hl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:30:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8e-0007tr-Dq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DW078fSvt/wxVo8MW6RkGmUKOq8LBVvtStTwUkCFZp0=;
 b=evR2OpGr6ryj4kHcIj8w0fMmTe+Wonw+aDBMTZccifnBR4SXAwGrjUdvLLnWp1spwWS7Hd
 gqmRTuZ0hQdPgq1Wf5TBnL1DbkpxCuxHBcP9hwITEX2RXu29/KAl6U+6IVEmh+0xXTmRxi
 dfZIk4WrTsUu8JD/eyDKtj4ebXqe378=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-3A8RmBVcO7GibjlF_bg_3A-1; Fri, 21 Feb 2020 12:30:54 -0500
X-MC-Unique: 3A8RmBVcO7GibjlF_bg_3A-1
Received: by mail-wr1-f70.google.com with SMTP id o9so1315031wrw.14
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uAN0dTE3rfOWvsVoICSRFD9tmlR68qf+wBSCeU/ZbPU=;
 b=ldhla/45eD8Q81fq35fN3rQXzcRYStlxweeqlH10fcVoDwBqWvvLaltYoAiCNswE9d
 vmiNegsuzz/4Zyxra8nAoO91HNCrKhvc3uIBWYWNM1SOTaiEIfPLX0nWcieEKK7dp12D
 zq+MTUYYK8ipaVp51/FSeisjCs6yDC4KQkzIFJcp03u1/ISjfvW907UBEQMwAJu7loKd
 AdN7nsIwum9zvZil8ev/Qvtc/9TB6ZwCtq/Z7R/pd9FUX1r03LuLQpivO/3MyCMZ+AAk
 gxPDUUy+WCJBHo0I89gbOw4eRQ1VJ8lJUQXyx9LHUnMbYNYUsApY0ay5cFiO/cAVWeSy
 izlA==
X-Gm-Message-State: APjAAAVgKhApdlRprNAxyMh0scXDgn4s0kX8NuVBAwJsV+iEgyJxq5VH
 7cGP4QJgxwq8undlHEiuTwImAPxkIRKnJ4TyiPNS6CQs6FdDzKWD0BM6bOKk5Zqa2//S79Y/GRr
 un4wgCMNng9PXuGg=
X-Received: by 2002:adf:fe43:: with SMTP id m3mr52587977wrs.213.1582306252672; 
 Fri, 21 Feb 2020 09:30:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqynjMoLs2CLxYrTIDWvEsXXOVLD/j3uHLlhbsn3QvkxuedCNGtdjQN2y3xDXD4I4Te2WtPi1Q==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr52587938wrs.213.1582306252393; 
 Fri, 21 Feb 2020 09:30:52 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:30:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] hw: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:42 +0100
Message-Id: <20200221173049.18134-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a device creates a MemoryRegion without setting its ownership,
the MemoryRegion is added to the machine "/unattached" container in
the QOM tree.

Add a script to do automatically let the device take the ownership
of the memory regions it creates, and run it.

Philippe Mathieu-Daud=C3=A9 (7):
  scripts/coccinelle: Add a script to let devices own their
    MemoryRegions
  hw/arm: Let devices own the MemoryRegion they create
  hw/char: Let devices own the MemoryRegion they create
  hw/core: Let devices own the MemoryRegion they create
  hw/display: Let devices own the MemoryRegion they create
  hw/dma: Let devices own the MemoryRegion they create
  hw/riscv: Let devices own the MemoryRegion they create

 hw/arm/exynos4210.c                           | 14 ++--
 hw/arm/fsl-imx25.c                            | 14 ++--
 hw/arm/fsl-imx31.c                            | 10 +--
 hw/arm/fsl-imx6.c                             | 10 +--
 hw/arm/fsl-imx6ul.c                           | 14 ++--
 hw/arm/msf2-soc.c                             |  8 +-
 hw/arm/nrf51_soc.c                            |  2 +-
 hw/arm/stm32f205_soc.c                        | 10 +--
 hw/arm/stm32f405_soc.c                        | 13 +--
 hw/arm/xlnx-zynqmp.c                          | 13 ++-
 hw/char/serial.c                              |  7 +-
 hw/core/platform-bus.c                        |  3 +-
 hw/display/cg3.c                              |  4 +-
 hw/display/g364fb.c                           |  5 +-
 hw/display/macfb.c                            |  4 +-
 hw/display/vmware_vga.c                       |  4 +-
 hw/dma/i8257.c                                |  2 +-
 hw/dma/rc4030.c                               |  4 +-
 hw/riscv/sifive_e.c                           |  8 +-
 hw/riscv/sifive_u.c                           |  4 +-
 .../memory_region_owner_nonnull.cocci         | 80 +++++++++++++++++++
 21 files changed, 158 insertions(+), 75 deletions(-)
 create mode 100644 scripts/coccinelle/memory_region_owner_nonnull.cocci

--=20
2.21.1


