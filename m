Received: from eggs.gnu.org ([2001:4830:134:3::10]:39948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcFX-0007pO-7x
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcFU-0004hG-DC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:20:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  7 Apr 2017 19:20:12 -0300
Message-Id: <20170407222016.15308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] 3 easy-to-fix clang warnings,
 1 error code fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This patchset fixes three easy-to-fix unrelated clang warnings, so it was
probably better to send them separately the first time.

v2:
    - hw/usb/dev-smartcard-reader.c: The first patch was treating NULL and 0 as
      errors but those values are legal in some cases, i.e. no (virtual)
      smartcard inserted into the card reader (Gerd Hoffmann's review).
    - device_tree.c: Added Marc-André Lureau's Reviewed-by.
    - qga/commands-posix.c: Added a commit to improve failed operation, as
      suggested by Michael Roth.

Philippe Mathieu-Daudé (4):
  usb-ccid: make ccid_write_data_block() cope with null buffers
  device_tree: fix compiler warnings (clang 5)
  qga: fix compiler warnings (clang 5)
  qga: improve error handling in transfer_memory_block

 device_tree.c                 |  1 +
 hw/usb/dev-smartcard-reader.c |  5 ++++-
 qga/commands-posix.c          | 11 ++++++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.11.0
