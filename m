Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tA-0004Be-MJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iM-0003SM-0d
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:45 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iL-0003Qn-Qj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:41 -0400
Received: by mail-wm1-f54.google.com with SMTP id 185-v6so8661178wmt.2
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:41 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:27 +0200
Message-Id: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/11] qga: report serial number and disk
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Note that PCI controller reporting on Windows was and still is broken.
Unfortunately I don't know how to fix it at the momemnt. See commit message and
code comment. If anyone has environment where the original code works let me
know. CCing author of the code In case I missed something obvious.

v4:
  - split changes into more patches
  - fixed UNC for physical drive to use device namespace
  - renamed g_debug_err() to debug_error()
  - fixed build without libudev

v3:
  - fix typos
  - add configure test for libudev
  - change order of patches fixing PCI controller info and build fix to avoid
    exposing broken code
  - split reporting of serial number and device node into two separate patches

v2:
  - fix checkpatch error

Tomáš Golembiovský (11):
  qga-win: fix crashes when PCI info cannot be retrived
  qga-win: handle NULL values
  build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
  qga-win: add debugging information
  qga-win: refactor disk properties (bus)
  configure: add test for libudev
  qga: report disk serial number
  qga-win: refactor disk info
  qga-win: handle multi-disk volumes
  qga: return disk device in guest-get-fsinfo
  qga-win: demystify namespace striping

 configure            |  24 +++-
 qga/Makefile.objs    |   1 +
 qga/commands-posix.c |  32 +++++
 qga/commands-win32.c | 269 ++++++++++++++++++++++++++++++++++++-------
 qga/qapi-schema.json |   5 +-
 5 files changed, 289 insertions(+), 42 deletions(-)

-- 
2.19.0
