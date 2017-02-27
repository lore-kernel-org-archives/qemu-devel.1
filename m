Received: from eggs.gnu.org ([2001:4830:134:3::10]:49647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBG-0003t7-Lq
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBC-0003cW-Jx
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ciRBC-0003cJ-AA
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:54 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RJdJqN138738
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:53 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vknj4p82-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:52 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 16:41:49 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1CBB8352005F
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:12 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1RJfjbL28246210
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:45 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1RJfjNL006426
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:45 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 16:41:30 -0300
In-Reply-To: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1488224492-20316-4-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 3/5] configure: Add initial support to
 PPC64 (big endian)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

This commit set Makefile to point to ppc64le source for both archs
(ppc64 and ppc64le) because they do the exact same thing. The
difference is in risugen and how the binary is build.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 configure | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 1fbc27c..5a91f57 100755
--- a/configure
+++ b/configure
@@ -38,11 +38,7 @@ guess_arch() {
     elif check_define __aarch64__ ; then
         ARCH="aarch64"
     elif check_define __powerpc64__ ; then
-        if check_define __BIG_ENDIAN__; then
-            ARCH="ppc64"
-        else
-            ARCH="ppc64le"
-        fi
+        ARCH="ppc64le"
     else
         echo "This cpu is not supported by risu. Try -h. " >&2
         exit 1
@@ -114,6 +110,9 @@ OBJDUMP="${OBJDUMP-${CROSS_PREFIX}objdump}"
 
 if test "x${ARCH}" = "x"; then
     guess_arch
+elif test "x${ARCH}" = "xppc64"; then
+    # ppc64 and ppc64le uses the same C source code
+    ARCH="ppc64le"
 fi
 
 generate_makefilein
-- 
2.7.4
