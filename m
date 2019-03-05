Received: from eggs.gnu.org ([209.51.188.92]:35591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlJ-0002CR-Ms
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlI-00010u-TU
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:53 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DlI-0000yG-La
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id n19so3358504wmi.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:21:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 17:21:34 +0000
Message-Id: <20190305172139.32662-8-peter.maydell@linaro.org>
In-Reply-To: <20190305172139.32662-1-peter.maydell@linaro.org>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/12] docs/conf.py: Disable option warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

sphinx-build complains about using :option: to mark up option
flags that it doesn't know about (because they were not defined
using the "option::" directive):
docs/pr-manager.rst:68: WARNING: unknown option: -d

Suppress these warnings. This way we get the semantic markup
of the option flag but no cross-referencing hyperlink.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
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
