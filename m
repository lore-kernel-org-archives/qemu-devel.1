Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED22AC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C002084D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C002084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PWI-00007y-6J
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQZ-0002ZS-8m
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQX-0001Hi-DH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQP-0001DI-Sm; Thu, 12 Sep 2019 09:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4704E3082D9E;
 Thu, 12 Sep 2019 13:46:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23186600C8;
 Thu, 12 Sep 2019 13:46:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:42 +0200
Message-Id: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 13:46:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/22] Block layer patches
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

The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04=
b1:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-0=
9-07' into staging (2019-09-09 09:48:34 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 65f9f0c2a53b1572043501bb4e99500914e88cc6:

  qcow2: Stop overwriting compressed clusters one by one (2019-09-12 11:2=
6:59 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2: Allow overwriting multiple compressed clusters at once for
  better performance
- nfs: add support for nfs_umount
- file-posix: write_zeroes fixes
- qemu-io, blockdev-create, pr-manager: Fix crashes and memory leaks
- qcow2: Fix the calculation of the maximum L2 cache size
- vpc: Fix return code for vpc_co_create()
- blockjob: Code cleanup
- iotests improvements (e.g. for use with valgrind)

----------------------------------------------------------------
Alberto Garcia (2):
      qcow2: Fix the calculation of the maximum L2 cache size
      qcow2: Stop overwriting compressed clusters one by one

Andrey Shinkevich (6):
      iotests: allow Valgrind checking all QEMU processes
      iotests: exclude killed processes from running under Valgrind
      iotests: Add casenotrun report to bash tests
      iotests: Valgrind fails with nonexistent directory
      iotests: extended timeout under Valgrind
      iotests: extend sleeping time under Valgrind

Kevin Wolf (2):
      file-posix: Fix has_write_zeroes after NO_FALLBACK
      qemu-io: Don't leak pattern file in error path

Markus Armbruster (1):
      pr-manager: Fix invalid g_free() crash bug

Max Reitz (7):
      block/file-posix: Reduce xfsctl() use
      iotests: Test reverse sub-cluster qcow2 writes
      vpc: Return 0 from vpc_co_create() on success
      iotests: Add supported protocols to execute_test()
      iotests: Restrict file Python tests to file
      iotests: Restrict nbd Python tests to nbd
      iotests: Test blockdev-create for vpc

Peter Lieven (1):
      block/nfs: add support for nfs_umount

Philippe Mathieu-Daud=C3=A9 (1):
      block/create: Do not abort if a block driver is not available

Vladimir Sementsov-Ogievskiy (2):
      job: drop job_drain
      iotests: skip 232 when run tests as root

 include/block/blockjob_int.h  |  19 ------
 include/qemu/job.h            |  13 ----
 block/backup.c                |  19 +-----
 block/commit.c                |   1 -
 block/create.c                |   6 +-
 block/file-posix.c            |  83 ++---------------------
 block/mirror.c                |  28 +-------
 block/nfs.c                   |   5 +-
 block/qcow2-cluster.c         |   8 +--
 block/qcow2.c                 |   6 +-
 block/stream.c                |   1 -
 block/vpc.c                   |   3 +-
 blockjob.c                    |  13 ----
 job.c                         |  12 +---
 qemu-io-cmds.c                |   4 ++
 scsi/pr-manager.c             |   1 -
 tests/test-bdrv-drain.c       |   3 -
 tests/test-block-iothread.c   |   1 -
 tests/test-blockjob-txn.c     |   1 -
 tests/test-blockjob.c         |   2 -
 tests/qemu-iotests/028        |   6 +-
 tests/qemu-iotests/030        |   3 +-
 tests/qemu-iotests/039        |   5 ++
 tests/qemu-iotests/039.out    |  30 ++-------
 tests/qemu-iotests/040        |   3 +-
 tests/qemu-iotests/041        |   3 +-
 tests/qemu-iotests/044        |   3 +-
 tests/qemu-iotests/045        |   3 +-
 tests/qemu-iotests/051        |   4 ++
 tests/qemu-iotests/055        |   3 +-
 tests/qemu-iotests/056        |   3 +-
 tests/qemu-iotests/057        |   3 +-
 tests/qemu-iotests/061        |   2 +
 tests/qemu-iotests/061.out    |  12 +---
 tests/qemu-iotests/065        |   3 +-
 tests/qemu-iotests/096        |   3 +-
 tests/qemu-iotests/118        |   3 +-
 tests/qemu-iotests/124        |   3 +-
 tests/qemu-iotests/129        |   3 +-
 tests/qemu-iotests/132        |   3 +-
 tests/qemu-iotests/137        |   1 +
 tests/qemu-iotests/137.out    |   6 +-
 tests/qemu-iotests/139        |   3 +-
 tests/qemu-iotests/147        |   5 +-
 tests/qemu-iotests/148        |   3 +-
 tests/qemu-iotests/151        |   3 +-
 tests/qemu-iotests/152        |   3 +-
 tests/qemu-iotests/155        |   3 +-
 tests/qemu-iotests/163        |   3 +-
 tests/qemu-iotests/165        |   3 +-
 tests/qemu-iotests/169        |   3 +-
 tests/qemu-iotests/183        |   9 ++-
 tests/qemu-iotests/192        |   6 +-
 tests/qemu-iotests/196        |   3 +-
 tests/qemu-iotests/199        |   3 +-
 tests/qemu-iotests/205        |   3 +-
 tests/qemu-iotests/232        |   6 ++
 tests/qemu-iotests/245        |   3 +-
 tests/qemu-iotests/247        |   6 +-
 tests/qemu-iotests/257        |   3 +-
 tests/qemu-iotests/265        |  67 ++++++++++++++++++
 tests/qemu-iotests/265.out    |   6 ++
 tests/qemu-iotests/266        | 153 ++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/266.out    | 137 ++++++++++++++++++++++++++++++++++++=
+
 tests/qemu-iotests/common.rc  | 105 ++++++++++++++++++++++++-----
 tests/qemu-iotests/group      |   2 +
 tests/qemu-iotests/iotests.py |   4 +-
 67 files changed, 590 insertions(+), 292 deletions(-)
 create mode 100755 tests/qemu-iotests/265
 create mode 100644 tests/qemu-iotests/265.out
 create mode 100755 tests/qemu-iotests/266
 create mode 100644 tests/qemu-iotests/266.out

