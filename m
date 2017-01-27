Received: from eggs.gnu.org ([2001:4830:134:3::10]:35046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yR-0007pU-Re
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cX0yH-0005Ki-R1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cX0yH-0005Jj-Gn
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:29:21 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jan 2017 08:29:16 +0100
Message-Id: <1485502157-25445-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1485502157-25445-1-git-send-email-armbru@redhat.com>
References: <1485502157-25445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] qapi: Remove unwanted commas after
 #optional keyword
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>

From: Stefan Weil <sw@weilnetz.de>

We don't want that commas to be part of the generated documentation,
so remove them.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20170122145407.27476-1-sw@weilnetz.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     |  4 ++--
 qapi/block-core.json | 10 +++++-----
 qapi/event.json      |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ac55f4a..82fabc6 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1506,7 +1506,7 @@
 #
 # The network connection information for server
 #
-# @auth: #optional, authentication method
+# @auth: #optional authentication method
 #
 # Since: 2.1
 ##
@@ -1694,7 +1694,7 @@
 #
 # Information about a SPICE server
 #
-# @auth: #optional, authentication method
+# @auth: #optional authentication method
 #
 # Since: 2.1
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1b3e6eb..932f5bb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3126,10 +3126,10 @@
 #
 # @filename:        filename of the new image to be loaded
 #
-# @format:          #optional, format to open the new image with (defaults to
+# @format:          #optional format to open the new image with (defaults to
 #                   the probed format)
 #
-# @read-only-mode:  #optional, change the read-only mode of the device; defaults
+# @read-only-mode:  #optional change the read-only mode of the device; defaults
 #                   to 'retain'
 #
 # Since: 2.5
@@ -3208,10 +3208,10 @@
 #       corruption being detected. It should not be parsed by machine as it is
 #       not guaranteed to be stable
 #
-# @offset: #optional, if the corruption resulted from an image access, this is
+# @offset: #optional if the corruption resulted from an image access, this is
 #          the host's access offset into the image
 #
-# @size: #optional, if the corruption resulted from an image access, this is
+# @size: #optional if the corruption resulted from an image access, this is
 #        the access size
 #
 # @fatal: if set, the image is marked corrupt and therefore unusable after this
@@ -3302,7 +3302,7 @@
 #
 # @speed: rate limit, bytes per second
 #
-# @error: #optional, error message. Only present on failure. This field
+# @error: #optional error message. Only present on failure. This field
 #         contains a human-readable error message. There are no semantics
 #         other than that streaming has failed and clients should not try to
 #         interpret the error string
diff --git a/qapi/event.json b/qapi/event.json
index f3737b7..7bf539b 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -186,7 +186,7 @@
 # At this point, it's safe to reuse the specified device ID. Device removal can
 # be initiated by the guest or by HMP/QMP commands.
 #
-# @device: #optional, device name
+# @device: #optional device name
 #
 # @path: device path
 #
@@ -209,7 +209,7 @@
 # Emitted once until the 'query-rx-filter' command is executed, the first event
 # will always be emitted
 #
-# @name: #optional, net client name
+# @name: #optional net client name
 #
 # @path: device path
 #
@@ -531,7 +531,7 @@
 #
 # @type: quorum operation type (Since 2.6)
 #
-# @error: #optional, error message. Only present on failure. This field
+# @error: #optional error message. Only present on failure. This field
 #         contains a human-readable error message. There are no semantics other
 #         than that the block layer reported an error and clients should not
 #         try to interpret the error string.
-- 
2.7.4
