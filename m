Received: from eggs.gnu.org ([2001:4830:134:3::10]:42635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5f-0005x5-3Z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5d-00028G-Vw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:11 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5d-00027P-O8
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:09 -0400
Received: by mail-wr0-x242.google.com with SMTP id f14-v6so14349860wre.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:24 +0100
Message-Id: <20180419135901.30035-7-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/43] configure: set cross_cc_FOO for host
 compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We can build tests for the host system with the compiler that we have
selected.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 29af33716d..44d310a692 100755
--- a/configure
+++ b/configure
@@ -1416,30 +1416,44 @@ case "$cpu" in
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
            LDFLAGS="-m32 $LDFLAGS"
+           cross_cc_i386=$cc
+           cross_cc_cflags_i386=$CPU_CFLAGS
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
@@ -1454,7 +1468,7 @@ case "$cpu" in
            CPU_CFLAGS="-mx32"
            LDFLAGS="-mx32 $LDFLAGS"
            cross_cc_i386=$cc
-           cross_cc_cflags_i386="-m32"
+           cross_cc_cflags_i386=$CPU_CFLAGS
            ;;
     # No special flags required for other host CPUs
 esac
-- 
2.17.0
