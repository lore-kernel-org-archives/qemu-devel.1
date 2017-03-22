Received: from eggs.gnu.org ([2001:4830:134:3::10]:49437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqnBw-0003sX-SV
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqnBt-0000SL-Qq
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:49:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 22 Mar 2017 17:48:41 -0300
Message-Id: <20170322204844.446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND 0/3] easy-to-fix clang warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This patchset fixes three easy-to-fix clang warnings.

Resent adding Marc-André Lureau's Reviewed-by and CC'ing qemu-trivial as
suggested by Markus Armbruster.

Philippe Mathieu-Daudé (3):
  usb-ccid: make ccid_write_data_block() cope with null buffers
  device_tree: fix compiler warnings (clang 5)
  qga: fix compiler warnings (clang 5)

 device_tree.c                 | 1 +
 hw/usb/dev-smartcard-reader.c | 8 +++++++-
 qga/commands-posix.c          | 8 +++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.11.0
