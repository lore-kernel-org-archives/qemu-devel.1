Received: from eggs.gnu.org ([2001:4830:134:3::10]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2r-0000tE-MY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2q-0000a9-Gm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:13 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:52325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt2q-0000ZM-9V
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:12 -0400
Received: by mail-wm0-x22a.google.com with SMTP id p126-v6so3122653wmb.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:26:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:13 +0100
Message-Id: <20180621062605.941-6-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 05/57] configure: set cross_cc_FOO for host
 compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We can build tests for the host system with the compiler that we have
selected.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/configure b/configure
index 259938e177..4d12cfbe3f 100755
--- a/configure
+++ b/configure
@@ -1431,26 +1431,38 @@ case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
+           cross_cc_powerpc=$cc
+           cross_cc_cflags_powerpc=$CPU_CFLAGS
            ;;
     ppc64)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
+           cross_cc_ppc64=$cc
+           cross_cc_cflags_ppc64=$CPU_CFLAGS
            ;;
     sparc)
            CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
            LDFLAGS="-m32 -mv8plus $LDFLAGS"
+           cross_cc_sparc=$cc
+           cross_cc_cflags_sparc=$CPU_CFLAGS
            ;;
     sparc64)
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
            LDFLAGS="-m64 $LDFLAGS"
+           cross_cc_sparc64=$cc
+           cross_cc_cflags_sparc64=$CPU_CFLAGS
            ;;
     s390)
            CPU_CFLAGS="-m31"
            LDFLAGS="-m31 $LDFLAGS"
+           cross_cc_s390=$cc
+           cross_cc_cflags_s390=$CPU_CFLAGS
            ;;
     s390x)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
+           cross_cc_s390x=$cc
+           cross_cc_cflags_s390x=$CPU_CFLAGS
            ;;
     i386)
            CPU_CFLAGS="-m32"
@@ -1471,7 +1483,7 @@ case "$cpu" in
            CPU_CFLAGS="-mx32"
            LDFLAGS="-mx32 $LDFLAGS"
            cross_cc_i386=$cc
-           cross_cc_cflags_i386="-m32"
+           cross_cc_cflags_i386=$CPU_CFLAGS
            ;;
     # No special flags required for other host CPUs
 esac
-- 
2.17.1
