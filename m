Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWQ4j-00019B-4Y
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWQ4f-0002kh-17
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:10:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eWQ4e-0002jg-N8
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:10:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w02H9Pk6089131
	for <qemu-devel@nongnu.org>; Tue, 2 Jan 2018 12:09:57 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f8c39dq5t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 12:09:57 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 2 Jan 2018 12:09:56 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue,  2 Jan 2018 15:09:36 -0200
In-Reply-To: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
References: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20180102170936.6150-3-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the existence of 'system_wakeup' and also on the proper support
for wake up from suspend, retrieved by the 'wakeup-suspend-support'
attribute of the 'query-target' QMP command.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..e3fb8adfce 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -566,8 +566,11 @@
 # package installed in the guest.
 #
 # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-ram.
+# command and the guest to support wake up from suspend. Thus, it's
+# *required* to query QEMU for the presence of the 'system_wakeup' command
+# and to verify that wake up from suspend is enabled by checking the
+# 'wakeup-suspend-support' flag of 'query-target' QMP command, before issuing
+# guest-suspend-ram.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
@@ -593,8 +596,11 @@
 # This command requires the pm-utils package to be installed in the guest.
 #
 # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-hybrid.
+# command and the guest to support wake up from suspend. Thus, it's
+# *required* to query QEMU for the presence of the 'system_wakeup' command
+# and to verify that wake up from suspend is enabled by checking the
+# 'wakeup-suspend-support' flag of 'query-target' QMP command, before issuing
+# guest-suspend-hybrid.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-- 
2.13.6
