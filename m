Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B5C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA6B20850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA6B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmbv-0008KB-P1
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbmRY-0001ZN-Iy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbmRV-0005jO-KH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:40:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbmRR-0005bk-49; Fri, 14 Jun 2019 09:40:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5837D3086202;
 Fri, 14 Jun 2019 13:40:23 +0000 (UTC)
Received: from localhost (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E43635D9D2;
 Fri, 14 Jun 2019 13:40:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 14 Jun 2019 15:40:01 +0200
Message-Id: <20190614134021.32486-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 14 Jun 2019 13:40:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/20] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5ec2eca83dc478ddf24077e02a8b34dd26cd3f=
f9:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201906=
13.0' into staging (2019-06-14 09:33:55 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-06-14

for you to fetch changes up to 21c1ce592a144188dfe59b9e156a97da412a59a2:

  iotests: Test qemu-img convert -C --salvage (2019-06-14 15:09:42 +0200)

----------------------------------------------------------------
Block patches:
- Allow blockdev-backup from nodes that are not in qemu's main AIO
  context to newly added nodes
- Add salvaging mode to qemu-img convert
- Minor fixes to tests, documentation, and for less Valgrind annoyance

----------------------------------------------------------------
Andrey Shinkevich (1):
  hw/block/fdc: floppy command FIFO memory initialization

John Snow (6):
  blockdev-backup: don't check aio_context too early
  iotests.py: do not use infinite waits
  QEMUMachine: add events_wait method
  iotests.py: rewrite run_job to be pickier
  iotests: add iotest 256 for testing blockdev-backup across iothread
    contexts
  event_match: always match on None value

Max Reitz (12):
  iotests: Filter 175's allocation information
  iotests: Fix intermittent failure in 219
  qemu-img: Fix options leakage in img_rebase()
  qapi/block-core: Overlays are not snapshots
  blockdev: Overlays are not snapshots
  qemu-img: Move quiet into ImgConvertState
  qemu-img: Add salvaging mode to convert
  blkdebug: Add @iotype error option
  blkdebug: Add "none" event
  blkdebug: Inject errors on .bdrv_co_block_status()
  iotests: Test qemu-img convert --salvage
  iotests: Test qemu-img convert -C --salvage

Vladimir Sementsov-Ogievskiy (1):
  iotests: restrict 254 to support only qcow2

 qapi/block-core.json          |  53 ++++++++---
 block/blkdebug.c              |  60 ++++++++++--
 blockdev.c                    |  14 +--
 hw/block/fdc.c                |   1 +
 qemu-img.c                    | 106 +++++++++++++++------
 python/qemu/__init__.py       |  67 ++++++++++----
 qemu-img-cmds.hx              |   4 +-
 qemu-img.texi                 |   4 +
 tests/qemu-iotests/082        |   1 +
 tests/qemu-iotests/082.out    |   3 +
 tests/qemu-iotests/085.out    |  10 +-
 tests/qemu-iotests/175        |  26 +++++-
 tests/qemu-iotests/175.out    |   8 +-
 tests/qemu-iotests/219        |  13 ++-
 tests/qemu-iotests/251        | 170 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/251.out    |  43 +++++++++
 tests/qemu-iotests/254        |   2 +
 tests/qemu-iotests/256        | 122 ++++++++++++++++++++++++
 tests/qemu-iotests/256.out    | 119 ++++++++++++++++++++++++
 tests/qemu-iotests/group      |   2 +
 tests/qemu-iotests/iotests.py |  60 +++++++-----
 21 files changed, 772 insertions(+), 116 deletions(-)
 create mode 100755 tests/qemu-iotests/251
 create mode 100644 tests/qemu-iotests/251.out
 create mode 100755 tests/qemu-iotests/256
 create mode 100644 tests/qemu-iotests/256.out

--=20
2.21.0


