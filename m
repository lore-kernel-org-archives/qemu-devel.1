Received: from eggs.gnu.org ([2001:4830:134:3::10]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgR-0007Ls-7B
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgN-0007pq-J3
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:47 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:34681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgN-0007pX-DP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:43 -0500
Received: by mail-wj0-f176.google.com with SMTP id tg4so12587175wjb.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:27 +0000
Message-Id: <20161209114830.9158-8-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 07/10] risugen: remove grocer's
 apostrophe from REs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This also fixes perl-modes confusion about escaped strings.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risugen b/risugen
index a604fe5..77a550b 100755
--- a/risugen
+++ b/risugen
@@ -288,7 +288,7 @@ Valid options:
                    'VMULL' will match 'VMULL A1' and 'VMULL A2' but not
                    'VMULL_scalar A1'. This is generally what you wanted.
     --not-pattern re[,re...] : exclude patterns matching regular expression.
-                   These RE's are applied after the matching pattern which
+                   These REs are applied after the matching pattern which
                    is useful if you want to exclude a specific instruction from
                    a general set you have excluded.
      --no-fp      : disable floating point: no fp init, randomization etc.
-- 
2.11.0
