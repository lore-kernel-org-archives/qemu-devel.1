Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753D7C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4272070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4272070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8EQ-0005UK-Ev
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:18:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8CL-00047f-Am
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8CK-0008Dp-1X
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP8CH-00088P-QJ; Fri, 10 May 2019 12:16:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AD493004149;
	Fri, 10 May 2019 16:16:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B34B4177AC;
	Fri, 10 May 2019 16:16:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 18:15:59 +0200
Message-Id: <20190510161614.23236-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 10 May 2019 16:16:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/15] Block layer patches
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

The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0cca=
e8:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-05-10 14:49:36 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 11f6fc50e7501b5f5d04100ea1c21fa8f1cf7b53:

  iotests: Add test for rebase without input base (2019-05-10 16:45:40 +0=
200)

----------------------------------------------------------------
Block layer patches:

- block: Remove bdrv_read() and bdrv_write()
- qemu-img: Allow rebase with no input base
- blockjob: Fix coroutine thread after AioContext change
- MAINTAINERS updates for pflash, curl and gluster

----------------------------------------------------------------
Alberto Garcia (5):
      qcow2: Replace bdrv_write() with bdrv_pwrite()
      vdi: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
      vvfat: Replace bdrv_{read,write}() with bdrv_{pread,pwrite}()
      block: Remove bdrv_read() and bdrv_write()
      qcow2: Remove BDRVQcow2State.cluster_sectors

Anton Kuchin (1):
      block: remove bs from lists before closing

Kevin Wolf (3):
      qemu-iotests: Fix cleanup for 192
      blockjob: Fix coroutine thread after AioContext change
      test-block-iothread: Job coroutine thread after AioContext switch

Max Reitz (3):
      qemu-img: Allow rebase with no input base
      qemu-img: Use zero writes after source backing EOF
      iotests: Add test for rebase without input base

Philippe Mathieu-Daud=C3=A9 (1):
      MAINTAINERS: Add an entry for the Parallel NOR Flash devices

Stefano Garzarella (1):
      qemu-img: Use IEC binary prefixes for size constants

Thomas Huth (1):
      MAINTAINERS: Downgrade status of block sections without "M:" to "Od=
d Fixes"

 block/qcow2.h               |   1 -
 include/block/block.h       |   4 --
 block.c                     |   4 +-
 block/io.c                  |  43 +++------------
 block/qcow2-refcount.c      |   4 +-
 block/qcow2.c               |   1 -
 block/vdi.c                 |  15 +++---
 block/vvfat.c               |  12 +++--
 job.c                       |   2 +-
 qemu-img.c                  |  77 ++++++++++++++++-----------
 tests/test-block-iothread.c | 107 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |  12 ++++-
 tests/qemu-iotests/192      |   4 +-
 tests/qemu-iotests/252      | 124 ++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/252.out  |  39 ++++++++++++++
 tests/qemu-iotests/group    |   1 +
 16 files changed, 358 insertions(+), 92 deletions(-)
 create mode 100755 tests/qemu-iotests/252
 create mode 100644 tests/qemu-iotests/252.out

