Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzac-00020W-9S
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzaX-0004Fi-E4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:51:46 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fmzaX-0004F9-7G
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:51:41 -0400
Received: by mail-wr1-f50.google.com with SMTP id v14-v6so15324630wro.5
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:51:41 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  7 Aug 2018 12:51:34 +0200
Message-Id: <cover.1533639095.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] qga: report serial number and disk node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

v2:
  - fix checkpatch error

Patches 1 and 3 are bug-fixes of existing code
Patch 2 is optional and contains debug messages -- the windows QGA seriously
lacks debug messages...
Patch 4 adds reporting of disk serial number and device node of the disk.

Tomáš Golembiovský (4):
  build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
  qga: win32: add debugging information
  qga: win32: fix crashes when PCI info cannot be retrived
  qga: report serial ID and device node

 configure            |   3 +-
 qga/commands-posix.c |  23 ++++++++++
 qga/commands-win32.c | 105 ++++++++++++++++++++++++++++++++++---------
 qga/qapi-schema.json |   4 +-
 4 files changed, 111 insertions(+), 24 deletions(-)

-- 
2.18.0
