Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B8C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1485F2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1485F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTHm-0000y9-3R
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRy4-0002mz-Lv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRy3-0006SV-AR
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hbRy3-0006RL-3m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C6A130860C0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 15:48:41 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C922C5C6D6
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 15:48:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:28 -0500
Message-Id: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 13 Jun 2019 15:48:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/9] NBD patches through 2019-06-13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 785a602eae7ad97076b9794ebaba072ad4a9f7=
4f:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190613-pull-req=
uest' into staging (2019-06-13 13:25:25 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-06-13

for you to fetch changes up to 611ae1d71647c58b23dc2c116a946884ce30abf8:

  block/nbd: merge NBDClientSession struct back to BDRVNBDState (2019-06-=
13 10:00:42 -0500)

----------------------------------------------------------------
nbd patches for 2019-06-13

- add 'qemu-nbd --pid-file'
- NBD-related iotest improvements
- NBD code refactoring in preparation for reconnect

----------------------------------------------------------------
Eric Blake (1):
      nbd/server: Nicer spelling of max BLOCK_STATUS reply length

Max Reitz (5):
      qemu-nbd: Add --pid-file option
      iotests.py: Add qemu_nbd_early_pipe()
      qemu-nbd: Do not close stderr
      iotests: Use qemu-nbd's --pid-file
      iotests: Let 233 run concurrently

Vladimir Sementsov-Ogievskiy (3):
      block/nbd-client: drop stale logout
      block/nbd: merge nbd-client.* to nbd.c
      block/nbd: merge NBDClientSession struct back to BDRVNBDState

 qemu-nbd.texi                 |    2 +
 block/nbd-client.h            |   71 ---
 block/nbd-client.c            | 1226 -----------------------------------=
----
 block/nbd.c                   | 1282 +++++++++++++++++++++++++++++++++++=
++++--
 nbd/server.c                  |   13 +-
 qemu-nbd.c                    |   14 +-
 tests/qemu-iotests/common.nbd |  100 ++--
 tests/qemu-iotests/common.rc  |    6 +-
 block/Makefile.objs           |    2 +-
 block/trace-events            |    4 +-
 tests/qemu-iotests/147        |    4 +-
 tests/qemu-iotests/233        |    1 -
 tests/qemu-iotests/iotests.py |    9 +-
 13 files changed, 1329 insertions(+), 1405 deletions(-)
 delete mode 100644 block/nbd-client.h
 delete mode 100644 block/nbd-client.c

--=20
2.20.1


