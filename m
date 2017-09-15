Received: from eggs.gnu.org ([2001:4830:134:3::10]:49471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsziI-0006ZB-RW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsziF-0004Qk-LR
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dsziF-0004QC-G2
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:07:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:07:44 -0300
Message-Id: <20170915230744.22942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add Python scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Cleber and I are volunteering to review and queue patches for the
Python scripts and modules in scripts/.

I'm setting "M: Odd fixes" because not all scripts are actively
maintained.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Even before this patch is merged, I plan to send a pull request
including some patches for the Python code soon.
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c333aba21..2c3b8ecde7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1390,6 +1390,13 @@ S: Maintained
 F: include/sysemu/cryptodev*.h
 F: backends/cryptodev*.c
 
+Python scripts
+M: Eduardo Habkost <ehabkost@redhat.com>
+M: Cleber Rosa <crosa@redhat.com>
+S: Odd fixes
+F: scripts/qmp/*
+F: scripts/*.py
+
 QAPI
 M: Markus Armbruster <armbru@redhat.com>
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
-- 
2.13.5
