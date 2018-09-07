Received: from eggs.gnu.org ([2001:4830:134:3::10]:36669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9c-0000tS-M4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fyF9Y-00047i-JG
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fyF9U-00040k-UH
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:42:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so14603075wrc.13
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 04:42:16 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri,  7 Sep 2018 13:42:08 +0200
Message-Id: <cover.1536320522.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/5] qga: report serial number and disk node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Note that PCI controller reporting on Windows was and still is broken.
Unfortunately I don't know how to fix it at the momemnt. See commit message and
code comment. If anyone has environment where the original code works let me
know. CCing author of the code In case I missed something obvious.

v3:
  - fix typos
  - add configure test for libudev
  - change order of patches fixing PCI controller info and build fix to avoid
    exposing broken code
  - split reporting of serial number and device node into two separate patches

v2:
  - fix checkpatch error

Patches 1 and 3 are bug-fixes of existing code
Patch 2 is optional and contains debug messages -- the windows QGA seriously
lacks debug messages...
Patch 4 adds reporting of disk serial number and device node of the disk.

Tomáš Golembiovský (5):
  qga: win32: fix crashes when PCI info cannot be retrived
  build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
  qga: win32: add debugging information
  qga: report disk serial number
  qga: return disk device in guest-get-fsinfo

 configure            |  24 ++++-
 qga/Makefile.objs    |   1 +
 qga/commands-posix.c |  27 +++++
 qga/commands-win32.c | 248 ++++++++++++++++++++++++++++++++++++-------
 qga/qapi-schema.json |   5 +-
 5 files changed, 264 insertions(+), 41 deletions(-)

-- 
2.18.0
