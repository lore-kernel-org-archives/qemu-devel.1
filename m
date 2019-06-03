Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FBDC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D0D25ABF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D0D25ABF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoWU-0001Py-Tl
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:05:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUG-0000AV-Ii
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUE-00067T-Lv
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoU9-0005x8-TH; Mon, 03 Jun 2019 11:02:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34C64300144D;
	Mon,  3 Jun 2019 15:02:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 487AA6726F;
	Mon,  3 Jun 2019 15:02:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:05 +0200
Message-Id: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 03 Jun 2019 15:02:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/28] Block layer patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ad88e4252f09c2956b99c90de39e95bab2e8e7=
af:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-1-2=
019' into staging (2019-06-03 10:25:12 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 9593db8ccd27800ce4a17f1d5b735b9130c541a2:

  iotests: Fix duplicated diff output on failure (2019-06-03 16:33:20 +02=
00)

----------------------------------------------------------------
Block layer patches:

- block: AioContext management, part 2
- Avoid recursive block_status call (i.e. lseek() calls) if possible
- linux-aio: Drop unused BlockAIOCB submission method
- nvme: add Get/Set Feature Timestamp support
- Fix crash on commit job start with active I/O on base node
- Fix crash in bdrv_drained_end
- Fix integer overflow in qcow2 discard

----------------------------------------------------------------
John Snow (1):
      blockdev: fix missed target unref for drive-backup

Julia Suvorova (1):
      block/linux-aio: Drop unused BlockAIOCB submission method

Kenneth Heitke (1):
      nvme: add Get/Set Feature Timestamp support

Kevin Wolf (19):
      block: Drain source node in bdrv_replace_node()
      iotests: Test commit job start with concurrent I/O
      test-block-iothread: Check filter node in test_propagate_mirror
      nbd-server: Call blk_set_allow_aio_context_change()
      block: Add Error to blk_set_aio_context()
      block: Add BlockBackend.ctx
      block: Add qdev_prop_drive_iothread property type
      scsi-disk: Use qdev_prop_drive_iothread
      block: Adjust AioContexts when attaching nodes
      test-block-iothread: Test adding parent to iothread node
      test-block-iothread: BlockBackend AioContext across root node chang=
e
      block: Move node without parents to main AioContext
      blockdev: Use bdrv_try_set_aio_context() for monitor commands
      block: Remove wrong bdrv_set_aio_context() calls
      virtio-scsi-test: Test attaching new overlay with iothreads
      iotests: Attach new devices to node in non-default iothread
      test-bdrv-drain: Use bdrv_try_set_aio_context()
      block: Remove bdrv_set_aio_context()
      iotests: Fix duplicated diff output on failure

Max Reitz (2):
      block/io: Delay decrementing the quiesce_counter
      iotests: Test cancelling a job and closing the VM

Vladimir Sementsov-Ogievskiy (4):
      tests/perf: Test lseek influence on qcow2 block-status
      block: avoid recursive block_status call if possible
      block/qcow2-refcount: add trace-point to qcow2_process_discards
      block/io: bdrv_pdiscard: support int64_t bytes parameter

 docs/devel/multiple-iothreads.txt          |   4 +-
 block/qcow2.h                              |   4 +
 hw/block/nvme.h                            |   2 +
 include/block/block.h                      |  21 ++---
 include/block/block_int.h                  |   1 +
 include/block/nvme.h                       |   2 +
 include/block/raw-aio.h                    |   3 -
 include/hw/block/block.h                   |   7 +-
 include/hw/qdev-properties.h               |   3 +
 include/hw/scsi/scsi.h                     |   1 +
 include/sysemu/block-backend.h             |   5 +-
 tests/libqtest.h                           |  11 +++
 block.c                                    |  79 ++++++++++++-----
 block/backup.c                             |   3 +-
 block/block-backend.c                      |  47 ++++++----
 block/commit.c                             |  13 +--
 block/crypto.c                             |   3 +-
 block/io.c                                 |  28 +++---
 block/linux-aio.c                          |  72 +++------------
 block/mirror.c                             |   4 +-
 block/parallels.c                          |   3 +-
 block/qcow.c                               |   3 +-
 block/qcow2-refcount.c                     |  39 ++++++++-
 block/qcow2.c                              |  17 +++-
 block/qed.c                                |   3 +-
 block/sheepdog.c                           |   3 +-
 block/vdi.c                                |   3 +-
 block/vhdx.c                               |   3 +-
 block/vmdk.c                               |   3 +-
 block/vpc.c                                |   3 +-
 blockdev.c                                 |  61 +++++++------
 blockjob.c                                 |  12 ++-
 hmp.c                                      |   3 +-
 hw/block/dataplane/virtio-blk.c            |  12 ++-
 hw/block/dataplane/xen-block.c             |   6 +-
 hw/block/fdc.c                             |   2 +-
 hw/block/nvme.c                            | 106 +++++++++++++++++++++-
 hw/block/xen-block.c                       |   2 +-
 hw/core/qdev-properties-system.c           |  41 ++++++++-
 hw/ide/qdev.c                              |   2 +-
 hw/scsi/scsi-disk.c                        |  24 +++--
 hw/scsi/virtio-scsi.c                      |  25 +++---
 migration/block.c                          |   3 +-
 nbd/server.c                               |   6 +-
 qemu-img.c                                 |   6 +-
 tests/libqtest.c                           |  19 ++++
 tests/test-bdrv-drain.c                    |  50 ++++++-----
 tests/test-bdrv-graph-mod.c                |   5 +-
 tests/test-block-backend.c                 |   6 +-
 tests/test-block-iothread.c                | 104 ++++++++++++++++++----
 tests/test-blockjob.c                      |   2 +-
 tests/test-throttle.c                      |   6 +-
 tests/virtio-scsi-test.c                   |  62 +++++++++++++
 block/trace-events                         |   3 +
 hw/block/trace-events                      |   2 +
 tests/perf/block/qcow2/convert-blockstatus |  71 +++++++++++++++
 tests/qemu-iotests/051                     |  24 +++++
 tests/qemu-iotests/051.out                 |   3 +
 tests/qemu-iotests/051.pc.out              |  27 ++++++
 tests/qemu-iotests/102                     |   2 +-
 tests/qemu-iotests/102.out                 |   3 +-
 tests/qemu-iotests/141.out                 |   2 +-
 tests/qemu-iotests/144.out                 |   2 +-
 tests/qemu-iotests/240                     |  21 +++++
 tests/qemu-iotests/240.out                 |  15 +++-
 tests/qemu-iotests/255                     | 135 +++++++++++++++++++++++=
++++++
 tests/qemu-iotests/255.out                 |  40 +++++++++
 tests/qemu-iotests/check                   |   1 -
 tests/qemu-iotests/group                   |   1 +
 tests/qemu-iotests/iotests.py              |  10 ++-
 70 files changed, 1048 insertions(+), 272 deletions(-)
 create mode 100755 tests/perf/block/qcow2/convert-blockstatus
 create mode 100755 tests/qemu-iotests/255
 create mode 100644 tests/qemu-iotests/255.out

