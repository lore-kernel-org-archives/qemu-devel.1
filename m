Received: from eggs.gnu.org ([2001:4830:134:3::10]:35208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5p-0004uj-1b
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5l-0004MU-76
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:26:01 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44312)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5k-0004M0-V3
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:57 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:25:41 +0300
Message-ID: <151299874146.4808.14480270206063651699.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 46/46] windbg: maintainers
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

Added WinDbg stub to the MAINTAINERS.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccee28b12d..8ee2c780e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1300,6 +1300,18 @@ S: Odd Fixes
 F: gdbstub*
 F: gdb-xml/
 
+WinDbg stub
+M: Mihail Abakumov <mikhail.abakumov@ispras.ru>
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
