Received: from eggs.gnu.org ([2001:4830:134:3::10]:56075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPA-0004Yx-B0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjP7-0006zf-Ns
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjP7-0006zF-El
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:46:57 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:13 +0300
Message-Id: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 00/29]: vmsvga: Various fixes and enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com

Hi,

This patch series aim to fix many issues in vmware-svga emulation
which have prevented it from being fully functional in a wide-variety
of guests.

Patches 1-5 are just code refactoring patches.

Patches 6-11 aim to fix multiple command parsing issues which caused
FIFO to desync and thus fail to parse commands posted after the
commands which failed to parse.

Patches 12-13 better define FIFO registers and add support for
extended FIFO registers.

Patches 14-17 add interrupt support.

Patches 18-19 utilize interrupt support to implement various interrupt
sources. Specifically, FIFO_PROGRESS interrupt and FIFO_FENCE related
interrupts.

Patches 20-24 fix various issues in cursor commands and improve
hardware cursor performance by utilizing CURSOR_BYPASS_3 capability
which allows getting cursor updates via FIFO registers.

Patch 25 add basic support for parsing GMR commands to avoid FIFO
desync.

Patches 26-27 add vmware-svga capabilities required by Linux
kernel vmware-svga driver.

Patch 28 is a small code refactoring change.

Patch 29 disallows setting screen size to zero width/height to avoid
VNC window surprisingly disappearing.

Regards,
-Liran Alon
