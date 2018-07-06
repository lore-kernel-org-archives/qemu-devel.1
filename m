Received: from eggs.gnu.org ([2001:4830:134:3::10]:53502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbLl9-0007ut-S2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbLl6-0006Fm-Nx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:06:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fbLl6-0006Ac-Ev
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:06:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id c13-v6so3201226wrt.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 01:06:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  6 Jul 2018 09:06:15 +0100
Message-Id: <20180706080615.25974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC for 3.0] tests/tpm-emu: double the timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

We see various failures on Travis so lets just double the timeout and
see if that makes them go away.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tpm-emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index 8c2bd53cad..308f1884f6 100644
--- a/tests/tpm-emu.c
+++ b/tests/tpm-emu.c
@@ -20,7 +20,7 @@
 
 void tpm_emu_test_wait_cond(TestState *s)
 {
-    gint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    gint64 end_time = g_get_monotonic_time() + 10 * G_TIME_SPAN_SECOND;
 
     g_mutex_lock(&s->data_mutex);
     if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
-- 
2.17.1
