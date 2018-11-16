Received: from eggs.gnu.org ([2001:4830:134:3::10]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbb8-0007H6-PH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNbaz-0000Zv-U8
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNbav-0000WH-MU
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:43:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 11:43:15 +0100
Message-Id: <20181116104319.10329-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] keymaps: drop support for include files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

Most keymaps are generated using qemu-keymap these days
and do not use include files anyway.

v2: fix "make install" failure.

Gerd Hoffmann (4):
  keymaps: remove modifiers include
  keymaps: drop nl-be map
  keymaps: remove common include
  keymaps: drop support for include files

 Makefile                  |   4 +-
 ui/keymaps.c              |   7 +-
 pc-bios/keymaps/common    | 157 ----------------------------------------
 pc-bios/keymaps/modifiers |  18 -----
 pc-bios/keymaps/nl-be     |   3 -
 pc-bios/keymaps/sl        | 177 +++++++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/sv        | 176 ++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 356 insertions(+), 186 deletions(-)
 delete mode 100644 pc-bios/keymaps/common
 delete mode 100644 pc-bios/keymaps/modifiers
 delete mode 100644 pc-bios/keymaps/nl-be

-- 
2.9.3
