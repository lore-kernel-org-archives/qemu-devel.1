Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8165C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A246720693
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 22:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QPS45eo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6jO8-0005w6-HY
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 18:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM7-00040K-Ai
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM6-0005dh-4a
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 18:38:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=146f6c1d5=dmitry.fomichev@wdc.com>)
 id 1i6jM3-0005a2-44; Sat, 07 Sep 2019 18:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567895931; x=1599431931;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RBp5lvceWxmPFvmaOsN/qZnbCkuCIBwD2Eko4j3dBRQ=;
 b=QPS45eo3yorJGKnlssIVLtYmgqHkn6kY+ID2LUVOA3W2eAkQEq0lPlpQ
 4HYUAdA/iAyIlK/oRbRizXvDcHHsfrnoxvAqPb/8aJytHmNK/F96czz73
 pUbijngtrj3M1H2eSZAfU6/zDZ2ntw9b+UuxlOuSPjqOkvV2MR/cWB7kk
 t4XgiCWPxWqe+eHRC4dJm7tjlIuOBEDtOA3kqVzlzV5UYAm7yUPR+HiAR
 lomY4TWS4nmuduDCQjD5ZDz6oRESKkMmvYuFxbHYkv33y2JHTmjTm6LGK
 +fyxBHyeGZdGKxH3y6fUodWkNCXf0AashRZNQBBp7PBcH2zXP1Yxhagp/ w==;
IronPort-SDR: Jf1KQOiRTgCmGZtdxrtrdunLjpjyLqWfNBMU9iEKtMKH0K4r6dvBv1B39L9+yz3sObDHXfFz5D
 nCboluZ3GH0EGT8fniNrGqh+gnqVBA3E4XFDTNLioxUV9Zar54sXW6gnsnWxRGYlp2QklXlYNm
 DiIQ8bKhuvgcUf3BQz7avdkxuCl6STtN+QqUETSoaToJSzr2Ra29mE539gzeAU6yx2vfeWxXUx
 BfLU1ChTrrdqotJVSRSCPBOkckOOYBMwNS5sAj9fDjpaIobuDnrV4WGfRIVrO7H5v0PAIywYbY
 EpY=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; d="scan'208";a="224505945"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 06:38:43 +0800
IronPort-SDR: AmqK6V/n8mHZRijEYAqV3fYVTU5TkSjP3UVSAR/5Bc8ijiNyl4Wb9lguD134Jf08obd2jr2o/N
 XPFDi/bk9p71Ij2VlxjPGez1jakFOGKEOG9MFGPOX300Ak1DQR+eiWlRzLnVpdBUo4W6nksUAE
 Wa5jI0JxJwFtk9Be+5sNWG9kZApADbYLRk2KKqXL3h8cID3oOQpdpDxbM2HxJTrCsSbc6LjckD
 FqrvY+4JxL9akVdJPl9V+3lkxKrGKR9S/wTq2o4DqxKX1aIMpg1Q5xzJjoQk+3BnB+kIgGVim1
 rE0PR0IIvZExMtnaBFi6LSho
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2019 15:35:32 -0700
IronPort-SDR: r30MxoIQpPAfAqTxEPqQk9eiOAgb40b/viDMJxEA4jAgUZZlcVcoiXBU8UZppcshRFMEtS+ooW
 3IgfTtyN9NAKi+oLVaDz4WHkh0wetfqy3nubZtBbLcdHc8Zs95QQmiKF/8adHju+jau0iz/26D
 39quftmH4PajOmqLEhKSK7fJtMrUVx1jWpq8/EZcrpMHMUIEnjsJj4MvsDWyQH23ENvVF6F9eX
 ys/KulxpDLGuR0QOZjztOeYFsPErSFN19LRpy3BKIzdxTRi8O1Jjw0ubNpwEr5RZuu3+7wZ97n
 0fI=
WDCIronportException: Internal
Received: from dhcp-10-88-173-181.hgst.com ([10.88.173.181])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2019 15:38:42 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Date: Sat,  7 Sep 2019 18:38:37 -0400
Message-Id: <20190907223841.20210-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v7 0/4] virtio/block: handle zoned backing
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

v6 -> v7:
- address review comment from Stefano Garzarella
  * fix BLK_PERM_ALL mask
  * add BLK_PERM_SUPPORT_HM_ZONED permission to QAPI schema
  * add a text name for BLK_PERM_SUPPORT_HM_ZONED permission

Dmitry Fomichev (4):
  block: Add zoned device model property
  raw: Recognize zoned backing devices
  block/ide/scsi: Set BLK_PERM_SUPPORT_HM_ZONED
  raw: Don't open ZBDs if backend can't handle them

 block.c                   | 37 +++++++++++-----
 block/file-posix.c        | 89 +++++++++++++++++++++++++++++++++------
 block/io.c                |  5 +++
 hw/block/block.c          |  6 ++-
 hw/block/fdc.c            |  5 ++-
 hw/block/nvme.c           |  2 +-
 hw/block/virtio-blk.c     |  2 +-
 hw/block/xen-block.c      |  2 +-
 hw/ide/qdev.c             |  2 +-
 hw/scsi/scsi-disk.c       | 13 +++---
 hw/scsi/scsi-generic.c    |  2 +-
 hw/usb/dev-storage.c      |  2 +-
 include/block/block.h     | 21 ++++++++-
 include/block/block_int.h |  3 ++
 include/hw/block/block.h  |  3 +-
 qapi/block-core.json      |  5 ++-
 16 files changed, 157 insertions(+), 42 deletions(-)

-- 
2.21.0


