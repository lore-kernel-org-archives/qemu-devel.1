Received: from eggs.gnu.org ([209.51.188.92]:58973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyL8q-00073x-AX
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyL8n-0005W7-0o
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:38:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 25 Feb 2019 19:37:51 +0100
Message-Id: <20190225183757.27378-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/6] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com

This is RFC mostly due to the last patch.  I'm not 100% sure my
approach is sane, and there's also an unresolved FIXME.  Please
review.

Based-on: <20190218125615.18970-1-armbru@redhat.com>

Markus Armbruster (6):
  qdev: Fix latent bug with compat_props and onboard devices
  qom: Move compat_props machinery from qdev to QOM
  vl: Fix latent bug with -global and onboard devices
  sysbus: Fix latent bug with onboard devices
  vl: Create block backends before setting machine properties
  pc: Support firmware configuration with -blockdev

 accel/accel.c            |   1 +
 hw/block/pflash_cfi01.c  |   5 +
 hw/core/qdev.c           |  21 +---
 hw/core/sysbus.c         |   3 -
 hw/i386/pc.c             |   4 +-
 hw/i386/pc_sysfw.c       | 230 ++++++++++++++++++++++++++-------------
 include/hw/block/flash.h |   1 +
 include/hw/i386/pc.h     |   6 +-
 include/hw/qdev-core.h   |   2 -
 include/qom/object.h     |   3 +
 qom/object.c             |  39 +++++++
 vl.c                     |  90 +++++++--------
 12 files changed, 255 insertions(+), 150 deletions(-)

--=20
2.17.2
