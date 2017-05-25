Received: from eggs.gnu.org ([2001:4830:134:3::10]:60307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDyAX-0003sE-F3
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDyAT-0001hQ-1L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dDyAS-0001hI-Na
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4PJ8cpL034399
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 15:11:27 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ans8ybu4b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 15:11:27 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 25 May 2017 16:11:24 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4PJBDYg17170818
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:11:21 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4PJAnZH013600
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:10:49 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu, 25 May 2017 16:10:21 -0300
In-Reply-To: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1495739423-32326-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu v3 2/4] configure: Add initial support to
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

Uses the same ppc64 source file for both BE/LE archs since they are
essentially the same thing.

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
