Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyU-0005od-Sc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyP-0007kn-It
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:22 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:59459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1cEKyP-0007jv-89
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:17 -0500
From: Fabian Lesniak <fabian@lesniak-it.de>
Date: Tue,  6 Dec 2016 20:00:04 +0100
Message-Id: <20161206190007.7539-1-fabian@lesniak-it.de>
Subject: [Qemu-devel] [PATCH v3 0/3] add support for mice with extra/side
 buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>

This patch implements event handling for 5-button ps/2 mice and 
appropriate event generation for gtk and input-linux input methods.

As Gerd suggested, it is now split into three parts and introduces
distinct ps2 mouse button definitions instead of using the legacy
ones from console.h. Please comment on the location of the new
definitions if inappropriate.

The changes to qapi were improved following Eric's hints.

Fabian Lesniak (3):
  qapi: add support for mice with extra/side buttons
  ps2: add support for mice with extra/side buttons
  ui: add support for mice with extra/side buttons

 hw/input/ps2.c         | 8 +++++---
 include/hw/input/ps2.h | 6 ++++++
 qapi-schema.json       | 7 ++++++-
 ui/gtk.c               | 4 ++++
 ui/input-linux.c       | 6 ++++++
 5 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.10.2
