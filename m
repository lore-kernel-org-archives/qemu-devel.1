Received: from eggs.gnu.org ([209.51.188.92]:49941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwIND-0000em-2J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwINA-0003Cv-VO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:16:38 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 20 Feb 2019 11:15:56 +0800
Message-Id: <20190220031557.26293-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190220031557.26293-1-richardw.yang@linux.intel.com>
References: <20190220031557.26293-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/2] CODING_STYLE: specify the indent rule
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
mislead users. And in current code, the code use different rules.

Add this rule in CODING_STYLE to make sure this is clear to every one.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

---
v3:
   * misleading -> mislead
   * add comma after arg2 in example
v2:
   * rephrase changelog suggested by Eric Blake
     - remove one redundant line
     - fix some awkward grammar
     - add { ; at the end of example

c1
---
 CODING_STYLE | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index ec075dedc4..1359f9ab81 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -29,6 +29,29 @@ Spaces of course are superior to tabs because:
 
 Do not leave whitespace dangling off the ends of lines.
 
+1.1 Multiline Indent
+
+There are several places where indent is necessary:
+
+ - struct definition
+ - if/else
+ - while/for
+ - function definition & call
+
+When breaking up a long line to fit within line widths, align the secondary
+lines just after the opening parenthesis of the first.
+
+For example:
+
+    if (a == 1 &&
+        b == 2) {
+
+    while (a == 1 &&
+           b == 2) {
+
+    do_something(arg1, arg2,
+                 arg3);
+
 2. Line width
 
 Lines should be 80 characters; try not to make them longer.
-- 
2.19.1
