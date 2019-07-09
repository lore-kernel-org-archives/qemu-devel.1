Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4CC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48142073D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 20:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rhhp2k+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48142073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkwvN-0007Pb-FO
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 16:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsx-0005oU-AG
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwsv-0000r0-5M
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 16:38:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=086c9c2ca=dmitry.fomichev@wdc.com>)
 id 1hkwso-0000VW-J6; Tue, 09 Jul 2019 16:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562704725; x=1594240725;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2cHvew4j0kTTwMBw/J8yB3CzzPWRi34LzSyhNAsUwLc=;
 b=rhhp2k+gQjptpeUIG8pcA9xs2Y1NSydSdkctUdnK0+uokfbnz0VsqxFx
 kchZLC2w9wXUado8U0o0fsNBe/44h0OnsQ+E3wx7QiMw3rQ0mHzhspZI+
 wTDOKwiEhUkiZNEAPaGM+3FQEUrRMu+xijQVNozKdVP/MAazfM/74NMhp
 YEkFjYF1shSYTfkn6UVGiH2Xt8hvHAIpnO4uRs2hHnBKjHUda2YNM5bt8
 3jpzVM4P66nhyPBPpc7XdXOrYTukP6CYH8KSRaWW21fCJxDKLuUf7bXMR
 c/kDfBmckEPQI2wY2tL1e+hlVaEnJXt+z2e7mW69XnE2k2lR6HS1VGBv9 g==;
IronPort-SDR: 2YMZgvMMb5udoI5R6t7TA4KR9jWwmNi12tn+RFTujp5hffhUKhNx3DRiDZtVh6Vp3FHhJUfHJX
 CZYRRVlyvNNmGJ2mm35icKhe9E+6mac4RMzGWUaqR4p31Um12t9Bd9qPHMuG01zmMOtYTNxqZh
 sepz6CFq+RXvJpleRapDFizY3fFN3ySkGp7xufazXyrPIUCjcIEGUyQqmjwpXVqyZFOmy0hI1+
 eewJ1aRgH47Y0m6sLf9DkVey4oN8kp9PwEpIpBWblmjlcdl3mdjFnVLLNVdkksqj9qMzTcnnO0
 JXo=
X-IronPort-AV: E=Sophos;i="5.63,471,1557158400"; d="scan'208";a="212488447"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 04:38:42 +0800
IronPort-SDR: A3BTeqfWSRPy8QwXJiIUM/9cMLxbs97INgRS12iimzJfBdP78qDV0ZEZpYNfQsGnZNxh+EBhks
 qO5syFIC2Alm29rPhcGh4/VPI3Ju2si1gKidePFQITa+8wgPK63JmNWKotIewWG2wFL2iJZhnQ
 BNMotDE+kM0KqA0NiJ95/reXcukgP2XYOk5tZ8HorDjy0VzFiZ/RpArL003NIgVT6Zx2I5tmeX
 tEmhn5DAHe8yrxyq6TKC5KptRRMNdK1BV3dcxh9imM621bjqP4ABNbzqLY/p+vlFXPX0a+e4EL
 C13Ns3/T95/IgUyL64NYJcMJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 13:37:23 -0700
IronPort-SDR: g3ggYWh8rJQfMZy0OO4SmoUgp9Nri9MjZy51HUHDvUTmq/YE2Oooms5LScSCZtEHgPzgABY3Dt
 i/cguienSgIFQl5bLspVPFG5uyw7hX35RnJ/MJQgu7HQaHcYs4bue2ClAo8V/YWgJiVkEDYj/D
 DOx0qebhP9eHPbMSgPD9pNZid8+kjVtiWgdWmrKzCwlzqc8OXl/lMfxawsx8lpK8kQWV7ernSF
 t1LHkplDtqs+6QVflSTDfiyEG76jo6RjZByIu05Fwb4/5v6/7tXyl+BkjO1e59XZ2r/QvEOdQp
 Bh8=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 13:38:36 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: kwolf@redhat.com, mreitz@redhat.com, mst@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 16:38:02 -0400
Message-Id: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH 0/4] virtio: handle zoned backing devices
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, attaching zoned block devices (i.e. storage devices
compliant to ZAC/ZBC standards) using several virtio methods doesn't
work - the zoned devices appear as regular block devices at the guest.
This may cause unexpected i/o errors and, potentially, some data
corruption.

To be more precise, attaching a zoned device via virtio-pci-blk,
virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
above behavior. A simple fix is needed to make
virtio-scsi-pci/scsi-block work and this is covered by a different
patch. The virtio-scsi-pci/scsi-generic method appears to handle zoned
devices without problems.

This patchset adds code to check if the backing device that is being
opened is zoned. If this is the case, the new code prohibits
virtualization of the device for all use cases lacking proper zoned
support.

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
Dmitry Fomichev (3):
  block: Add zoned device model property
  raw: Recognize zoned backing devices
  virtio-blk: Don't realize zoned block devices

Shin'ichiro Kawasaki (1):
  hw/scsi: Don't realize zoned block devices for virtio-scsi legacy
    drivers

 block.c                        | 14 +++++++
 block/block-backend.c          | 20 ++++++++++
 block/file-posix.c             | 69 ++++++++++++++++++++++++++++------
 block/raw-format.c             |  8 ++++
 hw/block/virtio-blk.c          |  5 +++
 hw/scsi/scsi-disk.c            |  5 +++
 include/block/block.h          |  9 +++++
 include/block/block_int.h      |  4 ++
 include/sysemu/block-backend.h |  2 +
 9 files changed, 125 insertions(+), 11 deletions(-)

-- 
2.21.0


