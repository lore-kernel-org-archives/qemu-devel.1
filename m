Received: from eggs.gnu.org ([2001:4830:134:3::10]:51069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4f7-0001aw-Gy
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4f6-0002fM-19
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:05 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:40685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ez4f5-0002eb-LR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:03 -0400
Received: by mail-lf0-x242.google.com with SMTP id e5-v6so14559527lfb.7
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:10:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 11:09:38 -0700
Message-Id: <20180322180940.8253-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180322180940.8253-1-jcmvbkbc@gmail.com>
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/3] target/xtensa: add .inc. to non-top level
 source file names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Fix definitions of existing cores and core importing script.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/core-dc232b.c                                           | 4 ++--
 target/xtensa/core-dc232b/{gdb-config.c => gdb-config.inc.c}          | 0
 target/xtensa/core-dc232b/{xtensa-modules.c => xtensa-modules.inc.c}  | 0
 target/xtensa/core-dc233c.c                                           | 4 ++--
 target/xtensa/core-dc233c/{gdb-config.c => gdb-config.inc.c}          | 0
 target/xtensa/core-dc233c/{xtensa-modules.c => xtensa-modules.inc.c}  | 0
 target/xtensa/core-de212.c                                            | 4 ++--
 target/xtensa/core-de212/{gdb-config.c => gdb-config.inc.c}           | 0
 target/xtensa/core-de212/{xtensa-modules.c => xtensa-modules.inc.c}   | 0
 target/xtensa/core-fsf.c                                              | 2 +-
 target/xtensa/core-fsf/{xtensa-modules.c => xtensa-modules.inc.c}     | 0
 target/xtensa/core-sample_controller.c                                | 4 ++--
 .../xtensa/core-sample_controller/{gdb-config.c => gdb-config.inc.c}  | 0
 .../core-sample_controller/{xtensa-modules.c => xtensa-modules.inc.c} | 0
 14 files changed, 9 insertions(+), 9 deletions(-)
 rename target/xtensa/core-dc232b/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-dc232b/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-dc233c/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-dc233c/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-de212/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-de212/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-fsf/{xtensa-modules.c => xtensa-modules.inc.c} (100%)
 rename target/xtensa/core-sample_controller/{gdb-config.c => gdb-config.inc.c} (100%)
 rename target/xtensa/core-sample_controller/{xtensa-modules.c => xtensa-modules.inc.c} (100%)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index fe80582df465..aa07018af4e7 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -35,7 +35,7 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_dc232b
-#include "core-dc232b/xtensa-modules.c"
+#include "core-dc232b/xtensa-modules.inc.c"
 
 static XtensaConfig dc232b __attribute__((unused)) = {
     .name = "dc232b",
@@ -43,7 +43,7 @@ static XtensaConfig dc232b __attribute__((unused)) = {
         .num_regs = 120,
         .num_core_regs = 52,
         .reg = {
-#include "core-dc232b/gdb-config.c"
+#include "core-dc232b/gdb-config.inc.c"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-dc232b/gdb-config.c b/target/xtensa/core-dc232b/gdb-config.inc.c
similarity index 100%
rename from target/xtensa/core-dc232b/gdb-config.c
rename to target/xtensa/core-dc232b/gdb-config.inc.c
diff --git a/target/xtensa/core-dc232b/xtensa-modules.c b/target/xtensa/core-dc232b/xtensa-modules.inc.c
similarity index 100%
rename from target/xtensa/core-dc232b/xtensa-modules.c
rename to target/xtensa/core-dc232b/xtensa-modules.inc.c
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index 00301c28a2e8..8296e6fa109a 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -36,7 +36,7 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_dc233c
-#include "core-dc233c/xtensa-modules.c"
+#include "core-dc233c/xtensa-modules.inc.c"
 
 static XtensaConfig dc233c __attribute__((unused)) = {
     .name = "dc233c",
@@ -44,7 +44,7 @@ static XtensaConfig dc233c __attribute__((unused)) = {
         .num_regs = 121,
         .num_core_regs = 52,
         .reg = {
-#include "core-dc233c/gdb-config.c"
+#include "core-dc233c/gdb-config.inc.c"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-dc233c/gdb-config.c b/target/xtensa/core-dc233c/gdb-config.inc.c
similarity index 100%
rename from target/xtensa/core-dc233c/gdb-config.c
rename to target/xtensa/core-dc233c/gdb-config.inc.c
diff --git a/target/xtensa/core-dc233c/xtensa-modules.c b/target/xtensa/core-dc233c/xtensa-modules.inc.c
similarity index 100%
rename from target/xtensa/core-dc233c/xtensa-modules.c
rename to target/xtensa/core-dc233c/xtensa-modules.inc.c
diff --git a/target/xtensa/core-de212.c b/target/xtensa/core-de212.c
index 466a467f7fa0..53775a97fae0 100644
--- a/target/xtensa/core-de212.c
+++ b/target/xtensa/core-de212.c
@@ -36,13 +36,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_de212
-#include "core-de212/xtensa-modules.c"
+#include "core-de212/xtensa-modules.inc.c"
 
 static XtensaConfig de212 __attribute__((unused)) = {
     .name = "de212",
     .gdb_regmap = {
         .reg = {
-#include "core-de212/gdb-config.c"
+#include "core-de212/gdb-config.inc.c"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-de212/gdb-config.c b/target/xtensa/core-de212/gdb-config.inc.c
similarity index 100%
rename from target/xtensa/core-de212/gdb-config.c
rename to target/xtensa/core-de212/gdb-config.inc.c
diff --git a/target/xtensa/core-de212/xtensa-modules.c b/target/xtensa/core-de212/xtensa-modules.inc.c
similarity index 100%
rename from target/xtensa/core-de212/xtensa-modules.c
rename to target/xtensa/core-de212/xtensa-modules.inc.c
diff --git a/target/xtensa/core-fsf.c b/target/xtensa/core-fsf.c
index f41de9a1aa05..01932bdc8b15 100644
--- a/target/xtensa/core-fsf.c
+++ b/target/xtensa/core-fsf.c
@@ -36,7 +36,7 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_fsf
-#include "core-fsf/xtensa-modules.c"
+#include "core-fsf/xtensa-modules.inc.c"
 
 static XtensaConfig fsf __attribute__((unused)) = {
     .name = "fsf",
diff --git a/target/xtensa/core-fsf/xtensa-modules.c b/target/xtensa/core-fsf/xtensa-modules.inc.c
similarity index 100%
rename from target/xtensa/core-fsf/xtensa-modules.c
rename to target/xtensa/core-fsf/xtensa-modules.inc.c
diff --git a/target/xtensa/core-sample_controller.c b/target/xtensa/core-sample_controller.c
index 879e853a9224..c622335ca5a2 100644
--- a/target/xtensa/core-sample_controller.c
+++ b/target/xtensa/core-sample_controller.c
@@ -36,13 +36,13 @@
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_sample_controller
-#include "core-sample_controller/xtensa-modules.c"
+#include "core-sample_controller/xtensa-modules.inc.c"
 
 static XtensaConfig sample_controller __attribute__((unused)) = {
     .name = "sample_controller",
     .gdb_regmap = {
         .reg = {
-#include "core-sample_controller/gdb-config.c"
+#include "core-sample_controller/gdb-config.inc.c"
         }
     },
     .isa_internal = &xtensa_modules,
diff --git a/target/xtensa/core-sample_controller/gdb-config.c b/target/xtensa/core-sample_controller/gdb-config.inc.c
similarity index 100%
rename from target/xtensa/core-sample_controller/gdb-config.c
rename to target/xtensa/core-sample_controller/gdb-config.inc.c
diff --git a/target/xtensa/core-sample_controller/xtensa-modules.c b/target/xtensa/core-sample_controller/xtensa-modules.inc.c
similarity index 100%
rename from target/xtensa/core-sample_controller/xtensa-modules.c
rename to target/xtensa/core-sample_controller/xtensa-modules.inc.c
-- 
2.11.0
