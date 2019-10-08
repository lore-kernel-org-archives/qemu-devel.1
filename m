Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2935C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9561520659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9561520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqvF-0002Oy-3p
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHqtT-0000Wc-1b
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHqtR-0003jD-Qd
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHqtN-0003d6-F4; Tue, 08 Oct 2019 10:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5E8EC059758;
 Tue,  8 Oct 2019 14:55:11 +0000 (UTC)
Received: from localhost (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65B4210016EB;
 Tue,  8 Oct 2019 14:55:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Block patches
Date: Tue,  8 Oct 2019 15:55:01 +0100
Message-Id: <20191008145505.3641-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 08 Oct 2019 14:55:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 560009f2c8b57b7cdd31a5693ea86ab369382f=
49:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-10-07 15:40:53 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 4d804b5305ffb4d5fa414c38d4f1bdfb987c8d0b:

  iotests/262: Switch source/dest VM launch order (2019-10-08 14:28:25 +0=
100)

----------------------------------------------------------------
Pull request

This pull request also contains the two commits from the previous pull re=
quest
that was dropped due to a mingw compilation error.  The compilation shoul=
d now
be fixed.

----------------------------------------------------------------

Max Reitz (2):
  block: Skip COR for inactive nodes
  iotests/262: Switch source/dest VM launch order

Sergio Lopez (1):
  virtio-blk: schedule virtio_notify_config to run on main context

Vladimir Sementsov-Ogievskiy (1):
  util/ioc.c: try to reassure Coverity about qemu_iovec_init_extended

 block/io.c                 | 41 +++++++++++++++++++++++++-------------
 hw/block/virtio-blk.c      | 16 ++++++++++++++-
 util/iov.c                 |  5 +++--
 tests/qemu-iotests/262     | 12 +++++------
 tests/qemu-iotests/262.out |  6 +++---
 5 files changed, 54 insertions(+), 26 deletions(-)

--=20
2.21.0


