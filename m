Received: from eggs.gnu.org ([2001:4830:134:3::10]:53672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB068-0005DS-Br
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fB067-0000eg-L7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fB067-0000dh-EQ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:43:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id c14-v6so10315751wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:43:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:56 +0100
Message-Id: <20180424152405.10304-38-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 37/46] tests/tcg/alpha: fix warnings about
 write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Although we are not linking to libc we still need a function prototype
for the write we have defined in crt.S.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/alpha/hello-alpha.c | 2 ++
 tests/tcg/alpha/test-cond.c   | 1 +
 tests/tcg/alpha/test-ovf.c    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/tests/tcg/alpha/hello-alpha.c b/tests/tcg/alpha/hello-alpha.c
index 79892e6522..f1207a2411 100644
--- a/tests/tcg/alpha/hello-alpha.c
+++ b/tests/tcg/alpha/hello-alpha.c
@@ -1,3 +1,5 @@
+void write(int, char*, int);
+
 int main (void)
 {
   write (1, "hello\n", 6);
diff --git a/tests/tcg/alpha/test-cond.c b/tests/tcg/alpha/test-cond.c
index 74adffaa69..b5774e4d6d 100644
--- a/tests/tcg/alpha/test-cond.c
+++ b/tests/tcg/alpha/test-cond.c
@@ -1,3 +1,4 @@
+void write(int, char*, int);
 
 #ifdef TEST_CMOV
 
diff --git a/tests/tcg/alpha/test-ovf.c b/tests/tcg/alpha/test-ovf.c
index 01c80e7525..7ecf7e4bce 100644
--- a/tests/tcg/alpha/test-ovf.c
+++ b/tests/tcg/alpha/test-ovf.c
@@ -1,3 +1,5 @@
+void write(int, char*, int);
+
 static long test_subqv (long a, long b)
 {
   long res;
-- 
2.17.0
