Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9038820716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcssocLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9038820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjr4-0003FL-Lj
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpn-0001cw-5Q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpk-0007gf-BI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XGDbtPDwq/ubIzTWRwC9l56GEedbKO84aS6vrVYbOaA=;
 b=dcssocLklgI1hsqeb8iukoI6/9JPJJaCc31ScqcJv/X6HpX9Rea/g3gY5+5ZMt4Rk0qTau
 WQOXSIex8hQpk2e6jg/1OnYuX/Fb0wUNcWg2WS+IQ5aV/sXM527Sk9DV5bP1/gI6Xs9Fjy
 kKk+PZfGsDf0EEthVYil7fJsCh4dfSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-ZqzL34pXOuWHatvgo29dNw-1; Tue, 23 Jun 2020 10:23:28 -0400
X-MC-Unique: ZqzL34pXOuWHatvgo29dNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110C964AD4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6CE07166A
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F5D1113846D; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Qdev patches for 2020-06-23
Date: Tue, 23 Jun 2020 16:23:10 +0200
Message-Id: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 61fee7f45955cd0bf9b79be9fa9c7ebabb5e6a85:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing-20200622' into staging (2020-06-22 20:50:10 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qdev-2020-06-23

for you to fetch changes up to 953cd66139b6e28fdc7cdbf28065a0a98ce7877c:

  sd/milkymist-memcard: Fix error API violation (2020-06-23 16:07:21 +0200)

----------------------------------------------------------------
Qdev patches for 2020-06-23

* Reject clash between -drive if=floppy and -global isa-fdc
* Deprecate configuring floppies with -global isa-fdc
* Deprecate -drive with bogus interface type
* Reject drive property override instead of screwing up
* Reject chardev property override instead of screwing up
* Various error handling improvements
* Extend iotests/172

----------------------------------------------------------------
Markus Armbruster (16):
      iotests/172: Include "info block" in test output
      iotests/172: Cover empty filename and multiple use of drives
      iotests/172: Cover -global floppy.drive=...
      fdc: Reject clash between -drive if=floppy and -global isa-fdc
      fdc: Open-code fdctrl_init_isa()
      fdc: Deprecate configuring floppies with -global isa-fdc
      docs/qdev-device-use.txt: Update section "Default Devices"
      blockdev: Deprecate -drive with bogus interface type
      qdev: Eliminate get_pointer(), set_pointer()
      qdev: Improve netdev property override error a bit
      qdev: Reject drive property override
      qdev: Reject chardev property override
      qdev: Make qdev_prop_set_drive() match the other helpers
      arm/aspeed: Drop aspeed_board_init_flashes() parameter @errp
      sd/pxa2xx_mmci: Don't crash on pxa2xx_mmci_init() error
      sd/milkymist-memcard: Fix error API violation

 docs/qdev-device-use.txt            |  17 +-
 docs/system/deprecated.rst          |  34 ++
 include/hw/block/fdc.h              |   2 +-
 include/hw/qdev-properties.h        |  18 +-
 include/sysemu/blockdev.h           |   2 +
 blockdev.c                          |  27 +-
 hw/arm/aspeed.c                     |  16 +-
 hw/arm/cubieboard.c                 |   2 +-
 hw/arm/exynos4210.c                 |   2 +-
 hw/arm/imx25_pdk.c                  |   2 +-
 hw/arm/mcimx6ul-evk.c               |   2 +-
 hw/arm/mcimx7d-sabre.c              |   2 +-
 hw/arm/msf2-som.c                   |   4 +-
 hw/arm/nseries.c                    |   4 +-
 hw/arm/orangepi.c                   |   2 +-
 hw/arm/raspi.c                      |   2 +-
 hw/arm/sabrelite.c                  |   6 +-
 hw/arm/vexpress.c                   |   3 +-
 hw/arm/xilinx_zynq.c                |   7 +-
 hw/arm/xlnx-versal-virt.c           |   2 +-
 hw/arm/xlnx-zcu102.c                |  10 +-
 hw/block/fdc.c                      |  82 +++--
 hw/block/nand.c                     |   2 +-
 hw/block/pflash_cfi01.c             |   6 +-
 hw/block/pflash_cfi02.c             |   2 +-
 hw/core/qdev-properties-system.c    | 151 +++++----
 hw/core/qdev-properties.c           |  17 +
 hw/i386/pc.c                        |   8 +-
 hw/ide/qdev.c                       |   4 +-
 hw/isa/isa-superio.c                |  18 +-
 hw/m68k/q800.c                      |   3 +-
 hw/microblaze/petalogix_ml605_mmu.c |   5 +-
 hw/ppc/pnv.c                        |   3 +-
 hw/ppc/spapr.c                      |   4 +-
 hw/scsi/scsi-bus.c                  |   2 +-
 hw/sd/milkymist-memcard.c           |   2 +-
 hw/sd/pxa2xx_mmci.c                 |  15 +-
 hw/sd/sd.c                          |   2 +-
 hw/sd/ssi-sd.c                      |   3 +-
 hw/sparc64/sun4u.c                  |   9 +-
 hw/xtensa/xtfpga.c                  |   3 +-
 softmmu/vl.c                        |   8 +
 tests/qemu-iotests/172              |  27 +-
 tests/qemu-iotests/172.out          | 656 ++++++++++++++++++++++++++++++++----
 44 files changed, 928 insertions(+), 270 deletions(-)

-- 
2.26.2


