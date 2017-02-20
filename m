Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucE-00084d-9n
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucB-0004b6-KZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:22 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:2709)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucB-0004at-FQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:19 -0500
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id F141AAFF79688
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:31:13 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Feb 2017 20:30:59 +0000
Message-ID: <1487622662-62984-6-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 5/8] dtc: Update requirement to v1.4.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Paul Burton <paul.burton@imgtec.com>

In order to obtain fdt_first_subnode & fdt_next_subnode symbols from
libfdt for use by a later patch, bump the requirement for dtc to v1.4.2
& the submodule to that same version.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 configure | 6 +++---
 dtc       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 1c9655e..4b68861 100755
--- a/configure
+++ b/configure
@@ -3396,11 +3396,11 @@ fi
 if test "$fdt" != "no" ; then
   fdt_libs="-lfdt"
   # explicitly check for libfdt_env.h as it is missing in some stable installs
-  # and test for required functions to make sure we are on a version >= 1.4.0
+  # and test for required functions to make sure we are on a version >= 1.4.2
   cat > $TMPC << EOF
 #include <libfdt.h>
 #include <libfdt_env.h>
-int main(void) { fdt_get_property_by_offset(0, 0, 0); return 0; }
+int main(void) { fdt_first_subnode(0, 0); return 0; }
 EOF
   if compile_prog "" "$fdt_libs" ; then
     # system DTC is good - use it
@@ -3418,7 +3418,7 @@ EOF
     fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
   elif test "$fdt" = "yes" ; then
     # have neither and want - prompt for system/submodule install
-    error_exit "DTC (libfdt) version >= 1.4.0 not present. Your options:" \
+    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:" \
         "  (1) Preferred: Install the DTC (libfdt) devel package" \
         "  (2) Fetch the DTC submodule, using:" \
         "      git submodule update --init dtc"
diff --git a/dtc b/dtc
index 65cc4d2..ec02b34 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf
+Subproject commit ec02b34c05be04f249ffaaca4b666f5246877dea
-- 
2.7.4
