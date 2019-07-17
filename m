Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95900C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6427D205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dKlF4dhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6427D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60589 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrTB-0002Wi-FP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSB-0006ox-3S
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS9-0006zH-MA
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS9-0006xL-D4; Wed, 17 Jul 2019 17:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563398829; x=1594934829;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=h9+Bzc7byhQZccPGwh+WXfctMpkyb+r6mhOQEYlQ66M=;
 b=dKlF4dhZihtTpUnyglaRFh73/fXgCOnx8XpcUUJIkX+eN7SnRSU+uHCZ
 Ot5Xkguv/wW0qkSsz3stWLH7BWm4iiL86OLMRtn4oPt2dwN2UqcJbdixS
 +PypZA1obD/S74i5V9H5hnUYARLIv2ApihZYUu48FRWmz4hE96cIdiBJt
 Y1tA6ZuX1ZHwOjWav8EoBYnHO+d43O6V0RxN4wUGXv2mbJt0FivURygqL
 uDS2EyiDrLkuwBngMQfkOL5Y2+Nw+4Pz4bkOV9i41uCJVbcjg3HLm0ADC
 HBRFt3OdBf0SX/1P+2zEv2Ni2Aets7VYY1wL0iKR7ipCQsgRQqJIIpjbL A==;
IronPort-SDR: W4DxUTaesUKnMPql3TqTqe5FP5RmpiqqnH+XyX10R33h8EX8CDCOuYGvRkeVKD5NRMmA1AWdYf
 EX3u4BPht5G2eTymUaM0YifaKKOAmx+29YhnZ3/XStPw/TxW9/t5okUNSEUfz+rW5H7T/LLKfG
 NMvZOXopm7I5KesGZK86oe6ztdX1kobAYzs09FqIMiXIisSpOXzAnt80jV3XgO0M/jmqxNdDUB
 vwBZkrFw2xBUh1AwJeGQXbt64ey7R4phQrorGAh/w977A1RoLrJ0Kc9t9BD/WQ6Lu3Us+UrAzg
 eAw=
X-IronPort-AV: E=Sophos;i="5.64,275,1559491200"; d="scan'208";a="113319438"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 05:27:04 +0800
IronPort-SDR: vjBT0rwWyxeWDTpsY5X+h30Y6U+2QgojZWfCdircZTWPKMm97NXGS7Cl4guC0I+iqWr+n9RS/X
 HHZ/bA0AWS5vkwQqn5ymnhEmBsgJ2hnqgndVmlQwmw/xhpILh3OTa3Bh/RzO4xdwlZ+qPKjbiZ
 jbwf1bhS9EQ9E+9iokUMgOndukC3IKz2qEiQ1NH7c2B/wsqMhlaalUoZHhzYfTcW38qQ/EUKxF
 IVRBDwFGG94lDBv8lHrriD4C8C/ThhMwPTqjdcLC9P6asJ6sj3ERFf75G1E8sbWDiYJ92Fj/oy
 gMgm/bjStz9lXgBqBh6zdSr8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jul 2019 14:25:32 -0700
IronPort-SDR: jyS5sLaIH/7x4kWqMJ8a3R7vLDUTq0rYc2CUAEfMZI1WG6jhU6CK5Uyo/LC8jj/V7HyZo0anaV
 C2WvjtEtaGoxvf+POydJNle2V705BBytITnXdxckmZ08kYT76Gq0A03RI9bIP/r5GtkisSpxnc
 EO4jr6RsJ9JB4LZs75DEIyI5bZcgF3PGm+jPZVWs4/1MXMRoPNQ2fHdivaY61uYhwK8LXNrXIc
 yBKlGQ5YbTqDYEtmfRbct1f88MW/z3s6RFc9oSExjeNsKezgP1FEPUXbVEGQI+p9jjvfLUfR/P
 1iA=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jul 2019 14:27:04 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Jul 2019 17:26:58 -0400
Message-Id: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 0/5] virtio/block: handle zoned backing
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

Currently, attaching zoned block devices (i.e. storage devices
compliant to ZAC/ZBC standards) using several virtio methods doesn't
work properly as zoned devices appear as regular block devices at the
guest. This may cause unexpected i/o errors and, potentially, some
data corruption.

To be more precise, attaching a zoned device via virtio-pci-blk,
virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
above behavior. The virtio-scsi-pci/scsi-block method works with a
recent patch. The virtio-scsi-pci/scsi-generic method also appears to
handle zoned devices without problems.

This patchset adds code to check if the backing device that is being
opened is a zoned Host Managed device. If this is the case, the patch
prohibits virtualization of the device for all use cases lacking proper
zoned support.

Host Aware zoned block devices are designed to work as regular block
devices at a guest system that does not support ZBD. Therefeore, this
patchset doesn't prohibit attachment of Host Aware devices.

Host Aware attachments were tested using file_zbc handler of
tcmu-runner daemon. Running QEMU against zoned devices provisioned by
tcmu-runner emulator exposed another problem - upon startup, QEMU
would exit via divide by zero exception in scsi_disk_reset(). The
reason for this is that tcmu-runner zoned devices don't support
READ CAPACITY(10). This is by design, since only READ CAPACITY(16)
support is mandatory for ZBDs and READ CAPACITY(10) is optional.
The last commit of this series fixes this problem.

Considering that there is still a couple of different working ways
to virtualize a ZBD, this patchset provides a reasonable short-term
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

This patchset contains some Linux-specific code. This code is
necessary to obtain Zoned Block Device model value from Linux sysfs.

Dmitry Fomichev (4):
  block: Add zoned device model property
  raw: Recognize zoned backing devices
  block/ide/scsi: Set BLK_PERM_SUPPORT_ZONED
  raw: Don't open ZBDs if backend can't handle them

Shin'ichiro Kawasaki (1):
  hw/scsi: Check sense key before READ CAPACITY output snoop

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
 hw/scsi/scsi-generic.c    | 33 +++++++++------
 hw/usb/dev-storage.c      |  2 +-
 include/block/block.h     | 21 +++++++++-
 include/block/block_int.h |  4 ++
 include/hw/block/block.h  |  3 +-
 15 files changed, 169 insertions(+), 42 deletions(-)

-- 
2.21.0


