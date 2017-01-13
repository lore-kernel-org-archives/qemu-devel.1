Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS339-0003KO-Ax
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS338-0006RZ-9I
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS338-0006R7-0E
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E847F8FD07
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:21 +0100
Message-Id: <20170113144135.5150-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 07/21] qapi: avoid interleaving sections and
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Follow documentation guideline, body, parameters then additional
sections.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 10 +++++-----
 qapi/event.json      |  4 ++--
 qapi/introspect.json |  3 +--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 6c251605ac..c1af70057d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4733,17 +4733,17 @@
 # it should be passed by management with device_add command when
 # a CPU is being hotplugged.
 #
+# @node-id: #optional NUMA node ID the CPU belongs to
+# @socket-id: #optional socket number within node/board the CPU belongs =
to
+# @core-id: #optional core number within socket the CPU belongs to
+# @thread-id: #optional thread number within core the CPU belongs to
+#
 # Note: currently there are 4 properties that could be present
 # but management should be prepared to pass through other
 # properties with device_add command to allow for future
 # interface extension. This also requires the filed names to be kept in
 # sync with the properties passed to -device/device_add.
 #
-# @node-id: #optional NUMA node ID the CPU belongs to
-# @socket-id: #optional socket number within node/board the CPU belongs =
to
-# @core-id: #optional core number within socket the CPU belongs to
-# @thread-id: #optional thread number within core the CPU belongs to
-#
 # Since: 2.7
 ##
 { 'struct': 'CpuInstanceProperties',
diff --git a/qapi/event.json b/qapi/event.json
index 37bf34ed6d..c7689b211d 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -272,9 +272,9 @@
 #
 # Emitted when guest executes ACPI _OST method.
 #
-# Since: 2.1
-#
 # @info: ACPIOSTInfo type as described in qapi-schema.json
+#
+# Since: 2.1
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 464097a235..f6adc439bb 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -78,14 +78,13 @@
 # @SchemaInfo:
 #
 # @name: the entity's name, inherited from @base.
+#        The SchemaInfo is always referenced by this name.
 #        Commands and events have the name defined in the QAPI schema.
 #        Unlike command and event names, type names are not part of
 #        the wire ABI.  Consequently, type names are meaningless
 #        strings here, although they are still guaranteed unique
 #        regardless of @meta-type.
 #
-# All references to other SchemaInfo are by name.
-#
 # @meta-type: the entity's meta type, inherited from @base.
 #
 # Additional members depend on the value of @meta-type.
--=20
2.11.0
