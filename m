Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEEE21874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g9pcLyRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEEE21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FL2-0001a2-Dk
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F95-0007ad-2Z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F93-0004JQ-UC
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:22:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1F91-0004HC-9w; Fri, 23 Aug 2019 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566588164; x=1598124164;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AlJFr47nhbm2wTlVLwsWWwbcv2AFTMXo7l+g1SK4Ph4=;
 b=g9pcLyRHmTsJoQkj/Brvw/fSRTlf/HxpwIH6udSsj2G8J+h0OcUj+/6J
 ey5aCZ6cxZZby2dQ3L5CzOf75ghWE92Lvl+5EbC5nnqQUMV4wElIxsQbd
 w9yfHSjRZQaOAvzi9ToI1v8r+lurocngsSitge0+0w8AKOkFqfk6oPoNZ
 QA+HtO5owVdybPoijnPq0VqYVuzy9cIsowHFNvl8PRu1MGEcl1EzAkcSD
 jfCN3zdtpqOlIkeE2BFK1Zg/2uqnGn42aQI0KWOq8TNMVgRzgXsqKvAYW
 JR9gulPjZ39Tbq3J1Wq9l7uKmLcaSEGCVX1pS4QfVwTpsgPz4KvRQGP0l Q==;
IronPort-SDR: cAcjCaoGORX/IfnO2ddD9Vu7laFMNrSrdMMn75fvjGKSKzdUS1KiOOmRS14KlPmXB+VvajzSEJ
 T8VnB8sCYOF8YkE2wyEAT5swH3pOm3LIiL/36LP7OgbAjL2kl5NknEsk1SkKi2d4sq+Z0575ti
 6H3Ri0rcMt4iuPNfCxd4nkqfH2qPraiA1RUywN5C7o9QG2gOER3vIOTJpQztSl2sD67DwHQkuQ
 375+5byM68iXUqQPrKQxb1UrJvZvUv/dYoD7i0jDsDOvEwXO42lspgJTmBVAthzW1g0aBIOTMS
 n0M=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117476287"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:22:29 +0800
IronPort-SDR: TXsoYe+uFfW/KFIM89ZwietGv8/YskN5bajiTQc/VQFp/3vESNzdoNgM9onz2aIx9vXL7ccDFu
 01c2vGMdHt1WMwkcAUecuTJ7O6Mz0WyFJ57j5ukYHGu2EtKKq1SBnpmpiLONIZ5AwpQoqsdYdl
 /UeT11CU44II2QnNOT7jR7DPJt07xI446lw0H9uYGGGrm7s+spsHhlQ9kSTFDl1AVdrC42t+Ir
 wal7BhbnYyWuAd+ZrxpfaQ3DKnKgYTt9PVUZw/9SWMqFXFlVh7FYFlReUSFaAjID31dn+EXtkT
 9opMy4xcxtFulgoNw1Ln/vf7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:19:45 -0700
IronPort-SDR: RJSTHSzxyfKQ4jM1KEj1qMEVhV+y46/yTfM3yDq0Y4oIhcyxpmySVxIlV/EPT/GrAesbFIWkVQ
 uWv2Rj9XlPA+KcW5XUQTOU/Tb6q3X663YxflvNSaXzOo/9IVpNnjd1nOr6YdAu6lq67CVXgQRq
 lyiUb8W+U5XnfT+ieetWFLEA7hzs3BmoHnFmaaUXozVlT3222HFU5O95PVrS8l5iU3mdGhbPGC
 Ek+tVezkYsrGQ+Y8kix1YfNVmubHkmf+1g8kvxekmpPZ4l23I6tEuZm99O9AhXW85vcIVOhROk
 zag=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 12:22:27 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:22:22 -0400
Message-Id: <20190823192226.21154-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v4 0/4] virtio/block: handle zoned backing
 devices
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping... Any objections to merging this patchset? Ask me if you are not
sure how to validate these patches without having the hardware :)


Currently, attaching zoned block devices (i.e., storage devices
compliant to ZAC/ZBC standards) using several virtio methods doesn't
work properly as zoned devices appear as regular block devices at the
guest. This may cause unexpected i/o errors and, potentially, some
data corruption.

To be more precise, attaching a zoned device via virtio-pci-blk,
virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
above behavior. The virtio-scsi-pci/scsi-block method works with a
recent patch. The virtio-scsi-pci/scsi-generic method also appears to
handle zoned devices without problems.

This patch set adds code to check if the backing device that is being
opened is a zoned Host Managed device. If this is the case, the patch
prohibits attaching such device for all use cases lacking proper
zoned support.

Host Aware zoned block devices are designed to work as regular block
devices at a guest system that does not support ZBD. Therefore, this
patch set doesn't prohibit attachment of Host Aware devices.

Considering that there is still a couple of different working ways
to attach a ZBD, this patch set provides a reasonable short-term
solution for this problem.

ZBD support for virtio-scsi-pci/scsi-disk and virtio-scsi-pci/scsi-hd
does not seem as necessary. Users will be expected to attach zoned
block devices via virtio-scsi-pci/scsi-block instead.

This patch set contains some Linux-specific code. This code is
necessary to obtain Zoned Block Device model value from Linux sysfs.

History:

v1 -> v2:
- rework code to be permission-based
- always allow Host Aware devices to be attached
- add fix for Host Aware attachments aka RCAP output snoop

v2 -> v3:
- drop the patch for RCAP output snoop - merged separately

v3 -> v4:
- rebase to the current code

Dmitry Fomichev (4):
  block: Add zoned device model property
  raw: Recognize zoned backing devices
  block/ide/scsi: Set BLK_PERM_SUPPORT_ZONED
  raw: Don't open ZBDs if backend can't handle them

 block.c                   | 19 +++++++++
 block/file-posix.c        | 88 +++++++++++++++++++++++++++++++++------
 block/raw-format.c        |  8 ++++
 hw/block/block.c          |  8 +++-
 hw/block/fdc.c            |  5 ++-
 hw/block/nvme.c           |  2 +-
 hw/block/virtio-blk.c     |  2 +-
 hw/block/xen-block.c      |  2 +-
 hw/ide/qdev.c             |  2 +-
 hw/scsi/scsi-disk.c       | 13 +++---
 hw/scsi/scsi-generic.c    |  2 +-
 hw/usb/dev-storage.c      |  2 +-
 include/block/block.h     | 21 +++++++++-
 include/block/block_int.h |  4 ++
 include/hw/block/block.h  |  3 +-
 15 files changed, 151 insertions(+), 30 deletions(-)

-- 
2.21.0


