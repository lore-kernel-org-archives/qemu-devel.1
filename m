Received: from eggs.gnu.org ([2001:4830:134:3::10]:41083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLt-0005Dm-KV
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmLr-0004cW-IB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmLp-0004Vv-KU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:01:46 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:09 -0200
Message-Id: <20181211180129.7661-5-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/24] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>

From: Kashyap Chamarthy <kchamart@redhat.com>

The intended functionality of QMP `cpu-add` is replaced with
`device_add` (and `query-hotpluggable-cpus`).  So let's deprecate
`cpu-add`.

A complete example of vCPU hotplug with the recommended way (using
`device_add`) is provided as part of a seperate docs patch.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com
Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20181030123526.26415-2-kchamart@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/misc.json       | 8 +++++++-
 qemu-deprecated.texi | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 6c1c5c0a37..45121492dd 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1109,7 +1109,7 @@
 ##
 # @cpu-add:
 #
-# Adds CPU with specified ID
+# Adds CPU with specified ID.
 #
 # @id: ID of CPU to be created, valid values [0..max_cpus)
 #
@@ -1117,6 +1117,10 @@
 #
 # Since: 1.5
 #
+# Note: This command is deprecated.  The `device_add` command should be
+#       used instead.  See the `query-hotpluggable-cpus` command for
+#       details.
+#
 # Example:
 #
 # -> { "execute": "cpu-add", "arguments": { "id": 2 } }
@@ -3219,6 +3223,8 @@
 ##
 # @query-hotpluggable-cpus:
 #
+# TODO: Better documentation; currently there is none.
+#
 # Returns: a list of HotpluggableCPU objects.
 #
 # Since: 2.7
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index cb4291f1e5..72b8191d60 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -121,6 +121,11 @@ replaced by the ``target'' output member.
 The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
 
+@subsection cpu-add (since 3.1)
+
+Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
+documentation of ``query-hotpluggable-cpus'' for additional details.
+
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
-- 
2.18.0.rc1.1.g3f1ff2140
