Received: from eggs.gnu.org ([2001:4830:134:3::10]:57020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQY-0006dP-V2
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQY-00063U-5c
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:54 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQY-00063H-1h
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:54 -0400
Received: by mail-oi0-x242.google.com with SMTP id v80so6022759oie.2
	for <qemu-devel@nongnu.org>; Sat, 27 May 2017 09:18:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 27 May 2017 13:17:47 -0300
Message-Id: <20170527161755.7761-17-f4bug@amsat.org>
In-Reply-To: <20170527161755.7761-1-f4bug@amsat.org>
References: <20170527161755.7761-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/24] shippable: use C locale to simplify
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
