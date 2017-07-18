Received: from eggs.gnu.org ([2001:4830:134:3::10]:34831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXn-0002pa-4i
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXm-00084r-Em
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:27 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXm-00084H-Af
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:26 -0400
Received: by mail-qk0-x241.google.com with SMTP id z22so1005386qka.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:47:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 23:47:10 -0300
Message-Id: <20170718024713.27557-3-f4bug@amsat.org>
In-Reply-To: <20170718024713.27557-1-f4bug@amsat.org>
References: <20170718024713.27557-1-f4bug@amsat.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2.5 2/5] shippable: add win32/64 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 53b43b349f..dd4bbc84b1 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,6 +7,10 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
+    - IMAGE=debian-win32-cross
+      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
+    - IMAGE=debian-win64-cross
+      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.13.2
