Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAAC227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg1HVrOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAAC227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzZo-0008MW-K4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXj-000673-CO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXh-0005SQ-9o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXh-0005Nd-3j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/zFuXFMxeF0UGEff9HNiT2iRb423l8lbOk8MdAb+k0Y=;
 b=Xg1HVrOfTzUqjo375fNKbsge6BrJg8HFqeTv82p7wyrFfGZT2iAp2b6WJqPBF2PS0WWfd2
 RMsmhN+H334tEglgw+wnqkurfo+wxdh3RfUQVzw7Nxkur6FBBLSLO3oU46v65/YTRgnXhv
 kd70yI0yA0Gm8I9AHaJwo+FOvvyEAfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-ZRI7mOloM8695t26pm21SQ-1; Thu, 19 Dec 2019 12:24:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954BFDB61;
 Thu, 19 Dec 2019 17:24:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 987E563B8A;
 Thu, 19 Dec 2019 17:24:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/30] Block layer patches
Date: Thu, 19 Dec 2019 18:24:11 +0100
Message-Id: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZRI7mOloM8695t26pm21SQ-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681=
:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-=
12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to f62f08ab7a9d902da70078992248ec5c98f652ad:

  iotests: Test external snapshot with VM state (2019-12-19 18:04:25 +0100)

----------------------------------------------------------------
Block layer patches:

- qemu-img: fix info --backing-chain --image-opts
- Error out on image creation with conflicting size options
- Fix external snapshot with VM state
- hmp: Allow using qdev ID for qemu-io command
- Misc code cleanup
- Many iotests improvements

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Use offset_into_cluster()

Daniel P. Berrang=C3=A9 (1):
      qapi: better document NVMe blockdev @device parameter

Kevin Wolf (19):
      block: Error out on image creation with conflicting size options
      blockjob: Fix error message for negative speed
      qcow2: Declare BDRV_REQ_NO_FALLBACK supported
      iotests: Add qemu_io_log()
      iotests: Fix timeout in run_job()
      iotests: Support job-complete in run_job()
      iotests: Create VM.blockdev_create()
      iotests: 255: Drop blockdev_create()
      iotests: 206: Convert to VM.blockdev_create()
      iotests: 210: Convert to VM.blockdev_create()
      iotests: 212: Convert to VM.blockdev_create()
      iotests: 213: Convert to VM.blockdev_create()
      iotests: 237: Convert to VM.blockdev_create()
      iotests: 266: Convert to VM.blockdev_create()
      iotests: 207: Remove duplication with VM.blockdev_create()
      iotests: 211: Remove duplication with VM.blockdev_create()
      block: Activate recursively even for already active nodes
      hmp: Allow using qdev ID for qemu-io command
      iotests: Test external snapshot with VM state

Max Reitz (2):
      iotests/273: Filter format-specific information
      iotests: Fix IMGOPTSSYNTAX for nbd

Stefan Hajnoczi (1):
      qemu-img: fix info --backing-chain --image-opts

Thomas Huth (4):
      iotests: Provide a function for checking the creation of huge files
      iotests: Skip test 060 if it is not possible to create large files
      iotests: Skip test 079 if it is not possible to create large files
      iotests: Add more "_require_drivers" checks to the shell-based tests

Tuguoyi (1):
      qcow2: Move error check of local_err near its assignment

Vladimir Sementsov-Ogievskiy (1):
      MAINTAINERS: fix qcow2-bitmap.c under Dirty Bitmaps header

 qapi/block-core.json          |   6 +-
 block.c                       |  60 ++++++-----
 block/qcow2.c                 |  21 ++--
 blockjob.c                    |   3 +-
 monitor/hmp-cmds.c            |  28 +++--
 qemu-img.c                    |   3 +
 MAINTAINERS                   |   6 +-
 hmp-commands.hx               |   8 +-
 tests/qemu-iotests/005        |   5 +-
 tests/qemu-iotests/030        |   4 +-
 tests/qemu-iotests/049        |   5 +
 tests/qemu-iotests/049.out    |   5 +
 tests/qemu-iotests/051        |   1 +
 tests/qemu-iotests/060        |   3 +
 tests/qemu-iotests/079        |   3 +
 tests/qemu-iotests/206        | 232 ++++++++++++++++++++------------------=
----
 tests/qemu-iotests/207        |   8 +-
 tests/qemu-iotests/210        |  81 +++++++--------
 tests/qemu-iotests/211        |  12 +--
 tests/qemu-iotests/212        | 101 +++++++++---------
 tests/qemu-iotests/213        | 113 ++++++++++----------
 tests/qemu-iotests/220        |   6 +-
 tests/qemu-iotests/237        | 139 ++++++++++++-------------
 tests/qemu-iotests/255        |  10 --
 tests/qemu-iotests/266        |  69 ++++++-------
 tests/qemu-iotests/266.out    |  14 +++
 tests/qemu-iotests/267        |   1 +
 tests/qemu-iotests/273        |   3 +-
 tests/qemu-iotests/273.out    |  27 -----
 tests/qemu-iotests/279        |  57 +++++++++++
 tests/qemu-iotests/279.out    |  35 +++++++
 tests/qemu-iotests/280        |  83 +++++++++++++++
 tests/qemu-iotests/280.out    |  50 +++++++++
 tests/qemu-iotests/common.rc  |  13 ++-
 tests/qemu-iotests/group      |   2 +
 tests/qemu-iotests/iotests.py |  25 ++++-
 36 files changed, 724 insertions(+), 518 deletions(-)
 create mode 100755 tests/qemu-iotests/279
 create mode 100644 tests/qemu-iotests/279.out
 create mode 100755 tests/qemu-iotests/280
 create mode 100644 tests/qemu-iotests/280.out


