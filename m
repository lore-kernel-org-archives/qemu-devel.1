Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37426C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F898206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F898206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sNZ-00029n-3A
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6sM3-0000OW-E1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6sM2-0007JA-4W
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:47:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45806 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6sM1-00073q-OX; Wed, 26 Feb 2020 03:47:42 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3DC5F2A4522DC625B0A0;
 Wed, 26 Feb 2020 16:47:37 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 16:47:29 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v2 00/13] redundant code: Fix warnings reported by Clang
 static code analyzer
Date: Wed, 26 Feb 2020 16:46:34 +0800
Message-ID: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Since v1:
- Patch1: Addressed John Snow review comment.
- Patch12=EF=BC=9AAddressed Philippe Mathieu-Daud=C3=A9 review comment.
- Patch9: Move the 'dst_type' declaration to while() statement.
- Patch13: Move the 'set' declaration to the for() statement.

Chen Qun (13):
  block/stream: Remove redundant statement in stream_run()
  block/iscsi:Remove redundant statement in iscsi_open()
  block/file-posix: Remove redundant statement in raw_handle_perm_lock()
  scsi/esp-pci: Remove redundant statement in esp_pci_io_write()
  scsi/scsi-disk: Remove redundant statement in
    scsi_disk_emulate_command()
  display/pxa2xx_lcd: Remove redundant statement in
    pxa2xx_palette_parse()
  display/exynos4210_fimd: Remove redundant statement in
    exynos4210_fimd_update()
  display/blizzard: Remove redundant statement in
    blizzard_draw_line16_32()
  dma/xlnx-zdma: Remove redundant statement in zdma_write_dst()
  migration/vmstate: Remove redundant statement in
    vmstate_save_state_v()
  timer/exynos4210_mct: Remove redundant statement in
    exynos4210_mct_write()
  usb/hcd-ehci: Remove redundant statements
  monitor/hmp-cmds: Remove redundant statement in
    hmp_rocker_of_dpa_groups()

 block/file-posix.c           |  1 -
 block/iscsi.c                |  1 -
 block/stream.c               |  1 -
 hw/display/blizzard.c        |  1 -
 hw/display/exynos4210_fimd.c |  1 -
 hw/display/pxa2xx_lcd.c      |  1 -
 hw/dma/xlnx-zdma.c           | 10 +++++-----
 hw/scsi/esp-pci.c            |  1 -
 hw/scsi/scsi-disk.c          |  1 -
 hw/timer/exynos4210_mct.c    |  4 ----
 hw/usb/hcd-ehci.c            |  3 ---
 migration/vmstate.c          |  1 -
 monitor/hmp-cmds.c           |  5 +----
 13 files changed, 6 insertions(+), 25 deletions(-)

--=20
2.23.0



