Received: from eggs.gnu.org ([2001:4830:134:3::10]:50013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSNdJ-0000QU-MV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fSNdI-0006Lp-IS
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:17:21 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 15:17:16 +0100
Message-Id: <20180611141716.3813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form for
 multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex Williamson <alex.williamson@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The codebase has a bit of a mix of different multiline
comment styles. State a preference for the Linux kernel
style:
    /*
     * Star on the left for each line.
     * Leading slash-star and trailing star-slash
     * each go on a line of their own.
     */

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is not my personal favourite, but seemed to be the
closest we had to consensus in the mail thread for v1;
I can live with it in order to avoid getting patches which
use the styles I like even less :-)
---
 CODING_STYLE | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index 12ba58ee293..2d84f5f26d1 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -124,6 +124,23 @@ We use traditional C-style /* */ comments and avoid // comments.
 Rationale: The // form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
 
+Multiline comments blocks should have a row of stars on the left,
+and the initial /* and terminating */ both on their own lines:
+    /*
+     * like
+     * this
+     */
+This is the same format required by the Linux kernel coding style.
+
+(Some of the existing comments in the codebase use the GNU Coding
+Standards form which does not have stars on the left, or other
+variations; avoid these when writing new comments, but don't worry
+about converting to the preferred form unless you're editing that
+comment anyway.)
+
+Rationale: Consistency, and ease of visually picking out a multiline
+comment from the surrounding code.
+
 8. trace-events style
 
 8.1 0x prefix
-- 
2.17.1
