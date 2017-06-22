Received: from eggs.gnu.org ([2001:4830:134:3::10]:56208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss0-0005lu-Bi
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrx-00054B-8B
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:24 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrx-000547-3i
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:21 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so595761qte.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:20 -0300
Message-Id: <20170622033231.19344-11-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/21] travis: increase S3 cache timeout
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index be28e0642c..62b9dfd2ae 100644
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
2.11.0
