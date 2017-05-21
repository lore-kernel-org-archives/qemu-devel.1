Received: from eggs.gnu.org ([2001:4830:134:3::10]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZq-0001dF-R4
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZp-0007My-ST
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:42 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCHZp-0007Mp-Nr
	for qemu-devel@nongnu.org; Sat, 20 May 2017 23:30:41 -0400
Received: by mail-oi0-x242.google.com with SMTP id h4so18064156oib.0
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 20:30:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 21 May 2017 00:29:49 -0300
Message-Id: <20170521032956.27446-18-f4bug@amsat.org>
In-Reply-To: <20170521032956.27446-1-f4bug@amsat.org>
References: <20170521032956.27446-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 17/24] shippable: build using all available
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
