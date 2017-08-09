Received: from eggs.gnu.org ([2001:4830:134:3::10]:48425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZi-0005wN-SE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZh-000293-Mv
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:30 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZh-00028t-IY
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:29 -0400
Received: by mail-qt0-x241.google.com with SMTP id i19so6897537qte.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:00 -0300
Message-Id: <20170809202712.6951-5-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 04/16] travis: increase S3 cache
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 311f25eb28..d622d8c433 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -6,6 +6,7 @@ compiler:
   - gcc
 cache:
   ccache: true
+  timeout: 1200 # https://docs.travis-ci.com/user/caching#setting-the-timeout
 addons:
   apt:
     packages:
-- 
2.13.3
