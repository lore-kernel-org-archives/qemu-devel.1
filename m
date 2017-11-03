Received: from eggs.gnu.org ([2001:4830:134:3::10]:34641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaX-0005sH-Vb
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaT-0003VE-4D
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:42 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:52427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=473f30fe0=owen.smith@citrix.com>)
	id 1eAaaS-0003St-VX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:56:37 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Fri, 3 Nov 2017 11:56:27 +0000
Message-ID: <20171103115631.15175-1-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/4] xenfb: Enablement for Windows PV HID
 frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, owen.smith@citrix.com

Improve the input device model in xenfb, by updating the
Qemu input handlers and adding a feature to allow for
raw (unscaled) absolute coordinates to be represented.

Changes:
  * use keycodedb to generate qcode to linux input mapping
  * move rescaling to the mouse_event handler
  * add activate for raw_pointer devices

Owen Smith (3):
  ui: generate qcode to linux mappings
  xenfb: Use Input Handlers directly
  xenfb: Add [feature|request]-raw-pointer
  xenfb: activate input handlers for raw pointer devices

 Makefile           |   1 +
 hw/display/xenfb.c | 294 ++++++++++++++++++++++++++++-------------------------
 include/ui/input.h |   3 +
 ui/input-keymap.c  |   1 +
 4 files changed, 161 insertions(+), 138 deletions(-)

-- 
2.11.0
