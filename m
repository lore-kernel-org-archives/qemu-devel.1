Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996n-0002t2-5K
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996k-00053U-2U
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996j-000538-SL
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 420377F7B5
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:51:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:25 +0200
Message-Id: <20170512115135.17379-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] ui patch queue
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

Here is the ui patch queue with some vnc cleanups, absolute event
support for input linux, egl bugfixes and the new eg-headless ui.

please pull,
  Gerd

The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:

  Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-ui-20170512-1

for you to fetch changes up to 7c9209e7bfb8c09ab5a4cadaa84928d146874a05:

  vnc: replace hweight_long() with ctpopl() (2017-05-12 12:36:02 +0200)

----------------------------------------------------------------
ui: add egl-headless
ui: some vnc cleanups
ui: absolute events for input-linux

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      vnc: replace hweight_long() with ctpopl()

Gerd Hoffmann (6):
      virtio-gpu: move virtio_gpu_gl_block
      egl-helpers: drop support for gles and debug logging
      egl-helpers: fix display init for x11
      egl-helpers: add missing error check
      egl: explicitly ask for core context
      opengl: add egl-headless display

Philippe Voinov (2):
      ui: Support non-zero minimum values for absolute input axes
      ui: input-linux: Add absolute event support

Wei Qi (1):
      vnc: simple clean up

 include/hw/virtio/virtio-gpu.h |   1 +
 include/qemu/bitops.h          |  10 ---
 include/ui/console.h           |   3 +
 include/ui/egl-helpers.h       |   3 +-
 include/ui/input.h             |  11 +--
 hw/display/virtio-gpu-3d.c     |  16 +++++
 hw/display/virtio-gpu.c        |  18 +----
 hw/input/virtio-input-hid.c    |   6 +-
 ui/egl-context.c               |   7 +-
 ui/egl-headless.c              | 158 +++++++++++++++++++++++++++++++++++=
++++++
 ui/egl-helpers.c               |  88 +++++++++--------------
 ui/gtk-egl.c                   |   2 +-
 ui/gtk.c                       |   4 +-
 ui/input-linux.c               |  25 ++++++-
 ui/input.c                     |  31 +++++---
 ui/sdl.c                       |   4 +-
 ui/sdl2.c                      |   4 +-
 ui/spice-input.c               |   4 +-
 ui/vnc-enc-zrle.c              |   1 -
 ui/vnc.c                       |  10 +--
 vl.c                           |  16 +++++
 ui/Makefile.objs               |   1 +
 ui/cocoa.m                     |   4 +-
 23 files changed, 311 insertions(+), 116 deletions(-)
 create mode 100644 ui/egl-headless.c
