Received: from eggs.gnu.org ([2001:4830:134:3::10]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cm2yV-0002VN-5u
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cm2yU-0002hf-5B
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cm2yT-0002hX-RS
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29IcbIi027559
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 13:39:40 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2937t3y8fa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 13:39:40 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 15:39:36 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v29IdQQV34406624
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 15:39:34 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v29Id3Kd022537
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 15:39:03 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu,  9 Mar 2017 15:38:37 -0300
In-Reply-To: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1489084718-15294-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu v2 2/3] configure: Add initial support to
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
index 055e6d6..dd64d8b 100755
--- a/configure
+++ b/configure
@@ -51,11 +51,7 @@ guess_arch() {
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
@@ -127,6 +123,9 @@ OBJDUMP="${OBJDUMP-${CROSS_PREFIX}objdump}"
 
 if test "x${ARCH}" = "x"; then
     guess_arch
+elif test "x${ARCH}" = "xppc64"; then
+    # ppc64 and ppc64le uses the same C source code
+    ARCH="ppc64le"
 fi
 
 generate_makefilein
-- 
2.7.4
