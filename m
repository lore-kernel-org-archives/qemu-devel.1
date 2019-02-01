Received: from eggs.gnu.org ([209.51.188.92]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9X-0008Jj-1R
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9W-00044R-0X
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:46 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9V-00043j-H1
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:45 -0500
Received: by mail-wr1-x441.google.com with SMTP id l9so7329374wrt.13
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:28 +0000
Message-Id: <20190201145035.22739-5-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/11] docs/conf.py: Disable unused _static
 directory
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

We don't yet have any custom static files, so disable this
config file setting to avoid a warning from sphinx about
not being able to find the directory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index 53a17506615..e1d08a34a65 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -93,7 +93,11 @@ html_theme = 'alabaster'
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
 # so a file named "default.css" will overwrite the builtin "default.css".
-html_static_path = ['_static']
+# QEMU doesn't yet have any static files, so comment this out so we don't
+# get a warning about a missing directory.
+# If we do ever add this then it would probably be better to call the
+# subdirectory sphinx_static, as the Linux kernel does.
+# html_static_path = ['_static']
 
 # Custom sidebar templates, must be a dictionary that maps document names
 # to template names.
-- 
2.20.1
