Received: from eggs.gnu.org ([2001:4830:134:3::10]:60634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gUd8t-000257-0c
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gUd8q-0008Ia-Vm
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:47:30 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gUd8q-0008DG-Of
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 14:47:28 -0500
Received: by mail-qk1-x742.google.com with SMTP id r71so12601697qkr.10
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:47:21 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed,  5 Dec 2018 17:47:00 -0200
Message-Id: <20181205194701.17836-3-danielhb413@gmail.com>
In-Reply-To: <20181205194701.17836-1-danielhb413@gmail.com>
References: <20181205194701.17836-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 2/3] qga: update guest-suspend-ram and
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
Cc: ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, mst@redhat.com, imammedo@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the proper support for wake up from suspend, retrieved by the
'wakeup-suspend-support' attribute of the 'query-current-machine'
QMP command.

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.19.2
