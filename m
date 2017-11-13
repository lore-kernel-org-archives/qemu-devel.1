Received: from eggs.gnu.org ([2001:4830:134:3::10]:33759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMU3-00030G-IT
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEMU0-00043w-1z
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEMTz-00043k-Rz
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 16:41:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2256C01A69F
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 21:41:30 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 13 Nov 2017 22:39:38 +0100
Message-Id: <20171113213945.20049-2-apahim@redhat.com>
In-Reply-To: <20171113213945.20049-1-apahim@redhat.com>
References: <20171113213945.20049-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v9 1/8] qemu.py: remove unused import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, Amador Pahim <apahim@redhat.com>

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
