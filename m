Received: from eggs.gnu.org ([2001:4830:134:3::10]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSyGl-00029k-7X
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSyGi-0008Fr-36
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:24:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Jun 2018 07:24:25 +0200
Message-Id: <1528867465-26696-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] trivial: Make bios files and source files
 non-executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

These files can not be executed on the host, so they should not be
marked as executable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/blkreplay.c                  |   0
 pc-bios/hppa-firmware.img          | Bin
 pc-bios/palcode-clipper            | Bin
 pc-bios/u-boot-sam460-20100605.bin | Bin
 pc-bios/u-boot.e500                | Bin
 replay/replay-char.c               |   0
 6 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 block/blkreplay.c
 mode change 100755 => 100644 pc-bios/hppa-firmware.img
 mode change 100755 => 100644 pc-bios/palcode-clipper
 mode change 100755 => 100644 pc-bios/u-boot-sam460-20100605.bin
 mode change 100755 => 100644 pc-bios/u-boot.e500
 mode change 100755 => 100644 replay/replay-char.c

diff --git a/block/blkreplay.c b/block/blkreplay.c
old mode 100755
new mode 100644
diff --git a/pc-bios/hppa-firmware.img b/pc-bios/hppa-firmware.img
old mode 100755
new mode 100644
diff --git a/pc-bios/palcode-clipper b/pc-bios/palcode-clipper
old mode 100755
new mode 100644
diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam460-20100605.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/u-boot.e500 b/pc-bios/u-boot.e500
old mode 100755
new mode 100644
diff --git a/replay/replay-char.c b/replay/replay-char.c
old mode 100755
new mode 100644
-- 
1.8.3.1
