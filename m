Received: from eggs.gnu.org ([2001:4830:134:3::10]:40353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSo-0008G8-0D
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSl-0001dZ-00
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmSk-0001cQ-MV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5rej2038898
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:09 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sn43a26e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:06 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 16:59:56 +1100
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Message-Id: <0a544cbec930e5ac5916ad00fbc8d91939d6efe8.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 03/12] scripts/update-linux-headers.sh:
 add new files for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com

The kernel has added some new headers for ARM, so add these so that
the script can be run successfully.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

* Added the two new arm headers.

 scripts/update-linux-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index c75c30da1b..d8a178b070 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -79,6 +79,7 @@ for arch in $ARCHLIST; do
     ARCH_EXTRA=
     ARCH_STD_EXTRA=
     case "$arch" in
+        arm) ARCH_EXTRA="unistd-eabi.h unistd-oabi.h" ;;
         powerpc) ARCH_EXTRA=epapr_hcalls.h ;;
         s390) ARCH_STD_EXTRA="kvm_virtio.h virtio-ccw.h" ;;
         x86) ARCH_EXTRA="unistd_32.h unistd_x32.h unistd_64.h" ARCH_STD_EXTRA="hyperv.h" ;;
-- 
2.11.0
