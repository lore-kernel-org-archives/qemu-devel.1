Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl2-0002tT-Lo
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMkz-0006OV-GJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1dsMkz-0006Hu-Ad
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D0BF5AFED
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:32:07 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 14 Sep 2017 01:31:43 -0400
Message-Id: <20170914053148.2512-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Initial write support for MTP objects
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

These patches implement write support for Qemu's MTP
emulation. Simple tests such as delete/move/edit/copy work ok.
Current issues/TODO:

 - File transfers > 4GB has not been tested and will probably not work
 - Some (or most) MTP clients don't advertise hidden files and folders (names
 that start with a .) even though iiuc Qemu MTP does advertise these files.
 This can confuse certain applications such as text editors or git.
 - Also related, file editors typically run fsync when saving. Depending on
 the MTP client, it may choose not to implement it (such as simple-mtpfs that runs
 on top of fuse).
 - Needs more testing :)


Bandan Das (5):
  usb-mtp: Add one more argument when building results
  usb-mtp: print parent path in IN_IGNORED trace fn
  usb-mtp: Support delete of mtp objects
  usb-mtp: Introduce write support for MTP objects
  usb-mtp: Advertise SendObjectInfo for write support

 hw/usb/dev-mtp.c | 449 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 421 insertions(+), 28 deletions(-)

-- 
2.9.4
