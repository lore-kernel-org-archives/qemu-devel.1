Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D74C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9107420659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9107420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAP9-0006am-SM
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hi8hN-00046e-KL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hi8hM-0006z4-FH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:39:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hi8hK-0006um-2a; Mon, 01 Jul 2019 22:39:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 875F130C5859;
 Tue,  2 Jul 2019 02:39:07 +0000 (UTC)
Received: from localhost (ovpn-204-243.brq.redhat.com [10.40.204.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2197718984;
 Tue,  2 Jul 2019 02:39:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  2 Jul 2019 04:39:01 +0200
Message-Id: <20190702023905.32470-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 02:39:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] Block patches for rc0
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

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-07-02

for you to fetch changes up to c624b015bf14fe01f1e6452a36e63b3ea1ae4998:

  block/stream: introduce a bottom node (2019-07-02 03:53:05 +0200)

----------------------------------------------------------------
Block patches for 4.1-rc0:
- The stream job no longer relies on a fixed base node
- The rbd block driver can now accomodate growing formats like qcow2

----------------------------------------------------------------
Andrey Shinkevich (3):
  block: include base when checking image chain for block allocation
  block/stream: refactor stream_run: drop goto
  block/stream: introduce a bottom node

Stefano Garzarella (1):
  block/rbd: increase dynamically the image size

 include/block/block.h  |  3 ++-
 block/commit.c         |  2 +-
 block/io.c             | 21 +++++++++++-----
 block/mirror.c         |  2 +-
 block/qcow2.c          |  3 ++-
 block/rbd.c            | 42 ++++++++++++++++++++++++++++---
 block/replication.c    |  2 +-
 block/stream.c         | 56 ++++++++++++++++++++----------------------
 qemu-img.c             |  2 +-
 tests/qemu-iotests/245 |  4 +--
 10 files changed, 91 insertions(+), 46 deletions(-)

--=20
2.21.0


