Received: from eggs.gnu.org ([2001:4830:134:3::10]:44921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fEJmV-00025U-Jn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fEJmR-0000ft-LX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:20:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fEJmR-0000dt-G9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:20:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3326681B006D
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 19:20:34 +0000 (UTC)
From: Bandan <bsd@redhat.com>
Date: Thu,  3 May 2018 15:20:26 -0400
Message-Id: <20180503192028.14353-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Minor MTP fixes
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

Minor MTP fixes. The first patch adds some checks/asserts for issues
reported by Coverity and the second fixes a bug where the readonly flag
is ignored if "desc" is specified.

Bandan Das (2):
  usb-mtp: Add some NULL checks for issues pointed out by coverity
  usb-mtp: Unconditionally check for the readonly bit

 hw/usb/dev-mtp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.11.0
