Received: from eggs.gnu.org ([2001:4830:134:3::10]:44658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKz-00013b-G3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKy-0006uK-Bj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:49 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKy-0006tg-6z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:48 -0400
Received: by mail-qt0-x243.google.com with SMTP id q8so6337716qtb.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:33:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 18:33:26 -0300
Message-Id: <20170911213328.9701-4-f4bug@amsat.org>
In-Reply-To: <20170911213328.9701-1-f4bug@amsat.org>
References: <20170911213328.9701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/5] tcg: move tcg-runtime to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.target                  | 2 +-
 {tcg => accel/tcg}/tcg-runtime.h | 0
 {tcg => accel/tcg}/tcg-runtime.c | 0
 accel/tcg/Makefile.objs          | 1 +
 4 files changed, 2 insertions(+), 1 deletion(-)
 rename {tcg => accel/tcg}/tcg-runtime.h (100%)
 rename {tcg => accel/tcg}/tcg-runtime.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 520305b025..6361f957fb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -94,7 +94,7 @@ all: $(PROGS) stap
 obj-y += exec.o
 obj-y += accel/
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-runtime.o
+obj-$(CONFIG_TCG) += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
similarity index 100%
rename from tcg/tcg-runtime.h
rename to accel/tcg/tcg-runtime.h
diff --git a/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
similarity index 100%
rename from tcg/tcg-runtime.c
rename to accel/tcg/tcg-runtime.c
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index f2422d0fb3..228cd84fa4 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-y += tcg-runtime.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
 
-- 
2.14.1
