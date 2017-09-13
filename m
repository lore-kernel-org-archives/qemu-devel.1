Received: from eggs.gnu.org ([2001:4830:134:3::10]:58483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsFt8-0000Qe-Bu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsFt4-0003vm-D1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:12:06 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsFt4-0003td-7S
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:12:02 -0400
Received: by mail-qt0-x241.google.com with SMTP id f24so949274qte.5
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 15:12:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Sep 2017 19:11:49 -0300
Message-Id: <20170913221149.30382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] accel/hax: move hax-stub.c to accel/stubs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Jiang Yunhong <yunhong.jiang@intel.com>, Vincent Palatin <vpalatin@chromium.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.target                      | 1 -
 hax-stub.c => accel/stubs/hax-stub.c | 0
 accel/stubs/Makefile.objs            | 1 +
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename hax-stub.c => accel/stubs/hax-stub.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 6361f957fb..af4b60d012 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -101,7 +101,6 @@ obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
-obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
diff --git a/hax-stub.c b/accel/stubs/hax-stub.c
similarity index 100%
rename from hax-stub.c
rename to accel/stubs/hax-stub.c
diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index fdfbf7332c..8038ad6553 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,2 +1,3 @@
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
+obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
-- 
2.14.1
