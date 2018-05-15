Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIaeW-0006EJ-2h
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIaeQ-0005fm-4Z
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:10:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59818
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIaeP-0005fH-VE
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:10:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FE01aK123810
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 10:10:01 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hyxh5qkwy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 10:10:00 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Tue, 15 May 2018 10:09:59 -0400
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Tue, 15 May 2018 11:09:44 -0300
In-Reply-To: <20180515140944.15979-1-danielhb@linux.ibm.com>
References: <20180515140944.15979-1-danielhb@linux.ibm.com>
Message-Id: <20180515140944.15979-3-danielhb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v6 2/2] qga: update guest-suspend-ram and
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
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the existence of 'system_wakeup' and also on the proper support
for wake up from suspend, retrieved by the 'wakeup-suspend-support'
attribute of the 'query-target' QMP command.

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.14.3
