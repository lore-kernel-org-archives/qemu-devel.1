Received: from eggs.gnu.org ([2001:4830:134:3::10]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfo-0004cm-1B
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfh-0005k8-5U
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:44 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfg-0005ja-Vx
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:37 -0400
Received: by mail-wr0-x243.google.com with SMTP id n64so2147872wrb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:35 +0200
Message-Id: <1505824179-21541-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 46/50] accel/hax: move hax-stub.c to accel/stubs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
Message-Id: <20170913221149.30382-1-f4bug@amsat.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.target                      | 1 -
 accel/stubs/Makefile.objs            | 1 +
 hax-stub.c => accel/stubs/hax-stub.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename hax-stub.c => accel/stubs/hax-stub.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 32b0100..a4b292d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -101,7 +101,6 @@ obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
-obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
index fdfbf73..c071aba 100644
--- a/accel/stubs/Makefile.objs
+++ b/accel/stubs/Makefile.objs
@@ -1,2 +1,3 @@
+obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
diff --git a/hax-stub.c b/accel/stubs/hax-stub.c
similarity index 100%
rename from hax-stub.c
rename to accel/stubs/hax-stub.c
-- 
1.8.3.1
