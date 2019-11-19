Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA4CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285E92070E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyoKSD+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285E92070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtu2-0003Xt-2V
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWtsE-0001sH-Hb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWtsB-0004c5-3Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWts7-0004aD-Hj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574132886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4e+bVqGc/WNzhWBqXmsiBs4z4f7CBySw+JVTpJgFkwM=;
 b=fyoKSD+tNGu4wdRkNpVdk0EJPsmzCNi6Zpkfw3rGF75z7To9NgNTvUTtjWLEAC+YSDw1H6
 FQRh0Y47nbvNVtG31SQkgcOUFNSkDVxKLlU8U8VD8dI5RuMmDQBnbaWNBRNZ5dSl7DSRPc
 YNskhcIEaWYQdRN2dFtDj5KC2/U3xyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-tilyQQWcNuSKeFXaPjNjJQ-1; Mon, 18 Nov 2019 22:08:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 300B11005500
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 03:08:02 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF07C87B1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 03:08:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] NBD patches for 2019-11-19 for 4.2-rc2
Date: Mon, 18 Nov 2019 21:07:49 -0600
Message-Id: <20191119030759.24907-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tilyQQWcNuSKeFXaPjNjJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a5c2a235103ab366ad5318636ec138e52c6dcfa4=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2019-11-18 17:06:17 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-11-19

for you to fetch changes up to 296416ff0f519d762fbb87ac59f0770824267f3f:

  tests: More iotest 223 improvements (2019-11-18 20:34:37 -0600)

----------------------------------------------------------------
nbd patches for 2019-11-19

- iotests: more tests of NBD reconnect, various test output improvements
- nbd: fix spec compliance issue with long strings
- slience a Coverity warning on coroutines

----------------------------------------------------------------
Andrey Shinkevich (1):
      iotests: Test NBD client reconnection

Eric Blake (8):
      qemu-coroutine-sleep: Silence Coverity warning
      nbd/server: Prefer heap over stack for parsing client names
      bitmap: Enforce maximum bitmap name length
      nbd: Don't send oversize strings
      iotests: Fix 173
      iotests: Switch nbd tests to use Unix rather than TCP
      iotests: Include QMP input in .out files
      tests: More iotest 223 improvements

Vladimir Sementsov-Ogievskiy (1):
      MAINTAINERS: add more bitmap-related to Dirty Bitmaps section

 qapi/block-core.json                     |   2 +-
 include/block/dirty-bitmap.h             |   2 +
 include/block/nbd.h                      |  12 ++--
 block/dirty-bitmap.c                     |  12 +++-
 block/nbd.c                              |  10 ++++
 block/qcow2-bitmap.c                     |   2 +
 blockdev-nbd.c                           |   5 ++
 nbd/client.c                             |  18 +++++-
 nbd/server.c                             |  43 ++++++++-----
 qemu-nbd.c                               |   9 +++
 util/qemu-coroutine-sleep.c              |   7 +++
 tests/qemu-iotests/common.filter         |   6 +-
 tests/qemu-iotests/common.qemu           |   9 +++
 tests/qemu-iotests/common.rc             |  13 ++--
 MAINTAINERS                              |   2 +
 tests/qemu-iotests/085.out               |  26 ++++++++
 tests/qemu-iotests/094.out               |   4 ++
 tests/qemu-iotests/095.out               |   2 +
 tests/qemu-iotests/109.out               |  88 +++++++++++++++++++++++++++
 tests/qemu-iotests/117.out               |   5 ++
 tests/qemu-iotests/127.out               |   4 ++
 tests/qemu-iotests/140.out               |   5 ++
 tests/qemu-iotests/141.out               |  26 ++++++++
 tests/qemu-iotests/143.out               |   3 +
 tests/qemu-iotests/144.out               |   5 ++
 tests/qemu-iotests/153.out               |  11 ++++
 tests/qemu-iotests/156.out               |  11 ++++
 tests/qemu-iotests/161.out               |   8 +++
 tests/qemu-iotests/173                   |   4 +-
 tests/qemu-iotests/173.out               |  10 +++-
 tests/qemu-iotests/182.out               |   8 +++
 tests/qemu-iotests/183.out               |  11 ++++
 tests/qemu-iotests/185.out               |  18 ++++++
 tests/qemu-iotests/191.out               |   8 +++
 tests/qemu-iotests/200.out               |   1 +
 tests/qemu-iotests/223                   |  16 ++++-
 tests/qemu-iotests/223.out               | 100 +++++++++++++++++++++++++++=
++++
 tests/qemu-iotests/229.out               |   3 +
 tests/qemu-iotests/249.out               |   6 ++
 tests/qemu-iotests/277                   |  96 +++++++++++++++++++++++++++=
++
 tests/qemu-iotests/277.out               |   6 ++
 tests/qemu-iotests/group                 |   1 +
 tests/qemu-iotests/iotests.py            |   5 ++
 tests/qemu-iotests/nbd-fault-injector.py |   3 +-
 44 files changed, 606 insertions(+), 40 deletions(-)
 create mode 100755 tests/qemu-iotests/277
 create mode 100644 tests/qemu-iotests/277.out

Andrey Shinkevich (1):
  iotests: Test NBD client reconnection

Eric Blake (8):
  qemu-coroutine-sleep: Silence Coverity warning
  nbd/server: Prefer heap over stack for parsing client names
  bitmap: Enforce maximum bitmap name length
  nbd: Don't send oversize strings
  iotests: Fix 173
  iotests: Switch nbd tests to use Unix rather than TCP
  iotests: Include QMP input in .out files
  tests: More iotest 223 improvements

Vladimir Sementsov-Ogievskiy (1):
  MAINTAINERS: add more bitmap-related to Dirty Bitmaps section

 qapi/block-core.json                     |   2 +-
 include/block/dirty-bitmap.h             |   2 +
 include/block/nbd.h                      |  12 +--
 block/dirty-bitmap.c                     |  12 ++-
 block/nbd.c                              |  10 +++
 block/qcow2-bitmap.c                     |   2 +
 blockdev-nbd.c                           |   5 ++
 nbd/client.c                             |  18 +++-
 nbd/server.c                             |  43 ++++++----
 qemu-nbd.c                               |   9 ++
 util/qemu-coroutine-sleep.c              |   7 ++
 tests/qemu-iotests/common.filter         |   6 +-
 tests/qemu-iotests/common.qemu           |   9 ++
 tests/qemu-iotests/common.rc             |  13 +--
 MAINTAINERS                              |   2 +
 tests/qemu-iotests/085.out               |  26 ++++++
 tests/qemu-iotests/094.out               |   4 +
 tests/qemu-iotests/095.out               |   2 +
 tests/qemu-iotests/109.out               |  88 ++++++++++++++++++++
 tests/qemu-iotests/117.out               |   5 ++
 tests/qemu-iotests/127.out               |   4 +
 tests/qemu-iotests/140.out               |   5 ++
 tests/qemu-iotests/141.out               |  26 ++++++
 tests/qemu-iotests/143.out               |   3 +
 tests/qemu-iotests/144.out               |   5 ++
 tests/qemu-iotests/153.out               |  11 +++
 tests/qemu-iotests/156.out               |  11 +++
 tests/qemu-iotests/161.out               |   8 ++
 tests/qemu-iotests/173                   |   4 +-
 tests/qemu-iotests/173.out               |  10 ++-
 tests/qemu-iotests/182.out               |   8 ++
 tests/qemu-iotests/183.out               |  11 +++
 tests/qemu-iotests/185.out               |  18 ++++
 tests/qemu-iotests/191.out               |   8 ++
 tests/qemu-iotests/200.out               |   1 +
 tests/qemu-iotests/223                   |  16 +++-
 tests/qemu-iotests/223.out               | 100 +++++++++++++++++++++++
 tests/qemu-iotests/229.out               |   3 +
 tests/qemu-iotests/249.out               |   6 ++
 tests/qemu-iotests/277                   |  96 ++++++++++++++++++++++
 tests/qemu-iotests/277.out               |   6 ++
 tests/qemu-iotests/group                 |   1 +
 tests/qemu-iotests/iotests.py            |   5 ++
 tests/qemu-iotests/nbd-fault-injector.py |   3 +-
 44 files changed, 606 insertions(+), 40 deletions(-)
 create mode 100755 tests/qemu-iotests/277
 create mode 100644 tests/qemu-iotests/277.out

--=20
2.21.0


