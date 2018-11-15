Received: from eggs.gnu.org ([2001:4830:134:3::10]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gN8mo-0000d1-On
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gN8mj-000535-8V
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 22:57:45 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 15 Nov 2018 14:56:59 +1100
Message-Id: <20181115035659.85245-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] configure/fdt: Use more strict test for
 libfdt version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The libfdt installed in the system is preferred to the dtc submodule by
default. The recent libfdt update added a new symbol - fdt_check_full -
and this breaks compile if there is an older libfdt installed in
the system.

This changes the test to force ./configure into using newer libfdt.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 74e313a..7e16a6c 100755
--- a/configure
+++ b/configure
@@ -3826,7 +3826,7 @@ if test "$fdt" != "no" ; then
   cat > $TMPC << EOF
 #include <libfdt.h>
 #include <libfdt_env.h>
-int main(void) { fdt_first_subnode(0, 0); return 0; }
+int main(void) { fdt_check_full(NULL, 0); return 0; }
 EOF
   if compile_prog "" "$fdt_libs" ; then
     # system DTC is good - use it
-- 
2.17.1
