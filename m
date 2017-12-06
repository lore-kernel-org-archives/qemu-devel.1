Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPb-0005ta-Cs
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPW-00057q-Dn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMYPW-00057I-56
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6C246d028451
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:02:43 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epdy17rrt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:02:42 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 07:02:41 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 10:02:17 -0200
In-Reply-To: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171206120217.11392-4-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] qga: update guest-suspend-ram and
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
Cc: armbru@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the existence of 'system_wakeup' and also on the proper support
for wake up from suspend, retrieved by the QMP command
'query-wakeup-from-suspend-support'.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..d64ada304b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -566,8 +566,10 @@
 # package installed in the guest.
 #
 # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-ram.
+# command and the guest to support wake up from suspend. Thus, it's
+# *required* to query QEMU for the presence of the 'system_wakeup' command
+# and to verify that wake up from suspend is enabled using
+# 'query-wakeup-from-suspend-support' before issuing guest-suspend-ram.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
@@ -593,8 +595,10 @@
 # This command requires the pm-utils package to be installed in the guest.
 #
 # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-hybrid.
+# command and the guest to support wake up from suspend. Thus, it's
+# *required* to query QEMU for the presence of the 'system_wakeup' command
+# and to verify that wake up from suspend is enabled using
+# 'query-wakeup-from-suspend-support' before issuing guest-suspend-hybrid.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-- 
2.13.6
