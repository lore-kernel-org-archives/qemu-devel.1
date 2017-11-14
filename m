Received: from eggs.gnu.org ([2001:4830:134:3::10]:51914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNY-0008OB-K1
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNV-00039M-GF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEYNV-00038c-9l
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:37 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 11:22:39 +0100
Message-Id: <20171114102246.22221-2-apahim@redhat.com>
In-Reply-To: <20171114102246.22221-1-apahim@redhat.com>
References: <20171114102246.22221-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v11 1/8] qemu.py: remove unused import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, muriloo@linux.vnet.ibm.com, armbru@redhat.com, Amador Pahim <apahim@redhat.com>

Removing 'import sys' as it's not used anywhere.

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9bfdf6d37d..65d9ad688c 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -15,7 +15,6 @@
 import errno
 import logging
 import os
-import sys
 import subprocess
 import qmp.qmp
 
-- 
2.13.6
