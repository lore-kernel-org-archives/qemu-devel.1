Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951D921741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMjeXu94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951D921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgio-00073h-O7
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdC-0002h8-85
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgd9-0008V2-Es
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33307
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgd9-0008MR-5q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T++k09iQxkSO3iLfwg/rjSHpPtTWSfYgFl22LjnU0Z0=;
 b=hMjeXu94POQXCMVfq/cfEdkkbyOqfNS1ZBkzBngAggQlltWuNNazJ2GKsmZ9P6LEcqZ59d
 +D58YekXbA4blaFn5pLOhR3Fp3usuVyy7etJRCajrdjpFJay0n0hmdP04tJHEXxAa1Ac7+
 uwFkXjlwpOBqTRZ2ciouYZcqmXO1YgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Am7LMLoVMeicU8PSbQOdGA-1; Thu, 06 Feb 2020 07:51:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22DEE1050908;
 Thu,  6 Feb 2020 12:51:34 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7ECC60BEC;
 Thu,  6 Feb 2020 12:51:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/17] Block patches
Date: Thu,  6 Feb 2020 13:51:15 +0100
Message-Id: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Am7LMLoVMeicU8PSbQOdGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d7611c=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040220-1'=
 into staging (2020-02-04 18:55:06 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-02-06

for you to fetch changes up to a541fcc27c98b96da187c7d4573f3270f3ddd283:

  iotests: add test for backup-top failure on permission activation (2020-0=
2-06 13:47:45 +0100)

----------------------------------------------------------------
Block patches:
- Drop BDRV_SECTOR_SIZE from qcow2
- Allow Python iotests to be added to the auto group
  (and add some)
- Fix for the backup job
- Fix memleak in bdrv_refresh_filename()
- Use GStrings in two places for greater efficiency (than manually
  handling string allocation)

----------------------------------------------------------------
Alberto Garcia (8):
  qcow2: Assert that host cluster offsets fit in L2 table entries
  block: Use a GString in bdrv_perm_names()
  qcow2: Use a GString in report_unsupported_feature()
  qcow2: Don't round the L1 table allocation up to the sector size
  qcow2: Tighten cluster_offset alignment assertions
  qcow2: Use bs->bl.request_alignment when updating an L1 entry
  qcow2: Don't require aligned offsets in qcow2_co_copy_range_from()
  qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded value

John Snow (1):
  iotests: remove 'linux' from default supported platforms

Pan Nengyuan (1):
  block: fix memleaks in bdrv_refresh_filename

Thomas Huth (5):
  iotests: Test 041 only works on certain systems
  iotests: Test 183 does not work on macOS and OpenBSD
  iotests: Check for the availability of the required devices in 267 and
    127
  iotests: Skip Python-based tests if QEMU does not support virtio-blk
  iotests: Enable more tests in the 'auto' group to improve test
    coverage

Vladimir Sementsov-Ogievskiy (2):
  block/backup-top: fix failure path
  iotests: add test for backup-top failure on permission activation

 block.c                       | 12 +++--
 block/backup-top.c            | 21 ++++----
 block/qcow2-cluster.c         | 44 +++++++++++------
 block/qcow2-refcount.c        |  2 +-
 block/qcow2-snapshot.c        |  3 +-
 block/qcow2.c                 | 46 ++++++++----------
 tests/qemu-iotests/041        |  3 +-
 tests/qemu-iotests/127        |  2 +
 tests/qemu-iotests/183        |  1 +
 tests/qemu-iotests/267        |  2 +
 tests/qemu-iotests/283        | 92 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/283.out    |  8 +++
 tests/qemu-iotests/check      | 12 ++++-
 tests/qemu-iotests/common.rc  | 14 ++++++
 tests/qemu-iotests/group      | 15 +++---
 tests/qemu-iotests/iotests.py | 16 ++++--
 16 files changed, 220 insertions(+), 73 deletions(-)
 create mode 100644 tests/qemu-iotests/283
 create mode 100644 tests/qemu-iotests/283.out

--=20
2.24.1


