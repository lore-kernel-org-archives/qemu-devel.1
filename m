Received: from eggs.gnu.org ([2001:4830:134:3::10]:40108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlA-0002JB-3F
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl9-0006RN-CK
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:20 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl9-0006Qq-79
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:19 -0400
Received: by mail-oi0-x241.google.com with SMTP id h4so13124937oib.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:22 -0300
Message-Id: <20170602185630.5059-17-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 16/24] shippable: use C locale to simplify
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
