Received: from eggs.gnu.org ([209.51.188.92]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9Z-0008K4-EU
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9X-00047E-Sr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:49 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9X-00045w-LX
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:47 -0500
Received: by mail-wr1-x444.google.com with SMTP id u4so7399283wrp.3
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:30 +0000
Message-Id: <20190201145035.22739-7-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] docs/conf.py: Don't include rST sources
 in HTML build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Sphinx defaults to including all the rST source files
in the HTML build and making each HTML page link to the
source file. Disable that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
