Received: from eggs.gnu.org ([2001:4830:134:3::10]:50108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNM2p-00078n-H6
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNM2m-0002tR-Ay
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:30:23 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNM2m-0002tM-6E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:30:20 -0400
Received: by mail-qt0-x22a.google.com with SMTP id v20so21672968qtg.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:30:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 20 Jun 2017 13:30:09 -0300
Message-Id: <20170620163009.21764-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg/tci: fix tcg-interpreter build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

fix regression from commit 244f144134:

    $ make subdir-arm-softmmu
    make[1]: *** No rule to make target 'tci.o', needed by 'qemu-system-arm'.  Stop.
    Makefile:328: recipe for target 'subdir-arm-softmmu' failed
    make: *** [subdir-arm-softmmu] Error 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index 3d49f29457..0066579090 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -92,7 +92,7 @@ obj-y += exec.o
 obj-y += accel/
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-y += tcg/tcg-common.o tcg/tcg-runtime.o
-obj-$(CONFIG_TCG_INTERPRETER) += tci.o
+obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
-- 
2.11.0
