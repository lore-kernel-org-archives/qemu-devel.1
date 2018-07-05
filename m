Received: from eggs.gnu.org ([2001:4830:134:3::10]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fbAYO-0004DT-CX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fbAYN-0002h6-Ek
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:36 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:35422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fbAYN-0002gE-AH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:08:35 -0400
Received: by mail-qt0-x235.google.com with SMTP id z6-v6so8191658qti.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:08:35 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu,  5 Jul 2018 17:08:12 -0300
Message-Id: <20180705200813.2033-3-danielhb413@gmail.com>
In-Reply-To: <20180705200813.2033-1-danielhb413@gmail.com>
References: <20180705200813.2033-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v8 2/3] qga: update guest-suspend-ram and
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
Cc: ehabkost@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

This patch updates the descriptions of 'guest-suspend-ram' and
'guest-suspend-hybrid' to mention that both commands relies now
on the proper support for wake up from suspend, retrieved by the
'wakeup-suspend-support' attribute of the 'query-current-machine'
QMP command.

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..912e7505bd 100644
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
+# QEMU. You *must* check QMP command query-current-machine returns
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
+# QEMU. You *must* check QMP command query-current-machine returns
+# wakeup-suspend-support: true before issuing this command.
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-- 
2.17.1
