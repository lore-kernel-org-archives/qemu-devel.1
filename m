Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF46C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE5D205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE5D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQMz-0000M6-4G
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfQGK-0002n5-2t
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfQGI-0006EE-LO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfQGD-0005e0-TH; Mon, 24 Jun 2019 10:47:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0766C6EB82;
 Mon, 24 Jun 2019 14:47:44 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C49A1001B02;
 Mon, 24 Jun 2019 14:47:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 16:47:32 +0200
Message-Id: <20190624144740.5338-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 24 Jun 2019 14:47:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 0/8] Block patches
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

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeac=
de:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-=
2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-06-24

for you to fetch changes up to ab5d4a30f7f3803ca5106b370969c1b7b54136f8:

  iotests: Fix 205 for concurrent runs (2019-06-24 16:01:40 +0200)

----------------------------------------------------------------
Block patches:
- The SSH block driver now uses libssh instead of libssh2
- The VMDK block driver gets read-only support for the seSparse
  subformat
- Various fixes

---

v2:
- Squashed Pino's fix for pre-0.8 libssh into the libssh patch=20

----------------------------------------------------------------
Anton Nefedov (1):
  iotest 134: test cluster-misaligned encrypted write

Klaus Birkelund Jensen (1):
  nvme: do not advertise support for unsupported arbitration mechanism

Max Reitz (1):
  iotests: Fix 205 for concurrent runs

Pino Toscano (1):
  ssh: switch from libssh2 to libssh

Sam Eiderman (3):
  vmdk: Fix comment regarding max l1_size coverage
  vmdk: Reduce the max bound for L1 table size
  vmdk: Add read-only support for seSparse snapshots

Vladimir Sementsov-Ogievskiy (1):
  blockdev: enable non-root nodes for transaction drive-backup source

 configure                                     |  65 +-
 block/Makefile.objs                           |   6 +-
 block/ssh.c                                   | 652 ++++++++++--------
 block/vmdk.c                                  | 372 +++++++++-
 blockdev.c                                    |   2 +-
 hw/block/nvme.c                               |   1 -
 .travis.yml                                   |   4 +-
 block/trace-events                            |  14 +-
 docs/qemu-block-drivers.texi                  |   2 +-
 .../dockerfiles/debian-win32-cross.docker     |   1 -
 .../dockerfiles/debian-win64-cross.docker     |   1 -
 tests/docker/dockerfiles/fedora.docker        |   4 +-
 tests/docker/dockerfiles/ubuntu.docker        |   2 +-
 tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
 tests/qemu-iotests/059.out                    |   2 +-
 tests/qemu-iotests/134                        |   9 +
 tests/qemu-iotests/134.out                    |  10 +
 tests/qemu-iotests/205                        |   2 +-
 tests/qemu-iotests/207                        |  54 +-
 tests/qemu-iotests/207.out                    |   2 +-
 20 files changed, 823 insertions(+), 384 deletions(-)

--=20
2.21.0


