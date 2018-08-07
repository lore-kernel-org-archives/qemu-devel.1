Received: from eggs.gnu.org ([2001:4830:134:3::10]:38815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYN-00087G-Be
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYI-00034c-Gj
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:27 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fmzYI-00034G-8y
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:22 -0400
Received: by mail-wr1-f42.google.com with SMTP id h9-v6so15335661wro.3
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:49:21 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  7 Aug 2018 12:49:14 +0200
Message-Id: <cover.1533638952.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] qga: report serial number and disk node
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
