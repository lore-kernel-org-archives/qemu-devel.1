Received: from eggs.gnu.org ([2001:4830:134:3::10]:36854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZOr-0002RC-8k
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZOn-0007eT-AE
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYZOn-0007e7-49
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:31:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E9743C36
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 15:31:40 +0000 (UTC)
Received: from red.redhat.com (ovpn-124-124.rdu2.redhat.com [10.10.124.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4A0860C8A
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 15:31:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon,  8 Jan 2018 09:31:34 -0600
Message-Id: <20180108153137.5195-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] NBD patches through 2018-01-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 799044b6a3a0fc63e1e020e4d9266786a2dc7a0b:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-01-08 13:44:01 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-08

for you to fetch changes up to c4365735a7d38f4355c6f77e6670d3972315f7c2:

  block/nbd: fix segmentation fault when .desc is not null-terminated (2018-01-08 09:12:23 -0600)

Careful readers may note that I'm abondoning my earlier pull
request from 20 Dec:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04517.html
This pull request includes the first two patches from that one,
but the second half of that request has a v2 posted by Vladimir,
which I'm letting bake a bit longer rather than including today.

----------------------------------------------------------------
nbd patches for 2018-01-08

- Eric Blake: 0/2 Optimize sparse reads over NBD
- Murilo Opsfelder Araujo: block/nbd: fix segmentation fault when .desc is not null-terminated

----------------------------------------------------------------
Eric Blake (2):
      nbd/server: Implement sparse reads atop structured reply
      nbd/server: Optimize final chunk of sparse read

Murilo Opsfelder Araujo (1):
      block/nbd: fix segmentation fault when .desc is not null-terminated

 block/nbd.c      |  1 +
 nbd/server.c     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 nbd/trace-events |  1 +
 3 files changed, 78 insertions(+), 3 deletions(-)

-- 
2.14.3
