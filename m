Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8253C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFF520835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFF520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJhK-0003nS-Dz
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iCJOg-00031i-Qd
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iCJOf-0004Xi-DU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iCJOf-0004XR-5l; Mon, 23 Sep 2019 04:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7881D300C76A;
 Mon, 23 Sep 2019 08:08:36 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBFA196B2;
 Mon, 23 Sep 2019 08:08:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 30/30] tests/tcg: target/s390x: Test MVC
Date: Mon, 23 Sep 2019 10:07:12 +0200
Message-Id: <20190923080712.23951-31-david@redhat.com>
In-Reply-To: <20190923080712.23951-1-david@redhat.com>
References: <20190923080712.23951-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 08:08:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's add a test that especially verifies that no data will be touched
in case we cross page boundaries and one page access triggers a fault.

Before the fault-safe handling fixes, the test failes with:
      TEST    mvc on s390x
    data modified during a fault
    make[2]: *** [../Makefile.target:116: run-mvc] Error 1

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/tcg/s390x/Makefile.target |   1 +
 tests/tcg/s390x/mvc.c           | 109 ++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 tests/tcg/s390x/mvc.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.t=
arget
index 6a3bfa8b29..241ef28f61 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -7,3 +7,4 @@ TESTS+=3Dexrl-trt
 TESTS+=3Dexrl-trtr
 TESTS+=3Dpack
 TESTS+=3Dmvo
+TESTS+=3Dmvc
diff --git a/tests/tcg/s390x/mvc.c b/tests/tcg/s390x/mvc.c
new file mode 100644
index 0000000000..aa552d52e5
--- /dev/null
+++ b/tests/tcg/s390x/mvc.c
@@ -0,0 +1,109 @@
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <signal.h>
+#include <setjmp.h>
+
+jmp_buf jmp_env;
+
+static void handle_sigsegv(int sig)
+{
+    siglongjmp(jmp_env, 1);
+}
+
+#define ALLOC_SIZE (2 * 4096)
+
+static inline void mvc_256(const char *dst, const char *src)
+{
+    asm volatile (
+        "    mvc 0(256,%[dst]),0(%[src])\n"
+        :
+        : [dst] "d" (dst),
+          [src] "d" (src)
+        : "memory");
+}
+
+int main(void)
+{
+    char *src, *dst;
+    int i;
+
+    /* register the SIGSEGV handler */
+    if (signal(SIGSEGV, handle_sigsegv) =3D=3D SIG_ERR) {
+        fprintf(stderr, "SIGSEGV not registered\n");
+        return 1;
+    }
+
+    /* prepare the buffers - two consecutive pages */
+    src =3D valloc(ALLOC_SIZE);
+    dst =3D valloc(ALLOC_SIZE);
+    memset(src, 0xff, ALLOC_SIZE);
+    memset(dst, 0x0, ALLOC_SIZE);
+
+    /* protect the second pages */
+    if (mprotect(src + 4096, 4096, PROT_NONE) ||
+        mprotect(dst + 4096, 4096, PROT_NONE)) {
+        fprintf(stderr, "mprotect failed\n");
+        return 1;
+    }
+
+    /* fault on second destination page */
+    if (sigsetjmp(jmp_env, 1) =3D=3D 0) {
+        mvc_256(dst + 4096 - 128, src);
+        fprintf(stderr, "fault not triggered\n");
+        return 1;
+    }
+
+    /* fault on second source page */
+    if (sigsetjmp(jmp_env, 1) =3D=3D 0) {
+        mvc_256(dst, src + 4096 - 128);
+        fprintf(stderr, "fault not triggered\n");
+        return 1;
+    }
+
+    /* fault on second source and second destination page */
+    if (sigsetjmp(jmp_env, 1) =3D=3D 0) {
+        mvc_256(dst + 4096 - 128, src + 4096 - 128);
+        fprintf(stderr, "fault not triggered\n");
+        return 1;
+    }
+
+    /* restore permissions */
+    if (mprotect(src + 4096, 4096, PROT_READ | PROT_WRITE) ||
+        mprotect(dst + 4096, 4096, PROT_READ | PROT_WRITE)) {
+        fprintf(stderr, "mprotect failed\n");
+        return 1;
+    }
+
+    /* no data must be touched during the faults */
+    for (i =3D 0; i < ALLOC_SIZE; i++) {
+        if (src[i] !=3D 0xff || dst[i]) {
+            fprintf(stderr, "data modified during a fault\n");
+            return 1;
+        }
+    }
+
+    /* test if MVC works now correctly accross page boundaries */
+    mvc_256(dst + 4096 - 128, src + 4096 - 128);
+    for (i =3D 0; i < ALLOC_SIZE; i++) {
+        if (src[i] !=3D 0xff) {
+            fprintf(stderr, "src modified\n");
+            return 1;
+        }
+        if (i < 4096 - 128 || i >=3D 4096 + 128) {
+            if (dst[i]) {
+                fprintf(stderr, "wrong dst modified\n");
+                return 1;
+            }
+        } else {
+            if (dst[i] !=3D 0xff) {
+                fprintf(stderr, "wrong data moved\n");
+                return 1;
+            }
+        }
+    }
+
+    return 0;
+}
--=20
2.21.0


