Received: from eggs.gnu.org ([2001:4830:134:3::10]:54494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNLj-00074H-Q3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNLf-0002dD-NV
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:31:27 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40030)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNLf-0001pE-DM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:31:23 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 29 Nov 2018 17:31:10 +0300
Message-ID: <154350187043.8036.10772397990057740477.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
References: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 39/39] windbg: maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Add WinDbg stub to the MAINTAINERS.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c56..dffbd267be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1689,6 +1689,18 @@ S: Odd Fixes
 F: gdbstub*
 F: gdb-xml/
 
+WinDbg stub
+M: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
+R: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
+S: Supported
+F: include/exec/windbgstub.h
+F: include/exec/windbgstub-utils.h
+F: include/exec/windbgkd.h
+F: windbgstub.c
+F: windbgstub-utils.c
+F: stubs/windbgstub.c
+F: target/i386/windbgstub.c
+
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
