Received: from eggs.gnu.org ([2001:4830:134:3::10]:40669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCQ-0007KY-Jt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCM-0004q3-IQ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:26 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCM-0004ok-Br
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:22 -0400
Received: by mail-wr0-x229.google.com with SMTP id r103so69638700wrb.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:44 +0100
Message-Id: <20170619104655.31104-3-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 02/13] README: document the coding
 style used for risu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We also include the an Emacs .dir-locals (as per QEMU) that enforces
this layout.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .dir-locals.el | 2 ++
 README         | 9 +++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 .dir-locals.el

diff --git a/.dir-locals.el b/.dir-locals.el
new file mode 100644
index 0000000..3ac0cfc
--- /dev/null
+++ b/.dir-locals.el
@@ -0,0 +1,2 @@
+((c-mode . ((c-file-style . "stroustrup")
+	    (indent-tabs-mode . nil))))
diff --git a/README b/README
index 4b37b4e..858a349 100644
--- a/README
+++ b/README
@@ -42,6 +42,15 @@ architecture that we support and that you have a cross compiler
 installed for. This is useful for confirming that your changes
 to risu haven't broken anything.
 
+Coding Style
+------------
+
+risu follows the same coding style as the QEMU project, namely 4
+spaces (no tabs) for indentation and the One True Brace Style variant
+of K&R. The source tree includes a .dir-locals.el for Emacs users that
+will set this automatically. Other editors are available.
+
+
 Usage
 -----
 
-- 
2.13.0
