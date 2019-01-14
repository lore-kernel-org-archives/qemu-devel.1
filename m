Received: from eggs.gnu.org ([209.51.188.92]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2lI-0006gL-QI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2lH-0004eT-Lu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:58:44 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:1339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2lH-0004Z1-DF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:58:43 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 14 Jan 2019 13:51:51 +0000
Message-ID: <20190114135154.16826-23-anthony.perard@citrix.com>
In-Reply-To: <20190114135154.16826-1-anthony.perard@citrix.com>
References: <20190114135154.16826-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 22/25] xen: Replace few mentions of xend by libxl
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

xend have been replaced by libxenlight (libxl) for many Xen releases
now.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xenpv/xen_machine_pv.c | 2 +-
 include/hw/xen/xen.h      | 2 +-
 qemu-options.hx           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 8d68fef25e..dcaf2a01a3 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -43,7 +43,7 @@ static void xen_init_pv(MachineState *machine)
 
     switch (xen_mode) {
     case XEN_ATTACH:
-        /* nothing to do, xend handles everything */
+        /* nothing to do, libxl handles everything */
         break;
     case XEN_EMULATE:
         error_report("xen emulation not implemented (yet)");
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 978aaa31fb..ba039c146d 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -15,7 +15,7 @@
 /* xen-machine.c */
 enum xen_mode {
     XEN_EMULATE = 0,  // xen emulation, using xenner (default)
-    XEN_ATTACH        // attach to xen domain created by xend
+    XEN_ATTACH        // attach to xen domain created by libxl
 };
 
 extern uint32_t xen_domid;
diff --git a/qemu-options.hx b/qemu-options.hx
index 7c323c9406..521511ec13 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3396,7 +3396,7 @@ DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
     "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
 DEF("xen-attach", 0, QEMU_OPTION_xen_attach,
     "-xen-attach     attach to existing xen domain\n"
-    "                xend will use this when starting QEMU\n",
+    "                libxl will use this when starting QEMU\n",
     QEMU_ARCH_ALL)
 DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
     "-xen-domid-restrict     restrict set of available xen operations\n"
@@ -3410,7 +3410,7 @@ Specify xen guest domain @var{id} (XEN only).
 @item -xen-attach
 @findex -xen-attach
 Attach to existing xen domain.
-xend will use this when starting QEMU (XEN only).
+libxl will use this when starting QEMU (XEN only).
 @findex -xen-domid-restrict
 Restrict set of available xen operations to specified domain id (XEN only).
 ETEXI
-- 
Anthony PERARD
