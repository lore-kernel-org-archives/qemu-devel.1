Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF64C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F01E21926
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 22:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U5/SsNH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F01E21926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq38l-0008Ls-As
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 18:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38P-0007PN-IQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38O-0001Cn-8r
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 18:19:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=100e7d3fb=dmitry.fomichev@wdc.com>)
 id 1hq38N-0001AZ-KO; Tue, 23 Jul 2019 18:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563920388; x=1595456388;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+XAdquywPqf67bvtg6BKG4c1lJyMCOwj3hjtBjUHYdY=;
 b=U5/SsNH3c87bpuHdRRM1G0AvxJ5L7+PhdFK6m5w9z4h/samS0hjbnmmE
 Sgq6b6IiOfxtLnQBjmMG0fb37Agz1Y2Nsfs9P09OtxnZhdjt+xqIlNbSe
 zSCZZ3AFWbmI5JMdRh6QahCUojJP5A7QZ9fJijmDYG+zX848YzZ1SR2cl
 HnlHtMfiJmfmodxC7t/h3zhGsyghQ/0qqSqIk6CKGiMoSYPJk8YeguTRk
 ap/Jzg1TBxbZL/zMch4+ADB/QlMeX4BEDm43eC2Zzcjr+pkfwzxFK5XBg
 TyV5Uu8LD+DDusjaaNyL7Snw6/MVDO0thtcDjxHT6NnHW/4YEk6wbvFPb w==;
IronPort-SDR: q0WFCjWkTPwRhv4QLoDh+V9e0pEMzVGRj1p6Ec60LWztjimzQXIe6LKAY7PEuJUKon8i3WMJsZ
 Ep80xsTONkhW5uwo/BvkTEgcSmVLdbVD+Q+8ow2QzlbOF9M9CfdPtOEUzWblOWPUdGhsfMYTaF
 bK7YVk5XvbHHwJDWP5yaRFUuAsPDNMMtPJjG2z5yLHq5gI/Pm2GxzWm4iipTw1obh7EKlCwzuE
 PztlotpAHsReZOIxGdyki1j4cYtwhbSQkIRk7L033dU6cb0U326rzjnoSQ9PLfTahecsFN4OXw
 w3U=
X-IronPort-AV: E=Sophos;i="5.64,300,1559491200"; d="scan'208";a="113843254"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2019 06:19:42 +0800
IronPort-SDR: nHj/pmlB/B9Wz3f+rPzOb2iYOQsK0BVMHp3HIjpNF5GrYoLmjXo2vIcwZ80ODNoHGEswNjqa7v
 eqlGn4S6REYz29v3Yi4MhCM8YtXk+up5U+ghjGU093qiYuPPU30TMqZg7Qr+EPxmME5tx9qW7q
 VcWPn2bDI6iXmgF4VZN2YCCdcTiFDhyHdMAkoJFne1kxu4AHMZkJKv3xkAkACsWAxEF0yqneRF
 vYfBIY69Vq9pCYDSXuhqJXbUSd60jGQBXeIEFq/SGXqrOM9zrU17BDK6rM4R9KjMuB3wj0c7pG
 N3b9aMJCeCDP168phUh1Qy7j
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 23 Jul 2019 15:17:55 -0700
IronPort-SDR: 1Rdrf6b5yQMFAdJiAb+Df5SksF0I77Kvey1caWk9xxkNyrd66+KIEC2sAMMKEBLsjkvgthiVBY
 FUdkt+1LhFeeIMn04LZ/uV880YczN86JPW1RTUHTyVZFgbIHrBurG7pAW6gy0lOeIrxmmHwSai
 3axg2tEF2M0CR3B+0WrcRda2fZAQ8xuHFWJnHMcfdxcoaehT7797p8vDs/yMSZpAA5QuQ+3Owv
 qpDa67gGPqZHFWiXEGXM19GbTNUVHSvSZ4HM/nAbBIBQM1A5bOhG52E/GMTfAhZdbvJFjavgAh
 eVU=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2019 15:19:42 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 23 Jul 2019 18:19:36 -0400
Message-Id: <20190723221940.25585-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v3 0/4] virtio/block: handle zoned backing
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
solution for this problem. What about long term?

It appears to be beneficial to add proper ZBD support to virtio-blk.
In order to support this use case properly, some virtio-blk protocol
changes will be necessary. They are needed to allow the host code to
propagate some ZBD properties that are required for virtio guest
driver to configure the guest block device as ZBD, such as zoned
device model, zone size and the total number of zones. Further, some
support needs to be added for REPORT ZONES command as well as for zone
operations, such as OPEN ZONE, CLOSE ZONE, FINISH ZONE and RESET ZONE.

These additions to the protocol are relatively straightforward, but
they need to be approved by the virtio TC and the whole process may
take some time.

ZBD support for virtio-scsi-pci/scsi-disk and virtio-scsi-pci/scsi-hd
does not seem as necessary. Users will be expected to attach zoned
block devices via virtio-scsi-pci/scsi-block instead.

This patch set contains some Linux-specific code. This code is
necessary to obtain Zoned Block Device model value from Linux sysfs.

History:

v1 -> v2:
- rework the code to be permission-based
- always allow Host Aware devices to be attached
- add fix for Host Aware attachments aka RCAP output snoop

v2 -> v3:
- drop the patch for RCAP output snoop - merged separately


Dmitry Fomichev (4):
  block: Add zoned device model property
  raw: Recognize zoned backing devices
  block/ide/scsi: Set BLK_PERM_SUPPORT_ZONED
  raw: Don't open ZBDs if backend can't handle them

 block.c                   | 19 +++++++++
 block/file-posix.c        | 88 +++++++++++++++++++++++++++++++++------
 block/raw-format.c        |  8 ++++
 hw/block/block.c          |  8 +++-
 hw/block/fdc.c            |  4 +-
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
 15 files changed, 150 insertions(+), 30 deletions(-)

-- 
2.21.0


