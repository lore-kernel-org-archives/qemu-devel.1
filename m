Received: from eggs.gnu.org ([2001:4830:134:3::10]:60011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d8naw-0002rE-7z
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d8nat-00008p-7d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d8nat-00007h-1J
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27040804F3
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:53:21 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 11 May 2017 14:53:12 +0200
Message-Id: <20170511125314.24549-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] usb-hub: clear PORT_STAT_SUSPEND on wakeup
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

Two small usb patches. Patch 2 fixes a problem with xhci on Windows,
patch 1 addresses a minor code issue I found when debugging it.

Ladi Prosek (2):
      xhci: fix logging
      usb-hub: clear PORT_STAT_SUSPEND on wakeup

 hw/usb/dev-hub.c  | 1 +
 hw/usb/hcd-xhci.c | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)
