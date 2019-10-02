Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1EAC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB1921920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB1921920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhNH-0007r6-FW
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFhLF-0005iz-Lt
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFhLE-0001xS-Gv
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:19:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFhL8-0001qL-W8; Wed, 02 Oct 2019 12:18:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3ECAD10C0928;
 Wed,  2 Oct 2019 16:18:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 365525D713;
 Wed,  2 Oct 2019 16:18:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL v2 0/4] Block layer patches
Date: Wed,  2 Oct 2019 18:18:47 +0200
Message-Id: <20191002161851.1016-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 02 Oct 2019 16:18:58 +0000 (UTC)
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3=
dc:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-10-01' into staging (2019-10-01 13:13:38 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 352492e5541e293ea8117412ffd171ce1c7ac15d:

  iotests: Remove Python 2 compatibility code (2019-10-02 16:47:23 +0200)

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

 block/snapshot.c                 |  26 ++++--
 tests/qemu-iotests/044           |   3 -
 tests/qemu-iotests/163           |   3 -
 tests/qemu-iotests/267           | 168 +++++++++++++++++++++++++++++++++=
+++
 tests/qemu-iotests/267.out       | 182 +++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/check         |  13 ++-
 tests/qemu-iotests/common.filter |  11 ++-
 tests/qemu-iotests/group         |   1 +
 tests/qemu-iotests/iotests.py    |  13 +--
 9 files changed, 392 insertions(+), 28 deletions(-)
 create mode 100755 tests/qemu-iotests/267
 create mode 100644 tests/qemu-iotests/267.out

