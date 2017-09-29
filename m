Received: from eggs.gnu.org ([2001:4830:134:3::10]:41412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxsQr-00073I-Kb
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxsQm-0005fA-SV
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxsQm-0005eA-N1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:22:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 026D661474
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 10:22:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 12:21:56 +0200
Message-Id: <20170929102201.15408-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Ui 20170929 patches
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

The following changes since commit ab161529261928ae7f3556e3220829c34b2686=
ec:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2017=
0927a' into staging (2017-09-27 22:44:51 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20170929-pull-request

for you to fetch changes up to 7364dbdabb7824d5bde1e341bb6d928282f01c83:

  ui: add tracing of VNC authentication process (2017-09-29 10:36:34 +020=
0)

----------------------------------------------------------------
ui and input patches.

----------------------------------------------------------------

Daniel P. Berrange (2):
  ui: add tracing of VNC operations related to QIOChannel
  ui: add tracing of VNC authentication process

Gerd Hoffmann (3):
  console: purge curses bits from console.h
  egl: misc framebuffer helper improvements.
  virtio-input: send rel-wheel events for wheel buttons

 include/hw/compat.h              |  10 +++-
 include/hw/virtio/virtio-input.h |   1 +
 include/ui/console.h             |  23 +-------
 include/ui/egl-helpers.h         |   5 +-
 hw/input/virtio-input-hid.c      | 119 +++++++++++++++++++++++++++++++++=
++++--
 target/unicore32/helper.c        |   6 ++
 ui/curses.c                      |  25 ++++++--
 ui/egl-headless.c                |   6 +-
 ui/egl-helpers.c                 |  26 ++++++---
 ui/gtk-egl.c                     |   4 +-
 ui/gtk-gl-area.c                 |   4 +-
 ui/sdl2-gl.c                     |   4 +-
 ui/vnc-auth-sasl.c               | 113 ++++++++++++++++-----------------=
----
 ui/vnc-auth-vencrypt.c           |  23 ++++----
 ui/vnc-ws.c                      |   6 +-
 ui/vnc.c                         |  47 +++++++++-------
 ui/trace-events                  |  21 +++++++
 17 files changed, 293 insertions(+), 150 deletions(-)

--=20
2.9.3
