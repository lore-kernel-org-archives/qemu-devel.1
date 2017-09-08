Received: from eggs.gnu.org ([2001:4830:134:3::10]:45406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dqHD1-0000t9-CO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dqHCw-0007xJ-VR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dqHCw-0007wI-Pa
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:12:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7BC880460
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:12:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Sep 2017 13:12:15 +0200
Message-Id: <20170908111217.21985-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] usb-host: cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



Gerd Hoffmann (2):
  usb: drop HOST_USB
  usb: only build usb-host with CONFIG_USB=y

 configure            | 7 -------
 hw/usb/Makefile.objs | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.9.3
