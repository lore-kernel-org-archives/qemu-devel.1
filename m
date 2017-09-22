Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dvPAc-00010G-QB
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dvPAb-0003Mk-U9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dvPAb-0003MQ-Nl
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:43:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 22 Sep 2017 11:42:59 -0300
Message-Id: <20170922144259.5956-3-ehabkost@redhat.com>
In-Reply-To: <20170922144259.5956-1-ehabkost@redhat.com>
References: <20170922144259.5956-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] MAINTAINERS: Add Python scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

Cleber and I are volunteering to review and queue patches for the
Python scripts and modules in scripts/.

I'm setting "M: Odd fixes" because not all scripts are actively
maintained.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170915230744.22942-1-ehabkost@redhat.com>
[ehabkost: add tests/*.py too]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e511ba780f..d3e91496b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1403,6 +1403,14 @@ S: Maintained
 F: include/sysemu/cryptodev*.h
 F: backends/cryptodev*.c
 
+Python scripts
+M: Eduardo Habkost <ehabkost@redhat.com>
+M: Cleber Rosa <crosa@redhat.com>
+S: Odd fixes
+F: scripts/qmp/*
+F: scripts/*.py
+F: tests/*.py
+
 QAPI
 M: Markus Armbruster <armbru@redhat.com>
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
-- 
2.13.5
