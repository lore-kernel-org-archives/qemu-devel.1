Received: from eggs.gnu.org ([2001:4830:134:3::10]:42489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY4-0006eS-BO
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY1-00063I-5A
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdY0-00060m-W7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:06:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0150F80473
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:06:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:06:48 +0100
Message-Id: <20171117100653.13015-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Ui 20171117 patches
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

The following changes since commit 1fa0f627d03cd0d0755924247cafeb42969016bf:

  Update version for v2.11.0-rc1 release (2017-11-14 18:37:49 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20171117-pull-request

for you to fetch changes up to bcf43cdc178ffbd06d0533b6c54e92640817c9c7:

  sdl2: Fix broken display updating after the window is hidden (2017-11-16 09:57:47 +0100)

----------------------------------------------------------------
sdl2 fixes for 2.11

----------------------------------------------------------------

Jindrich Makovicka (5):
  sdl2: Do not quit the emulator when an auxilliary window is closed
  sdl2: Use the same pointer show/hide logic for absolute and relative
    mode
  sdl2: Fix dead keyboard after fullsceen
  sdl2: Do not leave grab when fullscreen
  sdl2: Fix broken display updating after the window is hidden

 ui/sdl2.c | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

-- 
2.9.3
