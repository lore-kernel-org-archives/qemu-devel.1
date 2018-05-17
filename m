Received: from eggs.gnu.org ([2001:4830:134:3::10]:43057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJOVC-0008S7-Ib
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJOV7-0001Kc-KX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:23:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fJOV7-0001KR-EF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:23:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4HJIs0u003415
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:23:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j1fr6g90d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:23:44 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Thu, 17 May 2018 13:23:43 -0600
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Thu, 17 May 2018 16:23:24 -0300
In-Reply-To: <20180517192325.8335-1-danielhb@linux.ibm.com>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
Message-Id: <20180517192325.8335-3-danielhb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v7 2/3] qga: update guest-suspend-ram and
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
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com, dgilbert@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the proper support for wake up from suspend, retrieved by the
'wakeup-suspend-support' attribute of the 'query-target' QMP
command.

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..bc46c2d0f0 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -565,9 +565,9 @@
 # For the best results it's strongly recommended to have the pm-utils
 # package installed in the guest.
 #
-# IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-ram.
+# IMPORTANT: guest-suspend-ram requires working wakeup support in
+# QEMU. You *must* check QMP command query-target returns
+# wakeup-suspend-support: true before issuing this command.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
@@ -592,9 +592,9 @@
 #
 # This command requires the pm-utils package to be installed in the guest.
 #
-# IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-hybrid.
+# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
+# QEMU. You *must* check QMP command query-target returns
+# wakeup-suspend-support: true before issuing this command.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-- 
2.14.3
