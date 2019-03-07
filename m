Received: from eggs.gnu.org ([209.51.188.92]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utK-0002cC-Gx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utJ-0004rF-Rg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:02 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utJ-0004qB-Jw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:01 -0500
Received: by mail-wm1-x32e.google.com with SMTP id f65so9650826wma.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:25:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.24.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:24:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:45 +0000
Message-Id: <20190307152450.20340-8-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/12] docs/conf.py: Disable option warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

sphinx-build complains about using :option: to mark up option
flags that it doesn't know about (because they were not defined
using the "option::" directive):
docs/pr-manager.rst:68: WARNING: unknown option: -d

Suppress these warnings. This way we get the semantic markup
of the option flag but no cross-referencing hyperlink.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190305172139.32662-8-peter.maydell@linaro.org
Message-id: 20190228145624.24885-8-peter.maydell@linaro.org
---
 docs/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index d3018bc5395..56a74e0fcb3 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -77,6 +77,9 @@ pygments_style = 'sphinx'
 # If true, `todo` and `todoList` produce output, else they produce nothing.
 todo_include_todos = False
 
+# Sphinx defaults to warning about use of :option: for options not defined
+# with "option::" in the document being processed. Turn that off.
+suppress_warnings = ["ref.option"]
 
 # -- Options for HTML output ----------------------------------------------
 
-- 
2.20.1
