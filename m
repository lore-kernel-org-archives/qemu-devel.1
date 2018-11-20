Received: from eggs.gnu.org ([2001:4830:134:3::10]:39862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gOvxE-000091-UM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gOvxE-0006Cm-6w
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:56 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gOvxD-0006A4-W6
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 21:39:56 -0500
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so311268ljk.3
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 18:39:55 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 19 Nov 2018 18:39:34 -0800
Message-Id: <20181120023934.8552-3-jcmvbkbc@gmail.com>
In-Reply-To: <20181120023934.8552-1-jcmvbkbc@gmail.com>
References: <20181120023934.8552-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] target/xtensa: drop num_[core_]regs from
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
Cc: Max Filippov <jcmvbkbc@gmail.com>

Now that xtensa_count_regs does the right thing, remove manual
initialization of these fields from the affected configurations and let
xtensa_finalize_config initialize them. Add XTREG_END to terminate
register lists.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/core-dc232b.c                | 2 --
 target/xtensa/core-dc232b/gdb-config.inc.c | 1 +
 target/xtensa/core-dc233c.c                | 2 --
 target/xtensa/core-dc233c/gdb-config.inc.c | 1 +
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 71313378409e..7851bcb63687 100644
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
index 13aba5edecd6..d87168628be8 100644
--- a/target/xtensa/core-dc232b/gdb-config.inc.c
+++ b/target/xtensa/core-dc232b/gdb-config.inc.c
@@ -259,3 +259,4 @@
           0, 0, 0, 0, 0, 0)
   XTREG(119, 476, 32, 4, 4, 0x000f, 0x0006, -2, 8, 0x0100, a15,
           0, 0, 0, 0, 0, 0)
+  XTREG_END
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index d701e3f5de07..8853bfd4d08f 100644
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
index b632341b28ec..7e8963227fc0 100644
--- a/target/xtensa/core-dc233c/gdb-config.inc.c
+++ b/target/xtensa/core-dc233c/gdb-config.inc.c
@@ -143,3 +143,4 @@ XTREG(117, 468, 32, 4, 4, 0x000c, 0x0006, -2, 8, 0x0100, a12,         0, 0, 0, 0
 XTREG(118, 472, 32, 4, 4, 0x000d, 0x0006, -2, 8, 0x0100, a13,         0, 0, 0, 0, 0, 0)
 XTREG(119, 476, 32, 4, 4, 0x000e, 0x0006, -2, 8, 0x0100, a14,         0, 0, 0, 0, 0, 0)
 XTREG(120, 480, 32, 4, 4, 0x000f, 0x0006, -2, 8, 0x0100, a15,         0, 0, 0, 0, 0, 0)
+XTREG_END
-- 
2.11.0
