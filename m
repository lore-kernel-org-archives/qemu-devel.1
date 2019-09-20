Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC4E20717
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC4E20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLtO-00024j-Bf
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iBLeh-0007de-RP
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iBLef-0008BA-Nr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iBLeb-00088l-SV; Fri, 20 Sep 2019 12:21:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79ABC369D3;
 Fri, 20 Sep 2019 16:21:04 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-81.ams2.redhat.com
 [10.36.117.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 739B1646A1;
 Fri, 20 Sep 2019 16:21:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/4] Block layer patches
Date: Fri, 20 Sep 2019 18:20:54 +0200
Message-Id: <20190920162058.29743-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 20 Sep 2019 16:21:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 521db80318d6c749a6f6c5a65a68397af9e3ef=
16:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-09-=
16' into staging (2019-09-16 15:25:55 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to d2c8c09fca9210d0f2399c8d570086a4a66bd22e:

  iotests: Remove Python 2 compatibility code (2019-09-20 17:58:51 +0200)

----------------------------------------------------------------
Block layer patches:

- Fix internal snapshots with typical -blockdev setups
- iotests: Require Python 3.6 or later

----------------------------------------------------------------
Kevin Wolf (4):
      block/snapshot: Restrict set of snapshot nodes
      iotests: Test internal snapshots with -blockdev
      iotests: Require Python 3.6 or later
      iotests: Remove Python 2 compatibility code

 block/snapshot.c                         |  26 +++--
 tests/qemu-iotests/044                   |   3 -
 tests/qemu-iotests/163                   |   3 -
 tests/qemu-iotests/267                   | 168 +++++++++++++++++++++++++=
+++
 tests/qemu-iotests/267.out               | 182 +++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/check                 |  13 ++-
 tests/qemu-iotests/common.filter         |   5 +-
 tests/qemu-iotests/group                 |   1 +
 tests/qemu-iotests/iotests.py            |  13 +--
 tests/qemu-iotests/nbd-fault-injector.py |   7 +-
 10 files changed, 389 insertions(+), 32 deletions(-)
 create mode 100755 tests/qemu-iotests/267
 create mode 100644 tests/qemu-iotests/267.out

