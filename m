Received: from eggs.gnu.org ([2001:4830:134:3::10]:60001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2gd-0007cs-Mr
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2ga-00042P-LM
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:53:23 -0400
Received: from [107.173.13.209] (port=35792 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2ga-00042E-ER
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:53:20 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 30 Apr 2018 16:52:35 +1000
Message-Id: <20180430065235.577-1-aik@ozlabs.ru>
In-Reply-To: <87o9inxkd1.fsf@dusky.pond.sub.org>
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
Subject: [Qemu-devel] [PATCH qemu] qom: Document qom/device-list-properties
 implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 qapi/misc.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a..399ec74 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1491,6 +1491,10 @@
 #
 # List properties associated with a device.
 #
+# Note: the handler creates a device object, enumerates properties and destroys
+# the object so it only lists properties defined in DeviceClass::props or
+# created by DeviceClass::init()/TypeInfo::instance_init().
+#
 # @typename: the type name of a device
 #
 # Returns: a list of ObjectPropertyInfo describing a devices properties
@@ -1506,6 +1510,11 @@
 #
 # List properties associated with a QOM object.
 #
+# Note: the handler creates an object, enumerates properties and destroys
+# the object so it only lists properties created in TypeInfo::instance_init().
+# Since the instance_init() callback of the device object adds
+# DeviceClass::props as object properties, they will be listed as well.
+#
 # @typename: the type name of an object
 #
 # Returns: a list of ObjectPropertyInfo describing object properties
-- 
2.11.0
