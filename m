Received: from eggs.gnu.org ([2001:4830:134:3::10]:35581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGK-0007tP-PO
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGH-0000Ai-Hl
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csWGH-0000AI-Bb
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7B5515561
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 15:08:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 15:28:32 +0200
Message-Id: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 0/5] fixes for 2.9: vga, egl, cirrus,
 virtio-input.
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

Bugfix collection for 2.9, ui, vga, input.

please pull,
  Gerd

The following changes since commit ea2afcf5b6727a577cf561fd8fe0d8c397ecc927:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-03-24 14:14:18 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-fixes-20170327-1

for you to fetch changes up to e5766eb40453b1d22815fc5482802688ff184006:

  vnc: fix reverse mode (2017-03-27 12:16:02 +0200)

----------------------------------------------------------------
fixes for 2.9: vga, egl, cirrus, virtio-input.

----------------------------------------------------------------
Gerd Hoffmann (3):
      cirrus: fix PUTPIXEL macro
      ui/egl-helpers: fix egl 1.5 display init
      vnc: fix reverse mode

Ladi Prosek (2):
      virtio-input: free event queue when finalizing
      virtio-input: fix eventq batching

 hw/display/cirrus_vga_rop2.h     |  4 +--
 hw/input/virtio-input.c          | 33 ++++++++++++-----------
 include/hw/virtio/virtio-input.h |  5 +++-
 ui/egl-helpers.c                 | 58 +++++++++++++++++++++++++++++++++++-----
 ui/vnc.c                         | 17 +++++++-----
 5 files changed, 85 insertions(+), 32 deletions(-)
