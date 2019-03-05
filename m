Received: from eggs.gnu.org ([209.51.188.92]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlI-0002BE-Bh
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlH-0000wS-L2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:52 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DlH-0000pD-Cw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:51 -0500
Received: by mail-wm1-x344.google.com with SMTP id x7so3369685wmj.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:21:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 17:21:33 +0000
Message-Id: <20190305172139.32662-7-peter.maydell@linaro.org>
In-Reply-To: <20190305172139.32662-1-peter.maydell@linaro.org>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/12] docs/conf.py: Don't include rST
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

Sphinx defaults to including all the rST source files
in the HTML build and making each HTML page link to the
source file. Disable that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-id: 20190228145624.24885-7-peter.maydell@linaro.org
---
 docs/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index d118757cbd3..d3018bc5395 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -113,6 +113,9 @@ html_sidebars = {
     ]
 }
 
+# Don't copy the rST source files to the HTML output directory,
+# and don't put links to the sources into the output HTML.
+html_copy_source = False
 
 # -- Options for HTMLHelp output ------------------------------------------
 
-- 
2.20.1
