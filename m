Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8335C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EED20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG5Jr+aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EED20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvDk-0002oG-Qo
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuoc-0006hC-Fa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuoa-0005A1-4x
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuoa-000542-0Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l9x7QGG+sGPKiIwQz5wzank0pVYVupToCnuCHL1GZz0=;
 b=NG5Jr+aUMzquRxn9iW1bz4/AMG2EsMxo49wRKfLgyb5ty8MC46O4vxLxZYervEMFvki3zM
 0ii0JlcCNZynPjGIafIR79Pey3Irct8FZSrleDu0bFCZXAar4v01Dm3yd5wER6YZo7dR8M
 7HjldW3bedp0bXcO1tdiOjlrQzyRugQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-PPz7wE9jPzeUNQ3K83LIwg-1; Mon, 16 Mar 2020 14:50:10 -0400
X-MC-Unique: PPz7wE9jPzeUNQ3K83LIwg-1
Received: by mail-wr1-f71.google.com with SMTP id g4so1808873wrv.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p0B1qB6W1+B6V/iAfeHWgG1DaUKi1Fu7Es9TZCP9/cg=;
 b=VabSkRNXCfCDunG+ts1ph2xOZrZkZybrDlcxr4CmrBwcBh3iknbaYoPcXhlJhFvJ3S
 Ai+2hoxeIaC5DHCsFfG+N4JiFsZBX1qd9qRnPHDcRiDiwyweusrF0NBY57JnCjSMzYss
 cTqNph9DCsCKf25PdOpX8Qb4RIfqtTRzxwGEUOcyQ//WFDaBRzDHw9YcJoel+Yo4UyE/
 6zMb40LCmzVlUAczv3bS/+0VLmADTNBeQoPpZ1i+PbODzeeTFbhHOSt4BuYK8U5QaTZM
 FwutIl+47KkuPNqADth65k/dBAQL59yV72qHZER+MVPkoxZXR4tqL4qyyM4WLpiIw7as
 wwWw==
X-Gm-Message-State: ANhLgQ3ZC30xPgSpMSZApfpWlglb4g0MbgGxGAvfX/Lsb8cqltx3z5RX
 B1x3ykaGl+vT+OH0Bd/ep3xrGyxmTm3clcJLmWqd5nc6DnkqkcMBrdFx8veOpTFK9RmhBQarFkX
 j2596GvvHzEt3Pjg=
X-Received: by 2002:adf:eec7:: with SMTP id a7mr717104wrp.405.1584384609184;
 Mon, 16 Mar 2020 11:50:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs5ST1g6I/BhwwkZF+PG09+7nVl7kYB70MZQ7zEhEV6GLnTseA268whufZSvqjbOvHWoosKBw==
X-Received: by 2002:adf:eec7:: with SMTP id a7mr717081wrp.405.1584384608973;
 Mon, 16 Mar 2020 11:50:08 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id a13sm1066318wrh.80.2020.03.16.11.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/25] hw: Sanitize various MemoryRegion calls
Date: Mon, 16 Mar 2020 19:49:41 +0100
Message-Id: <20200316185006.576-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series simplifies various memory API calls when creating
memory regions.

Most of the patches are generated with Coccinelle semantic
patches (provided).
Few more cleanups added while writting the patches have been
added.

v1 was 'Let devices own the MemoryRegion they create':
https://www.mail-archive.com/qemu-devel@nongnu.org/msg681960.html

Since v2:
- only keep generated/automatic patches
- add reviewers tags

Since v1:
- understood a bit more Peter Maydell comments regarding
  how memory devices are migrated.

Philippe Mathieu-Daud=C3=A9 (25):
  memory: Correctly return alias region type
  memory: Simplify memory_region_init_rom_nomigrate() to ease review
  scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
  scripts/cocci: Patch to replace memory_region_init_{ram,readonly ->
    rom}
  hw/arm: Use memory_region_init_rom() with read-only regions
  hw/display: Use memory_region_init_rom() with read-only regions
  hw/m68k: Use memory_region_init_rom() with read-only regions
  hw/net: Use memory_region_init_rom() with read-only regions
  hw/pci-host: Use memory_region_init_rom() with read-only regions
  hw/ppc: Use memory_region_init_rom() with read-only regions
  hw/riscv: Use memory_region_init_rom() with read-only regions
  hw/sh4: Use memory_region_init_rom() with read-only regions
  hw/sparc: Use memory_region_init_rom() with read-only regions
  scripts/cocci: Patch to detect potential use of memory_region_init_rom
  scripts/cocci: Patch to remove unnecessary
    memory_region_set_readonly()
  scripts/cocci: Patch to let devices own their MemoryRegions
  hw/core: Let devices own the MemoryRegion they create
  hw/display: Let devices own the MemoryRegion they create
  hw/dma: Let devices own the MemoryRegion they create
  hw/riscv: Let devices own the MemoryRegion they create
  hw/char: Let devices own the MemoryRegion they create
  hw/arm/stm32: Use memory_region_init_rom() with read-only regions
  hw/ppc/ppc405: Use memory_region_init_rom() with read-only regions
  hw/arm: Remove unnecessary memory_region_set_readonly() on ROM alias
  hw/arm: Let devices own the MemoryRegion they create

 .../memory-region-housekeeping.cocci          | 159 ++++++++++++++++++
 .../coccinelle/memory-region-init-ram.cocci   |  38 -----
 hw/arm/exynos4210.c                           |  14 +-
 hw/arm/fsl-imx25.c                            |  10 +-
 hw/arm/fsl-imx31.c                            |   6 +-
 hw/arm/fsl-imx6.c                             |   6 +-
 hw/arm/fsl-imx6ul.c                           |   9 +-
 hw/arm/mainstone.c                            |   3 +-
 hw/arm/msf2-soc.c                             |   6 +-
 hw/arm/nrf51_soc.c                            |   2 +-
 hw/arm/omap_sx1.c                             |   6 +-
 hw/arm/palm.c                                 |   3 +-
 hw/arm/spitz.c                                |   3 +-
 hw/arm/stellaris.c                            |   3 +-
 hw/arm/stm32f205_soc.c                        |  11 +-
 hw/arm/stm32f405_soc.c                        |  12 +-
 hw/arm/tosa.c                                 |   3 +-
 hw/arm/xlnx-zynqmp.c                          |  11 +-
 hw/char/serial.c                              |   7 +-
 hw/core/platform-bus.c                        |   3 +-
 hw/display/cg3.c                              |   5 +-
 hw/display/g364fb.c                           |   3 +-
 hw/display/macfb.c                            |   4 +-
 hw/display/tcx.c                              |   5 +-
 hw/dma/i8257.c                                |   2 +-
 hw/dma/rc4030.c                               |   4 +-
 hw/m68k/q800.c                                |   3 +-
 hw/net/dp8393x.c                              |   5 +-
 hw/pci-host/prep.c                            |   5 +-
 hw/ppc/mac_newworld.c                         |   3 +-
 hw/ppc/mac_oldworld.c                         |   3 +-
 hw/ppc/ppc405_boards.c                        |   6 +-
 hw/riscv/sifive_e.c                           |   9 +-
 hw/riscv/sifive_u.c                           |   2 +-
 hw/sh4/shix.c                                 |   3 +-
 hw/sparc/leon3.c                              |   3 +-
 memory.c                                      |  16 +-
 MAINTAINERS                                   |   1 +
 38 files changed, 244 insertions(+), 153 deletions(-)
 create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
 delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci

--=20
2.21.1


