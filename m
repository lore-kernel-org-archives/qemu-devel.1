Received: from eggs.gnu.org ([2001:4830:134:3::10]:34415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002nf-Kx
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0A-00054W-Tl
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOM0A-000544-NO
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B6FF7DCC9
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:39:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:38 +0200
Message-Id: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Ui and input 20170623 patches
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

The following changes since commit e18a639164e162b3a4f078ab60606cd2f163d934:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170621-pull-request' into staging (2017-06-22 15:09:48 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-and-input-20170623-pull-request

for you to fetch changes up to 6e24ee0c1e4b6c0c9c748acab77ecd113c942a4d:

  ps2: reset queue in ps2_reset_keyboard (2017-06-23 11:51:50 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Alexander Graf (2):
  input: Decrement queue count on kbd delay
  hid: Reset kbd modifiers on reset

Gerd Hoffmann (5):
  keymaps: add tracing
  sdl2: add assert to make coverity happy
  ps2: add and use PS2State typedef
  ps2: add ps2_reset_queue
  ps2: reset queue in ps2_reset_keyboard

 include/hw/input/ps2.h  |  4 ++--
 include/qemu/typedefs.h |  1 +
 hw/input/hid.c          |  1 +
 hw/input/ps2.c          | 28 ++++++++++++++++------------
 ui/input.c              |  1 +
 ui/keymaps.c            | 33 ++++++++++++++++++---------------
 ui/sdl2.c               |  1 +
 ui/trace-events         |  5 +++++
 8 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.9.3
