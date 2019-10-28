Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3988ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CAE2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn226B3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CAE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3yz-0004lq-PI
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vS-000165-LG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vQ-00014w-OD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vQ-00014W-KQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qvUySwJYAqNJKc5UCCIjN36Q5T2HcnqjJmzBIifhFwc=;
 b=bn226B3nTznT9v2bsm4xAwNIXd6iGyXIiGvUnwDw9MRty1mEjQz3He+DZInghAwZUG99hs
 rJfvgojh/khtqs96JeB5U8HKePJKopLNZ5drdX85vy01IWyzKnpdyg3+y5Y7neCD6Qx2CL
 KH2JmDp2BlQ3GU0xT5U0uIl5IUcSNEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Acs_ib7IN2aepFxK5az63A-1; Mon, 28 Oct 2019 08:15:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD5B310052E0;
 Mon, 28 Oct 2019 12:15:03 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AE9060BF7;
 Mon, 28 Oct 2019 12:15:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/69] Block patches for softfreeze
Date: Mon, 28 Oct 2019 13:13:52 +0100
Message-Id: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Acs_ib7IN2aepFxK5az63A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-2510=
19-3' into staging (2019-10-26 10:13:48 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-10-28

for you to fetch changes up to ba9c45139e2938b8d20ce407db83a31bc9e5066c:

  qemu-iotests: restrict 264 to qcow2 only (2019-10-28 13:09:43 +0100)

----------------------------------------------------------------
Block patches for softfreeze:
- iotest patches
- Improve performance of the mirror block job in write-blocking mode
- Limit memory usage for the backup block job
- Add discard and write-zeroes support to the NVMe host block driver
- Fix a bug in the mirror job
- Prevent the qcow2 driver from creating technically non-compliant qcow2
  v3 images (where there is not enough extra data for snapshot table
  entries)
- Allow callers of bdrv_truncate() (etc.) to determine whether the file
  must be resized to the exact given size or whether it is OK for block
  devices not to shrink

----------------------------------------------------------------
Max Reitz (55):
  iotests: Prefer null-co over null-aio
  iotests: Allow skipping test cases
  iotests: Use case_skip() in skip_if_unsupported()
  iotests: Let skip_if_unsupported accept a function
  iotests: Test driver whitelisting in 093
  iotests: Test driver whitelisting in 136
  iotests: Cache supported_formats()
  iotests: Introduce $SOCK_DIR
  iotests.py: Store socket files in $SOCK_DIR
  iotests.py: Add @base_dir to FilePaths etc.
  iotests: Filter $SOCK_DIR
  iotests: Let common.nbd create socket in $SOCK_DIR
  iotests/083: Create socket in $SOCK_DIR
  iotests/140: Create socket in $SOCK_DIR
  iotests/143: Create socket in $SOCK_DIR
  iotests/147: Create socket in $SOCK_DIR
  iotests/181: Create socket in $SOCK_DIR
  iotests/182: Create socket in $SOCK_DIR
  iotests/183: Create socket in $SOCK_DIR
  iotests/192: Create socket in $SOCK_DIR
  iotests/194: Create sockets in $SOCK_DIR
  iotests/201: Create socket in $SOCK_DIR
  iotests/205: Create socket in $SOCK_DIR
  iotests/208: Create socket in $SOCK_DIR
  iotests/209: Create socket in $SOCK_DIR
  iotests/222: Create socket in $SOCK_DIR
  iotests/223: Create socket in $SOCK_DIR
  iotests/240: Create socket in $SOCK_DIR
  iotests/267: Create socket in $SOCK_DIR
  iotests: Drop TEST_DIR filter from _filter_nbd
  mirror: Do not dereference invalid pointers
  include: Move endof() up from hw/virtio/virtio.h
  qcow2: Use endof()
  qcow2: Add Error ** to qcow2_read_snapshots()
  qcow2: Keep unknown extra snapshot data
  qcow2: Make qcow2_write_snapshots() public
  qcow2: Put qcow2_upgrade() into its own function
  qcow2: Write v3-compliant snapshot list on upgrade
  qcow2: Separate qcow2_check_read_snapshot_table()
  qcow2: Add qcow2_check_fix_snapshot_table()
  qcow2: Fix broken snapshot table entries
  qcow2: Keep track of the snapshot table length
  qcow2: Fix overly long snapshot tables
  qcow2: Repair snapshot table with too many entries
  qcow2: Fix v3 snapshot table entry compliancy
  iotests: Add peek_file* functions
  iotests: Test qcow2's snapshot table handling
  block: Handle filter truncation like native impl.
  block/cor: Drop cor_co_truncate()
  block: Do not truncate file node when formatting
  block: Add @exact parameter to bdrv_co_truncate()
  block: Evaluate @exact in protocol drivers
  block: Let format drivers pass @exact
  block: Pass truncate exact=3Dtrue where reasonable
  Revert "qemu-img: Check post-truncation size"

Maxim Levitsky (2):
  block/nvme: add support for write zeros
  block/nvme: add support for discard

Vladimir Sementsov-Ogievskiy (12):
  hbitmap: handle set/reset with zero length
  block/mirror: simplify do_sync_target_write
  block/block-backend: add blk_co_pwritev_part
  block/mirror: support unaligned write in active mirror
  Revert "mirror: Only mirror granularity-aligned chunks"
  block/block-copy: allocate buffer in block_copy_with_bounce_buffer
  block/block-copy: limit copy_range_size to 16 MiB
  block/block-copy: refactor copying
  util: introduce SharedResource
  block/block-copy: add memory limit
  block/block-copy: increase buffered copy request
  qemu-iotests: restrict 264 to qcow2 only

 util/Makefile.objs                |   1 +
 block/qcow2.h                     |  17 +-
 include/block/block-copy.h        |   5 +-
 include/block/block.h             |   6 +-
 include/block/block_int.h         |  17 +-
 include/block/nvme.h              |  19 +-
 include/hw/virtio/virtio.h        |   7 -
 include/qemu/co-shared-resource.h |  71 ++++
 include/qemu/compiler.h           |   7 +
 include/sysemu/block-backend.h    |   8 +-
 block/block-backend.c             |  23 +-
 block/block-copy.c                | 182 ++++++-----
 block/commit.c                    |   5 +-
 block/copy-on-read.c              |   8 -
 block/crypto.c                    |   8 +-
 block/file-posix.c                |  11 +-
 block/file-win32.c                |   3 +-
 block/gluster.c                   |   1 +
 block/io.c                        |  29 +-
 block/iscsi.c                     |  10 +-
 block/mirror.c                    | 198 +++++------
 block/nfs.c                       |   2 +-
 block/nvme.c                      | 155 ++++++++-
 block/parallels.c                 |  18 +-
 block/qcow.c                      |   9 +-
 block/qcow2-refcount.c            |   2 +-
 block/qcow2-snapshot.c            | 323 +++++++++++++++++-
 block/qcow2.c                     | 200 +++++++++---
 block/qed.c                       |   8 +-
 block/raw-format.c                |   5 +-
 block/rbd.c                       |   1 +
 block/sheepdog.c                  |   5 +-
 block/ssh.c                       |   3 +-
 block/vdi.c                       |   2 +-
 block/vhdx-log.c                  |   4 +-
 block/vhdx.c                      |   7 +-
 block/vmdk.c                      |   8 +-
 block/vpc.c                       |   2 +-
 blockdev.c                        |   2 +-
 hw/block/virtio-blk.c             |   4 +-
 hw/net/virtio-net.c               |  10 +-
 qemu-img.c                        |  46 +--
 qemu-io-cmds.c                    |   7 +-
 tests/test-block-iothread.c       |   8 +-
 util/hbitmap.c                    |   8 +
 util/qemu-co-shared-resource.c    |  76 +++++
 block/trace-events                |   9 +-
 python/qemu/machine.py            |  15 +-
 python/qemu/qtest.py              |   9 +-
 tests/qemu-iotests/083            |   6 +-
 tests/qemu-iotests/083.out        |  34 +-
 tests/qemu-iotests/093            |  19 +-
 tests/qemu-iotests/136            |  14 +-
 tests/qemu-iotests/140            |   8 +-
 tests/qemu-iotests/140.out        |   2 +-
 tests/qemu-iotests/143            |   6 +-
 tests/qemu-iotests/143.out        |   2 +-
 tests/qemu-iotests/147            |   2 +-
 tests/qemu-iotests/181            |   2 +-
 tests/qemu-iotests/182            |   4 +-
 tests/qemu-iotests/183            |   2 +-
 tests/qemu-iotests/192            |   4 +-
 tests/qemu-iotests/192.out        |   2 +-
 tests/qemu-iotests/194            |   4 +-
 tests/qemu-iotests/201            |   2 +-
 tests/qemu-iotests/205            |   2 +-
 tests/qemu-iotests/208            |   2 +-
 tests/qemu-iotests/209            |   3 +-
 tests/qemu-iotests/222            |   2 +-
 tests/qemu-iotests/223            |  14 +-
 tests/qemu-iotests/240            |   4 +-
 tests/qemu-iotests/241            |   2 -
 tests/qemu-iotests/245            |   2 +-
 tests/qemu-iotests/261            | 523 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/261.out        | 346 ++++++++++++++++++++
 tests/qemu-iotests/264            |   2 +
 tests/qemu-iotests/267            |   4 +-
 tests/qemu-iotests/267.out        |   2 +-
 tests/qemu-iotests/check          |  15 +-
 tests/qemu-iotests/common.filter  |   7 +-
 tests/qemu-iotests/common.nbd     |   2 +-
 tests/qemu-iotests/common.rc      |  20 ++
 tests/qemu-iotests/group          |   1 +
 tests/qemu-iotests/iotests.py     |  68 ++--
 84 files changed, 2232 insertions(+), 486 deletions(-)
 create mode 100644 include/qemu/co-shared-resource.h
 create mode 100644 util/qemu-co-shared-resource.c
 create mode 100755 tests/qemu-iotests/261
 create mode 100644 tests/qemu-iotests/261.out

--=20
2.21.0


