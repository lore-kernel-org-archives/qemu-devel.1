Received: from eggs.gnu.org ([209.51.188.92]:42513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46g-0003Hf-UP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46f-0004iB-4k
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46e-0004ac-So
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4IL4054682
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:25 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97pamt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:22 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:39 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:33 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-60-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 59/97] target/xtensa: drop num_[core_]regs from
 dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

Now that xtensa_count_regs does the right thing, remove manual
initialization of these fields from the affected configurations and let
xtensa_finalize_config initialize them. Add XTREG_END to terminate
register lists.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
(cherry picked from commit 7da9111e77b9cdb3a927dcd47642b7ffff9de636)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/xtensa/core-dc232b.c                | 2 --
 target/xtensa/core-dc232b/gdb-config.inc.c | 1 +
 target/xtensa/core-dc233c.c                | 2 --
 target/xtensa/core-dc233c/gdb-config.inc.c | 1 +
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 7131337840..7851bcb636 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -40,8 +40,6 @@
 static XtensaConfig dc232b __attribute__((unused)) = {
     .name = "dc232b",
     .gdb_regmap = {
-        .num_regs = 120,
-        .num_core_regs = 52,
         .reg = {
 #include "core-dc232b/gdb-config.inc.c"
         }
diff --git a/target/xtensa/core-dc232b/gdb-config.inc.c b/target/xtensa/core-dc232b/gdb-config.inc.c
index 13aba5edec..d87168628b 100644
--- a/target/xtensa/core-dc232b/gdb-config.inc.c
+++ b/target/xtensa/core-dc232b/gdb-config.inc.c
@@ -259,3 +259,4 @@
           0, 0, 0, 0, 0, 0)
   XTREG(119, 476, 32, 4, 4, 0x000f, 0x0006, -2, 8, 0x0100, a15,
           0, 0, 0, 0, 0, 0)
+  XTREG_END
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index d701e3f5de..8853bfd4d0 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -40,8 +40,6 @@
 static XtensaConfig dc233c __attribute__((unused)) = {
     .name = "dc233c",
     .gdb_regmap = {
-        .num_regs = 121,
-        .num_core_regs = 52,
         .reg = {
 #include "core-dc233c/gdb-config.inc.c"
         }
diff --git a/target/xtensa/core-dc233c/gdb-config.inc.c b/target/xtensa/core-dc233c/gdb-config.inc.c
index b632341b28..7e8963227f 100644
--- a/target/xtensa/core-dc233c/gdb-config.inc.c
+++ b/target/xtensa/core-dc233c/gdb-config.inc.c
@@ -143,3 +143,4 @@ XTREG(117, 468, 32, 4, 4, 0x000c, 0x0006, -2, 8, 0x0100, a12,         0, 0, 0, 0
 XTREG(118, 472, 32, 4, 4, 0x000d, 0x0006, -2, 8, 0x0100, a13,         0, 0, 0, 0, 0, 0)
 XTREG(119, 476, 32, 4, 4, 0x000e, 0x0006, -2, 8, 0x0100, a14,         0, 0, 0, 0, 0, 0)
 XTREG(120, 480, 32, 4, 4, 0x000f, 0x0006, -2, 8, 0x0100, a15,         0, 0, 0, 0, 0, 0)
+XTREG_END
-- 
2.17.1
