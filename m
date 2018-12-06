Received: from eggs.gnu.org ([2001:4830:134:3::10]:42419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMX-0001fK-H1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMS-0006mk-PT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:37 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60512)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMR-0006FU-Ur
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:32 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:02:16 +0300
Message-ID: <154409773674.5432.12175496359431081691.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 39/39] windbg: maintainers
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
