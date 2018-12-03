Received: from eggs.gnu.org ([2001:4830:134:3::10]:60926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdM-0001s2-Oe
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdL-0004ue-KO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTqdL-0004th-EC
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DCF430842AA
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 15:59:41 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-230.rdu2.redhat.com [10.10.120.230])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9999619C7D
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 15:59:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Dec 2018 09:59:33 -0600
Message-Id: <20181203155936.114526-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] NBD patches for 3.1-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4750e1a888ac3d320607f33b676f299005be98e6:

  Update version for v3.1.0-rc3 release (2018-11-28 17:37:34 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-12-03

for you to fetch changes up to c688e6ca7b41a105241054853d250df64addbf8f:

  nbd/client: Send NBD_CMD_DISC if open fails after connect (2018-11-30 14:13:37 -0600)

----------------------------------------------------------------
nbd patches for 2018-12-03

Improve x-dirty-bitmap handling for experimenting with pull mode
incremental backups.

- Eric Blake: 0/3 NBD dirty bitmap cleanups

----------------------------------------------------------------
Eric Blake (3):
      nbd/server: Advertise all contexts in response to bare LIST
      nbd/client: Make x-dirty-bitmap more reliable
      nbd/client: Send NBD_CMD_DISC if open fails after connect

 block/nbd-client.c | 21 ++++++++++++++++++++-
 nbd/server.c       |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.17.2
