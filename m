Received: from eggs.gnu.org ([2001:4830:134:3::10]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fvouK-0006Bv-TA
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fvouG-0003ZL-MY
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fvouG-0003Yv-Gb
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 15:16:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08D5D804B4DB
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 19:16:31 +0000 (UTC)
From: Bandan <bsd@redhat.com>
Date: Fri, 31 Aug 2018 15:16:17 -0400
Message-Id: <20180831191619.20275-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Misc usb-mtp fixes
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

A documentation fix and changes to return the
right error code on write failures.

Bandan (2):
  usb-mtp: fix error conditions for write operation
  doc: replace x-root with rootdir for usb-mtp

 hw/usb/dev-mtp.c          | 7 ++++---
 qemu-doc.texi             | 2 +-
 scripts/device-crash-test | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.11.0
