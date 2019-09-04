Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCC9C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BEB20828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hq/ak5Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BEB20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dFJ-0006Qm-4f
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOy-0006Jg-Dq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOs-0007b7-SO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:01:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=143ed7f17=dmitry.fomichev@wdc.com>)
 id 1i5cOo-0007Va-IR; Wed, 04 Sep 2019 17:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567630867; x=1599166867;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=diSxR6wO4I35sBiUhc+r2rpM2rU2sFneSjA2GT8ajqM=;
 b=Hq/ak5Ure/Ss/96iSIG250B05M48hrhMKS+1foVVmB8R6cI/sus6kSjR
 sJoKUIxRWBd94CMBGsnadw3H+DcaoKILWPp65GINT2UY6RTvCoRg9bQlI
 L4rVp/1aQ3wGvOXoOsOtEkT0ptLXyZEuaya9+78R+ajz+rBRuT+mTnoHT
 4Eegk0A9WotQw4JKj3LK/Wp4jmP6ljveEzqjIGezu8zme+3o3c0haA8gE
 3RE6vQZ+S1yz/T3DwPd63L+IcJsGVqsaya9q4HW73uysHGtyLCWItTECB
 G5FcsY+wnS/cwWQxuggU0h7RcevYSJOMqwFCgKeTMaVnZI6gFqv3k7jgJ Q==;
IronPort-SDR: 4QOmrqreYICS80+PdvErkDzUrEqMNflDZiCKTEB07rWbvKpDKZmj6RBXe6x0KZvB0NmNrYRDeU
 N5/zbf2xIpPf/9g6InxXfH6WTBmsegdcpjcX1eVG3TonCRRtrr+0J9fsPDQABbj0T6Fhc1Vewa
 zixYsLLErvVlahXFzRm8zl3I545juR1mx5NdaP+3tvoxM/fJfzKUlbCTEeI6DXKyc9MhPEoFZi
 UCFNvc0a9OguJFweyiBdRRu8SnxFWF/VwUkd3gepWDh7a5pDugZnbRVQvD8dxeysw796i66cWX
 Ps0=
X-IronPort-AV: E=Sophos;i="5.64,468,1559491200"; d="scan'208";a="117451655"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2019 05:01:02 +0800
IronPort-SDR: hE4bh5bp7hdSqvVSYP73kI9DhYSwsY2hwQ5uyJQLj9yNc/B8/iUVr+vDYEWVGNX/y2+fchkrF3
 1H/Qj2V79CTK+qsEIPXG6FXUfwg9WmNBaIZKGKRjOsM3FLNOl60rB2W8yomzCCxXQvevfFxTyR
 N2NO0IZCLyJwDP2JGZU96lKMQOdkCdKf+/dXYn7vqiJgcdy27k2udNnaBFWxSQb6oCn5Zr8MCA
 ghVacR1ImvCCPkRdJ5nR7geCtKqqAvq39VpmR2wtVz+8lAMxfoDTThRxX2EKgw8aMnmKIuUNYd
 ODIy+uXkhduo2KkDxTd1r2Hc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 13:57:59 -0700
IronPort-SDR: HEz1r96eoRl2rUFbULH41UJRJf8AI8rXinNlMsdgv5HBK5E2HDB0Ww+OdNrqHc64IbG3WPsb+y
 kMOqIzWvHk4ZPYOb07jCbkawPUlTbkoHTWiuHiY0btHZuqVN/8J+rNpVxpzH032lbNwUy5P6un
 yTDmvBufv+u4pDKztfkaI6WSmGLaXb/rz8K4KAB1U53KMBfYk+ntsMfxP4pYKYu9cRDZmKL7ou
 bJwp+mZhAlAHzIBd5BwqScHmHRYT3My151N62bG8y+yx5HQzT3uJXXsoOPZ9IKRLAl9WQi9rNO
 WWU=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2019 14:01:00 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Wed,  4 Sep 2019 17:00:56 -0400
Message-Id: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v6 0/4] virtio/block: handle zoned backing
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

v5 -> v6:
- address review comments from Stefan Hajnoczi

Dmitry Fomichev (4):
  block: Add zoned device model property
  raw: Recognize zoned backing devices
  block/ide/scsi: Set BLK_PERM_SUPPORT_HM_ZONED
  raw: Don't open ZBDs if backend can't handle them

 block.c                   | 15 +++++++
 block/file-posix.c        | 89 +++++++++++++++++++++++++++++++++------
 block/io.c                |  5 +++
 hw/block/block.c          |  8 +++-
 hw/block/fdc.c            |  5 ++-
 hw/block/nvme.c           |  2 +-
 hw/block/virtio-blk.c     |  2 +-
 hw/block/xen-block.c      |  2 +-
 hw/ide/qdev.c             |  2 +-
 hw/scsi/scsi-disk.c       | 13 +++---
 hw/scsi/scsi-generic.c    |  2 +-
 hw/usb/dev-storage.c      |  2 +-
 include/block/block.h     | 19 ++++++++-
 include/block/block_int.h |  3 ++
 include/hw/block/block.h  |  3 +-
 15 files changed, 141 insertions(+), 31 deletions(-)

-- 
2.21.0


