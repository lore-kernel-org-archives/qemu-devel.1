Received: from eggs.gnu.org ([209.51.188.92]:38876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9a-0008Kz-Js
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9Z-00048q-Gi
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:50 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9Z-00047h-6h
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:49 -0500
Received: by mail-wr1-x42f.google.com with SMTP id p4so7372821wrt.7
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:31 +0000
Message-Id: <20190201145035.22739-8-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] docs/conf.py: Disable option warnings
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

sphinx-build complains about using :option: to mark up option
flags that it doesn't know about (because they were not defined
using the "option::" directive):
docs/pr-manager.rst:68: WARNING: unknown option: -d

Suppress these warnings. This way we get the semantic markup
of the option flag but no cross-referencing hyperlink.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 6ddaa549f28..c04000e78e4 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -76,6 +76,9 @@ pygments_style = 'sphinx'
 # If true, `todo` and `todoList` produce output, else they produce nothing.
 todo_include_todos = False
 
+# Sphinx defaults to warning about use of :option: for options not defined
+# with "option::" in the document being processed. Turn that off.
+suppress_warnings = ["ref.option"]
 
 # -- Options for HTML output ----------------------------------------------
 
-- 
2.20.1
