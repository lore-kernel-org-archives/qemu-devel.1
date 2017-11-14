Received: from eggs.gnu.org ([2001:4830:134:3::10]:52082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNn-0000Ez-IB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNm-0003P7-Pr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEYNm-0003Ol-KM
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:54 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 11:22:45 +0100
Message-Id: <20171114102246.22221-8-apahim@redhat.com>
In-Reply-To: <20171114102246.22221-1-apahim@redhat.com>
References: <20171114102246.22221-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v11 7/8] qemu.py: launch vm only if it's not
 running
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

If we allow launching VM again we will loose track of the first launched
VM.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 305d7bd098..0b0b61be39 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -207,6 +207,9 @@ class QEMUMachine(object):
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
         """
+        if self.is_running():
+            raise QEMUMachineError('VM already running')
+
         self._iolog = None
         self._qemu_full_args = None
         try:
-- 
2.13.6
