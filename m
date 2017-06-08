Received: from eggs.gnu.org ([2001:4830:134:3::10]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJD-0004L4-Fw
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002Di-5S
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:07 -0400
Received: from smtp.citrix.com ([66.165.176.89]:9025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002D1-0I
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:04 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Thu, 8 Jun 2017 13:15:30 +0000
Message-ID: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] xenfb: Add vkbd-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com, xen-devel@lists.xenproject.org, Owen Smith <owen.smith@citrix.com>

Adds the ability for a vkbd device to connect without the
QemuConsole, in order to support a standalone PV mouse and
keyboard frontend.
This series adds a new feature flag, which will need adding
to the xen's include/public/io/kbdif.h
"feature-vkbd-standalone" is set to 1 by backends that allow 
the vkbd device model to connect without requiring a vfb device
connected. The vkbd device will only bypass the check for
the vfb device if the frontend sets "request-vkbd-standalone"
to 1.
The last 2 patches add a couple of missing input handler
functions, and uses these to remove a leak in the vkbd device
model.

Owen Smith (4):
  xenfb: Add feature-vkbd-standalone
  xenfb: Activate mouse handler
  ui/input: Add activate/remove for keyboard handlers
  xenfb: Fix leak by adding/removing keyboard handler

 hw/display/xenfb.c   | 44 ++++++++++++++++++++++++++++++++------------
 include/ui/console.h |  2 ++
 ui/input-legacy.c    | 12 ++++++++++++
 3 files changed, 46 insertions(+), 12 deletions(-)

-- 
2.1.4
