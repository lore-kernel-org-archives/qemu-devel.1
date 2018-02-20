Received: from eggs.gnu.org ([2001:4830:134:3::10]:41657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9qi-0006Yl-Iq
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo9qe-000886-IV
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:28:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo9qe-00087a-DD
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:28:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A136F4E3
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 15:28:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 16:28:37 +0100
Message-Id: <20180220152843.26464-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Usb 20180220 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit b487e2b2ff6e9fff8a45a9600d6de3a7bf82666a:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2018-02-20 11:52:24 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180220-pull-request

for you to fetch changes up to 18c7310e9982b71d17e76648acfec0be42a57aea:

  usb-mtp: Advertise SendObjectInfo for write support (2018-02-20 16:06:56 +0100)

----------------------------------------------------------------
usb: Add write support to MTP.

----------------------------------------------------------------

Bandan Das (5):
  usb-mtp: Add one more argument when building results
  usb-mtp: print parent path in IN_IGNORED trace fn
  usb-mtp: Support delete of mtp objects
  usb-mtp: Introduce write support for MTP objects
  usb-mtp: Advertise SendObjectInfo for write support

 hw/usb/dev-mtp.c | 467 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 438 insertions(+), 29 deletions(-)

-- 
2.9.3
