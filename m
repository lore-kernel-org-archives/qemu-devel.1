Received: from eggs.gnu.org ([2001:4830:134:3::10]:54285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlac-00026P-4F
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaX-0004gO-Fc
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:54 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaX-0004gK-AP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id c20so15135285qte.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:56 -0300
Message-Id: <20170711031000.24844-15-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 14/18] shippable: add x86_64 targets
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 189d193da5..7a89341cea 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -5,6 +5,8 @@ env:
   global:
     - LC_ALL=C
   matrix:
+    - IMAGE=debian-amd64-cross
+      TARGET_LIST=x86_64-softmmu,x86_64-linux-user
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.13.2
