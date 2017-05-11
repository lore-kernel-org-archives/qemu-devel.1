Received: from eggs.gnu.org ([2001:4830:134:3::10]:56037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUu-0005II-Vr
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUt-0001R1-QF
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:09 +1000
Message-Id: <20170511041426.6488-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/23] tcg: enable MTTCG by default for PPC64 on
 x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

This enables the multi-threaded system emulation by default for PPC64
guests using the x86_64 TCG back-end.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 configure        | 2 ++
 target/ppc/cpu.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configure b/configure
index 7c020c0..84c37d4 100755
--- a/configure
+++ b/configure
@@ -6110,12 +6110,14 @@ case "$target_name" in
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
