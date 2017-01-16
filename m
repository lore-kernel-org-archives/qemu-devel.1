Received: from eggs.gnu.org ([2001:4830:134:3::10]:56870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq4-0002Tg-PY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq2-0007HV-KJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:08 -0500
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:35840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTCq2-0007HJ-ET
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:06 -0500
Received: by mail-pf0-x232.google.com with SMTP id 189so55491758pfu.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:21:06 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 16 Jan 2017 11:20:53 -0800
Message-Id: <d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
In-Reply-To: <cover.1484593565.git.ben@skyportsystems.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
In-Reply-To: <cover.1484594095.git.ben@skyportsystems.com>
References: <cover.1484594095.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v2 1/6] docs: vm generation id device's
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Gal Hammer <ghammer@redhat.com>

From: Ben Warren <ben@skyportsystems.com>

Signed-off-by: Ben Warren <ben@skyportsystems.com>
Cc: Gal Hammer <ghammer@redhat.com>
---
 docs/specs/vmgenid.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 docs/specs/vmgenid.txt

diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
new file mode 100644
index 0000000..afc1717
--- /dev/null
+++ b/docs/specs/vmgenid.txt
@@ -0,0 +1,38 @@
+VIRTUAL MACHINE GENERATION ID
+=============================
+
+Copyright (C) 2016 Red Hat, Inc.
+Copyright (C) 2016 Skyport Systems, Inc.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
+
+===
+
+The VM generation ID (vmgenid) device is an emulated device which
+exposes a 128-bit, cryptographically random, integer value identifier.
+This allows management applications (e.g. libvirt) to notify the guest
+operating system when the virtual machine is executed with a different
+configuration (e.g. snapshot execution or creation from a template).
+
+This is specified on the web at: http://go.microsoft.com/fwlink/?LinkId=260709
+
+---
+
+The vmgenid device is a sysbus device with the ACPI ID "QEMU_Gen_Counter_V1".
+
+The device has one properties, which can be set using the command line
+argument or the QMP interface:
+ guid - sets the value of the GUID
+For example:
+QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
+
+Or to change guid in runtime use:
+ set-vm-generation-id guid="124e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
+
+According to the specification, any change to the GUID executes an
+ACPI notification. The vmgenid device triggers the \_GPE._E00 handler
+which executes the ACPI Notify operation.
+
+Although not specified in Microsoft's document, it is assumed that the
+device is expected to use the little-endian system.
-- 
2.7.4
