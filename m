Received: from eggs.gnu.org ([2001:4830:134:3::10]:59359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dO9-0001cU-Vu
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dO9-0001TU-33
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:09 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dO8-0001T3-VU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:09 -0400
Received: by mail-qk0-x242.google.com with SMTP id o4so4541146qkb.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:37 -0700
Message-Id: <20170502192300.2124-3-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 02/25] tcg/sparc: Use the proper compilation
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 48a9370..d404374 100755
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
