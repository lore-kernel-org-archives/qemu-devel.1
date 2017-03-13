Received: from eggs.gnu.org ([2001:4830:134:3::10]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0007Y5-F1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJk-0003Yz-0e
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003Xs-Rh
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:12 +0100
Message-Id: <1489385927-6735-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 12/47] qapi/rocker: Fix up doc comment
 notes on optional members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Talking about #optional like this

    # Note: fields are marked #optional to indicate that they may or may
    # not appear ...

doesn't work so well in generated documentation, because the #optional
tag is not visible there.  Replace by

    # Note: optional members may or may not appear ...

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/rocker.json | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 97e2b83..f374038 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,3 +1,5 @@
+# -*- Mode: Python -*-
+
 ##
 # = Rocker switch device
 ##
@@ -137,8 +139,8 @@
 #
 # @ip-dst: #optional IP header destination address
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the flow key depending if they're relevant to the flow key.
+# Note: optional members may or may not appear in the flow key
+# depending if they're relevant to the flow key.
 #
 # Since: 2.4
 ##
@@ -167,8 +169,8 @@
 #
 # @ip-tos: #optional IP header TOS field
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the flow mask depending if they're relevant to the flow mask.
+# Note: optional members may or may not appear in the flow mask
+# depending if they're relevant to the flow mask.
 #
 # Since: 2.4
 ##
@@ -194,8 +196,8 @@
 #
 # @out-pport: #optional physical output port
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the flow action depending if they're relevant to the flow action.
+# Note: optional members may or may not appear in the flow action
+# depending if they're relevant to the flow action.
 #
 # Since: 2.4
 ##
@@ -288,8 +290,8 @@
 #
 # @ttl-check: #optional perform TTL check
 #
-# Note: fields are marked #optional to indicate that they may or may not
-# appear in the group depending if they're relevant to the group type.
+# Note: optional members may or may not appear in the group depending
+# if they're relevant to the group type.
 #
 # Since: 2.4
 ##
-- 
2.7.4
