Received: from eggs.gnu.org ([2001:4830:134:3::10]:48899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFOt-000197-Hc
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFOq-0000Uw-CF
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:43 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFOq-0000U3-7m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:40 -0500
Received: by mail-ot0-x232.google.com with SMTP id 45so5258899otd.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:18:40 -0800 (PST)
From: ben@skyportsystems.com
Date: Wed, 15 Feb 2017 22:18:18 -0800
Message-Id: <a669a5fd5981d6bb4820f0d9915f5a2633638a6a.1487224954.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487224954.git.ben@skyportsystems.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487224954.git.ben@skyportsystems.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v7 8/8] MAINTAINERS: Add VM Generation ID entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

Also add BIOS tables entry

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb57d8e..e2e4b4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -909,6 +909,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
+F: tests/bios-tables-test.c
 
 ppc4xx
 M: Alexander Graf <agraf@suse.de>
@@ -1123,6 +1124,13 @@ F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
 F: tests/prom-env-test.c
 
+VM Generation ID
+M: Ben Warren <ben@skyportsystems.com>
+S: Maintained
+F: hw/acpi/vmgenid.c
+F: include/hw/acpi/vmgenid.h
+F: tests/vmgenid-test.c
+
 Subsystems
 ----------
 Audio
-- 
2.7.4
