Received: from eggs.gnu.org ([209.51.188.92]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs2-0001z9-DM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs0-0007xf-5i
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:33 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLxrw-0007vK-Lo
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id z8so81149pln.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 15:38:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  1 May 2019 15:38:19 -0700
Message-Id: <20190501223819.8584-3-richard.henderson@linaro.org>
In-Reply-To: <20190501223819.8584-1-richard.henderson@linaro.org>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] configure: Use quotes around uses of
 $CPU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org

About half of the values to which CPU_CFLAGS is set
have multiple space separated arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 234cb929ca..16bd4375d1 100755
--- a/configure
+++ b/configure
@@ -1543,37 +1543,37 @@ case "$cpu" in
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_ppc64=$cc
-           cross_cc_cflags_ppc64=$CPU_CFLAGS
+           cross_cc_cflags_ppc64="$CPU_CFLAGS"
            ;;
     sparc)
            CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
            LDFLAGS="-m32 -mv8plus $LDFLAGS"
            cross_cc_sparc=$cc
-           cross_cc_cflags_sparc=$CPU_CFLAGS
+           cross_cc_cflags_sparc="$CPU_CFLAGS"
            ;;
     sparc64)
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_sparc64=$cc
-           cross_cc_cflags_sparc64=$CPU_CFLAGS
+           cross_cc_cflags_sparc64="$CPU_CFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
            LDFLAGS="-m31 $LDFLAGS"
            cross_cc_s390=$cc
-           cross_cc_cflags_s390=$CPU_CFLAGS
+           cross_cc_cflags_s390="$CPU_CFLAGS"
            ;;
     s390x)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_s390x=$cc
-           cross_cc_cflags_s390x=$CPU_CFLAGS
+           cross_cc_cflags_s390x="$CPU_CFLAGS"
            ;;
     i386)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
            cross_cc_i386=$cc
-           cross_cc_cflags_i386=$CPU_CFLAGS
+           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
@@ -1582,13 +1582,13 @@ case "$cpu" in
            CPU_CFLAGS="-m64 -mcx16"
            LDFLAGS="-m64 $LDFLAGS"
            cross_cc_x86_64=$cc
-           cross_cc_cflags_x86_64=$CPU_CFLAGS
+           cross_cc_cflags_x86_64="$CPU_CFLAGS"
            ;;
     x32)
            CPU_CFLAGS="-mx32"
            LDFLAGS="-mx32 $LDFLAGS"
            cross_cc_i386=$cc
-           cross_cc_cflags_i386=$CPU_CFLAGS
+           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     # No special flags required for other host CPUs
 esac
-- 
2.17.1
