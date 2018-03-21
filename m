Received: from eggs.gnu.org ([2001:4830:134:3::10]:53081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8u-0007A4-7R
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eye8t-000816-Jw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:51:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eye8t-00080w-GH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:51:03 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Mar 2018 14:50:35 +0100
Message-Id: <20180321135041.15768-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] sdl2 text console fixes and cleanups.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, balaton@eik.bme.hu



Gerd Hoffmann (5):
  ui: add ctrl modifier support to kbd_put_qcode_console()
  sdl2: track kbd modifier state unconditionally
  sdl2: enable ctrl modifier keys for text consoles
  sdl2: drop QEMU_KEY_BACKSPACE special case
  sdl2: drop dead code

 include/ui/console.h |  2 +-
 ui/console.c         | 15 +++++++++++++--
 ui/gtk.c             |  4 ++--
 ui/sdl2-input.c      | 46 ++++++++++++++++++++--------------------------
 4 files changed, 36 insertions(+), 31 deletions(-)

-- 
2.9.3
