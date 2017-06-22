Received: from eggs.gnu.org ([2001:4830:134:3::10]:56192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrv-0005hu-NV
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsru-00052t-Nt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:19 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsru-000523-JN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:18 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so595687qte.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:19 -0300
Message-Id: <20170622033231.19344-10-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/21] travis: enable multiple caching
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

(this eases git workflow)

see https://docs.travis-ci.com/user/caching#enabling-multiple-caching-features

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 61394b4764..be28e0642c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -4,7 +4,8 @@ python:
   - "2.4"
 compiler:
   - gcc
-cache: ccache
+cache:
+  ccache: true
 addons:
   apt:
     packages:
-- 
2.11.0
