Received: from eggs.gnu.org ([209.51.188.92]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gzXVM-0001b3-34
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 21:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gzXVL-0002tF-2c
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 21:02:28 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri,  1 Mar 2019 10:01:46 +0800
Message-Id: <20190301020147.18567-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190301020147.18567-1-richardw.yang@linux.intel.com>
References: <20190301020147.18567-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 1/2] CODING_STYLE: specify the indent rule
 for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru, imammedo@redhat.com, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, Wei Yang <richardw.yang@linux.intel.com>

We didn't specify the indent rule for multiline code here, which may
mislead users. And in current code, the code use various styles.

Add this rule in CODING_STYLE to make sure this is clear to every one.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>

---
v5:
   * different rules -> various styles
   * describe function variants separately
   * take struct out
v4:
   * widths -> width
   * add an exception example for function
v3:
   * misleading -> mislead
   * add comma after arg2 in example
v2:
   * rephrase changelog suggested by Eric Blake
     - remove one redundant line
     - fix some awkward grammar
     - add { ; at the end of example
---
 CODING_STYLE | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index ec075dedc4..e175e6ea9a 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -29,6 +29,45 @@ Spaces of course are superior to tabs because:
 
 Do not leave whitespace dangling off the ends of lines.
 
+1.1 Multiline Indent
+
+There are several places where indent is necessary:
+
+ - if/else
+ - while/for
+ - function definition & call
+
+When breaking up a long line to fit within line width, we need a proper indent
+for the following lines.
+
+In case of if/else, while/for, align the secondary lines just after the
+opening parenthesis of the first.
+
+For example:
+
+    if (a == 1 &&
+        b == 2) {
+
+    while (a == 1 &&
+           b == 2) {
+
+In case of function, there are several variants:
+
+    * 4 spaces indent from the beginning
+    * align the secondary lines just after the opening parenthesis of the
+      first
+
+For example:
+
+    do_something(x, y,
+        z);
+
+    do_something(x, y,
+                 z);
+
+    do_something(x, do_another(y,
+                               z);
+
 2. Line width
 
 Lines should be 80 characters; try not to make them longer.
-- 
2.19.1
