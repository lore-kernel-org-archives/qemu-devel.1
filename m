Received: from eggs.gnu.org ([2001:4830:134:3::10]:49298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSxyQ-0005Ih-FK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSxyP-0002DD-19
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:05:34 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Jun 2018 07:05:20 +0200
Message-Id: <1528866321-23886-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1528866321-23886-1-git-send-email-thuth@redhat.com>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qemu-options: Improve the documentation of
 '-accel' and '-machine accel=...'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org

Instead of repeating the same text for both options, let's rather change
the '-machine accel' documentation to point to the preferred '-accel' option
instead.
And in the documenation of the -accel option, make it clear that you can
use colons to specify multiple accelerators.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 451f7a6..0ec9cac 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -30,8 +30,7 @@ ETEXI
 DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
-    "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hax, hvf, whpx or tcg (default: tcg)\n"
+    "                property accel=accel1[:accel2[:...]] selects accelerator (see -accel)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
@@ -66,10 +65,8 @@ of QEMU will support machine types from many previous versions.
 Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
-This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
-more than one accelerator specified, the next one is used if the previous one
-fails to initialize.
+This can be used to enable an accelerator. See the preferred @code{-accel}
+option for a list of available accelerators.
 @item kernel_irqchip=on|off
 Controls in-kernel irqchip support for the chosen accelerator when available.
 @item gfx_passthru=on|off
@@ -128,16 +125,17 @@ Select CPU model (@code{-cpu help} for list and additional feature selection)
 ETEXI
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
-    "-accel [accel=]accelerator[,thread=single|multi]\n"
+    "-accel [accel=]accelerator[:accelerator[:...]][,thread=single|multi]\n"
     "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
-    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
+    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
-more than one accelerator specified, the next one is used if the previous one
-fails to initialize.
+kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used.
+Multiple accelerators can be specified by separating them with a colon. If
+there is more than one accelerator specified, the next one is used if the
+previous one fails to initialize.
 @table @option
 @item thread=single|multi
 Controls number of TCG threads. When the TCG is multi-threaded there will be one
-- 
1.8.3.1
