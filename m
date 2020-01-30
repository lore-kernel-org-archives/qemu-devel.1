Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77690C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DD020674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i91SUI7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DD020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHRY-0000Xo-FH
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHPP-0006kQ-KJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHPM-0004e1-OR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHPL-0004c9-Nx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FdBOIwHFRBuFdMRliXgUL/f4DX9a/mysc3py+hAdC10=;
 b=i91SUI7ins+ZDpgdL7kn+u81e+LG+KgURIDNwT+K2ZLuoug0OiKo4VHhFcCWGxZf5X1JEg
 lsYZG1swrUu3204HQsk76aZMaa9+IoVWvjuoKABXATHOwsrKWKq72vS7oaCg+EJpyEEgZI
 tuLNoQChvg7/QDoYUQn5UHDzJUs60Wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-A93twi5QOmOKKQJlR8Sdlw-1; Thu, 30 Jan 2020 16:31:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5212BDB61;
 Thu, 30 Jan 2020 21:31:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC71E84BCE;
 Thu, 30 Jan 2020 21:31:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Block patches
Date: Thu, 30 Jan 2020 21:30:56 +0000
Message-Id: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: A93twi5QOmOKKQJlR8Sdlw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f57d=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
130' into staging (2020-01-30 16:19:04 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 8dff69b9415b4287e900358744b732195e1ab2e2:

  tests/qemu-iotests: use AIOMODE with various tests (2020-01-30 21:01:40 +=
0000)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Aarushi Mehta (15):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: adds bdrv_parse_aio to use io_uring
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring
  block/io_uring: adds userspace completion polling
  qemu-io: adds option to use aio engine
  qemu-img: adds option to use aio engine for benchmarking
  qemu-nbd: adds option for aio engines
  tests/qemu-iotests: enable testing with aio options
  tests/qemu-iotests: use AIOMODE with various tests

Paolo Bonzini (3):
  block: eliminate BDRV_REQ_NO_SERIALISING
  block/io: wait for serialising requests when a request becomes
    serialising
  block/io: take bs->reqs_lock in bdrv_mark_request_serialising

 MAINTAINERS                   |   9 +
 block.c                       |  22 ++
 block/Makefile.objs           |   3 +
 block/file-posix.c            |  99 ++++++--
 block/io.c                    | 162 +++++++------
 block/io_uring.c              | 433 ++++++++++++++++++++++++++++++++++
 block/trace-events            |  12 +
 blockdev.c                    |  12 +-
 configure                     |  27 +++
 docs/interop/qemu-nbd.rst     |   4 +-
 include/block/aio.h           |  16 +-
 include/block/block.h         |  14 +-
 include/block/block_int.h     |   3 +-
 include/block/raw-aio.h       |  12 +
 qapi/block-core.json          |   4 +-
 qemu-img-cmds.hx              |   4 +-
 qemu-img.c                    |  11 +-
 qemu-img.texi                 |   5 +-
 qemu-io.c                     |  25 +-
 qemu-nbd.c                    |  12 +-
 stubs/Makefile.objs           |   1 +
 stubs/io_uring.c              |  32 +++
 tests/qemu-iotests/028        |   2 +-
 tests/qemu-iotests/058        |   2 +-
 tests/qemu-iotests/089        |   4 +-
 tests/qemu-iotests/091        |   4 +-
 tests/qemu-iotests/109        |   2 +-
 tests/qemu-iotests/147        |   5 +-
 tests/qemu-iotests/181        |   8 +-
 tests/qemu-iotests/183        |   4 +-
 tests/qemu-iotests/185        |  10 +-
 tests/qemu-iotests/200        |   2 +-
 tests/qemu-iotests/201        |   8 +-
 tests/qemu-iotests/check      |  15 +-
 tests/qemu-iotests/common.rc  |  14 ++
 tests/qemu-iotests/iotests.py |  12 +-
 util/async.c                  |  36 +++
 37 files changed, 878 insertions(+), 172 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

--=20
2.24.1


