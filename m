Received: from eggs.gnu.org ([209.51.188.92]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utH-0002Z8-IT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utG-0004oZ-Rl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:24:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utG-0004nq-Kv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:24:58 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y6so2753911wrn.7
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:24:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.24.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:24:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:42 +0000
Message-Id: <20190307152450.20340-5-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/12] docs/conf.py: Disable unused _static
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

We don't yet have any custom static files, so disable this
config file setting to avoid a warning from sphinx about
not being able to find the directory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190305172139.32662-5-peter.maydell@linaro.org
Message-id: 20190228145624.24885-5-peter.maydell@linaro.org
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
