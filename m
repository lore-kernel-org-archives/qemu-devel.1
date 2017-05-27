Received: from eggs.gnu.org ([2001:4830:134:3::10]:57041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQa-0006gD-WE
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQa-00064G-6z
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:56 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQa-000640-2V
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:56 -0400
Received: by mail-oi0-x241.google.com with SMTP id w10so6039505oif.1
	for <qemu-devel@nongnu.org>; Sat, 27 May 2017 09:18:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 27 May 2017 13:17:48 -0300
Message-Id: <20170527161755.7761-18-f4bug@amsat.org>
In-Reply-To: <20170527161755.7761-1-f4bug@amsat.org>
References: <20170527161755.7761-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 17/24] shippable: build using all available
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

As of this commit:

$ echo "container proc:" `getconf _NPROCESSORS_ONLN` `getconf _NPROCESSORS_CONF`
container proc: 2 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index 231c29b620..1e3ae35dd9 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -20,4 +20,4 @@ build:
   ci:
     - unset CC
     - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
-    - make -j2
+    - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
2.11.0
