Received: from eggs.gnu.org ([209.51.188.92]:52165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzN76-0004hZ-2K
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzN75-0007jM-6e
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:43 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzN75-0007ij-05
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:56:43 -0500
Received: by mail-wr1-x42c.google.com with SMTP id d17so22255748wre.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 06:56:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 14:56:18 +0000
Message-Id: <20190228145624.24885-6-peter.maydell@linaro.org>
In-Reply-To: <20190228145624.24885-1-peter.maydell@linaro.org>
References: <20190228145624.24885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/11] docs/conf.py: Configure the
 'alabaster' theme
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

Add the 'navigation' bar to the sidebar, which for some
reason is not enabled by default. Remove 'relations', which
is effectively disabled anyway and isn't useful for us.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/conf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index e1d08a34a65..348e6358740 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -106,7 +106,8 @@ html_theme = 'alabaster'
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
