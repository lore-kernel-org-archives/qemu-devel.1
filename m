Received: from eggs.gnu.org ([2001:4830:134:3::10]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICY0-0004uc-A4
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICXv-0000HQ-SP
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dICXv-0000Gb-NC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3E5DC83E
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 11:21:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 13:21:02 +0200
Message-Id: <20170606112105.13331-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] reset queue in ps2_reset_keyboard
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

  Hi,

Patches 1+2 are small cleanups and refactorings,
patch 3 is the actual fix.

cheers,
  Gerd

Gerd Hoffmann (3):
  ps2: add and use PS2State typedef
  ps2: add ps2_reset_queue
  ps2: reset queue in ps2_reset_keyboard

 include/hw/input/ps2.h  |  4 ++--
 include/qemu/typedefs.h |  1 +
 hw/input/ps2.c          | 28 ++++++++++++++++------------
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.9.3
