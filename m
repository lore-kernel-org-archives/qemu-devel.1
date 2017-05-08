Received: from eggs.gnu.org ([2001:4830:134:3::10]:36719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ak0-0003EM-Vk
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ak0-0007fr-9y
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7ak0-0007fe-4z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:57:48 -0400
Received: by mail-qt0-x243.google.com with SMTP id r58so8239696qtb.2
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:57:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:56:53 -0300
Message-Id: <20170508045715.21770-2-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/23] shippable: use C locale to simplify
 console output
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

remove this noise:

perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = "en_US.UTF-8",
    LC_CTYPE = "en_US.UTF-8",
    LANG = "en_US.UTF-8"
    are supported and installed on your system.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 653bd750fe..231c29b620 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -1,5 +1,7 @@
 language: c
 env:
+  global:
+    - LC_ALL=C
   matrix:
     - IMAGE=debian-armhf-cross
       TARGET_LIST=arm-softmmu,arm-linux-user
-- 
2.11.0
