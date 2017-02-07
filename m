Received: from eggs.gnu.org ([2001:4830:134:3::10]:48420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavar-0003Yr-IM
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavaq-0005Y0-N5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:21 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cavaq-0005Xr-Je
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:33:20 -0500
Received: by mail-it0-x241.google.com with SMTP id 203so10997371ith.2
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:33:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  6 Feb 2017 18:32:29 -0800
Message-Id: <20170207023229.29431-6-rth@twiddle.net>
In-Reply-To: <20170207023229.29431-1-rth@twiddle.net>
References: <20170207023229.29431-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 5/5] target/hppa: Fix gdb_write_register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Add a missing break, detected by Coverity.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 413a5e1..c37a56f 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -85,6 +85,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         break;
     case 35:
         env->iaoq_b = val;
+        break;
     case 59:
         env->cr26 = val;
         break;
-- 
2.9.3
