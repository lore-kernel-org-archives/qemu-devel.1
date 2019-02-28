Received: from eggs.gnu.org ([209.51.188.92]:52204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzN7O-0004rz-Ga
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzN7C-0007qY-5d
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzN78-0007mx-Ef
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id w2so22282359wrt.11
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 06:56:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 14:56:19 +0000
Message-Id: <20190228145624.24885-7-peter.maydell@linaro.org>
In-Reply-To: <20190228145624.24885-1-peter.maydell@linaro.org>
References: <20190228145624.24885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/11] docs/conf.py: Don't include rST
 sources in HTML build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Sphinx defaults to including all the rST source files
in the HTML build and making each HTML page link to the
source file. Disable that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 348e6358740..6ddaa549f28 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -112,6 +112,9 @@ html_sidebars = {
     ]
 }
 
+# Don't copy the rST source files to the HTML output directory,
+# and don't put links to the sources into the output HTML.
+html_copy_source = False
 
 # -- Options for HTMLHelp output ------------------------------------------
 
-- 
2.20.1
