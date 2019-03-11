Received: from eggs.gnu.org ([209.51.188.92]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODo-0007L8-Hj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODn-0003il-06
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODm-0003fN-PG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id o10so207343wmc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:13 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e12sm6484836wrs.91.2019.03.11.09.56.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 09:56:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:35 +0100
Message-Id: <1552323335-46779-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 31/31] qemugdb: fix licensing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu-gdb.py was committed after 2012-01-13, so the notice about
GPL v2-only contributions does not apply.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemu-gdb.py          | 7 ++-----
 scripts/qemugdb/coroutine.py | 7 ++-----
 scripts/qemugdb/mtree.py     | 7 ++-----
 scripts/qemugdb/tcg.py       | 7 ++-----
 4 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index 690827e..f2a305c 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -7,11 +7,8 @@
 # Authors:
 #  Avi Kivity <avi@redhat.com>
 #
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
-# Contributions after 2012-01-13 are licensed under the terms of the
-# GNU GPL, version 2 or (at your option) any later version.
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
 
 # Usage:
 # At the (gdb) prompt, type "source scripts/qemu-gdb.py".
diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 81f811a..41e079d 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -7,11 +7,8 @@
 # Authors:
 #  Avi Kivity <avi@redhat.com>
 #
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
-# Contributions after 2012-01-13 are licensed under the terms of the
-# GNU GPL, version 2 or (at your option) any later version.
+# This work is licensed under the terms of the GNU GPL, version 2
+# or later.  See the COPYING file in the top-level directory.
 
 import gdb
 
diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index e6791b7..3030a60 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -7,11 +7,8 @@
 # Authors:
 #  Avi Kivity <avi@redhat.com>
 #
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
-# Contributions after 2012-01-13 are licensed under the terms of the
-# GNU GPL, version 2 or (at your option) any later version.
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
 
 # 'qemu mtree' -- display the memory hierarchy
 
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
index 8c7f1d7..18880fc 100644
--- a/scripts/qemugdb/tcg.py
+++ b/scripts/qemugdb/tcg.py
@@ -8,11 +8,8 @@
 # Authors:
 #  Alex Bennée <alex.bennee@linaro.org>
 #
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
-# Contributions after 2012-01-13 are licensed under the terms of the
-# GNU GPL, version 2 or (at your option) any later version.
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
 
 # 'qemu tcg-lock-status' -- display the TCG lock status across threads
 
-- 
1.8.3.1
