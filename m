Received: from eggs.gnu.org ([209.51.188.92]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3KE3-0006Qx-Pd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3KE2-0001oW-Rn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:40:15 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 13:35:05 +0100
Message-Id: <20190311123507.24867-2-pbonzini@redhat.com>
In-Reply-To: <20190311123507.24867-1-pbonzini@redhat.com>
References: <20190311123507.24867-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] qemugdb: fix licensing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

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
index 690827e6fc..f2a305c42e 100644
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
=20
 # Usage:
 # At the (gdb) prompt, type "source scripts/qemu-gdb.py".
diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 81f811ac00..41e079d0e2 100644
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
=20
 import gdb
=20
diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index e6791b7885..3030a60d3f 100644
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
=20
 # 'qemu mtree' -- display the memory hierarchy
=20
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
index 8c7f1d7454..18880fc9a7 100644
--- a/scripts/qemugdb/tcg.py
+++ b/scripts/qemugdb/tcg.py
@@ -8,11 +8,8 @@
 # Authors:
 #  Alex Benn=C3=A9e <alex.bennee@linaro.org>
 #
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
-# Contributions after 2012-01-13 are licensed under the terms of the
-# GNU GPL, version 2 or (at your option) any later version.
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
=20
 # 'qemu tcg-lock-status' -- display the TCG lock status across threads
=20
--=20
2.20.1
