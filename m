Received: from eggs.gnu.org ([2001:4830:134:3::10]:44447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZi8G-0003CJ-D9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZi8F-00075I-Oz
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:58:48 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Feb 2017 17:58:42 +0000
Message-Id: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] CODING_STYLE: Mention preferred comment form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

Our defacto coding style strongly prefers /* */ style comments
over the single-line // style, and checkpatch enforces this,
but we don't actually document this. Mention it in CODING_STYLE.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 CODING_STYLE | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index f53180b..2fa0c0b 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -116,3 +116,10 @@ if (a == 1) {
 Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
 Besides, good compilers already warn users when '==' is mis-typed as '=',
 even when the constant is on the right.
+
+7. Comment style
+
+We use traditional C-style /* */ comments and avoid // comments.
+
+Rationale: The // form is valid in C99, so this is purely a matter of
+consistency of style. The checkpatch script will warn you about this.
-- 
2.7.4
