Received: from eggs.gnu.org ([209.51.188.92]:33941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utI-0002aE-PM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utH-0004pR-UM
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:25:00 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utH-0004oe-Mo
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:24:59 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w2so17889187wrt.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:24:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.24.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:24:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:43 +0000
Message-Id: <20190307152450.20340-6-peter.maydell@linaro.org>
In-Reply-To: <20190307152450.20340-1-peter.maydell@linaro.org>
References: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/12] docs/conf.py: Configure the 'alabaster'
 theme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add the 'navigation' bar to the sidebar, which for some
reason is not enabled by default. Remove 'relations', which
is effectively disabled anyway and isn't useful for us.

This requires that we mandate having at least Sphinx 1.3,
where the theme was added.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-id: 20190305172139.32662-6-peter.maydell@linaro.org
Message-id: 20190228145624.24885-6-peter.maydell@linaro.org
---
 docs/conf.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index e1d08a34a65..d118757cbd3 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -25,7 +25,8 @@
 
 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# needs_sphinx = '1.0'
+# 1.3 is where the 'alabaster' theme was shipped with Sphinx.
+needs_sphinx = '1.3'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
@@ -106,7 +107,8 @@ html_theme = 'alabaster'
 # refs: http://alabaster.readthedocs.io/en/latest/installation.html#sidebars
 html_sidebars = {
     '**': [
-        'relations.html',  # needs 'show_related': True theme option to display
+        'about.html',
+        'navigation.html',
         'searchbox.html',
     ]
 }
-- 
2.20.1
