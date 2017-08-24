Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa7-0006TF-Qc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa5-0004Cl-QG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa5-0004BC-Fg
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62A6C8765C
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:14:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:14:08 +0200
Message-Id: <1503602048-12268-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/16] qapi-schema: Improve section headings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

The generated QEMU QMP reference is now structured as follows:

    1.1 Introduction
    1.2 Stability Considerations
    1.3 Common data types
    1.4 Socket data types
    1.5 VM run state
    1.6 Cryptography
    1.7 Block devices
    1.7.1 Block core (VM unrelated)
    1.7.2 QAPI block definitions (vm unrelated)
    1.8 Character devices
    1.9 Net devices
    1.10 Rocker switch device
    1.11 TPM (trusted platform module) devices
    1.12 Remote desktop
    1.12.1 Spice
    1.12.2 VNC
    1.13 Input
    1.14 Migration
    1.15 Transactions
    1.16 Tracing
    1.17 QMP introspection
    1.18 Miscellanea

Section "1.18 Miscellanea" is still too big: it documents 134 symbols.
Section "1.7.1 Block core (VM unrelated)" is also rather big: 128
symbols.  All the others are of reasonable size.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 2 +-
 qapi/block-core.json | 2 +-
 qapi/block.json      | 5 ++---
 qapi/common.json     | 2 +-
 qapi/crypto.json     | 2 +-
 qapi/trace.json      | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 7a393ec..f3af2cb 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -94,7 +94,7 @@
 { 'include': 'qapi/introspect.json' }
 
 ##
-# = QMP commands
+# = Miscellanea
 ##
 
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f4caa5c..28abb9e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,7 +1,7 @@
 # -*- Mode: Python -*-
 
 ##
-# == QAPI block core definitions (vm unrelated)
+# == Block core (VM unrelated)
 ##
 
 { 'include': 'common.json' }
diff --git a/qapi/block.json b/qapi/block.json
index 8ce3357..f093fa3 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,14 +1,13 @@
 # -*- Mode: Python -*-
 
 ##
-# = QAPI block definitions
+# = Block devices
 ##
 
-# QAPI block core definitions
 { 'include': 'block-core.json' }
 
 ##
-# == QAPI block definitions (vm unrelated)
+# == Additional block stuff (VM related)
 ##
 
 ##
diff --git a/qapi/common.json b/qapi/common.json
index 0c67e4a..6eb0182 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,7 +1,7 @@
 # -*- Mode: Python -*-
 
 ##
-# = QAPI common definitions
+# = Common data types
 ##
 
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6b6fde3..288bc05 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -2,7 +2,7 @@
 #
 
 ##
-# = QAPI crypto definitions
+# = Cryptography
 ##
 
 ##
diff --git a/qapi/trace.json b/qapi/trace.json
index de6588d..799b254 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -6,7 +6,7 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Tracing commands
+# = Tracing
 ##
 
 ##
-- 
2.7.5
