Received: from eggs.gnu.org ([2001:4830:134:3::10]:32891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFiDW-0004L8-K7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFiDQ-0000Y2-Nh
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eFiDQ-0000XE-I2
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7F1B51150
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 15:05:59 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-34.rdu2.redhat.com [10.10.123.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B34D7BCF1
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 15:05:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 17 Nov 2017 09:05:52 -0600
Message-Id: <20171117150556.16947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] NBD patches for 2.11-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit fec035a53fa15c4c8c4e62bfef56a35df4161e38:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171117-pull-request' into staging (2017-11-17 10:18:41 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-11-17

for you to fetch changes up to fed5f8f82056c9f222433c41aeb9fca50c89f297:

  nbd/server: Fix error reporting for bad requests (2017-11-17 08:38:38 -0600)

----------------------------------------------------------------
nbd patches for 2017-11-17

Eric Blake - nbd: Don't crash when server reports NBD_CMD_READ failure
Eric Blake - nbd/client: Use error_prepend() correctly
Eric Blake - nbd/client: Don't hard-disconnect on ESHUTDOWN from server
Eric Blake - nbd/server: Fix error reporting for bad requests

----------------------------------------------------------------
Eric Blake (4):
      nbd: Don't crash when server reports NBD_CMD_READ failure
      nbd/client: Use error_prepend() correctly
      nbd/client: Don't hard-disconnect on ESHUTDOWN from server
      nbd/server: Fix error reporting for bad requests

 block/nbd-client.c |  4 ++--
 nbd/client.c       | 56 +++++++++++++++++++++++++-----------------------------
 nbd/server.c       | 36 ++++++++++++-----------------------
 3 files changed, 40 insertions(+), 56 deletions(-)

-- 
2.13.6
