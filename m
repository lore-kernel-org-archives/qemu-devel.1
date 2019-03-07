Received: from eggs.gnu.org ([209.51.188.92]:33952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utJ-0002b1-FU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utI-0004q0-Nw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utI-0004pV-Gt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id g20so9559632wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:25:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.24.58
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:24:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:44 +0000
Message-Id: <20190307152450.20340-7-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/12] docs/conf.py: Don't include rST sources
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

Sphinx defaults to including all the rST source files
in the HTML build and making each HTML page link to the
source file. Disable that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190305172139.32662-7-peter.maydell@linaro.org
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
