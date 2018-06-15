Received: from eggs.gnu.org ([2001:4830:134:3::10]:60739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfU-0001bH-7R
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfS-0006D4-Uy
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfS-00065w-Gz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfR-0003gK-GG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:53 +0100
Message-Id: <20180615142521.19143-16-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/43] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The codebase has a bit of a mix of different multiline
comment styles. State a preference for the Linux kernel
style:
    /*
     * Star on the left for each line.
     * Leading slash-star and trailing star-slash
     * each go on a line of their own.
     */

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180611141716.3813-1-peter.maydell@linaro.org
---
 CODING_STYLE | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index 12ba58ee293..ec075dedc4a 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -124,6 +124,23 @@ We use traditional C-style /* */ comments and avoid // comments.
 Rationale: The // form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
 
+Multiline comment blocks should have a row of stars on the left,
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
