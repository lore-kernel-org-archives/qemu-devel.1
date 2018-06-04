Received: from eggs.gnu.org ([2001:4830:134:3::10]:59242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPsEs-0000tg-Qy
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPsEr-000744-VL
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:21:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Jun 2018 17:21:40 +0100
Message-Id: <20180604162140.20688-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] CODING_STYLE: Define our preferred form for
 multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org

The codebase has a bit of a mix of
 /* multiline comments
  * like this
  */
and
 /* multiline comments like this
    in the GNU Coding Standards style */

State a preference for the former.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I admit that to some extent I'm imposing my aesthetic
preferences here; pretty sure we have a lot more style
1 comments than style 2, though.
---
 CODING_STYLE | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index 12ba58ee293..fb1d1f1cd62 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -124,6 +124,19 @@ We use traditional C-style /* */ comments and avoid // comments.
 Rationale: The // form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
 
+Multiline comments blocks should have a row of stars on the left
+and the terminating */ on its own line:
+    /* like
+     * this
+     */
+Putting the initial /* on its own line is accepted, but not required.
+(Some of the existing comments in the codebase use the GNU Coding
+Standards form which does not have stars on the left; avoid this
+when writing new comments.)
+
+Rationale: Consistency, and ease of visually picking out a multiline
+comment from the surrounding code.
+
 8. trace-events style
 
 8.1 0x prefix
-- 
2.17.1
