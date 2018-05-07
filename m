Received: from eggs.gnu.org ([2001:4830:134:3::10]:42771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFchZ-0002jI-Qw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFchY-00059c-AB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFchY-00057Y-5Z
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A066B40201A5
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 09:44:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:44:45 +0200
Message-Id: <20180507094448.32386-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Usb 20180507 patches
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

The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180507-pull-request

for you to fetch changes up to 3280ea8edede3814553aa19fa27a58daedd48ad9:

  usb-host: skip open on pending postload bh (2018-05-07 11:10:42 +0200)

----------------------------------------------------------------
usb: fixes for mtp and host.

----------------------------------------------------------------

Bandan Das (2):
  usb-mtp: Add some NULL checks for issues pointed out by coverity
  usb-mtp: Unconditionally check for the readonly bit

Gerd Hoffmann (1):
  usb-host: skip open on pending postload bh

 hw/usb/dev-mtp.c     | 15 ++++++++-------
 hw/usb/host-libusb.c |  7 +++++++
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.9.3
