Received: from eggs.gnu.org ([2001:4830:134:3::10]:45125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfq-00079b-T7
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfn-0005sr-Qk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:14 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:48 +0300
Message-Id: <25ac5bbec43973e9b97a454e55fd307ef9db1320.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 05/14] CODING_STYLE: Mention preferred comment
 form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

Our defacto coding style strongly prefers /* */ style comments
over the single-line // style, and checkpatch enforces this,
but we don't actually document this. Mention it in CODING_STYLE.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.1.4
