Received: from eggs.gnu.org ([2001:4830:134:3::10]:39392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fyOw4-0005FS-G7
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fyOw1-0001Zo-8b
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:09:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fyOw1-0001Qe-1i
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F5B26A81
	for <qemu-devel@nongnu.org>; Fri,  7 Sep 2018 22:09:00 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri,  7 Sep 2018 18:08:48 -0400
Message-Id: <20180907220851.9658-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Misc usb-mtp fixes
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

v2:
Same as v1 but with another minor cleanup
patch. The write buffer breakup is still WIP.

A documentation fix and changes to return the
right error code on write failures.

Bandan (2):
  usb-mtp: fix error conditions for write operation
  doc: replace x-root with rootdir for usb-mtp

Bandan Das (1):
  usb-mtp: reset ObjectInfo dataset size on cleanup

 hw/usb/dev-mtp.c          | 9 ++++++---
 qemu-doc.texi             | 2 +-
 scripts/device-crash-test | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.14.4
