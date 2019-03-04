Received: from eggs.gnu.org ([209.51.188.92]:45557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h0hqp-0007UU-GS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h0hqn-0007sw-Po
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:17:27 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon,  4 Mar 2019 15:16:31 +0800
Message-Id: <20190304071631.27567-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190304071631.27567-1-richardw.yang@linux.intel.com>
References: <20190304071631.27567-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 2/2] CODING_STYLE: indent example code as
 all others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru, imammedo@redhat.com, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, sgarzare@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

All the example code are indented with four spaces except this one.

Fix this by adding four spaces here.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 CODING_STYLE | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/CODING_STYLE b/CODING_STYLE
index 90321e9c28..cb8edcbb36 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -147,10 +147,10 @@ block to a separate function altogether.
 When comparing a variable for (in)equality with a constant, list the
 constant on the right, as in:
 
-if (a == 1) {
-    /* Reads like: "If a equals 1" */
-    do_something();
-}
+    if (a == 1) {
+        /* Reads like: "If a equals 1" */
+        do_something();
+    }
 
 Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
 Besides, good compilers already warn users when '==' is mis-typed as '=',
-- 
2.19.1
