Received: from eggs.gnu.org ([2001:4830:134:3::10]:44901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxURZ-0004gf-VS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxURW-0007ue-Qs
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:13:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cxURW-0007uS-HH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:12:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3A89A3G028072
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 04:12:45 -0400
Received: from e28smtp05.in.ibm.com ([125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29r285ta3e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 04:12:44 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 13:42:41 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 13:42:17 +0530
Message-Id: <20170410081217.2897-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for 2.10] tcg: enable MTTCG by default for
 PPC64 on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, intermediadc@hotmail.com, programmingkidx@gmail.com, clg@kaod.org

This enables the multi-threaded system emulation by default for PPC64
guests using the x86_64 TCG back-end.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---

Depends on following patch which fixes the define name:

https://patchwork.ozlabs.org/patch/748840/

---
 configure        | 2 ++
 target/ppc/cpu.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configure b/configure
index 4b3b5cd..2a87495 100755
--- a/configure
+++ b/configure
@@ -6008,12 +6008,14 @@ case "$target_name" in
   ppc64)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
+    mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
   ppc64le)
     TARGET_ARCH=ppc64
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
+    mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
   ppc64abi32)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e0ff041..ece535d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -30,6 +30,8 @@
 #define TARGET_LONG_BITS 64
 #define TARGET_PAGE_BITS 12
 
+#define TCG_GUEST_DEFAULT_MO 0
+
 /* Note that the official physical address space bits is 62-M where M
    is implementation dependent.  I've not looked up M for the set of
    cpus we emulate at the system level.  */
-- 
2.9.3
