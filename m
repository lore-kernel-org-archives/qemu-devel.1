Received: from eggs.gnu.org ([2001:4830:134:3::10]:55904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJx-00060U-IB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJv-00086r-7U
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJu-00081b-Rs
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:46 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 11:09:39 +0100
Message-Id: <20181218100941.25267-6-armbru@redhat.com>
In-Reply-To: <20181218100941.25267-1-armbru@redhat.com>
References: <20181218100941.25267-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] qga: update guest-suspend-ram and
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the proper support for wake up from suspend, retrieved by the
'wakeup-suspend-support' attribute of the 'query-current-machine'
QMP command.

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-Id: <20181205194701.17836-3-danielhb413@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c6725b3ec8..a4ff5b8fc9 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -567,9 +567,11 @@
 # For the best results it's strongly recommended to have the pm-utils
 # package installed in the guest.
 #
-# IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-ram.
+# IMPORTANT: guest-suspend-ram requires working wakeup support in
+# QEMU. You should check QMP command query-current-machine returns
+# wakeup-suspend-support: true before issuing this command. Failure in
+# doing so can result in a suspended guest that QEMU will not be able to
+# awaken, forcing the user to power cycle the guest to bring it back.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
@@ -594,9 +596,11 @@
 #
 # This command requires the pm-utils package to be installed in the guest.
 #
-# IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
-# command.  Thus, it's *required* to query QEMU for the presence of the
-# 'system_wakeup' command before issuing guest-suspend-hybrid.
+# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
+# QEMU. You should check QMP command query-current-machine returns
+# wakeup-suspend-support: true before issuing this command. Failure in
+# doing so can result in a suspended guest that QEMU will not be able to
+# awaken, forcing the user to power cycle the guest to bring it back.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-- 
2.17.2
