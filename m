Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5053CC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DB92171F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DB92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sZC-0004AP-Ba
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ru5-0002mH-RW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ru3-0000Z9-NB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9rty-0000WS-QX; Mon, 16 Sep 2019 10:22:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A70A7A26670;
 Mon, 16 Sep 2019 14:22:49 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B1F64020;
 Mon, 16 Sep 2019 14:22:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:30 +0200
Message-Id: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 16 Sep 2019 14:22:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/16] Block patches
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

The following changes since commit dd25f97c66a75d1508f1d4c6478ed2c95bec42=
8f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90913' into staging (2019-09-16 10:15:15 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-09-16

for you to fetch changes up to 1825cc0783ccf0ec5d9f0b225a99b340bdd4c68f:

  qemu-iotests: Add test for bz #1745922 (2019-09-16 15:37:12 +0200)

----------------------------------------------------------------
Block patches:
- Fix for block jobs when used with I/O threads
- Fix for a corruption when using qcow2's LUKS encryption mode
- cURL fix
- check-block.sh cleanups (for make check)
- Refactoring

----------------------------------------------------------------
Max Reitz (7):
  curl: Keep pointer to the CURLState in CURLSocket
  curl: Keep *socket until the end of curl_sock_cb()
  curl: Check completion in curl_multi_do()
  curl: Pass CURLSocket to curl_multi_do()
  curl: Report only ready sockets
  curl: Handle success in multi_check_completion
  curl: Check curl_multi_add_handle()'s return code

Maxim Levitsky (3):
  block/qcow2: Fix corruption introduced by commit 8ac0f15f335
  block/qcow2: refactor encryption code
  qemu-iotests: Add test for bz #1745922

Nir Soffer (2):
  block: Use QEMU_IS_ALIGNED
  block: Remove unused masks

Sergio Lopez (1):
  blockjob: update nodes head while removing all bdrv

Thomas Huth (2):
  tests/qemu-iotests/check: Replace "tests" with "iotests" in final
    status text
  tests/Makefile: Do not print the name of the check-block.sh shell
    script

Vladimir Sementsov-Ogievskiy (1):
  tests/qemu-iotests: Fix qemu-io related output in 026.out.nocache

 tests/Makefile.include             |   2 +-
 block/qcow2.h                      |   8 +-
 include/block/block.h              |   2 -
 block/bochs.c                      |   4 +-
 block/cloop.c                      |   4 +-
 block/curl.c                       | 133 ++++++++++-------------
 block/dmg.c                        |   4 +-
 block/io.c                         |   8 +-
 block/qcow2-cluster.c              |  40 +++----
 block/qcow2-threads.c              |  63 ++++++++---
 block/qcow2.c                      |   9 +-
 block/vvfat.c                      |   8 +-
 blockjob.c                         |  17 ++-
 migration/block.c                  |   2 +-
 qemu-img.c                         |   2 +-
 tests/qemu-iotests/026.out.nocache | 168 ++++++++++++++---------------
 tests/qemu-iotests/263             |  91 ++++++++++++++++
 tests/qemu-iotests/263.out         |  40 +++++++
 tests/qemu-iotests/check           |   8 +-
 tests/qemu-iotests/group           |   1 +
 20 files changed, 380 insertions(+), 234 deletions(-)
 create mode 100755 tests/qemu-iotests/263
 create mode 100644 tests/qemu-iotests/263.out

--=20
2.21.0


