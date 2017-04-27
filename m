Received: from eggs.gnu.org ([2001:4830:134:3::10]:52075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5q-0003rJ-PG
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5p-0001N7-0f
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:18 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3i5o-0001Mj-QT
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:16 -0400
Received: by mail-wr0-x244.google.com with SMTP id w50so3539818wrc.0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:00:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 27 Apr 2017 13:59:49 +0200
Message-Id: <20170427120006.20564-3-rth@twiddle.net>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 02/19] tcg/sparc: Use the proper compilation
 flags for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

We have required a v9 cpu since 9b9c37c36439ee0452632253dac7a31897f27f70.
However, the flags we were using did not reliably enable v8plus, which
meant that the compiler didn't know it could inline 64-bit atomics.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index c35acf1..55dd9c3 100755
--- a/configure
+++ b/configure
@@ -1206,12 +1206,12 @@ case "$cpu" in
            LDFLAGS="-m64 $LDFLAGS"
            ;;
     sparc)
-           LDFLAGS="-m32 $LDFLAGS"
-           CPU_CFLAGS="-m32 -mcpu=ultrasparc"
+           CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
+           LDFLAGS="-m32 -mv8plus $LDFLAGS"
            ;;
     sparc64)
-           LDFLAGS="-m64 $LDFLAGS"
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
+           LDFLAGS="-m64 $LDFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
-- 
2.9.3
