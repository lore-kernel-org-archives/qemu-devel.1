Received: from eggs.gnu.org ([209.51.188.92]:36995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvuGB-0006pJ-SH
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 20:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvuGB-00025n-3X
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 20:31:47 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 19 Feb 2019 09:31:05 +0800
Message-Id: <20190219013106.17538-2-richardw.yang@linux.intel.com>
In-Reply-To: <20190219013106.17538-1-richardw.yang@linux.intel.com>
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] CODING_STYLE: specify the indent rule for
 multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru, imammedo@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

We didn't specify the indent rule for multiline code here, which may
misleading users. And in current code, the code use different rules.

Add this rule in CODING_STYLE to make sure this is clear to every one.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
---
 CODING_STYLE | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index ec075dedc4..73f66ca185 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -29,6 +29,32 @@ Spaces of course are superior to tabs because:
 
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
+All the above cases apply the same rule: indent with four spaces.
+
+While the last three case may face another situation: code should spread into
+several lines. In this case the rule is align the new line with first
+parentheses.
+
+For example:
+
+    if (a == 1 &&
+        b == 2)
+
+    while (a == 1 &&
+           b == 2)
+
+    do_something(arg1, arg2
+                 arg3)
+
 2. Line width
 
 Lines should be 80 characters; try not to make them longer.
-- 
2.19.1
