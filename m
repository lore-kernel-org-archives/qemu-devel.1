Received: from eggs.gnu.org ([2001:4830:134:3::10]:60272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gHTFK-00060O-Tv
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gHTFI-0002lh-Ok
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gHTFG-0002ZC-EW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60DBF65871
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:35:38 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Tue, 30 Oct 2018 13:35:24 +0100
Message-Id: <20181030123526.26415-2-kchamart@redhat.com>
In-Reply-To: <20181030123526.26415-1-kchamart@redhat.com>
References: <20181030123526.26415-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, thuth@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

The intended functionality of QMP `cpu-add` is replaced with
`device_add` (and `query-hotpluggable-cpus`).  So let's deprecate
`cpu-add`.

A complete example of vCPU hotplug with the recommended way (using
`device_add`) is provided as part of a seperate docs patch.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com
Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
---
 qapi/misc.json       | 8 +++++++-
 qemu-deprecated.texi | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index d450cfef21..fbee1e6d34 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1104,7 +1104,7 @@
 ##
 # @cpu-add:
 #
-# Adds CPU with specified ID
+# Adds CPU with specified ID.
 #
 # @id: ID of CPU to be created, valid values [0..max_cpus)
 #
@@ -1112,6 +1112,10 @@
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
@@ -3213,6 +3217,8 @@
 ##
 # @query-hotpluggable-cpus:
 #
+# TODO: Better documentation; currently there is none.
+#
 # Returns: a list of HotpluggableCPU objects.
 #
 # Since: 2.7
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 1b9c007f12..c86924ad9a 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -155,6 +155,11 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
 
+@subsection cpu-add (since 3.1)
+
+Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
+documentation of ``query-hotpluggable-cpus'' for additional details.
+
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
-- 
2.17.1
