Received: from eggs.gnu.org ([2001:4830:134:3::10]:37019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iC-0000qW-Bp
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iB-0004kG-8Q
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:39:56 +0100
Message-Id: <20180522104000.9044-2-peter.maydell@linaro.org>
In-Reply-To: <20180522104000.9044-1-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] qapi: Change "since 2.13" annotations to
 "since 3.0"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

We're going to make the next release be 3.0, not 2.13; change
the annotations in our json appropriately.

Changes produced with
  sed -i -e 's/2\.13/3.0/g' qapi/*.json

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json |  4 ++--
 qapi/common.json     |  2 +-
 qapi/migration.json  | 16 ++++++++--------
 qapi/misc.json       |  4 ++--
 qapi/net.json        |  2 +-
 qapi/ui.json         |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 55728cb823..b5ce98856b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2510,7 +2510,7 @@
 # @vxhs: Since 2.10
 # @throttle: Since 2.11
 # @nvme: Since 2.12
-# @copy-on-read: Since 2.13
+# @copy-on-read: Since 3.0
 #
 # Since: 2.9
 ##
@@ -2538,7 +2538,7 @@
 # @x-check-cache-dropped: whether to check that page cache was dropped on live
 #                         migration.  May cause noticeable delays if the image
 #                         file is large, do not use in production.
-#                         (default: off) (since: 2.13)
+#                         (default: off) (since: 3.0)
 #
 # Since: 2.9
 ##
diff --git a/qapi/common.json b/qapi/common.json
index c811d04984..c367adc4b6 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -140,7 +140,7 @@
 #        prefix to produce the corresponding QEMU executable name. This
 #        is true even for "qemu-system-x86_64".
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
   'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
diff --git a/qapi/migration.json b/qapi/migration.json
index 3ec418dabf..dc9cc85545 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -89,9 +89,9 @@
 #
 # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
 #
-# @postcopy-paused: during postcopy but paused. (since 2.13)
+# @postcopy-paused: during postcopy but paused. (since 3.0)
 #
-# @postcopy-recover: trying to recover from a paused postcopy. (since 2.13)
+# @postcopy-recover: trying to recover from a paused postcopy. (since 3.0)
 #
 # @completed: migration is finished.
 #
@@ -163,11 +163,11 @@
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during postcopy
 #           live migration. This is only present when the postcopy-blocktime
-#           migration capability is enabled. (Since 2.13)
+#           migration capability is enabled. (Since 3.0)
 #
 # @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU.  This is
 #           only present when the postcopy-blocktime migration capability
-#           is enabled. (Since 2.13)
+#           is enabled. (Since 3.0)
 #
 #
 # Since: 0.14.0
@@ -374,7 +374,7 @@
 #                 (since 2.12)
 #
 # @postcopy-blocktime: Calculate downtime for postcopy live migration
-#                     (since 2.13)
+#                     (since 3.0)
 #
 # Since: 1.2
 ##
@@ -1034,7 +1034,7 @@
 # @detach: this argument exists only for compatibility reasons and
 #          is ignored by QEMU
 #
-# @resume: resume one paused migration, default "off". (since 2.13)
+# @resume: resume one paused migration, default "off". (since 3.0)
 #
 # Returns: nothing on success
 #
@@ -1208,7 +1208,7 @@
 #      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
 # <- { "return": {} }
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'migrate-recover', 'data': { 'uri': 'str' },
   'allow-oob': true }
@@ -1225,6 +1225,6 @@
 # -> { "execute": "migrate-pause" }
 # <- { "return": {} }
 #
-# Since: 2.13
+# Since: 3.0
 ##
 { 'command': 'migrate-pause', 'allow-oob': true }
diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc0b5..99bcaacd62 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -558,11 +558,11 @@
 # @props: properties describing to which node/socket/core/thread
 #         virtual CPU belongs to, provided if supported by board
 #
-# @arch: base architecture of the cpu; deprecated since 2.13.0 in favor
+# @arch: base architecture of the cpu; deprecated since 3.0.0 in favor
 #        of @target
 #
 # @target: the QEMU system emulation target, which determines which
-#          additional fields will be listed (since 2.13)
+#          additional fields will be listed (since 3.0)
 #
 # Since: 2.12
 #
diff --git a/qapi/net.json b/qapi/net.json
index b8adf1f03f..5c1dc48890 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -498,7 +498,7 @@
 #
 # Since: 1.2
 #
-# 'vlan': dropped in 2.13
+# 'vlan': dropped in 3.0
 ##
 { 'struct': 'NetLegacy',
   'data': {
diff --git a/qapi/ui.json b/qapi/ui.json
index 3ad7835992..fc18a05f0f 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1031,7 +1031,7 @@
  # @core: Use OpenGL with Core (desktop) Context.
  # @es: Use OpenGL with ES (embedded systems) Context.
  #
- # Since: 2.13
+ # Since: 3.0
  #
  ##
  { 'enum'    : 'DisplayGLMode',
-- 
2.17.0
