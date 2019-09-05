Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA0C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 21:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBA4206CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 21:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBA4206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5z84-0002xy-4Y
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 17:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5z6Q-0001ca-CN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5z6N-00024u-KE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i5z6N-000240-Et
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4585210C6973
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 21:15:34 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 112AF60A97
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 21:15:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 16:15:13 -0500
Message-Id: <20190905211522.2824-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 05 Sep 2019 21:15:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 0/9] NBD patches through 2019-09-05
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

The following changes since commit eac2f39602e0423adf56be410c9a22c31fec9a=
81:

  target/arm: Inline gen_bx_im into callers (2019-09-05 13:23:04 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-09-05-v2

for you to fetch changes up to b491dbb7f8e09ef864770c205a3b5bce6c5c1881:

  nbd: Implement server use of NBD FAST_ZERO (2019-09-05 16:04:53 -0500)

v2 pull request: fix iotests 223 and 233 (only re-sending the patches
that needed tweaking, per this backport-diff):
001/9:[0002] [FC] 'nbd: Advertise multi-conn for shared read-only connect=
ions'
002/9:[----] [--] 'nbd: Use g_autofree in a few places'
003/9:[0008] [FC] 'nbd: Tolerate more errors to structured reply request'
004/9:[----] [--] 'block: workaround for unaligned byte range in fallocat=
e()'
005/9:[----] [--] 'docs: Update preferred NBD device syntax'
006/9:[0002] [FC] 'nbd: Improve per-export flag handling in server'
007/9:[----] [--] 'nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO'
008/9:[----] [--] 'nbd: Implement client use of NBD FAST_ZERO'
009/9:[0004] [FC] 'nbd: Implement server use of NBD FAST_ZERO'

----------------------------------------------------------------
nbd patches for 2019-09-05

- Advertise NBD_FLAG_CAN_MULTI_CONN on readonly images
- Tolerate larger set of server error responses during handshake
- More precision on handling fallocate() failures due to alignment
- Better documentation of NBD connection URIs
- Implement new extension NBD_CMD_FLAG_FAST_ZERO to benefit qemu-img conv=
ert

----------------------------------------------------------------
Andrey Shinkevich (1):
      block: workaround for unaligned byte range in fallocate()

Eric Blake (8):
      nbd: Advertise multi-conn for shared read-only connections
      nbd: Use g_autofree in a few places
      nbd: Tolerate more errors to structured reply request
      docs: Update preferred NBD device syntax
      nbd: Improve per-export flag handling in server
      nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
      nbd: Implement client use of NBD FAST_ZERO
      nbd: Implement server use of NBD FAST_ZERO

 docs/interop/nbd.txt       |  2 ++
 qemu-doc.texi              | 11 ++++--
 include/block/nbd.h        |  6 +++-
 block/io.c                 |  2 +-
 block/file-posix.c         |  7 ++++
 block/nbd.c                | 18 ++++++----
 blockdev-nbd.c             |  3 +-
 nbd/client.c               | 85 ++++++++++++++++++++++------------------=
------
 nbd/common.c               |  5 +++
 nbd/server.c               | 83 +++++++++++++++++++++++++---------------=
----
 qemu-nbd.c                 |  7 ++--
 nbd/trace-events           |  2 +-
 tests/qemu-iotests/223.out |  4 +--
 tests/qemu-iotests/233.out | 10 +++---
 14 files changed, 141 insertions(+), 104 deletions(-)

--=20
2.21.0


