Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54308C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD962339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD962339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i592U-0006Vd-Pr
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yY-00020o-1c
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58yW-00067F-I7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yS-000652-V1; Tue, 03 Sep 2019 09:35:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E913018927A6;
 Tue,  3 Sep 2019 13:35:55 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8EC1001947;
 Tue,  3 Sep 2019 13:35:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:37 +0200
Message-Id: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 13:35:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/16] Block patches
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 54b89db5309d5fa8b5d3fe5fe56f81704e2f97=
06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-09-03 09:43:26 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-09-03

for you to fetch changes up to 755c5fe79d88717600356d3edf04835bba43dcb6:

  iotests: Unify cache mode quoting (2019-09-03 14:56:06 +0200)

----------------------------------------------------------------
Block patches:
- qemu-io now accepts a file to read a write pattern from
- Ensure that raw files have their first block allocated so we can probe
  the O_DIRECT alignment if necessary
- Various fixes

----------------------------------------------------------------
v2:
- Added a patch we already had on the list to keep the iotests passing
  when $DISPLAY is not set

----------------------------------------------------------------
Denis Plotnikov (1):
  qemu-io: add pattern file for write command

Max Reitz (8):
  iotests: Fix _filter_img_create()
  vmdk: Use bdrv_dirname() for relative extent paths
  iotests: Keep testing broken relative extent paths
  vmdk: Reject invalid compressed writes
  iotests: Disable broken streamOptimized tests
  iotests: Disable 110 for vmdk.twoGbMaxExtentSparse
  iotests: Disable 126 for flat vmdk subformats
  iotests: Add -display none to the qemu options

Nir Soffer (3):
  block: posix: Always allocate the first block
  iotests: Test allocate_first_block() with O_DIRECT
  iotests: Unify cache mode quoting

Stefan Hajnoczi (1):
  file-posix: fix request_alignment typo

Thomas Huth (2):
  iotests: Check for enabled drivers before testing them
  tests/check-block: Skip iotests when sanitizers are enabled

Vladimir Sementsov-Ogievskiy (1):
  block: fix permission update in bdrv_replace_node

 block.c                                       |  5 +-
 block/file-posix.c                            | 53 +++++++++-
 block/vmdk.c                                  | 64 ++++++++----
 qemu-io-cmds.c                                | 99 +++++++++++++++++--
 tests/check-block.sh                          |  5 +
 tests/qemu-iotests/002                        |  1 +
 tests/qemu-iotests/003                        |  1 +
 tests/qemu-iotests/005                        |  3 +-
 tests/qemu-iotests/009                        |  1 +
 tests/qemu-iotests/010                        |  1 +
 tests/qemu-iotests/011                        |  1 +
 tests/qemu-iotests/017                        |  3 +-
 tests/qemu-iotests/018                        |  3 +-
 tests/qemu-iotests/019                        |  3 +-
 tests/qemu-iotests/020                        |  3 +-
 tests/qemu-iotests/026                        |  4 +-
 tests/qemu-iotests/027                        |  1 +
 tests/qemu-iotests/032                        |  1 +
 tests/qemu-iotests/033                        |  1 +
 tests/qemu-iotests/034                        |  3 +-
 tests/qemu-iotests/037                        |  3 +-
 tests/qemu-iotests/039                        |  4 +-
 tests/qemu-iotests/052                        |  2 +-
 tests/qemu-iotests/059                        | 34 ++++++-
 tests/qemu-iotests/059.out                    | 26 +++--
 tests/qemu-iotests/063                        |  3 +-
 tests/qemu-iotests/071                        |  1 +
 tests/qemu-iotests/072                        |  1 +
 tests/qemu-iotests/081                        |  4 +-
 tests/qemu-iotests/091                        |  4 +-
 tests/qemu-iotests/099                        |  1 +
 tests/qemu-iotests/105                        |  3 +-
 tests/qemu-iotests/110                        |  3 +-
 tests/qemu-iotests/120                        |  1 +
 tests/qemu-iotests/126                        |  2 +
 tests/qemu-iotests/{150.out =3D> 150.out.qcow2} |  0
 tests/qemu-iotests/150.out.raw                | 12 +++
 tests/qemu-iotests/162                        |  4 +-
 tests/qemu-iotests/175                        | 47 +++++++--
 tests/qemu-iotests/175.out                    | 16 ++-
 tests/qemu-iotests/178.out.qcow2              |  4 +-
 tests/qemu-iotests/184                        |  1 +
 tests/qemu-iotests/186                        |  1 +
 tests/qemu-iotests/197                        |  1 +
 tests/qemu-iotests/215                        |  1 +
 tests/qemu-iotests/221.out                    | 12 ++-
 tests/qemu-iotests/251                        |  1 +
 tests/qemu-iotests/253.out                    | 12 ++-
 tests/qemu-iotests/check                      |  6 +-
 tests/qemu-iotests/common.filter              |  4 +-
 tests/qemu-iotests/common.rc                  | 14 +++
 51 files changed, 394 insertions(+), 90 deletions(-)
 rename tests/qemu-iotests/{150.out =3D> 150.out.qcow2} (100%)
 create mode 100644 tests/qemu-iotests/150.out.raw

--=20
2.21.0


