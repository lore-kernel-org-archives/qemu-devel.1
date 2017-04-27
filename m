Received: from eggs.gnu.org ([2001:4830:134:3::10]:56579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bqA-0000q7-Hv
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3bq7-0002Yf-Du
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38891
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3bq7-0002YX-7p
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:19:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5IdZP132643
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:38 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a333he0tq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:19:38 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 15:19:35 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 10:48:23 +0530
In-Reply-To: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
References: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170427051824.30194-6-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/6] tcg: enable MTTCG by default for PPC64
 on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

This enables the multi-threaded system emulation by default for PPC64
guests using the x86_64 TCG back-end.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 configure        | 2 ++
 target/ppc/cpu.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configure b/configure
index c35acf1..3814617 100755
--- a/configure
+++ b/configure
@@ -6090,12 +6090,14 @@ case "$target_name" in
   ppc64)
     TARGET_BASE_ARCH=3Dppc
     TARGET_ABI_DIR=3Dppc
+    mttcg=3Dyes
     gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml power-vsx.xml"
   ;;
   ppc64le)
     TARGET_ARCH=3Dppc64
     TARGET_BASE_ARCH=3Dppc
     TARGET_ABI_DIR=3Dppc
+    mttcg=3Dyes
     gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml power-vsx.xml"
   ;;
   ppc64abi32)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e0ff041..ece535d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -30,6 +30,8 @@
 #define TARGET_LONG_BITS 64
 #define TARGET_PAGE_BITS 12
=20
+#define TCG_GUEST_DEFAULT_MO 0
+
 /* Note that the official physical address space bits is 62-M where M
    is implementation dependent.  I've not looked up M for the set of
    cpus we emulate at the system level.  */
--=20
2.9.3
