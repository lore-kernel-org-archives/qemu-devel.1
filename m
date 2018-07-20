Received: from eggs.gnu.org ([2001:4830:134:3::10]:42721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8g-0005DF-FW
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8d-0005n0-AB
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fgd8d-0005lH-4P
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3DD981A4EB7
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 21:40:33 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri, 20 Jul 2018 17:40:15 -0400
Message-Id: <20180720214020.22897-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] usb-mtp write fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Patch 1 adds support for canceling an ongoing transaction.
2,3 and 4 fix writes for large transfers. For > 4G file transfers,
the logic has been modified to check for the end of the data phase
by checking for a short packet. Patch 5 renames x-root to a more
meaningful rootdir.

Bandan Das (5):
  dev-mtp: add support for canceling transaction
  dev-mtp: fix buffer allocation for writing file contents
  dev-mtp: retry write for incomplete transfers
  dev-mtp: Add support for > 4GB file transfers
  dev-mtp: rename x-root to rootdir

 hw/usb/dev-mtp.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 14 deletions(-)

-- 
2.14.4
