Received: from eggs.gnu.org ([2001:4830:134:3::10]:56227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNGov-0004p8-IO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNGor-00061F-Iw
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNGop-000600-Hd
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:25 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Nov 2018 13:32:14 +0100
Message-Id: <20181115123218.25387-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] keymaps: drop support for include files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@gmail.com>



Gerd Hoffmann (4):
  keymaps: remove modifiers include
  keymaps: drop nl-be map
  keymaps: remove common include
  keymaps: drop support for include files

 ui/keymaps.c              |   7 +-
 pc-bios/keymaps/common    | 157 ----------------------------------------
 pc-bios/keymaps/modifiers |  18 -----
 pc-bios/keymaps/nl-be     |   3 -
 pc-bios/keymaps/sl        | 177 +++++++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/sv        | 176 ++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 354 insertions(+), 184 deletions(-)
 delete mode 100644 pc-bios/keymaps/common
 delete mode 100644 pc-bios/keymaps/modifiers
 delete mode 100644 pc-bios/keymaps/nl-be

-- 
2.9.3
