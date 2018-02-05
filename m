Received: from eggs.gnu.org ([2001:4830:134:3::10]:59348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipt8-0001m8-SC
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipt8-0007A6-16
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipt7-00079n-SF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:25 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:50 -0200
Message-Id: <20180205230900.11344-12-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/21] qemu.py: remove unused import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Amador Pahim <apahim@redhat.com>

Removing 'import sys' as it's not used anywhere.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Message-Id: <20171114102246.22221-2-apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.14.3
