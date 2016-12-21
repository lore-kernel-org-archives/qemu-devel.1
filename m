Received: from eggs.gnu.org ([2001:4830:134:3::10]:51700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUvA-0001gz-7c
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUv7-00087W-5q
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:16 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:59701)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJUv6-00087L-Ty
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:38:13 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 21 Dec 2016 01:38:03 +0100
Message-Id: <20161221003806.22412-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCHv4 0/3] Move getting XWindow ID from baum driver
 to graphical backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Hello,

This is a respin of moving getting XWindow ID from baum to actual
graphical backends.  This only contains the new API, the move
of existing code to the new API, and the addition of support for
SDL2. Gtk will need more discussion and work.

Compared to v3, this makes the API use a QemuConsole* parameter instead of an
integer index,

Samuel

Samuel Thibault (3):
  console: add API to get underlying gui window ID
  console: move window ID code from baum to sdl
  sdl2: set window ID

 backends/baum.c      | 31 ++++++++-----------------------
 include/ui/console.h |  4 ++++
 ui/console.c         | 11 +++++++++++
 ui/sdl.c             | 25 +++++++++++++++++++++++++
 ui/sdl2.c            |  7 +++++++
 5 files changed, 55 insertions(+), 23 deletions(-)

-- 
2.11.0
