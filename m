Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA6C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACF420873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACF420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2qv-0004qk-CH
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK2p9-0002mR-H1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK2p8-0006Nt-8Z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK2p4-0006Hc-CV; Mon, 14 Oct 2019 12:03:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9E3118CB8FB;
 Mon, 14 Oct 2019 16:03:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2F285C1D4;
 Mon, 14 Oct 2019 16:03:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/15] Block layer patches
Date: Mon, 14 Oct 2019 18:03:34 +0200
Message-Id: <20191014160343.8211-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 14 Oct 2019 16:03:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 22dbfdecc3c52228d3489da3fe81da92b21197=
bf:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-2019101=
0.0' into staging (2019-10-14 15:09:08 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to a1406a9262a087d9ec9627b88da13c4590b61dae:

  iotests: Test large write request to qcow2 file (2019-10-14 17:12:48 +0=
200)

----------------------------------------------------------------
Block layer patches:

- block: Fix crash with qcow2 partial cluster COW with small cluster
  sizes (misaligned write requests with BDRV_REQ_NO_FALLBACK)
- qcow2: Fix integer overflow potentially causing corruption with huge
  requests
- vhdx: Detect truncated image files
- tools: Support help options for --object
- Various block-related replay improvements
- iotests/028: Fix for long $TEST_DIRs

----------------------------------------------------------------
Alberto Garcia (1):
      block: Reject misaligned write requests with BDRV_REQ_NO_FALLBACK

Kevin Wolf (4):
      vl: Split off user_creatable_print_help()
      qemu-io: Support help options for --object
      qemu-img: Support help options for --object
      qemu-nbd: Support help options for --object

Max Reitz (3):
      iotests/028: Fix for long $TEST_DIRs
      qcow2: Limit total allocation range to INT_MAX
      iotests: Test large write request to qcow2 file

Pavel Dovgaluk (6):
      block: implement bdrv_snapshot_goto for blkreplay
      replay: disable default snapshot for record/replay
      replay: update docs for record/replay with block devices
      replay: don't drain/flush bdrv queue while RR is working
      replay: finish record/replay before closing the disks
      replay: add BH oneshot event for block layer

Peter Lieven (1):
      block/vhdx: add check for truncated image files

 docs/replay.txt                 |  12 +++-
 include/qom/object_interfaces.h |  12 ++++
 include/sysemu/replay.h         |   4 ++
 replay/replay-internal.h        |   1 +
 block/blkreplay.c               |   8 +++
 block/block-backend.c           |   9 ++-
 block/io.c                      |  39 ++++++++++++-
 block/iscsi.c                   |   5 +-
 block/nfs.c                     |   6 +-
 block/null.c                    |   4 +-
 block/nvme.c                    |   6 +-
 block/qcow2-cluster.c           |   5 +-
 block/rbd.c                     |   5 +-
 block/vhdx.c                    | 120 ++++++++++++++++++++++++++++++++++=
------
 block/vxhs.c                    |   5 +-
 cpus.c                          |   2 -
 qemu-img.c                      |  34 +++++++-----
 qemu-io.c                       |   9 ++-
 qemu-nbd.c                      |   9 ++-
 qom/object_interfaces.c         |  61 ++++++++++++++++++++
 replay/replay-events.c          |  16 ++++++
 replay/replay.c                 |   2 +
 stubs/replay-user.c             |   9 +++
 vl.c                            |  63 ++++-----------------
 stubs/Makefile.objs             |   1 +
 tests/qemu-iotests/028          |  11 +++-
 tests/qemu-iotests/028.out      |   1 -
 tests/qemu-iotests/268          |  55 ++++++++++++++++++
 tests/qemu-iotests/268.out      |   7 +++
 tests/qemu-iotests/270          |  83 +++++++++++++++++++++++++++
 tests/qemu-iotests/270.out      |   9 +++
 tests/qemu-iotests/group        |   2 +
 32 files changed, 504 insertions(+), 111 deletions(-)
 create mode 100644 stubs/replay-user.c
 create mode 100755 tests/qemu-iotests/268
 create mode 100644 tests/qemu-iotests/268.out
 create mode 100755 tests/qemu-iotests/270
 create mode 100644 tests/qemu-iotests/270.out

