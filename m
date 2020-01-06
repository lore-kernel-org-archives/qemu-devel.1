Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBF6C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4869F20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDnl4TLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4869F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTc4-0007Qp-Ua
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTaE-00055q-P6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTaC-00088W-To
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTaC-00088H-Pq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gOAirrA4Wcu4cy2R3DZ+IdRkR6nHHuNstxcLtcx7NKk=;
 b=dDnl4TLIgWOZ//ziFqoYN1jDUJ70JeD2uXBz0mIB3T3rsP79w2rYa+vFYV/OJKbY6uE7US
 RwP1yZA+qlnFIzTOWgB9Dg9l4dNSe1Z+S2GwdfkHa87zCXp8Dr2tCXFnqA+f1tC7bOLdrm
 USbvMf9VY5opT676hDnHJ0EFSbGVFzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-1-YZy_RTMm6_KsLvjJe8WQ-1; Mon, 06 Jan 2020 09:42:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0568E107ACC9;
 Mon,  6 Jan 2020 14:42:12 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2969C86CA0;
 Mon,  6 Jan 2020 14:42:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/34] Block patches
Date: Mon,  6 Jan 2020 15:41:32 +0100
Message-Id: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1-YZy_RTMm6_KsLvjJe8WQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit f17783e706ab9c7b3a2b69cf48e4f0ba40664f54=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191=
220' into staging (2020-01-03 18:50:33 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-01-06

for you to fetch changes up to 503ca1262bab2c11c533a4816d1ff4297d4f58a6:

  backup-top: Begin drain earlier (2020-01-06 14:26:23 +0100)

----------------------------------------------------------------
Block patches:
- Minor fixes and tests from the freeze period (too minor to be included
  in 4.2)
- Allow many bash iotests to test qcow2's external data file feature
- Add compress filter driver
- Fix Python iotests after 6f6e1698a6
- Fix for the backup job

----------------------------------------------------------------
Andrey Shinkevich (3):
  block: introduce compress filter driver
  qcow2: Allow writing compressed data of multiple clusters
  tests/qemu-iotests: add case to write compressed data of multiple
    clusters

Max Reitz (28):
  block: Add bdrv_qapi_perm_to_blk_perm()
  block: Use bdrv_qapi_perm_to_blk_perm()
  blkdebug: Allow taking/unsharing permissions
  iotests: Add @error to wait_until_completed
  iotests: Add test for failing mirror complete
  iotests: s/qocw2/qcow2/
  iotests/qcow2.py: Add dump-header-exts
  iotests/qcow2.py: Split feature fields into bits
  iotests: Add _filter_json_filename
  iotests: Filter refcount_order in 036
  iotests: Replace IMGOPTS by _unsupported_imgopts
  iotests: Drop compat=3D1.1 in 050
  iotests: Let _make_test_img parse its parameters
  iotests: Add -o and --no-opts to _make_test_img
  iotests: Inject space into -ocompat=3D0.10 in 051
  iotests: Replace IMGOPTS=3D by -o
  iotests: Replace IMGOPTS=3D'' by --no-opts
  iotests: Drop IMGOPTS use in 267
  iotests: Avoid qemu-img create
  iotests: Use _rm_test_img for deleting test images
  iotests: Avoid cp/mv of test images
  iotests: Make 091 work with data_file
  iotests: Make 110 work with data_file
  iotests: Make 137 work with data_file
  iotests: Make 198 work with data_file
  iotests: Disable data_file where it cannot be used
  iotests: Allow check -o data_file
  backup-top: Begin drain earlier

PanNengyuan (1):
  throttle-groups: fix memory leak in throttle_group_set_limit:

Philippe Mathieu-Daud=C3=A9 (1):
  tests/qemu-iotests: Update tests to recent desugarized -accel option

Vladimir Sementsov-Ogievskiy (1):
  qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap

 block.c                          |  47 +++++----
 block/Makefile.objs              |   1 +
 block/backup-top.c               |   4 +-
 block/blkdebug.c                 |  93 ++++++++++++++++-
 block/filter-compress.c          | 168 +++++++++++++++++++++++++++++++
 block/qcow2-bitmap.c             |  41 ++++----
 block/qcow2.c                    | 102 ++++++++++++++-----
 block/throttle-groups.c          |   4 +-
 include/block/block.h            |   1 +
 qapi/block-core.json             |  24 ++++-
 tests/qemu-iotests/007           |   5 +-
 tests/qemu-iotests/014           |   2 +
 tests/qemu-iotests/015           |   5 +-
 tests/qemu-iotests/019           |   6 +-
 tests/qemu-iotests/020           |   6 +-
 tests/qemu-iotests/024           |  10 +-
 tests/qemu-iotests/026           |   5 +-
 tests/qemu-iotests/028           |   2 +-
 tests/qemu-iotests/029           |   7 +-
 tests/qemu-iotests/031           |   9 +-
 tests/qemu-iotests/031.out       |  36 +++----
 tests/qemu-iotests/036           |  15 +--
 tests/qemu-iotests/036.out       |  66 ++----------
 tests/qemu-iotests/039           |  27 ++---
 tests/qemu-iotests/039.out       |  22 ++--
 tests/qemu-iotests/041           |  44 ++++++++
 tests/qemu-iotests/041.out       |   4 +-
 tests/qemu-iotests/043           |   4 +-
 tests/qemu-iotests/046           |   2 +
 tests/qemu-iotests/048           |   4 +-
 tests/qemu-iotests/050           |   8 +-
 tests/qemu-iotests/051           |   7 +-
 tests/qemu-iotests/053           |   4 +-
 tests/qemu-iotests/058           |   7 +-
 tests/qemu-iotests/059           |  20 ++--
 tests/qemu-iotests/060           |  14 +--
 tests/qemu-iotests/060.out       |  20 ++--
 tests/qemu-iotests/061           |  63 ++++++------
 tests/qemu-iotests/061.out       |  72 ++++++-------
 tests/qemu-iotests/062           |   5 +-
 tests/qemu-iotests/063           |  18 ++--
 tests/qemu-iotests/063.out       |   3 +-
 tests/qemu-iotests/066           |   7 +-
 tests/qemu-iotests/067           |   6 +-
 tests/qemu-iotests/068           |   6 +-
 tests/qemu-iotests/069           |   2 +-
 tests/qemu-iotests/071           |   7 +-
 tests/qemu-iotests/073           |   4 +
 tests/qemu-iotests/074           |   4 +-
 tests/qemu-iotests/079           |   3 +-
 tests/qemu-iotests/080           |   7 +-
 tests/qemu-iotests/081           |   6 +-
 tests/qemu-iotests/085           |  18 ++--
 tests/qemu-iotests/085.out       |   8 +-
 tests/qemu-iotests/088           |   2 +-
 tests/qemu-iotests/090           |   2 +
 tests/qemu-iotests/091           |   2 +-
 tests/qemu-iotests/091.out       |   2 -
 tests/qemu-iotests/092           |   2 +-
 tests/qemu-iotests/094           |   4 +-
 tests/qemu-iotests/095           |   5 +-
 tests/qemu-iotests/098           |   6 +-
 tests/qemu-iotests/099           |  10 +-
 tests/qemu-iotests/103           |   5 +-
 tests/qemu-iotests/106           |   2 +-
 tests/qemu-iotests/108           |  10 +-
 tests/qemu-iotests/109           |   4 +-
 tests/qemu-iotests/110           |  11 +-
 tests/qemu-iotests/110.out       |   4 +-
 tests/qemu-iotests/111           |   3 +-
 tests/qemu-iotests/112           |  37 +++----
 tests/qemu-iotests/114           |   2 +
 tests/qemu-iotests/115           |   3 +-
 tests/qemu-iotests/121           |   9 +-
 tests/qemu-iotests/122           |   6 +-
 tests/qemu-iotests/123           |   4 +-
 tests/qemu-iotests/125           |   2 +-
 tests/qemu-iotests/137           |  17 +++-
 tests/qemu-iotests/137.out       |   6 +-
 tests/qemu-iotests/138           |   8 +-
 tests/qemu-iotests/141           |   4 +-
 tests/qemu-iotests/142           |   2 +-
 tests/qemu-iotests/144           |   4 +-
 tests/qemu-iotests/153           |  12 +--
 tests/qemu-iotests/156           |  10 +-
 tests/qemu-iotests/159           |   2 +-
 tests/qemu-iotests/160           |   3 +-
 tests/qemu-iotests/161           |   4 +-
 tests/qemu-iotests/170           |   2 +-
 tests/qemu-iotests/172           |   6 +-
 tests/qemu-iotests/173           |   3 +-
 tests/qemu-iotests/174           |   2 +-
 tests/qemu-iotests/175           |   2 +-
 tests/qemu-iotests/176           |   7 +-
 tests/qemu-iotests/178           |   6 +-
 tests/qemu-iotests/182           |   2 +-
 tests/qemu-iotests/183           |   2 +-
 tests/qemu-iotests/185           |   4 +-
 tests/qemu-iotests/187           |   6 +-
 tests/qemu-iotests/190           |   4 +-
 tests/qemu-iotests/191           |  11 +-
 tests/qemu-iotests/195           |   2 +-
 tests/qemu-iotests/197           |   6 +-
 tests/qemu-iotests/198           |   6 +-
 tests/qemu-iotests/198.out       |   4 +-
 tests/qemu-iotests/200           |   7 +-
 tests/qemu-iotests/201           |   6 +-
 tests/qemu-iotests/214           |  46 ++++++++-
 tests/qemu-iotests/214.out       |  14 +++
 tests/qemu-iotests/215           |   6 +-
 tests/qemu-iotests/217           |   3 +-
 tests/qemu-iotests/220           |   5 +-
 tests/qemu-iotests/225           |   2 +-
 tests/qemu-iotests/229           |   3 +-
 tests/qemu-iotests/232           |   4 +-
 tests/qemu-iotests/235           |   2 +-
 tests/qemu-iotests/243           |  10 +-
 tests/qemu-iotests/244           |  15 +--
 tests/qemu-iotests/247           |   4 +-
 tests/qemu-iotests/249           |   4 +-
 tests/qemu-iotests/250           |   5 +-
 tests/qemu-iotests/252           |   2 +-
 tests/qemu-iotests/261           |   5 +-
 tests/qemu-iotests/265           |   2 +-
 tests/qemu-iotests/267           |  17 ++--
 tests/qemu-iotests/273           |   3 +
 tests/qemu-iotests/check         |   6 +-
 tests/qemu-iotests/common.filter |  47 ++++++++-
 tests/qemu-iotests/common.rc     |  63 ++++++++++--
 tests/qemu-iotests/iotests.py    |  18 ++--
 tests/qemu-iotests/qcow2.py      |  23 ++++-
 131 files changed, 1139 insertions(+), 552 deletions(-)
 create mode 100644 block/filter-compress.c

--=20
2.24.1


