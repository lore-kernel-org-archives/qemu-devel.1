Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0418205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0418205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1tA-0000Nz-NS
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:20:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rQ-0007mc-JS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rO-0003oG-SL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rL-0003jc-4p; Tue, 07 May 2019 11:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AAD430018FC;
	Tue,  7 May 2019 15:18:22 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A1B8E53E20;
	Tue,  7 May 2019 15:18:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:08 +0200
Message-Id: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 15:18:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/11] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08=
e0:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2019-05-07 10:43:32 +0100)

are available in the Git repository at:

  https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2019-05-07

for you to fetch changes up to 1278dce7927301bf3d004a40061dbd2c1e0846a8:

  iotests: Fix iotests 110 and 126 (2019-05-07 17:14:21 +0200)

----------------------------------------------------------------
Block patches:
- Fixes to qcow2's implementation of qemu-img check
- Our SSH driver now supports bdrv_refresh_filename()
- Miscellaneous fixes

----------------------------------------------------------------
Alberto Garcia (2):
  block: Assert that drv->bdrv_child_perm is set in bdrv_child_perm()
  commit: Use bdrv_append() in commit_start()

Andrey Shinkevich (1):
  qcow2: discard bitmap when removed

Max Reitz (3):
  block/ssh: Implement .bdrv_refresh_filename()
  block/ssh: Implement .bdrv_dirname()
  iotests: Fix iotests 110 and 126

Vladimir Sementsov-Ogievskiy (5):
  qcow2-refcount: fix check_oflag_copied
  qcow2-refcount: avoid eating RAM
  qcow2-refcount: check_refcounts_l2: reduce ignored overlaps
  qcow2-refcount: check_refcounts_l2: don't count fixed cluster as
    allocated
  qcow2-refcount: don't mask corruptions under internal errors

 block.c                       |  9 ++--
 block/commit.c                | 11 +----
 block/qcow2-bitmap.c          |  2 +-
 block/qcow2-refcount.c        | 80 ++++++++++++++++++++++-------------
 block/ssh.c                   | 73 +++++++++++++++++++++++++++++---
 tests/qemu-iotests/110        | 10 +++--
 tests/qemu-iotests/126        | 10 +++--
 tests/qemu-iotests/138        | 12 +++---
 tests/qemu-iotests/138.out    |  5 ++-
 tests/qemu-iotests/207        | 10 ++---
 tests/qemu-iotests/207.out    | 10 ++---
 tests/qemu-iotests/common.rc  |  2 +-
 tests/qemu-iotests/iotests.py |  2 +-
 13 files changed, 159 insertions(+), 77 deletions(-)

--=20
2.20.1


