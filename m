Received: from eggs.gnu.org ([209.51.188.92]:52253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQh-0006Au-Jt
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQf-0007MM-Vk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:47 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:14928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqcQb-00076s-Ve
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:28:45 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 4 Feb 2019 11:28:00 +0000
Message-ID: <20190204112803.11645-2-anthony.perard@citrix.com>
In-Reply-To: <20190204112803.11645-1-anthony.perard@citrix.com>
References: <20190204112803.11645-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/4] configure: xen: Stop build-testing for
 xc_domain_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

Its last uses was removed by: 6d7c06c213ddcfabcafdc178ccef81736f85a7c2
"Remove broken Xen PV domain builder".

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
---
 configure | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/configure b/configure
index f8176b3c40..ca1986125d 100755
--- a/configure
+++ b/configure
@@ -2474,7 +2474,6 @@ int main(void) {
   xenforeignmemory_handle *xfmem;
   xenevtchn_handle *xe;
   xengnttab_handle *xg;
-  xen_domain_handle_t handle;
   xengnttab_grant_copy_segment_t* seg = NULL;
 
   xs_daemon_open();
@@ -2484,7 +2483,6 @@ int main(void) {
   xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
   xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
   xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
 
   xfmem = xenforeignmemory_open(0, 0);
   xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
@@ -2526,7 +2524,6 @@ int main(void) {
   xenforeignmemory_handle *xfmem;
   xenevtchn_handle *xe;
   xengnttab_handle *xg;
-  xen_domain_handle_t handle;
 
   xs_daemon_open();
 
@@ -2535,7 +2532,6 @@ int main(void) {
   xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
   xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
   xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
 
   xfmem = xenforeignmemory_open(0, 0);
   xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
@@ -2553,21 +2549,6 @@ EOF
       then
       xen_ctrl_version=40701
       xen=yes
-    elif
-        cat > $TMPC <<EOF &&
-#include <xenctrl.h>
-#include <stdint.h>
-int main(void) {
-  xc_interface *xc = NULL;
-  xen_domain_handle_t handle;
-  xc_domain_create(xc, 0, handle, 0, NULL, NULL);
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs"
-      then
-      xen_ctrl_version=40700
-      xen=yes
 
     # Xen 4.6
     elif
-- 
Anthony PERARD
