Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EC8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D59B2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cu8H/PXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D59B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FbC-00034t-Ng
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ4-0000MM-DL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FZ2-0000Ys-V3
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:49:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1319249da=dmitry.fomichev@wdc.com>)
 id 1i1FYy-0000VF-IY; Fri, 23 Aug 2019 15:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566589772; x=1598125772;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zz1rRM120t/fH1+D/a7F3wpZaMtd6VHSaTkonjByP1s=;
 b=cu8H/PXCzWauOb0U0uBA8As25qAyONKKry7hcJyR1DS07uLyKYrIHFvA
 LhCaxydvWKRtO/ieY9cENmlNJYPfoIVOj1C44A9W5QyqPA5lRiseUUiwB
 jiDNUAcb+6t9lHjmEO0NdSpGkd4XeGgPNWabuEhstQL3myFq1etQWAW2x
 TL77TaUdQKtErFgn2rnVb84aDklRaCLylim4rrcNVXDuR9UpUrePm/SKd
 OTToRnjHvRGSMIILzaGmTLM8QOBiredpTVMXQXgdiUB8kd+VR1zKmI/r5
 3d5R2MIPcEZmjrXy1ybEEVCOPLDLthVfJe66mMtb+paT8tcGXHuoyZKNK w==;
IronPort-SDR: txq5UmU2FmIr+fa5Hx8x03sSs7dCsPgLBMyTUSwcrYFdq3/cD77+uu0j+kBd9JrrgjFYmQKsSA
 7Yl6+tkahQLxUkNx/uIT+P/SDDqooGyakCmCuKuofdtW12t/KiV6i66GKh5d/v0zKmM5e8bKBx
 A9ItPpvfsblkqZAdqHA+YGFh+upo3TdLmuqD5OJVlFBVFGDhAiOejrRrqswjaJKdiIXxcAV3me
 c/S42ahLb0xAt2YpPRfadaJroAcbWJIhQWiJkHMwjvQz/Njl/gEdExoQ6sj+ZQ+SgTs/jvjaUs
 n2g=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="223162540"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 03:49:29 +0800
IronPort-SDR: SRRPqeko/wJwMfpNMHElhGSvRIHCasC8goqnUWJc73rYDmjfi+yPR2+u+K5fATnV02diIJnyoe
 3Ah29w1byHqAi4wsISYiuteNtjNJj/rIzHO8H27WOFsgDLhBYgrdlT04beLTco3GHlXXwnBcxm
 49xLS3alzRlOaTtSPPtGw5SOBU9NSLJOq61msvQbEkLx/87cX4K9Szvixek1j9Rjd13r3xWF6g
 gCf23M0h7T1+xm+fOOxQMRcTNVJVimpP710Xx7ZZuqxfG1SC++pmLIpFCxUw3awrYBT5SGgyJX
 fKf/5LCLUhse70UZqoOjLCsY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 12:46:46 -0700
IronPort-SDR: PTLmiUHF8+qrsFJbOwjG7f7JwkbtKLGKzUaiyPIlSFPK+polXnjPEBSU+emqaXSZOS0VpBZ0FK
 RakxsxpyV2GUqUS2ccsxChycpvm+I+W7sBYu+cPlHJfJQhE8IrADxqx3xhSZ0UW78nzEC7tdeG
 h9X8sI9vTA6DpKawE5L4tTlmSgYeNWFc5xcHRbNpSvme668hEq3r8af3Y89VMLdY4LFdJrufyO
 /C4Xg0N4AvjaJ+gO9uk4KISD8wD7wHgnPyV/B/a9+Yp/JevPLJLDA4QYGi+LDi0knOtpXwQjrx
 KcM=
WDCIronportException: Internal
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 12:49:28 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Fri, 23 Aug 2019 15:49:23 -0400
Message-Id: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v5 0/4] virtio/block: handle zoned backing
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

v4 -> v5:
- avoid checkpatch warning

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


