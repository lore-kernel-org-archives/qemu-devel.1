Received: from eggs.gnu.org ([2001:4830:134:3::10]:52448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8t-0007z0-2m
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8o-00089K-CK
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:55 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:52998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8o-00088v-1T
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:50 -0400
Received: by mail-oi0-x235.google.com with SMTP id p126so3670856oih.9
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:22 -0700
Message-Id: <20170917150535.8284-5-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/17] accel/tcg: move tcg-runtime to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170911213328.9701-4-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.13.5
