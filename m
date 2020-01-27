Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E597C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAF120CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZwh55E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8dh-0003rK-2L
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cN-000212-Py
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cM-0002hY-Ot
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cM-0002gt-Kx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pi2EU31C8H+vfyZVQ+qc45uTwHzdzeOIKGXPNAdTcZ0=;
 b=DZwh55E4rNs1aH9IHLfhgzxfjw4pJUKeINLYQEFoopFQ/YDdeFOy5pC2gaOlwN0mQRKBvT
 KWF7vdhfwUZeoV5BJ/SjPMXpvXMOV8ellBTV1ohphgSfZ0oXweQRbUavWpM8nqqNgJqRvn
 NrUf47J3QR2VhVi6Jl1qyxUcuq1Cfoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-i529NoPoMp2V2tjqt6viEA-1; Mon, 27 Jan 2020 12:56:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F4BE100551A;
 Mon, 27 Jan 2020 17:56:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8494E863C0;
 Mon, 27 Jan 2020 17:56:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/13] Block layer patches
Date: Mon, 27 Jan 2020 18:55:46 +0100
Message-Id: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: i529NoPoMp2V2tjqt6viEA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into st=
aging (2020-01-27 13:02:36 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 5fbf1d56c24018772e900a40a0955175ff82f35c:

  iscsi: Don't access non-existent scsi_lba_status_descriptor (2020-01-27 1=
7:19:53 +0100)

----------------------------------------------------------------
Block layer patches:

- iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
- AioContext fixes in QMP commands for backup and bitmaps
- iotests fixes

----------------------------------------------------------------
Eiichi Tsukata (1):
      block/backup: fix memory leak in bdrv_backup_top_append()

Felipe Franciosi (1):
      iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)

Kevin Wolf (1):
      iscsi: Don't access non-existent scsi_lba_status_descriptor

Max Reitz (1):
      iotests.py: Let wait_migration wait even more

Sergio Lopez (8):
      blockdev: fix coding style issues in drive_backup_prepare
      blockdev: unify qmp_drive_backup and drive-backup transaction paths
      blockdev: unify qmp_blockdev_backup and blockdev-backup transaction p=
aths
      blockdev: honor bdrv_try_set_aio_context() context requirements
      block/backup-top: Don't acquire context while dropping top
      blockdev: Acquire AioContext on dirty bitmap functions
      blockdev: Return bs to the proper context on snapshot abort
      iotests: Test handling of AioContexts with some blockdev actions

Thomas Huth (1):
      iotests: Add more "skip_if_unsupported" statements to the python test=
s

 block/backup-top.c            |   7 +-
 block/backup.c                |   3 +
 block/iscsi.c                 |   7 +-
 blockdev.c                    | 393 +++++++++++++++++++++++---------------=
----
 tests/qemu-iotests/iotests.py |   6 +-
 tests/qemu-iotests/030        |   4 +-
 tests/qemu-iotests/040        |   2 +
 tests/qemu-iotests/041        |  39 +----
 tests/qemu-iotests/141.out    |   2 +
 tests/qemu-iotests/185.out    |   2 +
 tests/qemu-iotests/219        |   7 +-
 tests/qemu-iotests/219.out    |   8 +
 tests/qemu-iotests/234        |   8 +-
 tests/qemu-iotests/245        |   2 +
 tests/qemu-iotests/262        |   4 +-
 tests/qemu-iotests/280        |   2 +-
 tests/qemu-iotests/281        | 247 ++++++++++++++++++++++++++
 tests/qemu-iotests/281.out    |   5 +
 tests/qemu-iotests/group      |   1 +
 19 files changed, 510 insertions(+), 239 deletions(-)
 create mode 100755 tests/qemu-iotests/281
 create mode 100644 tests/qemu-iotests/281.out


