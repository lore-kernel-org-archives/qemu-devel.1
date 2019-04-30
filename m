Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB25C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE7020652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE7020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVC0-0005f2-2C
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:01:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00081c-Hi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUun-00024S-VC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUuA-0001XH-Tl; Tue, 30 Apr 2019 11:42:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BCD730ADBAF;
	Tue, 30 Apr 2019 15:42:50 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 432704C7;
	Tue, 30 Apr 2019 15:42:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:17 +0200
Message-Id: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 30 Apr 2019 15:42:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/27] Block layer patches
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
Message-ID: <20190430154217.iPxqCYJFxgTmh1_l-ep9d3lwJwuC_mVMfdWvvLZt_mQ@z>

The following changes since commit 22d96eac64877c4d96f9928babb6f2fcc68faa=
cf:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2019-04-29 19:11:15 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 54277a2aab876aba7b55c7e88e2b372691849741:

  block/qed: add missed coroutine_fn markers (2019-04-30 15:29:00 +0200)

----------------------------------------------------------------
Block layer patches:

- iotests: Fix output of qemu-io related tests
- Don't ignore bdrv_set_aio_context() for nodes with bs->drv =3D NUL
- vmdk: Set vmdk parent backing_format to vmdk
- qcow2: Preallocation fixes (especially for external data files)
- Add linear-buffer-based APIs (as wrappers around qiov-based ones)
- Various code cleanups and small corner case fixes

----------------------------------------------------------------
Alberto Garcia (3):
      qcow2: Fix error handling in the compression code
      commit: Make base read-only if there is an early failure
      iotests: Check that images are in read-only mode after block-commit

Eric Blake (2):
      cutils: Fix size_to_str() on 32-bit platforms
      qemu-img: Saner printing of large file sizes

Kevin Wolf (5):
      block: Fix AioContext switch for bs->drv =3D=3D NULL
      qcow2: Avoid COW during metadata preallocation
      qcow2: Add errp to preallocate_co()
      qcow2: Fix full preallocation with external data file
      qcow2: Fix qcow2_make_empty() with external data file

Max Reitz (2):
      iotests: Perform the correct test in 082
      qemu-img: Make create hint at protocol options

Sam Eiderman (1):
      vmdk: Set vmdk parent backing_format to vmdk

Stefano Garzarella (2):
      block/vhdx: Remove redundant IEC binary prefixes definition
      block/vhdx: Use IEC binary prefixes for size constants

Thomas Huth (1):
      tests/qemu-iotests: Fix output of qemu-io related tests

Vladimir Sementsov-Ogievskiy (10):
      block: introduce byte-based io helpers
      block/qcow2: use buffer-based io
      block/qcow: use buffer-based io
      block/qed: use buffer-based io
      block/parallels: use buffer-based io
      block/backup: use buffer-based io
      block/commit: use buffer-based io
      block/stream: use buffer-based io
      qemu-img: use buffer-based io
      block/qed: add missed coroutine_fn markers

Zhengui li (1):
      vpc: unlock Coroutine lock to make IO submit Concurrently

 block/qed.h                    |  28 ++++---
 block/vhdx.h                   |  16 ++--
 include/block/block_int.h      |  16 ++++
 include/sysemu/block-backend.h |  19 +++++
 block.c                        |  12 +--
 block/backup.c                 |  14 ++--
 block/commit.c                 |   8 +-
 block/parallels.c              |  14 ++--
 block/qapi.c                   |  49 +++---------
 block/qcow.c                   |  19 ++---
 block/qcow2.c                  |  80 ++++++++++----------
 block/qed-check.c              |   4 +-
 block/qed-table.c              |  45 ++++++-----
 block/qed.c                    |  11 ++-
 block/stream.c                 |   4 +-
 block/vhdx-log.c               |   2 +-
 block/vhdx.c                   |   7 +-
 block/vmdk.c                   |   2 +
 block/vpc.c                    |   4 +
 qemu-img.c                     |  26 ++++---
 util/cutils.c                  |   2 +-
 tests/qemu-iotests/026.out     | 168 ++++++++++++++++++++---------------=
------
 tests/qemu-iotests/043.out     |   6 +-
 tests/qemu-iotests/053.out     |   2 +-
 tests/qemu-iotests/059.out     |  10 +--
 tests/qemu-iotests/060.out     |  16 ++--
 tests/qemu-iotests/061.out     |  12 +--
 tests/qemu-iotests/069.out     |   2 +-
 tests/qemu-iotests/070.out     |   4 +-
 tests/qemu-iotests/075.out     |  14 ++--
 tests/qemu-iotests/076.out     |   6 +-
 tests/qemu-iotests/078.out     |  12 +--
 tests/qemu-iotests/080.out     |  40 +++++-----
 tests/qemu-iotests/081.out     |   2 +-
 tests/qemu-iotests/082         |   5 +-
 tests/qemu-iotests/082.out     |  51 ++++++++-----
 tests/qemu-iotests/084.out     |   8 +-
 tests/qemu-iotests/088.out     |  12 +--
 tests/qemu-iotests/089.out     |   2 +-
 tests/qemu-iotests/095.out     |   4 +-
 tests/qemu-iotests/103.out     |  14 ++--
 tests/qemu-iotests/104.out     |   6 +-
 tests/qemu-iotests/110.out     |   6 +-
 tests/qemu-iotests/114.out     |   4 +-
 tests/qemu-iotests/116.out     |  14 ++--
 tests/qemu-iotests/126.out     |   4 +-
 tests/qemu-iotests/130.out     |  10 +--
 tests/qemu-iotests/131.out     |   2 +-
 tests/qemu-iotests/133.out     |  30 ++++----
 tests/qemu-iotests/137.out     |  28 +++----
 tests/qemu-iotests/140.out     |   2 +-
 tests/qemu-iotests/143.out     |   2 +-
 tests/qemu-iotests/153.out     |  32 ++++----
 tests/qemu-iotests/187.out     |   6 +-
 tests/qemu-iotests/188.out     |   2 +-
 tests/qemu-iotests/191.out     |   8 +-
 tests/qemu-iotests/195.out     |   4 +-
 tests/qemu-iotests/197.out     |   2 +-
 tests/qemu-iotests/198.out     |   4 +-
 tests/qemu-iotests/205         |   2 +-
 tests/qemu-iotests/206.out     |  10 +--
 tests/qemu-iotests/207.out     |  12 +--
 tests/qemu-iotests/210.out     |   8 +-
 tests/qemu-iotests/211.out     |  10 +--
 tests/qemu-iotests/212.out     |  10 +--
 tests/qemu-iotests/213.out     |  10 +--
 tests/qemu-iotests/215.out     |   2 +-
 tests/qemu-iotests/226.out     |  16 ++--
 tests/qemu-iotests/233.out     |   4 +-
 tests/qemu-iotests/237.out     |  22 +++---
 tests/qemu-iotests/242.out     |  10 +--
 tests/qemu-iotests/244.out     |  10 +--
 tests/qemu-iotests/249         | 115 ++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out     |  35 +++++++++
 tests/qemu-iotests/group       |   1 +
 75 files changed, 696 insertions(+), 519 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

